public with sharing class DealershipHomeController {
    public Pagereference addClient() {
        Pagereference pr = new Pagereference('/apex/AddClientPage');
        return pr;
    }
    public Pagereference addCar() {
        Pagereference pr = new Pagereference('/apex/AddCarPage');
        return pr;
    }
    
    public Pagereference addPurchase() {
        Pagereference pr = new Pagereference('/apex/AddPurchasePage');
        return pr;
    }
    
    public Pagereference viewClients() {
        Pagereference pr = new Pagereference('/apex/ViewClientsPage');
        return pr;
    }
    
    public Pagereference viewCars() {
        Pagereference pr = new Pagereference('/apex/ViewCarsPage');
        return pr;
    }
    
    public Pagereference viewPurchases() {
        Pagereference pr = new Pagereference('/apex/ViewPurchasesPage');
        return pr;
    }
    
    public Pagereference brochureView() {
        Pagereference pr = new Pagereference('/apex/SendAddsPage');
        return pr;
    }
    
    public Pagereference findClient() {
        Pagereference pr = new Pagereference('/apex/FindClientPage');
        return pr;
    }
    
    public Pagereference findCar() {
        Pagereference pr = new Pagereference('/apex/FindCarPage');
        return pr;
    }
    
    public Pagereference findPurchase() {
        Pagereference pr = new Pagereference('/apex/FindPurchasePage');
        return pr;
    }
}