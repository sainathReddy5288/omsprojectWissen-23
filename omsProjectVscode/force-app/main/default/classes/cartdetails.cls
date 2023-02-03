public class cartdetails {
    
    @AuraEnabled(cacheable=true)
    public static list<Productnimage> showcartproducts(){
        
        list<Productnimage> pdimg = new list<Productnimage>(); 
        //   list<Cart_Item__c> pd =new list<Cart_Item__c>();
        
        
        string presentusermail = UserInfo.getUserEmail() ;
        string pc = [select id,email from Contact where email =: presentusermail][0].id;
        
        string cartt = [select id from Cart__c where Customer__c =: pc and Status__c = 'Open'][0].id ;
        
        //   list<Cart_Item__c> cartdet = [select Product__c from Cart_Item__c where Cart_Id__c =: cartt];
        
        //    for(Cart_Item__c prdct : cartdet){
        list<Cart_Item__c> pd = [select id,Cart_Id__c,Product__c,Quantity__c,Product__r.Price__c,Product__r.Name from Cart_Item__c where Cart_Id__c =: cartt];
        //      }
        //  list<Product_Image__c> Prdctg = [select id,Product__c,URL__c from Product_Image__c where Product__c =: cartdet[0].Product__c];
        
        
        system.debug(pd);   
        
        for(Cart_Item__c prd : pd){
            list<Product_Image__c> pdi = [select id,HeroImage__c,Type__c,Resource__c,ResourceURL__c,URL__c from Product_Image__c where Product__c =: prd.Product__c];
            list<Product_Image__c> hpdi = [select id,HeroImage__c,Type__c,Resource__c,ResourceURL__c,URL__c from Product_Image__c where Product__c =: prd.Product__c and HeroImage__c =: true];
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
        string presentusermail = UserInfo.getUserEmail() ;
        string pc = [select id,email from Contact where email =: presentusermail][0].id;
        string cartt = [select id from Cart__c where Customer__c =: pc and Status__c = 'Open'][0].id ;
        list<Cart_Item__c> pd = [select id,Product__c,Quantity__c,Product__r.Price__c,Product__r.Name from Cart_Item__c where Cart_Id__c =: cartt ];
        list<Product_Image__c> pdi = [select id,HeroImage__c,Type__c,Resource__c,ResourceURL__c,URL__c from Product_Image__c where Product__c =: pd[0].Product__c];
        list<Product_Image__c> hpdi = [select id,HeroImage__c,Type__c,Resource__c,ResourceURL__c,URL__c from Product_Image__c where Product__c =: pd[0].Product__c and HeroImage__c =: true];
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
    public class Productnimage {
        @AuraEnabled
        Public Cart_Item__c prdt{get;set;}
        @AuraEnabled
        Public list<Product_Image__c> Prdimg{get;set;}
        @AuraEnabled  
        Public Product_Image__c hprdimg{get;set;}
    }
    
    @AuraEnabled (cacheable=true)
    public static Decimal totalprice(){
        string presentusermail = UserInfo.getUserEmail() ;
        string pc = [select id,email from Contact where email =: presentusermail][0].id;
        list<Cart__c> cartt = [select id,Total_Amount__c,Discounted_Amount__c from Cart__c where Customer__c =: pc and Status__c = 'Open'];
        system.debug(cartt);
        if(cartt[0].Discounted_Amount__c == null){
            return cartt[0].Total_Amount__c ;
        }
        else{
        return cartt[0].Discounted_Amount__c; 
    }
    }
     @AuraEnabled
    public static void incredecre(id prodid,integer val){
        system.debug(prodid);
        system.debug(val);
    Cart_Item__c cartt = [select id,Quantity__c from Cart_Item__c where id =: prodid][0];
        system.debug(cartt.Quantity__c);
    cartt.Quantity__c = val ;
        update cartt;
    }
    
    @AuraEnabled
    public static void Deletebutton(id deleteid){
      //   list<Cart_Item__c> cartt = new list<Cart_Item__c>(); 
      list <Cart_Item__c> cartt = [select id from Cart_Item__c where id =: deleteid];
        system.debug(cartt);
        try{
        delete(cartt);
            
        }
        catch(exception e){
            system.debug(e.getMessage());
        }
}
}