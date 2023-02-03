import { LightningElement,wire } from 'lwc';
import My_Resource from '@salesforce/resourceUrl/myResource';
import getCategories from '@salesforce/apex/ProductList.getCategories'
import { NavigationMixin } from 'lightning/navigation';
export default class ApplicationPage extends NavigationMixin(LightningElement) {
    cats
@wire(getCategories)
getCat({data,error})
{
    if(data)
    {
        console.log(data)
        this.cats=data
    }
    if(error)
    {
        console.log(error)
    }
}
    spring20Logo = My_Resource;
    
    handleMe(){
        // eslint-disable-next-line no-alert
        alert ('We are coming soon...Pls wait!!!');
    }

    handelShow(){
        // eslint-disable-next-line no-alert
        alert ('Happy to see you.....We are coming soon...Pls wait!!!')

    }


    navigateToLightningComponent(event) {
        console.log('name',event.target.name)
       /* this[NavigationMixin.Navigate]({
            "type": "standard__component",
            "attributes": {
                //Here customLabelExampleAura is name of lightning aura component
                //This aura component should implement lightning:isUrlAddressable
                "componentName": "c__ProductTest"
            }
        });*/
        var defination={
            componentDef:"c:applicationProdDetailpage",
            attributes:
            {
            recId:event.target.name
            }
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