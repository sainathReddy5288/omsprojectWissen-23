import { LightningElement,wire,api } from 'lwc';
import My_Resource from '@salesforce/resourceUrl/myResource';
import getProducts from '@salesforce/apex/ProductList.getProducts';
import { NavigationMixin } from 'lightning/navigation';
export default class ApplicationProdDetailpage extends NavigationMixin(LightningElement) {
    spring20Logo = My_Resource;
   products
   @api recId
  @wire(getProducts,{catId:'$recId'})
getProds({data,error})
{
    if(data)
    {
        console.log('data',data)
        this.products=data
    }
    if(error)
    {
        console.log('error',error)
    }
}
handleHomePage()
{
    var defination={
        componentDef:"c:applicationPage",
        }
        this[NavigationMixin.Navigate]({
        type:'standard__webPage',
        attributes:
        {
        url:'/one/one.app#'+btoa(JSON.stringify(defination))
        }
        })
}
}