public with sharing class SendAddController {
    public string selected;
    
    public string getSelected() {
        return selected;
    }
    
    public void setSelected(string val) {
        selected = val;
    }
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Седан','Седан'));
        options.add(new SelectOption('Хечбек', 'Хечбек'));
        options.add(new SelectOption('Джип', 'Джип'));
        options.add(new SelectOption('Комби', 'Комби'));
        return options;
    }    
    
    public Pagereference sendOut() {
        List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
        List<Client__c> contacts = [SELECT first_name__c, last_name__c, email__c FROM Client__c WHERE preffered_catagory__c = :this.selected];
        List<Car__c> cars = [SELECT make__c, model__c, price__C FROM Car__c WHERE ID NOT IN (SELECT car_id__c FROM Purchase__c) AND category__c = :this.selected];
    
        for (Client__c con : contacts) {
             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
             mail.setToAddresses(new String[] {con.email__c});
             mail.setSubject('Брошура');
             String body = '<!DOCTYPE html>';
             body += '<html lang="bg"><head>';
             body += '<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">';
             body += '<title>Брошура</title><style>';
             body += 'body {font-family: Arial, sans-serif;background-color: #f4f4f4;margin: 0;padding: 0;}';
             body += '.container {max-width: 600px;margin: 20px auto;background-color: #fff;padding: 20px;border-radius: 5px;box-shadow: 0 0 10px rgba(0,0,0,0.1);}';
             body += 'h2 {color: #333;}p {color: #666;}table {width: 100%;border-collapse: collapse;}';
             body += 'th, td {padding: 8px;text-align: left;border-bottom: 1px solid #ddd;}';
             body += 'th {background-color: #f2f2f2;}';
             body += '</style></head><body><div class="container">';
             body += '<h2>Здравейте ' + con.first_name__c + ' ' + con.last_name__c + ',</h2>';
             body += '<p>Благодарим Ви, че проявихте интерес към нашите продукти!</p>';
             body += '<p>Моля, вижте нашите предложения за автомобили от категория \'' + this.selected + '\':</p>';
             
             // Pretty table for displaying car suggestions
             body += '<table>';
             body += '<tr><th>Марка</th><th>Модел</th><th>Цена</th></tr>';
             for(Car__c car : cars) {
                 body += '<tr><td>' + car.make__c + '</td><td>' + car.model__c + '</td><td>' + car.price__c + '</td></tr>';
             }
             body += '</table>';
             
             // Placeholder link
             body += '<p>За повече информация, моля посетете <a href="#">този линк</a>.</p>';
             
             body += '<p>Най-добри пожелания,</p>';
             body += '<p>Автокъща ******</p></div></body></html>';

             mail.setHtmlBody(body);
             
             allmsg.add(mail);
        }
        Messaging.sendEmail(allmsg);
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Брошурите бяха успешно изпратени!'));
        
        Pagereference pr = new Pagereference('/apex/SendAddsPage');
        return pr;
    }
}