public with sharing class CarController {
    string make;
    string model;
    string color;
    double price;
    integer year;
    string category;
    List<Car__c> allCars;
    
    public List<Car__c> getAllCars() {
        return allCars = [SELECT make__c, model__c, color__c, price__c, year__c, category__c FROM Car__c];
    }
    
    public string getMake() { return make; }
    public void setMake(string val) { make = val; }
    
    public string getModel() { return model; }
    public void setModel(string val) { model = val; }
    
    public string getColor() { return color; }
    public void setColor(string val) { color = val; }
    
    public double getPrice() { return price; }
    public void setPrice(double val) { price = val; }
    
    public integer getYear() { return year; }
    public void setYear(integer val) { year = val; }
    
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
        Car__c newCar = new Car__c();
        newCar.make__c = this.make;
        newCar.model__c = this.model;
        newCar.color__c = this.color;
        newCar.price__c = this.price;
        newCar.year__c = this.year;
        newCar.category__c = this.category;
        
        Database.insert(newCar, false);
        
        Pagereference pr = new Pagereference('/apex/ViewCarsPage');
        return pr;
    }
}