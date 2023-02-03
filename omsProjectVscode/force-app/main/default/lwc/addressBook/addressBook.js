import { LightningElement } from "lwc";
import getAddress from "@salesforce/apex/addressBook.getAddressDetails";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ADDRESS_OBJECT from "@salesforce/schema/Address_Book__c";
import Street_Field from "@salesforce/schema/Address_Book__c.Street__c";
import City_Field from "@salesforce/schema/Address_Book__c.City__c";
import State_Field from "@salesforce/schema/Address_Book__c.State__c";
import Country_Field from "@salesforce/schema/Address_Book__c.Country__c";
import PostalCode_Field from "@salesforce/schema/Address_Book__c.Postal_Code__c";
import Land_Field from "@salesforce/schema/Address_Book__c.Land_Mark__c";
import saveAddress from '@salesforce/apex/addressBook.createAddress';
import { NavigationMixin } from 'lightning/navigation';

export default class AddressBook extends NavigationMixin(LightningElement) {
    objectApiName=ADDRESS_OBJECT
     addRecord = {

        Street__c:Street_Field,

       City__c:City_Field,

       State__c:State_Field,

       Country__c:Country_Field,

       Land_Mark__c:Land_Field,

       Postal_Code__c:PostalCode_Field

    };
  addressDetails;
  showNewAdd=false;
  connectedCallback() {
    this.getAddressMethod();
  }
  getAddressMethod() {
    getAddress()
      .then((result) => {
        console.log('result',result);
        this.addressDetails = result;
      })
      .catch((error) => {
        console.log(error);
      });
  }
  /**back button  */
   navigateToHomePage() {
     this[NavigationMixin.Navigate]({
         type: 'standard__namedPage',
          attributes: {
             pageName: 'home'
         },
      });
 }
    

  

  handleChange(event)

        {

            const {name,value}=event.target

            if(name==='Street')

            {

                this.addRecord.Street__c=value

            }else if(name==='City')

            {

                this.addRecord.City__c=value

            }

            else if(name==='State')

            {

                this.addRecord.State__c=value

            }

            else if(name==='Country')

            {

                this.addRecord.Country__c=value

            }else if(name==='LandMark')

            {

                this.addRecord.Land_Mark__c=value

            }

            else{

             this.addRecord.Postal_Code__c=value

            }

       

        }
        handleSave()

        {
            saveAddress({objAdd:this.addRecord}).then(result=>{
                this.getAddressMethod()
                this.showNewAdd=false
                console.log('result',result)
                const evt = new ShowToastEvent({
                    title: 'Shipping Address Created Successfully',
                    message: 'Record ID: ' + result,
                    variant: 'success',
                });
                this.dispatchEvent(evt);

            }).catch(error=>{

                console.log('error',error)
                const evt = new ShowToastEvent({
                    title: 'Shipping Address Creation Failed',
                    message: error,
                    variant: 'error',
                });
                this.dispatchEvent(evt);
            })
        }
handleNewAddress()
{
this.showNewAdd=true
}
}