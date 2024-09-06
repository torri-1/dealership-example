public with sharing class PurchaseController {
    public class Purchase {
        string clname;
        string cemail;
        
        string crname;
        double askprice;
        
        Date pdate;
        double pprice;
        string pstatus;
        
        public string getClname() { return clname; }
        public string getCemail() { return cemail; }
        public string getCrname() { return crname; }
        public double getAskprice() { return askprice; }
        public Date getPdate() { return pdate; }
        public double getPprice() { return pprice; }
        public string getPstatus() { return pstatus; }
    }

    ID client;
    ID car;  
    Date data;
    double price;
    string pstatus;
    
    List<Purchase> purchases;
    
    public ID getClient() { return client; }
    public void setClient(ID val) { client = val; }
    
    public ID getCar() { return car; }
    public void setCar(ID val) { car = val; }
    
    public Date getData() { return data; }
    public void setData(Date val) { data = val; }    
    
    public double getPrice() { return price; }
    public void setPrice(double val) { price = val; }  
    
    public string getPstatus() { return pstatus; }
    public void setPstatus(string val) { pstatus = val; }   
    
    public List<Purchase> getPurchases() {
        List<Purchase__c> purr = [SELECT client_id__c, car_id__c, date__c, price__c, payment_status__c FROM Purchase__c];
        Map<ID, Client__c> clnts = new Map<ID, Client__c>([SELECT Name, first_name__c, last_name__c, email__c FROM Client__c]);
        Map<ID, Car__c> crs = new Map<ID, Car__c>([SELECT Name, make__c, model__c, price__c FROM Car__c]);
        
        List<Purchase> res = new List<Purchase>();
        for(Purchase__c pr : purr) {
            Purchase np = new Purchase();
            
            Client__c cln = clnts.get(pr.client_id__c);
            np.clname = '[' + cln.Name + '] ' + cln.first_name__c + ' ' + cln.last_name__c;
            np.cemail = cln.email__c;
            
            Car__c cr = crs.get(pr.car_id__c);
            np.crname = '[' + cr.Name + '] ' + cr.make__c + ' ' + cr.model__c;
            np.askprice = cr.price__c;
        
            np.pdate = pr.date__c; 
            np.pprice = pr.price__c;
            np.pstatus = pr.payment_status__c;
            res.add(np);
        }
        
        return res;
    }
    
    public List<SelectOption> getClients() {
        List<SelectOption> options = new List<SelectOption>();   
        for(Client__c c : [SELECT Id, Name, first_name__c, last_name__c, email__c FROM Client__c]) {
            string name = '[' + c.Name + '] ' + c.first_name__c + ' ' + c.last_name__c;
            options.add(new SelectOption(c.Id, name));
        }
        return options;
    } 
    
    public List<SelectOption> getCars() {
        List<SelectOption> options = new List<SelectOption>();   
        for(Car__c c : [SELECT Id, Name, make__c, model__c FROM Car__c WHERE ID NOT IN (SELECT car_id__c FROM Purchase__c) ]) {
            string name = '[' + c.Name + '] ' + c.make__c + ' ' + c.model__c;
            options.add(new SelectOption(c.Id, name));
        }
        return options;
    } 
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Платена', 'Платена'));
        options.add(new SelectOption('Частично платена', 'Частично платена'));
        options.add(new SelectOption('Очаква плащане', 'Очаква плащане'));
        return options;
    }    
    
    public pagereference addPurchase() { 
        Purchase__c newPur = new Purchase__c();
        
        newPur.client_id__c = this.client;
        newPur.car_id__c = this.car;  
        newPur.date__c = this.data;
        newPur.price__c = this.price;
        newPur.payment_status__c = this.pstatus;
               
        Database.insert(newPur,false);
        
        return sendReceipt();
    }  
    
    public pagereference sendReceipt() {
        Client__c cli = [SELECT first_name__c, last_name__c, email__c FROM Client__c WHERE ID = :this.client];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {cli.email__c});
        mail.setSubject('Фактура');
        EmailTemplate et =[SELECT Id, Subject, HtmlValue, DeveloperName, Body
                           FROM EmailTemplate WHERE name = 'receipt'];
        mail.setTemplateID(et.Id);
        mail.setHtmlBody(et.HtmlValue);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        
        Pagereference pr = new Pagereference('/apex/ViewPurchasesPage');
        return pr;
    }
}