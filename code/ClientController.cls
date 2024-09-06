public with sharing class ClientController {
    string fname;
    string lname;
    string city;
    string address;
    string email;
    string phone;
    string category;
    List<Client__c> allClients;
    
    public List<Client__c> getAllClients() {
        return allClients = [SELECT first_name__c, last_name__c, city__c, email__c, phone__c, preffered_catagory__c FROM Client__c];
    }
    
    public string getFname() { return fname; }
    public void setFname(string val) { fname = val; }

    public string getLname() { return lname; }
    public void setLname(string val) { lname = val; }
    
    public string getCity() { return city; }
    public void setCity(string val) { city = val; }
    
    public string getAddress() { return address; }
    public void setAddress(string val) { address = val; }
    
    public string getEmail() { return email; }
    public void setEmail(string val) { email = val; }
    
    public string getPhone() { return phone; }
    public void setPhone(string val) { phone = val; }
    
    public string getCategory() { return category; }
    public void setCategory(string val) { category = val; }   
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Седан', 'Седан'));
        options.add(new SelectOption('Хечбек', 'Хечбек'));
        options.add(new SelectOption('Джип', 'Джип'));
        options.add(new SelectOption('Комби', 'Комби'));
        return options;
    }     
    
    public pagereference addClient() {
        Client__c newCli = new Client__c();
        newCli.first_name__c = this.fname;
        newCli.last_name__c = this.lname;
        newCli.city__c = this.city;
        newCli.address__C = this.address;
        newCli.email__c = this.email;
        newCli.phone__c = this.phone;
        newCli.preffered_catagory__c = this.category;
        
        Database.insert(newCli, false);
        
        Pagereference pr = new Pagereference('/apex/ViewClientsPage');
        return pr;
    }
}