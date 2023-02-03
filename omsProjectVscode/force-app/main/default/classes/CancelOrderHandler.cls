public class CancelOrderHandler {
 public static void addCountRelatedProducts(List<Order__c> countList){


        List<Order__c> odList=[Select id,Status__c FROM Order__c WHERE Status__c='Cancelled' AND Id IN:countList ];
        List<Order_Line_Item__c> odlnList = [Select id,Product__c,Order__c,Quantity__c
                                             from Order_Line_Item__c where Order__c IN:odList];

        map<id,Order_Line_Item__c> oltMap = new map<id,Order_Line_Item__c>();
        set<id> pdIds = new set<id>();
        for(Order_Line_Item__c o:odlnList){
            if(o.Product__c != null){
                pdIds.add(o.Product__c);
                oltMap.put(o.Product__c, o);
            }
        }
        List<Product2> pdList = [SELECT id,Remaining_Quantity__c FROM Product2 WHERE id IN:pdIds];
        List<Product2> pdList2 = new List<Product2>();
        for(Product2 p: pdList){
            if(p.id == oltMap.get(p.id).Product__c){
                p.Remaining_Quantity__c += oltMap.get(p.id).Quantity__c;
                pdList2.add(p);
            }
        }
        update pdList2;
    }
    public static void RemainingRelatedProducts(List<Order__c> countList){


        List<Order__c> odList=[Select id,Status__c FROM Order__c WHERE Status__c='Return requested' AND Id IN:countList ];
        List<Order_Line_Item__c> odlnList = [Select id,Product__c,Order__c,Quantity__c
                                             from Order_Line_Item__c where Order__c IN:odList];

        map<id,Order_Line_Item__c> oltMap = new map<id,Order_Line_Item__c>();
        set<id> pdIds = new set<id>();
        for(Order_Line_Item__c o:odlnList){
            if(o.Product__c != null){
                pdIds.add(o.Product__c);
                oltMap.put(o.Product__c, o);
            }
        }
        List<Product2> pdList = [SELECT id,Remaining_Quantity__c FROM Product2 WHERE id IN:pdIds];
        List<Product2> pdList2 = new List<Product2>();
        for(Product2 p: pdList){
            if(p.id == oltMap.get(p.id).Product__c){
                p.Remaining_Quantity__c += oltMap.get(p.id).Quantity__c;
                pdList2.add(p);
            }
        }
        update pdList2;
    }


    
    
}