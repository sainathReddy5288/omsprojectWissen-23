public class Product_Category_Controller 
{
    @AuraEnabled
    public static List<Product2> getProductList(String srchStr)
    {        
        List<Product2> prdctList = new List<Product2>();
        // Fetching Records and RecordIds
        String queryList='Select Id, Name, Description,Price__c From Product2 Where Name LIKE \'%'+srchStr+'%\'';            
        prdctList = Database.query(queryList);
        system.debug(prdctList);
        return prdctList;
    }
}