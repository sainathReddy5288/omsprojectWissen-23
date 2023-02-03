public class Product_list_page {
    
    
    //Product list page
    @AuraEnabled(cacheable=true)
    public static list<Productnimage> getPrdimg(string catg, integer min, integer max,string sortingby,list<string>multiplecategories ){
        system.debug(multiplecategories);
        list<Productnimage> pdimg = new list<Productnimage>(); 
        set<Product2> pd =new set<Product2>();
        
        //for all products and single category
        if(catg=='all'){
            system.debug('all1');
            pd.addAll( [select id,name,Inventory__c,Discount__c,Price__c,Remaining_Quantity__c from Product2]);
            system.debug('all2');
        }else if(catg!=null){
            system.debug('ctg1');
            list<Product_Category__c> Prdctg = [select Category__c,Product__c from Product_Category__c where Category__r.Name=: catg ];
            for(Product_Category__c prdct : Prdctg){
                pd.addAll([select id,name,Inventory__c,Discount__c,Price__c,Remaining_Quantity__c from Product2 where id =: prdct.Product__c]);
            }
            system.debug('ctg2');
        }
        system.debug(pd);
        
        // filter - price range 
        if(min!=null && max!=null){
            system.debug('prc1');
            pd.addAll([select id,name,Inventory__c,Discount__c,Price__c,Remaining_Quantity__c from Product2 where Product2.Price__c >=:min and Product2.Price__c<=:max]);
            system.debug('prc2');
        }
        
        system.debug(pd);
        
        // filter - categories
        if(multiplecategories!=null){
            for(string i : multiplecategories){
                list<Product_Category__c> Prdctg = [select Category__c,Product__c from Product_Category__c where Category__r.Name=: i ];
                for(Product_Category__c prdct : Prdctg){
                    pd.addAll([select id,name,Inventory__c,Discount__c,Price__c,Remaining_Quantity__c from Product2 where id =: prdct.Product__c]);
                }
            }
        }
        
        //filter - sorting
        system.debug(sortingby);
        if(sortingby=='LowToHigh'){
            
        }else if(sortingby=='HighToLow'){
            
        }else if(sortingby=='NewestFirst'){
            
        }
        
        for(Product2 prd : pd){
            list<Product_Image__c> pdi = [select id,HeroImage__c,Type__c,Resource__c,ResourceURL__c,URL__c from Product_Image__c where Product__c =: prd.id];
            list<Product_Image__c> hpdi = [select id,HeroImage__c,Type__c,Resource__c,ResourceURL__c,URL__c from Product_Image__c where Product__c =: prd.id and HeroImage__c =: true];
            Productnimage pimg = new Productnimage();
            if(pdi.size()!=0 ){               
                pimg.prdt = prd;
                pimg.Prdimg = pdi;                
                if(hpdi.size()!=0){
                    pimg.hprdimg = hpdi[0];  
                }else{
                    pimg.hprdimg = pdi[0]; 
                }
                pdimg.add(pimg);
            }   
        }
        return pdimg;
    }
    
    // Product detail page
    @AuraEnabled(cacheable=true)
    Public static list<Productnimage> prd(string iD){
        list<Productnimage> pdimg = new list<Productnimage>();
        list<Product2> pd = [select id,name,Inventory__c,Discount__c,Price__c,Remaining_Quantity__c,Description from Product2 where id=:iD];
        list<Product_Image__c> pdi = [select id,HeroImage__c,Type__c,Resource__c,ResourceURL__c,URL__c from Product_Image__c where Product__c =: pd[0].id];
        list<Product_Image__c> hpdi = [select id,HeroImage__c,Type__c,Resource__c,ResourceURL__c,URL__c from Product_Image__c where Product__c =: pd[0].id and HeroImage__c =: true];
        Productnimage pimg = new Productnimage();
        if(pdi.size()!=0 ){               
            pimg.prdt = pd[0];
            pimg.Prdimg = pdi;                
            if(hpdi.size()!=0){
                pimg.hprdimg = hpdi[0];  
            }else{
                pimg.hprdimg = pdi[0]; 
            }
            pdimg.add(pimg);
        }
        return pdimg;
    }
    
    //wrapper
    public class Productnimage {
        @AuraEnabled
        Public Product2 prdt{get;set;}
        @AuraEnabled
        Public list<Product_Image__c> Prdimg{get;set;}
        @AuraEnabled 
        Public Product_Image__c hprdimg{get;set;}
    }
    
    //Add to cart button   
    //
    @AuraEnabled
    public static void method(id productid, integer items)
    {
        Addtocart.addtocartmeth1(productid,items);
    }
    
    //Product categories
    @AuraEnabled(cacheable=true)
    public static list<Category__c> catg(){
        list<Category__c> categories = [select Name from Category__c];
        system.debug(categories);
        return categories;
    }
}