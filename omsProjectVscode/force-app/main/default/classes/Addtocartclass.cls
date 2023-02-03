public class Addtocartclass 
{
@AuraEnabled
public static void addToCart(String articleId){
  Cart__c cart = new Cart__c();

  List<Product2> linelist= new List<Product2>();

  Product2 line = new Product2();

  line.ProductCode = articleId;
  update line;
  linelist.add(line);
  system.debug(line);

}
}