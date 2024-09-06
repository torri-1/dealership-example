public with sharing class FindController {
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

    List<Client__c> clients;
    List<Car__c> cars;
    List<Purchase> purchases;
    string sterm;
    integer fromm;
    integer tto;
    
    public List<Client__c> getClients() { return clients; }
    public List<Car__c> getCars() { return cars; }
    public List<Purchase> getPurchases() { return purchases; }
    
    public string getSterm() { return sterm; }
    public void setSterm(string val) { sterm = val; }
    
    public integer getFromm() { return fromm; }
    public void setFromm(integer val) { fromm = val; }
    
    public integer getTto() { return tto; }
    public void setTto(integer val) { tto = val; }
    
    
    public void findClient() {
        string searchQuery = 'SELECT first_name__c, last_name__c, city__c, email__c, phone__c, preffered_catagory__c ' +
                             'FROM Client__c WHERE city__c LIKE \'%' + sterm + '%\''; 
        clients = Database.query(searchQuery);
    }
    
    public void findCar() {
        string searchQuery = 'SELECT make__c, model__c, color__c, price__c, year__c, category__c FROM Car__c ' +
                             'WHERE (model__c LIKE \'%' + sterm + '%\' OR make__c LIKE \'%' + sterm + '%\')'; 
        cars = Database.query(searchQuery);
    }
    
    public void findPurchase() {
        if(this.tto == 0) tto = 10000000;
         
        string searchQuery = 'SELECT client_id__c, car_id__c, date__c, price__c, payment_status__c FROM Purchase__c ' +
                             'WHERE price__c >= ' + this.fromm + ' AND price__c <= ' + this.tto;
        
        List<Purchase__c> purr = Database.query(searchQuery);
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
        purchases = res;
    }
}