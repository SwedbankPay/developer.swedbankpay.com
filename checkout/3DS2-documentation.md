---
title: Swedbank Pay Checkout – 3DS2 Documentation
sidebar:
  navigation:
  - title: Checkout
    items:
    - url: /checkout/
      title: Introduction
    - url: /checkout/payment
      title: Payment
    - url: /checkout/after-payment
      title: After Payment
    - url: /checkout/3DS2-documentation
      title: 3DS2 Documentation
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

## General

### Glossary

{:.table .table-striped}
| Term      | Description |
|:---       |:---        |
| Recurring (requires recurrenceToken) | Subscription type payment. E.g Monthly debited amount for service.
| Stored Card | Card data is saved on the consumers profile to allow future payments to be simplified.
| Verification Transaction (operation Verify) | Create a payment without debiting the consumer. Used to create a recurrenceToken for recurring payments without debiting an amount.

**API Changes for 3DS2.0 in PaymentOrder**

{:.table .table-striped}
| Change      | Description |
|:---       |:---        |
| Removed   | generatePaymentToken removed as stored card is handled by PayEx.
| Added     | generateRecurrenceToken added to create a token for recurring payments.
| Added     | Payer object and parameters added to allow decreased chance of authentication challenge flow.
| Removed   | Some CreditCard object-parameters removed as they will not be eligible in 3DS2.0. (E.g. no3DSecure: true).

## Use Cases: Create Payment Order
There are three different Create Payment Order cases based on which kind of integration you're set to use.

{:.table .table-striped}
| Integration      | Definition |
|:---              |:---        |
| PayEx Checkout   | The standard setup. The consumer provide details on PayEx end to create a new consumer profile or use an already existing profile of the consumer.
| PayEx Checkout without Checkin | Anonymous payment. No consumer profile will be created or used in the payment. Does not allow stored cards.
| PayEx Checkout - Merchant onboarding | The advanced setup. The merchant provides consumer details and PayEx will create a new consumer profile or use an already existing profile of the consumer. An advanced setup needs a separate GDPR agreement and approval from PayEx.

### 1.0 Use Case: PayEx Checkout

{:.code-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 0,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",                               
        "language": "sv-SE",
        "generateRecurrenceToken": false,                         
        "disablePaymentMenu": false,                              
        "urls": {
            "hostUrls": [ "http://test-dummy.net", "http://test-dummy2.net" ],
            "completeUrl": "http://test-dummy.net/payment-completed",
            "cancelUrl": "http://test-dummy.net/payment-canceled",
            "paymentUrl": "http://test-dummy.net/payment",
            "callbackUrl": "http://test-dummy.net/payment-callback",     
            "termsOfServiceUrl": "http://test-dummy.net/termsandconditoons.pdf",
            "logoUrl": "http://test-dummy.net/logo.png"
        },
        "payeeInfo": {
            "payeeId": "12345678-1234-1234-1234-123456789012",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",                                   
            "productCategory": "A123",                                   
            "subsite": "MySubsite",                                      
            "orderReference" : "or-123456"                                
        },
        "payer": {
            "consumerProfileRef": "string",
            "email": "string",
            "msisdn": "string",
            "workPhoneNumber" : "string",                              
            "homePhoneNumber" : "string"                                 
        },
        "riskIndicator" : {
            "deliveryEmailAddress" : "string",              
            "deliveryTimeFrameindicator" : "01",   
            "preOrderDate" : "YYYYMMDD",                    
            "preOrderPurchaseIndicator" : "01",          
            "shipIndicator" : "01",        
            "giftCardPurchase" : "false",               
            "reOrderPurchaseIndicator" : "01",           
            "pickUpAddress" : {                            
                "name" : "companyname",                    
                "streetAddress" : "string",                 
                "coAddress" : "string",                   
                "city" : "string",
                "zipCode" : "string",
                "countryCode" : "string"
            }
        },
        "metadata": {                                                 
            "key1": "value1",
            "key2": 2,
            "key3": 3.1,
            "key4": false
        },
        "items": [                                                
        {
        "creditCard": {
            "rejectCreditCards": false,                           
            "rejectDebitCards": false,                           
            "rejectConsumerCards": false,                        
            "rejectCorporateCards": false                      
            }
        }
        {
        "invoice": {
            "feeAmount" : 1900
          }
        },
        {
        "campaignInvoice": {
            "campaignCode" : "Campaign1",
            "feeAmount" : 2900 
          }
        },
        {
        "swish": {
            "EnableEcomOnly": false           
      }
    }
   ]
  }
}
```

{:.table .table-striped}
| Property                                  | Type       | Required | Description   |
|-------------------------------------------|------------|----------|---------------|
| paymentorder                              | object     | Y        | The payment order object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| operation                                 | string     | Y        | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| currency                                  | string     | Y        | The currency of the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| amount                                    | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                      |
| vatAmount                                 | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                             |
| description                               | string     | Y        | The description of the payment order.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| userAgent                                 | string     | N        | The user agent of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| language                                  | string     | Y        | The language of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| generateRecurrenceToken                   | boolean    | N        | Determines if a recurrence token should be generated. A recurrence token is primarily used to enable recurring payments through server-to-server calls. Default value is false                                                                                                                                                                                                                                                                                                                                     |
| urls.hostUrls                             | array      | Y        | The array of URIs valid for embedding of PayEx Hosted Views.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.completeUrl                          | string     | Y        | The URI to redirect the payer to once the payment is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.cancelUrl                            | string     | N        | The URI to redirect the payer to if the payment is canceled.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.paymentUrl                           | string     | N        | The URI that PayEx will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted view. See URLs for details.                                                                                                                                                                                                                                                                                                                        |
| payeeInfo.payeeName                       | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| payeeInfo.productCategory                 | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                            |
| payeeInfo.subsite                         | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                               |
| payeeInfo.orderReference                  | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                            |
| payer.consumerProfileRef                  | string     | N        | The consumer profile reference as obtained through the Consumers API.                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| payer.email                               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.msisdn                              | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.homePhoneNumber                     | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.workPhoneNumber                     | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| riskIndicator.deliveryEmailAddress        | string     | N        | For electronic delivery, the email address to which the merchandise was delivered.                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| riskIndicator.deliveryTimeFrameIndicator  | string     | N        | Indicates the merchandise delivery timeframe.01 (Electronic Delivery)02 (Same day shipping)03 (Overnight shipping)04 (Two-day or more shipping)                                                                                                                                                                                                                                                                                                                                                                    |
| riskIndicator.preOrderDate                | string     | N        | For a pre-ordered purchase. The expected date that the merchandise will be available.FORMAT: "YYYYMMDD"                                                                                                                                                                                                                                                                                                                                                                                                            |
| riskIndicator.preOrderPurchaseIndicator   | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.shipIndicator               | string     | N        | Indicates shipping method chosen for the transaction.01 (Ship to cardholder's billing address)02 (Ship to another verified address on file with merchant)03 (Ship to address that is different than cardholder's billing address)04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)05 (Digital goods, includes online services, electronic giftcards and redemption codes)06 (Travel and Event tickets, not shipped)07 (Other, e.g. gaming, digital service) |
| riskIndicator.giftCardPurchase            | boolean    | N        | true if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| riskIndicator.reOrderPurchaseIndicator    | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.pickUpAddress               | object     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.name          | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.streetAddress | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.coAddress     | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.city          | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.zipCode       | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.countryCode   | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| metadata                                  | object     | N        | The keys and values that should be associated with the payment order. Can be additional identifiers and data you want to associate with the payment.                                                                                                                                                                                                                                                                                                                                                               |
| items                                     | array      | N        | The array of items that will affect how the payment is performed.                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| items.creditCard.rejectDebitCards         | boolean    | N        | true if debit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                             |
| items.creditCard.rejectCreditCards        | boolean    | N        | true if credit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                            |
| items.creditCard.rejectConsumerCards      | boolean    | N        | true if consumer cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                          |
| items.creditCard.rejectCorporateCards     | boolean    | N        | true if corporate cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                         |
| items.invoice.feeAmount                   | integer    | N        | The fee amount in the lowest monetary unit to apply if the consumer chooses to pay with invoice.                                                                                                                                                                                                                                                                                                                                                                                                                   |
| items.swish.enableEcomOnly                | boolean    | N        | true to only enable Swish on ecommerce transactions.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

### 1.1 Use Case: PayEx Checkout without Checkin


{:.code-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Purchase",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",                                 
    "language": "sv-SE",
    "generateRecurrenceToken": false,                         
    "disablePaymentMenu": false,                              
    "urls": {
      "hostUrls": [ "http://test-dummy.net", "http://test-dummy2.net" ],
      "completeUrl": "http://test-dummy.net/payment-completed",
      "cancelUrl": "http://test-dummy.net/payment-canceled",
      "paymentUrl": "http://test-dymmy.net/payment",
      "callbackUrl": "http://test-dummy.net/payment-callback",     
      "termsOfServiceUrl": "http://test-dummy.net/termsandconditoons.pdf",
      "logoUrl": "http://test-dummy.net/logo.png"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",                                    
      "productCategory": "A123",                                   
      "subsite": "MySubsite",                                       
      "orderReference" : "or-123456"                               
    },
    "payer": {
      "nationalIdentifier": {                                      
        "socialSecurityNumber": "19XXXXXXXXXX",
        "countryCode": "SE"
      },
      "firstName": "string",                      
      "lastName": "string",                 
      "email": "string",      
      "msisdn": "string",                 
      "workPhoneNumber" : "string",                        
      "homePhoneNumber" : "string",                        
      "shippingAddress" : {                    
        "firstName" : "firstname/compnayname", 
        "lastName" : "lastname",               
        "email": "string",       
        "msisdn": "string",      
        "streetAddress" : "string",      
        "coAddress" : "string",          
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "billingAddress" : {                      
        "firstName" : "firstname/compnayname",  
        "lastName" : "lastname",                
        "email": "string",      
        "msisdn": "string",                
        "streetAddress" : "string",        
        "coAddress" : "string",            
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "accountInfo" : {                                 
        "accountAgeIndicator" : "01",       
        "accountChangeIndicator" : "01",       
        "accountPwdChangeIndicator" : "01", 
        "shippingAddressUsageIndicator" : "01",
        "shippingNameIndicator" : "01",              
        "suspiciousAccountActivity" : "01",        
        "addressMatchIndicator": "false"           
      }
     },
    "riskIndicator" : {
       "deliveryEmailAddress" : "string",               
       "deliveryTimeFrameindicator" : "01",    
       "preOrderDate" : "YYYYMMDD",                     
       "preOrderPurchaseIndicator" : "01",           
       "shipIndicator" : "01",        
       "giftCardPurchase" : "false",               
       "reOrderPurchaseIndicator" : "01",            
       "pickUpAddress" : {                              
           "name" : "companyname",                      
           "streetAddress" : "string",                  
           "coAddress" : "string",                      
           "city" : "string",
           "zipCode" : "string",
           "countryCode" : "string"
       }
    },
    "metadata": {                                          
      "key1": "value1",
      "key2": 2,
      "key3": 3.1,
      "key4": false
    },
    "items": [                                             
    {
      "creditCard": {
        "rejectCreditCards": false,                   
        "rejectDebitCards": false,                    
        "rejectConsumerCards": false,                 
        "rejectCorporateCards": false                 
      }
    },
    {
      "invoice": {
        "feeAmount" : 1900
      }
    },
    {
      "campaignInvoice": {
        "campaignCode" : "Campaign1",
        "feeAmount" : 2900 
      }
    },
    {
      "swish": {
        "EnableEcomOnly": false                 
      }
    }
   ]
  }
}
```

{:.table .table-striped}
| Property                                      | Type       | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|-----------------------------------------------|------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder                                  | object     | Y        | The payment order object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| operation                                     | string     | Y        | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| currency                                      | string     | Y        | The currency of the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| amount                                        | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                      |
| vatAmount                                     | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                             |
| description                                   | string     | Y        | The description of the payment order.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| userAgent                                     | string     | N        | The user agent of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| language                                      | string     | Y        | The language of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| generateRecurrenceToken                       | boolean    | N        | Determines if a recurrence token should be generated. A recurrence token is primarily used to enable recurring payments through server-to-server calls. Default value is false                                                                                                                                                                                                                                                                                                                                     |
| urls.hostUrls                                 | array      | Y        | The array of URIs valid for embedding of PayEx Hosted Views.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.completeUrl                              | string     | Y        | The URI to redirect the payer to once the payment is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.cancelUrl                                | string     | N        | The URI to redirect the payer to if the payment is canceled.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.paymentUrl                               | string     | N        | The URI that PayEx will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted views. Can not be used simultaneously with cancelUrl; only cancelUrl or paymentUrl can be used, not both.                                                                                                                                                                                                                                          |
| urls.callbackUrl                              | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                                                                                                                                                                                                                                                                                                                                                          |
| urls.termsOfServiceUrl                        | string     | Y        | The URI to the terms of service document the payer must accept in order to complete the payment. Require https.                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.logoUrl                                  | string     | Y        | The URI to the logo that will be displayed on redirect pages. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| payeeInfo.payeeId                             | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| payeeInfo.payeeReference                      | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                                                                                                                                                                                                                                                                                                                                              |
| payeeInfo.payeeName                           | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| payeeInfo.productCategory                     | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                            |
| payeeInfo.subsite                             | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                               |
| payeeInfo.orderReference                      | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                            |
| payer.nationalIdentifier                      | object     | N        | Optional.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.socialSecurityNumber | string     | N        | Optional.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.countryCode          | string     | N        | Optional.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.firstName                               | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.lastName                                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.email                                   | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.msisdn                                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.homePhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.workPhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.firstName               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.lastName                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.streetAddress           | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.coAddress               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.city                    | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.zipCode                 | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.countryCode             | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.firstName                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.lastName                 | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.streetAddress            | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.coAddress                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.city                     | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.zipCode                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.countryCode              | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| accountInfo                                   | object     | N        | Optional. If payer is known by merchant and have some kind of registered user then these fields can be set.                                                                                                                                                                                                                                                                                                                                                                                                        |
| accountInfo.accountAgeIndicator               | string     | N        | Indicates the length of time that the payments account was enrolled in the cardholder's account with merchant.01 (No account, guest)02 (Created during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                     |
| accountInfo.accountChangeIndicator            | string     | N        | Length of time since the cardholder's account information with the merchant was changed. Including billing etc.01 (Changed during transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                          |
| accountInfo.accountPwdChangeIndicator         | string     | N        | Indicates the length of time since the cardholder's account with the merchant had a password change or account reset.01 (No change)02 (Changed during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                      |
| accountInfo.shippingAddressUsageIndicator     | string     | N        | Indicates when the shipping address used for this transaction was first used with the merchant.01 (This transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                                                    |
| accountInfo.shippingNameIndicator             | string     | N        | Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.01 (Account name identical to shipping name)02 (Account name different than shipping name)                                                                                                                                                                                                                                                                                                             |
| accountInfo.suspiciousAccountActivity         | string     | N        | Indicates whether merchant has experienced suspicious activity (including previous fraud) on the cardholder account.01 (No suspicious activity has been observed)02 (Suspicious activity has been observed)                                                                                                                                                                                                                                                                                                        |
| accountInfo.addressMatchIndicator             | boolean    | N        | Allows the 3DS Requestor to indicate to the ACS whether the cardholder’s billing and shipping address are the same.                                                                                                                                                                                                                                                                                                                                                                                                |
| riskIndicator.deliveryEmailAddress            | string     | N        | For electronic delivery, the email address to which the merchandise was delivered.                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| riskIndicator.deliveryTimeFrameIndicator      | string     | N        | Indicates the merchandise delivery timeframe.01 (Electronic Delivery)02 (Same day shipping)03 (Overnight shipping)04 (Two-day or more shipping)                                                                                                                                                                                                                                                                                                                                                                    |
| riskIndicator.preOrderDate                    | string     | N        | For a pre-ordered purchase. The expected date that the merchandise will be available.FORMAT: "YYYYMMDD"                                                                                                                                                                                                                                                                                                                                                                                                            |
| riskIndicator.preOrderPurchaseIndicator       | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.shipIndicator                   | string     | N        | Indicates shipping method chosen for the transaction.01 (Ship to cardholder's billing address)02 (Ship to another verified address on file with merchant)03 (Ship to address that is different than cardholder's billing address)04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)05 (Digital goods, includes online services, electronic giftcards and redemption codes)06 (Travel and Event tickets, not shipped)07 (Other, e.g. gaming, digital service) |
| riskIndicator.giftCardPurchase                | boolean    | N        | true if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| riskIndicator.reOrderPurchaseIndicator        | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.pickUpAddress                   | object     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.name              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.streetAddress     | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.coAddress         | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.city              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.zipCode           | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.countryCode       | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| metadata                                      | object     | N        | The keys and values that should be associated with the payment order. Can be additional identifiers and data you want to associate with the payment.                                                                                                                                                                                                                                                                                                                                                               |
| items                                         | array      | N        | The array of items that will affect how the payment is performed.                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| items.creditCard.rejectDebitCards             | boolean    | N        | true if debit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                             |
| items.creditCard.rejectCreditCards            | boolean    | N        | true if credit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                            |
| items.creditCard.rejectConsumerCards          | boolean    | N        | true if consumer cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                          |
| items.creditCard.rejectCorporateCards         | boolean    | N        | true if corporate cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                         |
| items.invoice.feeAmount                       | integer    | N        | The fee amount in the lowest monetary unit to apply if the consumer chooses to pay with invoice.                                                                                                                                                                                                                                                                                                                                                                                                                   |
| items.swish.enableEcomOnly                    | boolean    | N        | true to only enable Swish on ecommerce transactions.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

### 1.2 Use Case: PayEx Checkout - Merchant Onboarding

{:.code-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Purchase",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",                                 
    "language": "sv-SE",
    "generateRecurrenceToken": false,                         
    "disablePaymentMenu": false,                              
    "urls": {
      "hostUrls": [ "http://test-dummy.net", "http://test-dummy2.net" ],
      "completeUrl": "http://test-dummy.net/payment-completed",
      "cancelUrl": "http://test-dummy.net/payment-canceled",
      "paymentUrl": "http://test-dummy.net/payment",
      "callbackUrl": "http://test-dummy.net/payment-callback",     
      "termsOfServiceUrl": "http://test-dummy.net/termsandconditoons.pdf",
      "logoUrl": "http://test-dummy.net/logo.png"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",                                    
      "productCategory": "A123",                                   
      "subsite": "MySubsite",                                       
      "orderReference" : "or-123456"                               
    },
    "payer": {
      "nationalIdentifier": {                                      
        "socialSecurityNumber": "19XXXXXXXXXX",
        "countryCode": "SE"
      },
      "firstName": "string",                      
      "lastName": "string",                 
      "email": "string",      
      "msisdn": "string",                 
      "workPhoneNumber" : "string",                        
      "homePhoneNumber" : "string",                        
      "shippingAddress" : {                    
        "firstName" : "firstname/companyname", 
        "lastName" : "lastname",               
        "email": "string",       
        "msisdn": "string",      
        "streetAddress" : "string",      
        "coAddress" : "string",          
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "billingAddress" : {                      
        "firstName" : "firstname/companyname",  
        "lastName" : "lastname",                
        "email": "string",      
        "msisdn": "string",                
        "streetAddress" : "string",        
        "coAddress" : "string",            
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "accountInfo" : {                                 
        "accountAgeIndicator" : "01",       
        "accountChangeIndicator" : "01",       
        "accountPwdChangeIndicator" : "01", 
        "shippingAddressUsageIndicator" : "01",
        "shippingNameIndicator" : "01",              
        "suspiciousAccountActivity" : "01",        
        "addressMatchIndicator": "false"           
      }
     },
    "riskIndicator" : {
       "deliveryEmailAddress" : "string",               
       "deliveryTimeFrameindicator" : "01",    
       "preOrderDate" : "YYYYMMDD",                     
       "preOrderPurchaseIndicator" : "01",           
       "shipIndicator" : "01",        
       "giftCardPurchase" : "false",               
       "reOrderPurchaseIndicator" : "01",            
       "pickUpAddress" : {                              
           "name" : "companyname",                      
           "streetAddress" : "string",                  
           "coAddress" : "string",                      
           "city" : "string",
           "zipCode" : "string",
           "countryCode" : "string"
       }
    },
    "metadata": {                                          
      "key1": "value1",
      "key2": 2,
      "key3": 3.1,
      "key4": false
    },
    "items": [                                             
    {
      "creditCard": {
        "rejectCreditCards": false,                   
        "rejectDebitCards": false,                    
        "rejectConsumerCards": false,                 
        "rejectCorporateCards": false                 
      }
    },
    {
      "invoice": {
        "feeAmount" : 1900
      }
    },
    {
      "campaignInvoice": {
        "campaignCode" : "Campaign1",
        "feeAmount" : 2900 
      }
    },
    {
      "swish": {
        "EnableEcomOnly": false                 
      }
    }
   ]
  }
}
```

{:.table .table-striped}
| Property                                      | Type       | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|-----------------------------------------------|------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder                                  | object     | Y        | The payment order object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| operation                                     | string     | Y        | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| currency                                      | string     | Y        | The currency of the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| amount                                        | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                      |
| vatAmount                                     | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                             |
| description                                   | string     | Y        | The description of the payment order.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| userAgent                                     | string     | N        | The user agent of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| language                                      | string     | Y        | The language of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| generateRecurrenceToken                       | boolean    | N        | Determines if a recurrence token should be generated. A recurrence token is primarily used to enable recurring payments through server-to-server calls. Default value is false                                                                                                                                                                                                                                                                                                                                     |
| urls.hostUrls                                 | array      | Y        | The array of URIs valid for embedding of PayEx Hosted Views.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.completeUrl                              | string     | Y        | The URI to redirect the payer to once the payment is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.cancelUrl                                | string     | N        | The URI to redirect the payer to if the payment is canceled.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.paymentUrl                               | string     | N        | The URI that PayEx will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted views. Can not be used simultaneously with cancelUrl; only cancelUrl or paymentUrl can be used, not both.                                                                                                                                                                                                                                          |
| urls.callbackUrl                              | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                                                                                                                                                                                                                                                                                                                                                          |
| urls.termsOfServiceUrl                        | string     | Y        | The URI to the terms of service document the payer must accept in order to complete the payment. Require https.                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.logoUrl                                  | string     | Y        | The URI to the logo that will be displayed on redirect pages. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| payeeInfo.payeeId                             | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| payeeInfo.payeeReference                      | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                                                                                                                                                                                                                                                                                                                                              |
| payeeInfo.payeeName                           | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| payeeInfo.productCategory                     | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                            |
| payeeInfo.subsite                             | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                               |
| payeeInfo.orderReference                      | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                            |
| payer.nationalIdentifier                      | object     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.socialSecurityNumber | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.countryCode          | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.firstName                               | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.lastName                                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.email                                   | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.msisdn                                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.homePhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.workPhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.firstName               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.lastName                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.streetAddress           | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.coAddress               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.city                    | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.zipCode                 | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.countryCode             | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.firstName                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.lastName                 | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.streetAddress            | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.coAddress                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.city                     | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.zipCode                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.countryCode              | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| accountInfo                                   | object     | N        | Optional. If payer is known by merchant and have some kind of registered user then these fields can be set.                                                                                                                                                                                                                                                                                                                                                                                                        |
| accountInfo.accountAgeIndicator               | string     | N        | Indicates the length of time that the payments account was enrolled in the cardholder's account with merchant.01 (No account, guest)02 (Created during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                     |
| accountInfo.accountChangeIndicator            | string     | N        | Length of time since the cardholder's account information with the merchant was changed. Including billing etc.01 (Changed during transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                          |
| accountInfo.accountPwdChangeIndicator         | string     | N        | Indicates the length of time since the cardholder's account with the merchant had a password change or account reset.01 (No change)02 (Changed during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                      |
| accountInfo.shippingAddressUsageIndicator     | string     | N        | Indicates when the shipping address used for this transaction was first used with the merchant.01 (This transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                                                    |
| accountInfo.shippingNameIndicator             | string     | N        | Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.01 (Account name identical to shipping name)02 (Account name different than shipping name)                                                                                                                                                                                                                                                                                                             |
| accountInfo.suspiciousAccountActivity         | string     | N        | Indicates whether merchant has experienced suspicious activity (including previous fraud) on the cardholder account.01 (No suspicious activity has been observed)02 (Suspicious activity has been observed)                                                                                                                                                                                                                                                                                                        |
| accountInfo.addressMatchIndicator             | boolean    | N        | Allows the 3DS Requestor to indicate to the ACS whether the cardholder’s billing and shipping address are the same.                                                                                                                                                                                                                                                                                                                                                                                                |
| riskIndicator.deliveryEmailAddress            | string     | N        | For electronic delivery, the email address to which the merchandise was delivered.                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| riskIndicator.deliveryTimeFrameIndicator      | string     | N        | Indicates the merchandise delivery timeframe.01 (Electronic Delivery)02 (Same day shipping)03 (Overnight shipping)04 (Two-day or more shipping)                                                                                                                                                                                                                                                                                                                                                                    |
| riskIndicator.preOrderDate                    | string     | N        | For a pre-ordered purchase. The expected date that the merchandise will be available.FORMAT: "YYYYMMDD"                                                                                                                                                                                                                                                                                                                                                                                                            |
| riskIndicator.preOrderPurchaseIndicator       | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.shipIndicator                   | string     | N        | Indicates shipping method chosen for the transaction.01 (Ship to cardholder's billing address)02 (Ship to another verified address on file with merchant)03 (Ship to address that is different than cardholder's billing address)04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)05 (Digital goods, includes online services, electronic giftcards and redemption codes)06 (Travel and Event tickets, not shipped)07 (Other, e.g. gaming, digital service) |
| riskIndicator.giftCardPurchase                | boolean    | N        | true if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| riskIndicator.reOrderPurchaseIndicator        | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.pickUpAddress                   | object     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.name              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.streetAddress     | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.coAddress         | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.city              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.zipCode           | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.countryCode       | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| metadata                                      | object     | N        | The keys and values that should be associated with the payment order. Can be additional identifiers and data you want to associate with the payment.                                                                                                                                                                                                                                                                                                                                                               |
| items                                         | array      | N        | The array of items that will affect how the payment is performed.                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| items.creditCard.rejectDebitCards             | boolean    | N        | true if debit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                             |
| items.creditCard.rejectCreditCards            | boolean    | N        | true if credit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                            |
| items.creditCard.rejectConsumerCards          | boolean    | N        | true if consumer cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                          |
| items.creditCard.rejectCorporateCards         | boolean    | N        | true if corporate cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                         |
| items.invoice.feeAmount                       | integer    | N        | The fee amount in the lowest monetary unit to apply if the consumer chooses to pay with invoice.                                                                                                                                                                                                                                                                                                                                                                                                                   |
| items.swish.enableEcomOnly                    | boolean    | N        | true to only enable Swish on ecommerce transactions.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

## Use Cases: Payments
The following use case scenarios (e.g 1.0 Use Case: Regular Payments) will follow the Create Payment Order  [1.2 Use Case: PayEx Checkout - Merchant onboarding](#12-use-case-payex-checkout---merchant-onboarding)

## 1.0 Use Case: Regular Payments
A regular payment for single debit transaction.

{:.table .table-striped}
| Integration                                                | Allowed |
|------------------------------------------------------------|---------|
| PayEx Checkout with Checkin                                | Yes     |
| PayEx Checkout without Checkin                             | Yes     |
| PayEx Checkout without Checkin. Merchant onboards consumer | Yes     |

{:.table .table-striped}
| Function         | Allowed |
|------------------|---------|
| Recurring        | No      |
| Store card       | No      |
| Operation Verify | No      |

**The example requests will have specific parameters set to true or false if it's required in the scenario.**

### 1.1 Create Payment Order
Example follows Create Payment Order [1.2 Use Case: PayEx Checkout - Merchant onboarding](#12-use-case-payex-checkout---merchant-onboarding)

{:.code-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Purchase",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",                                 
    "language": "sv-SE",
    "generateRecurrenceToken": false,                         
    "disablePaymentMenu": false,                              
    "urls": {
      "hostUrls": [ "http://test-dummy.net", "http://test-dummy2.net" ],
      "completeUrl": "http://test-dummy.net/payment-completed",
      "cancelUrl": "http://test-dummy.net/payment-canceled",
      "paymentUrl": "http://test-dummy.net/payment",
      "callbackUrl": "http://test-dummy.net/payment-callback",     
      "termsOfServiceUrl": "http://test-dummy.net/termsandconditoons.pdf",
      "logoUrl": "http://test-dummy.net/logo.png"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",                                    
      "productCategory": "A123",                                   
      "subsite": "MySubsite",                                       
      "orderReference" : "or-123456"                               
    },
    "payer": {
      "nationalIdentifier": {                                      
        "socialSecurityNumber": "19XXXXXXXXXX",
        "countryCode": "SE"
      },
      "firstName": "string",                      
      "lastName": "string",                 
      "email": "string",      
      "msisdn": "string",                 
      "workPhoneNumber" : "string",                        
      "homePhoneNumber" : "string",                        
      "shippingAddress" : {                    
        "firstName" : "firstname/companyname", 
        "lastName" : "lastname",               
        "email": "string",       
        "msisdn": "string",      
        "streetAddress" : "string",      
        "coAddress" : "string",          
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "billingAddress" : {                      
        "firstName" : "firstname/companyname",  
        "lastName" : "lastname",                
        "email": "string",      
        "msisdn": "string",                
        "streetAddress" : "string",        
        "coAddress" : "string",            
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "accountInfo" : {                                 
        "accountAgeIndicator" : "01",       
        "accountChangeIndicator" : "01",       
        "accountPwdChangeIndicator" : "01", 
        "shippingAddressUsageIndicator" : "01",
        "shippingNameIndicator" : "01",              
        "suspiciousAccountActivity" : "01",        
        "addressMatchIndicator": "false"           
      }
     },
    "riskIndicator" : {
       "deliveryEmailAddress" : "string",               
       "deliveryTimeFrameindicator" : "01",    
       "preOrderDate" : "YYYYMMDD",                     
       "preOrderPurchaseIndicator" : "01",           
       "shipIndicator" : "01",        
       "giftCardPurchase" : "false",               
       "reOrderPurchaseIndicator" : "01",            
       "pickUpAddress" : {                              
           "name" : "companyname",                      
           "streetAddress" : "string",                  
           "coAddress" : "string",                      
           "city" : "string",
           "zipCode" : "string",
           "countryCode" : "string"
       }
    },
    "metadata": {                                          
      "key1": "value1",
      "key2": 2,
      "key3": 3.1,
      "key4": false
    },
    "items": [                                             
    {
      "creditCard": {
        "rejectCreditCards": false,                   
        "rejectDebitCards": false,                    
        "rejectConsumerCards": false,                 
        "rejectCorporateCards": false                 
      }
    },
    {
      "invoice": {
        "feeAmount" : 1900
      }
    },
    {
      "campaignInvoice": {
        "campaignCode" : "Campaign1",
        "feeAmount" : 2900 
      }
    },
    {
      "swish": {
        "EnableEcomOnly": false                 
      }
    }
   ]
  }
}
```
### 1.2 Create Payment Order Properties

{:.table.table-striped}
| Property                                      | Type       | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|-----------------------------------------------|------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder                                  | object     | Y        | The payment order object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| operation                                     | string     | Y        | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| currency                                      | string     | Y        | The currency of the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| amount                                        | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                      |
| vatAmount                                     | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                             |
| description                                   | string     | Y        | The description of the payment order.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| userAgent                                     | string     | N        | The user agent of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| language                                      | string     | Y        | The language of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| generateRecurrenceToken                       | boolean    | N        | Determines if a recurrence token should be generated. A recurrence token is primarily used to enable recurring payments through server-to-server calls. Default value is false                                                                                                                                                                                                                                                                                                                                     |
| urls.hostUrls                                 | array      | Y        | The array of URIs valid for embedding of PayEx Hosted Views.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.completeUrl                              | string     | Y        | The URI to redirect the payer to once the payment is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.cancelUrl                                | string     | N        | The URI to redirect the payer to if the payment is canceled.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.paymentUrl                               | string     | N        | The URI that PayEx will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted views. Can not be used simultaneously with cancelUrl; only cancelUrl or paymentUrl can be used, not both.                                                                                                                                                                                                                                          |
| urls.callbackUrl                              | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                                                                                                                                                                                                                                                                                                                                                          |
| urls.termsOfServiceUrl                        | string     | Y        | The URI to the terms of service document the payer must accept in order to complete the payment. Require https.                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.logoUrl                                  | string     | Y        | The URI to the logo that will be displayed on redirect pages. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| payeeInfo.payeeId                             | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| payeeInfo.payeeReference                      | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                                                                                                                                                                                                                                                                                                                                              |
| payeeInfo.payeeName                           | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| payeeInfo.productCategory                     | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                            |
| payeeInfo.subsite                             | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                               |
| payeeInfo.orderReference                      | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                            |
| payer.nationalIdentifier                      | object     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.socialSecurityNumber | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.countryCode          | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.firstName                               | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.lastName                                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.email                                   | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.msisdn                                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.homePhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.workPhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.firstName               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.lastName                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.streetAddress           | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.coAddress               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.city                    | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.zipCode                 | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.countryCode             | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.firstName                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.lastName                 | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.streetAddress            | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.coAddress                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.city                     | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.zipCode                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.countryCode              | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| accountInfo                                   | object     | N        | Optional. If payer is known by merchant and have some kind of registered user then these fields can be set.                                                                                                                                                                                                                                                                                                                                                                                                        |
| accountInfo.accountAgeIndicator               | string     | N        | Indicates the length of time that the payments account was enrolled in the cardholder's account with merchant.01 (No account, guest)02 (Created during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                     |
| accountInfo.accountChangeIndicator            | string     | N        | Length of time since the cardholder's account information with the merchant was changed. Including billing etc.01 (Changed during transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                          |
| accountInfo.accountPwdChangeIndicator         | string     | N        | Indicates the length of time since the cardholder's account with the merchant had a password change or account reset.01 (No change)02 (Changed during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                      |
| accountInfo.shippingAddressUsageIndicator     | string     | N        | Indicates when the shipping address used for this transaction was first used with the merchant.01 (This transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                                                    |
| accountInfo.shippingNameIndicator             | string     | N        | Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.01 (Account name identical to shipping name)02 (Account name different than shipping name)                                                                                                                                                                                                                                                                                                             |
| accountInfo.suspiciousAccountActivity         | string     | N        | Indicates whether merchant has experienced suspicious activity (including previous fraud) on the cardholder account.01 (No suspicious activity has been observed)02 (Suspicious activity has been observed)                                                                                                                                                                                                                                                                                                        |
| accountInfo.addressMatchIndicator             | boolean    | N        | Allows the 3DS Requestor to indicate to the ACS whether the cardholder’s billing and shipping address are the same.                                                                                                                                                                                                                                                                                                                                                                                                |
| riskIndicator.deliveryEmailAddress            | string     | N        | For electronic delivery, the email address to which the merchandise was delivered.                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| riskIndicator.deliveryTimeFrameIndicator      | string     | N        | Indicates the merchandise delivery timeframe.01 (Electronic Delivery)02 (Same day shipping)03 (Overnight shipping)04 (Two-day or more shipping)                                                                                                                                                                                                                                                                                                                                                                    |
| riskIndicator.preOrderDate                    | string     | N        | For a pre-ordered purchase. The expected date that the merchandise will be available.FORMAT: "YYYYMMDD"                                                                                                                                                                                                                                                                                                                                                                                                            |
| riskIndicator.preOrderPurchaseIndicator       | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.shipIndicator                   | string     | N        | Indicates shipping method chosen for the transaction.01 (Ship to cardholder's billing address)02 (Ship to another verified address on file with merchant)03 (Ship to address that is different than cardholder's billing address)04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)05 (Digital goods, includes online services, electronic giftcards and redemption codes)06 (Travel and Event tickets, not shipped)07 (Other, e.g. gaming, digital service) |
| riskIndicator.giftCardPurchase                | boolean    | N        | true if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| riskIndicator.reOrderPurchaseIndicator        | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.pickUpAddress                   | object     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.name              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.streetAddress     | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.coAddress         | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.city              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.zipCode           | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.countryCode       | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| metadata                                      | object     | N        | The keys and values that should be associated with the payment order. Can be additional identifiers and data you want to associate with the payment.                                                                                                                                                                                                                                                                                                                                                               |
| items                                         | array      | N        | The array of items that will affect how the payment is performed.                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| items.creditCard.rejectDebitCards             | boolean    | N        | true if debit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                             |
| items.creditCard.rejectCreditCards            | boolean    | N        | true if credit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                            |
| items.creditCard.rejectConsumerCards          | boolean    | N        | true if consumer cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                          |
| items.creditCard.rejectCorporateCards         | boolean    | N        | true if corporate cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                         |
| items.invoice.feeAmount                       | integer    | N        | The fee amount in the lowest monetary unit to apply if the consumer chooses to pay with invoice.                                                                                                                                                                                                                                                                                                                                                                                                                   |
| items.swish.enableEcomOnly                    | boolean    | N        | true to only enable Swish on ecommerce transactions.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

### 1.3 Create Payment Order Response

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Purchase",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
    "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
    "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
    "items": [
      {
        "creditCard": {
          "cardBrands": [ "Visa", "MasterCard", "Ica", "etc..." ]
        }
      },
      { "invoice": {} },
      { "campaignInvoice": {} },
      { "swish": {} },
      { "vipps": {} }
    ]
  },
  "operations": [
    {
      "href": "https://ecom.payex.com/paymentorders/123456123412341234123456789012",
      "rel": "redirect-paymentorder",
      "method": "GET",
      "contentType": "application/json"
    },
    {
      "href": "https://ecom.dev.payex.com/paymentmenu/scripts/client/client-paymentmenu.js",
      "rel": "view-paymentorder",
      "method": "GET",
      "contentType": "application/javascript"
    }
  ]
}
```

## 2.0 Use Case: Recurring Payments
Create a recurrenceToken with an initial purchase or verify paymentOrder to enable the recurring scenario. 

{:.table.table-striped}
| Integration                                                | Allowed |
|------------------------------------------------------------|---------|
| PayEx Checkout with Checkin                                | Yes     |
| PayEx Checkout without Checkin                             | Yes     |
| PayEx Checkout without Checkin. Merchant onboards consumer | Yes     |

{:.table.table-striped}
| Function         | Allowed |
|------------------|---------|
| Recurring        | Yes     |
| Store card       | No      |
| Operation Verify | Yes     |

**The example requests will have specific parameters set to true or false if it's required in the scenario.**

### 2.1 Create Payment Order with initiating purchase

Set generateRecurrenceToken value to **true** and a recurrenceToken will be available to retrieve after the completed payment.

Example follows Create Payment Order [1.2 Use Case: PayEx Checkout - Merchant onboarding](#12-use-case-payex-checkout---merchant-onboarding)

{:.code-header}
**Request**
```http
POST /psp/paymentorders HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Purchase",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",                                 
    "language": "sv-SE",
    "generateRecurrenceToken": true,                         
    "disablePaymentMenu": false,                              
    "urls": {
      "hostUrls": [ "http://test-dummy.net", "http://test-dummy2.net" ],
      "completeUrl": "http://test-dummy.net/payment-completed",
      "cancelUrl": "http://test-dummy.net/payment-canceled",
      "paymentUrl": "http://test-dummy.net/payment",
      "callbackUrl": "http://test-dummy.net/payment-callback",     
      "termsOfServiceUrl": "http://test-dummy.net/termsandconditoons.pdf",
      "logoUrl": "http://test-dummy.net/logo.png"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",                                    
      "productCategory": "A123",                                   
      "subsite": "MySubsite",                                       
      "orderReference" : "or-123456"                               
    },
    "payer": {
      "nationalIdentifier": {                                      
        "socialSecurityNumber": "19XXXXXXXXXX",
        "countryCode": "SE"
      },
      "firstName": "string",                      
      "lastName": "string",                 
      "email": "string",      
      "msisdn": "string",                 
      "workPhoneNumber" : "string",                        
      "homePhoneNumber" : "string",                        
      "shippingAddress" : {                    
        "firstName" : "firstname/companyname", 
        "lastName" : "lastname",               
        "email": "string",       
        "msisdn": "string",      
        "streetAddress" : "string",      
        "coAddress" : "string",          
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "billingAddress" : {                      
        "firstName" : "firstname/companyname",  
        "lastName" : "lastname",                
        "email": "string",      
        "msisdn": "string",                
        "streetAddress" : "string",        
        "coAddress" : "string",            
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "accountInfo" : {                                 
        "accountAgeIndicator" : "01",       
        "accountChangeIndicator" : "01",       
        "accountPwdChangeIndicator" : "01", 
        "shippingAddressUsageIndicator" : "01",
        "shippingNameIndicator" : "01",              
        "suspiciousAccountActivity" : "01",        
        "addressMatchIndicator": "false"           
      }
     },
    "riskIndicator" : {
       "deliveryEmailAddress" : "string",               
       "deliveryTimeFrameindicator" : "01",    
       "preOrderDate" : "YYYYMMDD",                     
       "preOrderPurchaseIndicator" : "01",           
       "shipIndicator" : "01",        
       "giftCardPurchase" : "false",               
       "reOrderPurchaseIndicator" : "01",            
       "pickUpAddress" : {                              
           "name" : "companyname",                      
           "streetAddress" : "string",                  
           "coAddress" : "string",                      
           "city" : "string",
           "zipCode" : "string",
           "countryCode" : "string"
       }
    },
    "metadata": {                                          
      "key1": "value1",
      "key2": 2,
      "key3": 3.1,
      "key4": false
    },
    "items": [                                             
    {
      "creditCard": {
        "rejectCreditCards": false,                   
        "rejectDebitCards": false,                    
        "rejectConsumerCards": false,                 
        "rejectCorporateCards": false                 
      }
    },
    {
      "invoice": {
        "feeAmount" : 1900
      }
    },
    {
      "campaignInvoice": {
        "campaignCode" : "Campaign1",
        "feeAmount" : 2900 
      }
    },
    {
      "swish": {
        "EnableEcomOnly": false                 
      }
    }
   ]
  }
}
```

{:.table.table-striped}
| Property                                      | Type       | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|-----------------------------------------------|------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder                                  | object     | Y        | The payment order object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| operation                                     | string     | Y        | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| currency                                      | string     | Y        | The currency of the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| amount                                        | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                      |
| vatAmount                                     | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                             |
| description                                   | string     | Y        | The description of the payment order.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| userAgent                                     | string     | N        | The user agent of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| language                                      | string     | Y        | The language of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| generateRecurrenceToken                       | boolean    | N        | Determines if a recurrence token should be generated. A recurrence token is primarily used to enable recurring payments through server-to-server calls. Default value is false                                                                                                                                                                                                                                                                                                                                     |
| urls.hostUrls                                 | array      | Y        | The array of URIs valid for embedding of PayEx Hosted Views.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.completeUrl                              | string     | Y        | The URI to redirect the payer to once the payment is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.cancelUrl                                | string     | N        | The URI to redirect the payer to if the payment is canceled.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.paymentUrl                               | string     | N        | The URI that PayEx will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted views. Can not be used simultaneously with cancelUrl; only cancelUrl or paymentUrl can be used, not both.                                                                                                                                                                                                                                          |
| urls.callbackUrl                              | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                                                                                                                                                                                                                                                                                                                                                          |
| urls.termsOfServiceUrl                        | string     | Y        | The URI to the terms of service document the payer must accept in order to complete the payment. Require https.                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.logoUrl                                  | string     | Y        | The URI to the logo that will be displayed on redirect pages. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| payeeInfo.payeeId                             | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| payeeInfo.payeeReference                      | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                                                                                                                                                                                                                                                                                                                                              |
| payeeInfo.payeeName                           | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| payeeInfo.productCategory                     | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                            |
| payeeInfo.subsite                             | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                               |
| payeeInfo.orderReference                      | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                            |
| payer.nationalIdentifier                      | object     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.socialSecurityNumber | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.countryCode          | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.firstName                               | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.lastName                                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.email                                   | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.msisdn                                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.homePhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.workPhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.firstName               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.lastName                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.streetAddress           | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.coAddress               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.city                    | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.zipCode                 | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.countryCode             | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.firstName                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.lastName                 | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.streetAddress            | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.coAddress                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.city                     | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.zipCode                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.countryCode              | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| accountInfo                                   | object     | N        | Optional. If payer is known by merchant and have some kind of registered user then these fields can be set.                                                                                                                                                                                                                                                                                                                                                                                                        |
| accountInfo.accountAgeIndicator               | string     | N        | Indicates the length of time that the payments account was enrolled in the cardholder's account with merchant.01 (No account, guest)02 (Created during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                     |
| accountInfo.accountChangeIndicator            | string     | N        | Length of time since the cardholder's account information with the merchant was changed. Including billing etc.01 (Changed during transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                          |
| accountInfo.accountPwdChangeIndicator         | string     | N        | Indicates the length of time since the cardholder's account with the merchant had a password change or account reset.01 (No change)02 (Changed during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                      |
| accountInfo.shippingAddressUsageIndicator     | string     | N        | Indicates when the shipping address used for this transaction was first used with the merchant.01 (This transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                                                    |
| accountInfo.shippingNameIndicator             | string     | N        | Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.01 (Account name identical to shipping name)02 (Account name different than shipping name)                                                                                                                                                                                                                                                                                                             |
| accountInfo.suspiciousAccountActivity         | string     | N        | Indicates whether merchant has experienced suspicious activity (including previous fraud) on the cardholder account.01 (No suspicious activity has been observed)02 (Suspicious activity has been observed)                                                                                                                                                                                                                                                                                                        |
| accountInfo.addressMatchIndicator             | boolean    | N        | Allows the 3DS Requestor to indicate to the ACS whether the cardholder’s billing and shipping address are the same.                                                                                                                                                                                                                                                                                                                                                                                                |
| riskIndicator.deliveryEmailAddress            | string     | N        | For electronic delivery, the email address to which the merchandise was delivered.                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| riskIndicator.deliveryTimeFrameIndicator      | string     | N        | Indicates the merchandise delivery timeframe.01 (Electronic Delivery)02 (Same day shipping)03 (Overnight shipping)04 (Two-day or more shipping)                                                                                                                                                                                                                                                                                                                                                                    |
| riskIndicator.preOrderDate                    | string     | N        | For a pre-ordered purchase. The expected date that the merchandise will be available.FORMAT: "YYYYMMDD"                                                                                                                                                                                                                                                                                                                                                                                                            |
| riskIndicator.preOrderPurchaseIndicator       | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.shipIndicator                   | string     | N        | Indicates shipping method chosen for the transaction.01 (Ship to cardholder's billing address)02 (Ship to another verified address on file with merchant)03 (Ship to address that is different than cardholder's billing address)04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)05 (Digital goods, includes online services, electronic giftcards and redemption codes)06 (Travel and Event tickets, not shipped)07 (Other, e.g. gaming, digital service) |
| riskIndicator.giftCardPurchase                | boolean    | N        | true if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| riskIndicator.reOrderPurchaseIndicator        | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.pickUpAddress                   | object     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.name              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.streetAddress     | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.coAddress         | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.city              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.zipCode           | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.countryCode       | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| metadata                                      | object     | N        | The keys and values that should be associated with the payment order. Can be additional identifiers and data you want to associate with the payment.                                                                                                                                                                                                                                                                                                                                                               |
| items                                         | array      | N        | The array of items that will affect how the payment is performed.                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| items.creditCard.rejectDebitCards             | boolean    | N        | true if debit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                             |
| items.creditCard.rejectCreditCards            | boolean    | N        | true if credit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                            |
| items.creditCard.rejectConsumerCards          | boolean    | N        | true if consumer cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                          |
| items.creditCard.rejectCorporateCards         | boolean    | N        | true if corporate cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                         |
| items.invoice.feeAmount                       | integer    | N        | The fee amount in the lowest monetary unit to apply if the consumer chooses to pay with invoice.                                                                                                                                                                                                                                                                                                                                                                                                                   |
| items.swish.enableEcomOnly                    | boolean    | N        | true to only enable Swish on ecommerce transactions.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Purchase",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
    "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
    "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
    "items": [
      {
        "creditCard": {
          "cardBrands": [ "Visa", "MasterCard", "Ica", "etc..." ]
        }
      },
      { "invoice": {} },
      { "campaignInvoice": {} },
      { "swish": {} },
      { "vipps": {} }
    ]
  },
  "operations": [
    {
      "href": "https://ecom.payex.com/paymentorders/123456123412341234123456789012",
      "rel": "redirect-paymentorder",
      "method": "GET",
      "contentType": "application/json"
    },
    {
      "href": "https://ecom.dev.payex.com/paymentmenu/scripts/client/client-paymentmenu.js",
      "rel": "view-paymentorder",
      "method": "GET",
      "contentType": "application/javascript"
    }
  ]
}
```

### 2.2 Retrieve Recurrence Token
When the consumer has completed their payment in the initially created payment order, you are able to retrieve the recurrenceToken from the payment order.

{:.code-header}
**Request**
```http
GET /psp/paymentorders/<paymentOrderId>/currentpayment HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json
```

{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "recurrenceToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
    "menuElementName": "creditcard",
    "payment": {
        "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
        "number": 1234567890,
        "instrument": "CreditCard",
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "operation": "Purchase",
        "intent": "Authorization",
        "state": "Ready",
        "currency": "SEK",
        "amount": 1500,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "paymentToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
        "prices": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/prices" },
        "transactions": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions" },
        "authorizations": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/authorizations" },
        "captures": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/captures" },
        "cancellations": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/cancellations" },
        "reversals": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals" },
        "verifications": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/verifications" },
        "urls" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
        "payeeInfo" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
        "metadata" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/metadata" },
        "settings": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" }
    },
    "operations": []
}
```

### 2.3 Recurring Payment
When you have a recurrence token safely tucked away, you can use this token in a subsequent Recur payment. This will be a server-to-server affair, as we have tied all necessary payment instrument details related to the recurrence token during the initial payment order.

{:.code-header}
**Request**
```http
POST /psp/paymentorders HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Recur",
    "intent": "Authorization",
    "recurrenceToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Recurrence",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls": {
      "callbackUrl": "http://test-dummy.net/payment-callback"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",
      "productCategory": "A123",
      "orderReference": "orderRef123",
      "subsite": "MySubsite"       
    }
  }
}
``` 

{:.table.table-striped}
| Property                  | Type       | Required | Description                                                                                                                                                                             |
|---------------------------|------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder              | object     | Y        | The payment order object.                                                                                                                                                               |
| operation                 | string     | Y        | Recur is always used for recurring payments.                                                                                                                                            |
| intent                    | string     | Y        | The intent of the payment.                                                                                                                                                              |
| recurrenceToken           | string     | Y        | The reccurenceToken to debit.                                                                                                                                                           |
| currency                  | string     | Y        | The currency of the payment.                                                                                                                                                            |
| amount                    | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                           |
| vatAmount                 | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                  |
| description               | string     | Y        | The description of the payment order.                                                                                                                                                   |
| userAgent                 | string     | Y        | The user agent of the payer.                                                                                                                                                            |
| language                  | string     | Y        | The language of the payer.                                                                                                                                                              |
| urls.callbackUrl          | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                               |
| payeeInfo.payeeId         | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                           |
| payeeInfo.payeeReference  | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                   |
| payeeInfo.payeeName       | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                |
| payeeInfo.productCategory | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process. |
| payeeInfo.orderReference  | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                 |
| payeeInfo.subsite         | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                    |

{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Recur",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
    "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
    "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
    "items": [
      {
        "creditCard": {
          "cardBrands": [ "Visa", "MasterCard", "Ica", "etc..." ]
        }
      },
      { "invoice": {} },
      { "campaignInvoice": {} },
      { "swish": {} },
      { "vipps": {} }
    ]
  },
  "operations":  [
      {
      }
  ]
}
``` 

## 3.0 Use Case: Stored Card Payments
A payment order where the consumer stores their card during the payment. As you will notice, this scenario is the same as a regular payment. This is because the choice is on the consumers end to store their card data on their profile, this option will be available for the consumer inside the payment menu. If the consumer chooses to store their card data, the used card data will be shown (masked) and available to use in future payments.

If you allow consumers to store cards on their profile without making any purchase, use operation Verify.

{:.table.table-striped}
| Integration                                                | Allowed |
|------------------------------------------------------------|---------|
| PayEx Checkout with Checkin                                | Yes     |
| PayEx Checkout without Checkin                             | No      |
| PayEx Checkout without Checkin. Merchant onboards consumer | Yes     |

{:.table.table-striped}
| Function         | Allowed |
|------------------|---------|
| Recurring        | No      |
| Store card       | Yes     |
| Operation Verify | Yes     |

**The example requests will have specific parameters set to true or false if it's required in the scenario.**

### 3.1 Create Payment Order
Example follows Create Payment Order [1.2 Use Case: PayEx Checkout - Merchant onboarding](#12-use-case-payex-checkout---merchant-onboarding)

{:.code-header}
**Request**
```http
POST /psp/paymentorders HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Purchase",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",                                 
    "language": "sv-SE",
    "generateRecurrenceToken": false,                         
    "disablePaymentMenu": false,                              
    "urls": {
      "hostUrls": [ "http://test-dummy.net", "http://test-dummy2.net" ],
      "completeUrl": "http://test-dummy.net/payment-completed",
      "cancelUrl": "http://test-dummy.net/payment-canceled",
      "paymentUrl": "http://test-dummy.net/payment",
      "callbackUrl": "http://test-dummy.net/payment-callback",     
      "termsOfServiceUrl": "http://test-dummy.net/termsandconditoons.pdf",
      "logoUrl": "http://test-dummy.net/logo.png"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",                                    
      "productCategory": "A123",                                   
      "subsite": "MySubsite",                                       
      "orderReference" : "or-123456"                               
    },
    "payer": {
      "nationalIdentifier": {                                      
        "socialSecurityNumber": "19XXXXXXXXXX",
        "countryCode": "SE"
      },
      "firstName": "string",                      
      "lastName": "string",                 
      "email": "string",      
      "msisdn": "string",                 
      "workPhoneNumber" : "string",                        
      "homePhoneNumber" : "string",                        
      "shippingAddress" : {                    
        "firstName" : "firstname/companyname", 
        "lastName" : "lastname",               
        "email": "string",       
        "msisdn": "string",      
        "streetAddress" : "string",      
        "coAddress" : "string",          
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "billingAddress" : {                      
        "firstName" : "firstname/companyname",  
        "lastName" : "lastname",                
        "email": "string",      
        "msisdn": "string",                
        "streetAddress" : "string",        
        "coAddress" : "string",            
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "accountInfo" : {                                 
        "accountAgeIndicator" : "01",       
        "accountChangeIndicator" : "01",       
        "accountPwdChangeIndicator" : "01", 
        "shippingAddressUsageIndicator" : "01",
        "shippingNameIndicator" : "01",              
        "suspiciousAccountActivity" : "01",        
        "addressMatchIndicator": "false"           
      }
     },
    "riskIndicator" : {
       "deliveryEmailAddress" : "string",               
       "deliveryTimeFrameindicator" : "01",    
       "preOrderDate" : "YYYYMMDD",                     
       "preOrderPurchaseIndicator" : "01",           
       "shipIndicator" : "01",        
       "giftCardPurchase" : "false",               
       "reOrderPurchaseIndicator" : "01",            
       "pickUpAddress" : {                              
           "name" : "companyname",                      
           "streetAddress" : "string",                  
           "coAddress" : "string",                      
           "city" : "string",
           "zipCode" : "string",
           "countryCode" : "string"
       }
    },
    "metadata": {                                          
      "key1": "value1",
      "key2": 2,
      "key3": 3.1,
      "key4": false
    },
    "items": [                                             
    {
      "creditCard": {
        "rejectCreditCards": false,                   
        "rejectDebitCards": false,                    
        "rejectConsumerCards": false,                 
        "rejectCorporateCards": false                 
      }
    },
    {
      "invoice": {
        "feeAmount" : 1900
      }
    },
    {
      "campaignInvoice": {
        "campaignCode" : "Campaign1",
        "feeAmount" : 2900 
      }
    },
    {
      "swish": {
        "EnableEcomOnly": false                 
      }
    }
   ]
  }
}
```

{:.table.table-striped}
| Property                                      | Type       | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|-----------------------------------------------|------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder                                  | object     | Y        | The payment order object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| operation                                     | string     | Y        | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| currency                                      | string     | Y        | The currency of the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| amount                                        | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                      |
| vatAmount                                     | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                             |
| description                                   | string     | Y        | The description of the payment order.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| userAgent                                     | string     | N        | The user agent of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| language                                      | string     | Y        | The language of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| generateRecurrenceToken                       | boolean    | N        | Determines if a recurrence token should be generated. A recurrence token is primarily used to enable recurring payments through server-to-server calls. Default value is false                                                                                                                                                                                                                                                                                                                                     |
| urls.hostUrls                                 | array      | Y        | The array of URIs valid for embedding of PayEx Hosted Views.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.completeUrl                              | string     | Y        | The URI to redirect the payer to once the payment is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.cancelUrl                                | string     | N        | The URI to redirect the payer to if the payment is canceled.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.paymentUrl                               | string     | N        | The URI that PayEx will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted views. Can not be used simultaneously with cancelUrl; only cancelUrl or paymentUrl can be used, not both.                                                                                                                                                                                                                                          |
| urls.callbackUrl                              | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                                                                                                                                                                                                                                                                                                                                                          |
| urls.termsOfServiceUrl                        | string     | Y        | The URI to the terms of service document the payer must accept in order to complete the payment. Require https.                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.logoUrl                                  | string     | Y        | The URI to the logo that will be displayed on redirect pages. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| payeeInfo.payeeId                             | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| payeeInfo.payeeReference                      | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                                                                                                                                                                                                                                                                                                                                              |
| payeeInfo.payeeName                           | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| payeeInfo.productCategory                     | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                            |
| payeeInfo.subsite                             | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                               |
| payeeInfo.orderReference                      | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                            |
| payer.nationalIdentifier                      | object     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.socialSecurityNumber | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.countryCode          | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.firstName                               | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.lastName                                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.email                                   | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.msisdn                                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.homePhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.workPhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.firstName               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.lastName                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.streetAddress           | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.coAddress               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.city                    | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.zipCode                 | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.countryCode             | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.firstName                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.lastName                 | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.streetAddress            | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.coAddress                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.city                     | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.zipCode                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.countryCode              | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| accountInfo                                   | object     | N        | Optional. If payer is known by merchant and have some kind of registered user then these fields can be set.                                                                                                                                                                                                                                                                                                                                                                                                        |
| accountInfo.accountAgeIndicator               | string     | N        | Indicates the length of time that the payments account was enrolled in the cardholder's account with merchant.01 (No account, guest)02 (Created during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                     |
| accountInfo.accountChangeIndicator            | string     | N        | Length of time since the cardholder's account information with the merchant was changed. Including billing etc.01 (Changed during transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                          |
| accountInfo.accountPwdChangeIndicator         | string     | N        | Indicates the length of time since the cardholder's account with the merchant had a password change or account reset.01 (No change)02 (Changed during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                      |
| accountInfo.shippingAddressUsageIndicator     | string     | N        | Indicates when the shipping address used for this transaction was first used with the merchant.01 (This transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                                                    |
| accountInfo.shippingNameIndicator             | string     | N        | Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.01 (Account name identical to shipping name)02 (Account name different than shipping name)                                                                                                                                                                                                                                                                                                             |
| accountInfo.suspiciousAccountActivity         | string     | N        | Indicates whether merchant has experienced suspicious activity (including previous fraud) on the cardholder account.01 (No suspicious activity has been observed)02 (Suspicious activity has been observed)                                                                                                                                                                                                                                                                                                        |
| accountInfo.addressMatchIndicator             | boolean    | N        | Allows the 3DS Requestor to indicate to the ACS whether the cardholder’s billing and shipping address are the same.                                                                                                                                                                                                                                                                                                                                                                                                |
| riskIndicator.deliveryEmailAddress            | string     | N        | For electronic delivery, the email address to which the merchandise was delivered.                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| riskIndicator.deliveryTimeFrameIndicator      | string     | N        | Indicates the merchandise delivery timeframe.01 (Electronic Delivery)02 (Same day shipping)03 (Overnight shipping)04 (Two-day or more shipping)                                                                                                                                                                                                                                                                                                                                                                    |
| riskIndicator.preOrderDate                    | string     | N        | For a pre-ordered purchase. The expected date that the merchandise will be available.FORMAT: "YYYYMMDD"                                                                                                                                                                                                                                                                                                                                                                                                            |
| riskIndicator.preOrderPurchaseIndicator       | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.shipIndicator                   | string     | N        | Indicates shipping method chosen for the transaction.01 (Ship to cardholder's billing address)02 (Ship to another verified address on file with merchant)03 (Ship to address that is different than cardholder's billing address)04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)05 (Digital goods, includes online services, electronic giftcards and redemption codes)06 (Travel and Event tickets, not shipped)07 (Other, e.g. gaming, digital service) |
| riskIndicator.giftCardPurchase                | boolean    | N        | true if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| riskIndicator.reOrderPurchaseIndicator        | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.pickUpAddress                   | object     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.name              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.streetAddress     | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.coAddress         | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.city              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.zipCode           | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.countryCode       | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| metadata                                      | object     | N        | The keys and values that should be associated with the payment order. Can be additional identifiers and data you want to associate with the payment.                                                                                                                                                                                                                                                                                                                                                               |
| items                                         | array      | N        | The array of items that will affect how the payment is performed.                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| items.creditCard.rejectDebitCards             | boolean    | N        | true if debit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                             |
| items.creditCard.rejectCreditCards            | boolean    | N        | true if credit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                            |
| items.creditCard.rejectConsumerCards          | boolean    | N        | true if consumer cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                          |
| items.creditCard.rejectCorporateCards         | boolean    | N        | true if corporate cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                         |
| items.invoice.feeAmount                       | integer    | N        | The fee amount in the lowest monetary unit to apply if the consumer chooses to pay with invoice.                                                                                                                                                                                                                                                                                                                                                                                                                   |
| items.swish.enableEcomOnly                    | boolean    | N        | true to only enable Swish on ecommerce transactions.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Purchase",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
    "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
    "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
    "items": [
      {
        "creditCard": {
          "cardBrands": [ "Visa", "MasterCard", "Ica", "etc..." ]
        }
      },
      { "invoice": {} },
      { "campaignInvoice": {} },
      { "swish": {} },
      { "vipps": {} }
    ]
  },
  "operations": [
    {
      "href": "https://ecom.payex.com/paymentorders/123456123412341234123456789012",
      "rel": "redirect-paymentorder",
      "method": "GET",
      "contentType": "application/json"
    },
    {
      "href": "https://ecom.dev.payex.com/paymentmenu/scripts/client/client-paymentmenu.js",
      "rel": "view-paymentorder",
      "method": "GET",
      "contentType": "application/javascript"
    }
  ]
}
```

### 3.2 Stored Card Payment Order
The card data is stored after the payment is completed and if the consumer chose to store their card. Go back to [3.1 Create Payment Order](#31-create-payment-order) and perform the same request when the consumer wants to make a new purchase but this time it will be in a simplified manner as their card is stored on their checkout profile. 

**Important!** Use Operation Purchase when creating a payment order that should debit the consumer as Verify will not debit any amount.

## 4.0 Use Case: Stored Card and Recurring Combination Payment
A payment order where you allow the consumer to store their card on their profile and you (the merchant) wants to create a recurrence token for recurring payments.

**Recurring payments**: Set generateRecurrenceToken value to **true** and a recurrenceToken will be available to retrieve after the completed payment.

**Stored Card**: The choice to store a card is on the consumers end, this option will be available for the consumer inside the payment menu. If the consumer chooses to store their card data, the card used will be shown (masked) and available to use in future payments after the completed payment.

{:.table.table-striped}
| Integration                                                | Allowed |
|------------------------------------------------------------|---------|
| PayEx Checkout with Checkin                                | Yes     |
| PayEx Checkout without Checkin                             | No      |
| PayEx Checkout without Checkin. Merchant onboards consumer | Yes     |

{:.table.table-striped}
| Function         | Allowed |
|------------------|---------|
| Recurring        | Yes     |
| Store card       | Yes     |
| Operation Verify | Yes     |

**The example requests will have specific parameters set to true or false if it's required in the scenario.**

### 4.1 Create Payment Order
Set generateRecurrenceToken value to **true**

Example follows Create Payment Order [1.2 Use Case: PayEx Checkout - Merchant onboarding](#12-use-case-payex-checkout---merchant-onboarding)

{:.code-header}
**Request**
```http 
POST /psp/paymentorders HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Purchase",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",                                 
    "language": "sv-SE",
    "generateRecurrenceToken": true,                         
    "disablePaymentMenu": false,                              
    "urls": {
      "hostUrls": [ "http://test-dummy.net", "http://test-dummy2.net" ],
      "completeUrl": "http://test-dummy.net/payment-completed",
      "cancelUrl": "http://test-dummy.net/payment-canceled",
      "paymentUrl": "http://test-dummy.net/payment",
      "callbackUrl": "http://test-dummy.net/payment-callback",     
      "termsOfServiceUrl": "http://test-dummy.net/termsandconditoons.pdf",
      "logoUrl": "http://test-dummy.net/logo.png"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",                                    
      "productCategory": "A123",                                   
      "subsite": "MySubsite",                                       
      "orderReference" : "or-123456"                               
    },
    "payer": {
      "nationalIdentifier": {                                      
        "socialSecurityNumber": "19XXXXXXXXXX",
        "countryCode": "SE"
      },
      "firstName": "string",                      
      "lastName": "string",                 
      "email": "string",      
      "msisdn": "string",                 
      "workPhoneNumber" : "string",                        
      "homePhoneNumber" : "string",                        
      "shippingAddress" : {                    
        "firstName" : "firstname/companyname", 
        "lastName" : "lastname",               
        "email": "string",       
        "msisdn": "string",      
        "streetAddress" : "string",      
        "coAddress" : "string",          
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "billingAddress" : {                      
        "firstName" : "firstname/companyname",  
        "lastName" : "lastname",                
        "email": "string",      
        "msisdn": "string",                
        "streetAddress" : "string",        
        "coAddress" : "string",            
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "accountInfo" : {                                 
        "accountAgeIndicator" : "01",       
        "accountChangeIndicator" : "01",       
        "accountPwdChangeIndicator" : "01", 
        "shippingAddressUsageIndicator" : "01",
        "shippingNameIndicator" : "01",              
        "suspiciousAccountActivity" : "01",        
        "addressMatchIndicator": "false"           
      }
     },
    "riskIndicator" : {
       "deliveryEmailAddress" : "string",               
       "deliveryTimeFrameindicator" : "01",    
       "preOrderDate" : "YYYYMMDD",                     
       "preOrderPurchaseIndicator" : "01",           
       "shipIndicator" : "01",        
       "giftCardPurchase" : "false",               
       "reOrderPurchaseIndicator" : "01",            
       "pickUpAddress" : {                              
           "name" : "companyname",                      
           "streetAddress" : "string",                  
           "coAddress" : "string",                      
           "city" : "string",
           "zipCode" : "string",
           "countryCode" : "string"
       }
    },
    "metadata": {                                          
      "key1": "value1",
      "key2": 2,
      "key3": 3.1,
      "key4": false
    },
    "items": [                                             
    {
      "creditCard": {
        "rejectCreditCards": false,                   
        "rejectDebitCards": false,                    
        "rejectConsumerCards": false,                 
        "rejectCorporateCards": false                 
      }
    },
    {
      "invoice": {
        "feeAmount" : 1900
      }
    },
    {
      "campaignInvoice": {
        "campaignCode" : "Campaign1",
        "feeAmount" : 2900 
      }
    },
    {
      "swish": {
        "EnableEcomOnly": false                 
      }
    }
   ]
  }
}
```

{:.table.table-striped}
| Property                                      | Type       | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|-----------------------------------------------|------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder                                  | object     | Y        | The payment order object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| operation                                     | string     | Y        | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| currency                                      | string     | Y        | The currency of the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| amount                                        | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                      |
| vatAmount                                     | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                             |
| description                                   | string     | Y        | The description of the payment order.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| userAgent                                     | string     | N        | The user agent of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| language                                      | string     | Y        | The language of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| generateRecurrenceToken                       | boolean    | N        | Determines if a recurrence token should be generated. A recurrence token is primarily used to enable recurring payments through server-to-server calls. Default value is false                                                                                                                                                                                                                                                                                                                                     |
| urls.hostUrls                                 | array      | Y        | The array of URIs valid for embedding of PayEx Hosted Views.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.completeUrl                              | string     | Y        | The URI to redirect the payer to once the payment is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.cancelUrl                                | string     | N        | The URI to redirect the payer to if the payment is canceled.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.paymentUrl                               | string     | N        | The URI that PayEx will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted views. Can not be used simultaneously with cancelUrl; only cancelUrl or paymentUrl can be used, not both.                                                                                                                                                                                                                                          |
| urls.callbackUrl                              | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                                                                                                                                                                                                                                                                                                                                                          |
| urls.termsOfServiceUrl                        | string     | Y        | The URI to the terms of service document the payer must accept in order to complete the payment. Require https.                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.logoUrl                                  | string     | Y        | The URI to the logo that will be displayed on redirect pages. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| payeeInfo.payeeId                             | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| payeeInfo.payeeReference                      | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                                                                                                                                                                                                                                                                                                                                              |
| payeeInfo.payeeName                           | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| payeeInfo.productCategory                     | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                            |
| payeeInfo.subsite                             | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                               |
| payeeInfo.orderReference                      | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                            |
| payer.nationalIdentifier                      | object     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.socialSecurityNumber | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.countryCode          | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.firstName                               | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.lastName                                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.email                                   | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.msisdn                                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.homePhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.workPhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.firstName               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.lastName                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.streetAddress           | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.coAddress               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.city                    | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.zipCode                 | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.countryCode             | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.firstName                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.lastName                 | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.streetAddress            | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.coAddress                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.city                     | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.zipCode                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.countryCode              | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| accountInfo                                   | object     | N        | Optional. If payer is known by merchant and have some kind of registered user then these fields can be set.                                                                                                                                                                                                                                                                                                                                                                                                        |
| accountInfo.accountAgeIndicator               | string     | N        | Indicates the length of time that the payments account was enrolled in the cardholder's account with merchant.01 (No account, guest)02 (Created during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                     |
| accountInfo.accountChangeIndicator            | string     | N        | Length of time since the cardholder's account information with the merchant was changed. Including billing etc.01 (Changed during transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                          |
| accountInfo.accountPwdChangeIndicator         | string     | N        | Indicates the length of time since the cardholder's account with the merchant had a password change or account reset.01 (No change)02 (Changed during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                      |
| accountInfo.shippingAddressUsageIndicator     | string     | N        | Indicates when the shipping address used for this transaction was first used with the merchant.01 (This transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                                                    |
| accountInfo.shippingNameIndicator             | string     | N        | Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.01 (Account name identical to shipping name)02 (Account name different than shipping name)                                                                                                                                                                                                                                                                                                             |
| accountInfo.suspiciousAccountActivity         | string     | N        | Indicates whether merchant has experienced suspicious activity (including previous fraud) on the cardholder account.01 (No suspicious activity has been observed)02 (Suspicious activity has been observed)                                                                                                                                                                                                                                                                                                        |
| accountInfo.addressMatchIndicator             | boolean    | N        | Allows the 3DS Requestor to indicate to the ACS whether the cardholder’s billing and shipping address are the same.                                                                                                                                                                                                                                                                                                                                                                                                |
| riskIndicator.deliveryEmailAddress            | string     | N        | For electronic delivery, the email address to which the merchandise was delivered.                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| riskIndicator.deliveryTimeFrameIndicator      | string     | N        | Indicates the merchandise delivery timeframe.01 (Electronic Delivery)02 (Same day shipping)03 (Overnight shipping)04 (Two-day or more shipping)                                                                                                                                                                                                                                                                                                                                                                    |
| riskIndicator.preOrderDate                    | string     | N        | For a pre-ordered purchase. The expected date that the merchandise will be available.FORMAT: "YYYYMMDD"                                                                                                                                                                                                                                                                                                                                                                                                            |
| riskIndicator.preOrderPurchaseIndicator       | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.shipIndicator                   | string     | N        | Indicates shipping method chosen for the transaction.01 (Ship to cardholder's billing address)02 (Ship to another verified address on file with merchant)03 (Ship to address that is different than cardholder's billing address)04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)05 (Digital goods, includes online services, electronic giftcards and redemption codes)06 (Travel and Event tickets, not shipped)07 (Other, e.g. gaming, digital service) |
| riskIndicator.giftCardPurchase                | boolean    | N        | true if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| riskIndicator.reOrderPurchaseIndicator        | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.pickUpAddress                   | object     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.name              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.streetAddress     | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.coAddress         | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.city              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.zipCode           | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.countryCode       | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| metadata                                      | object     | N        | The keys and values that should be associated with the payment order. Can be additional identifiers and data you want to associate with the payment.                                                                                                                                                                                                                                                                                                                                                               |
| items                                         | array      | N        | The array of items that will affect how the payment is performed.                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| items.creditCard.rejectDebitCards             | boolean    | N        | true if debit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                             |
| items.creditCard.rejectCreditCards            | boolean    | N        | true if credit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                            |
| items.creditCard.rejectConsumerCards          | boolean    | N        | true if consumer cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                          |
| items.creditCard.rejectCorporateCards         | boolean    | N        | true if corporate cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                         |
| items.invoice.feeAmount                       | integer    | N        | The fee amount in the lowest monetary unit to apply if the consumer chooses to pay with invoice.                                                                                                                                                                                                                                                                                                                                                                                                                   |
| items.swish.enableEcomOnly                    | boolean    | N        | true to only enable Swish on ecommerce transactions.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |


{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Purchase",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
    "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
    "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
    "items": [
      {
        "creditCard": {
          "cardBrands": [ "Visa", "MasterCard", "Ica", "etc..." ]
        }
      },
      { "invoice": {} },
      { "campaignInvoice": {} },
      { "swish": {} },
      { "vipps": {} }
    ]
  },
  "operations": [
    {
      "href": "https://ecom.payex.com/paymentorders/123456123412341234123456789012",
      "rel": "redirect-paymentorder",
      "method": "GET",
      "contentType": "application/json"
    },
    {
      "href": "https://ecom.dev.payex.com/paymentmenu/scripts/client/client-paymentmenu.js",
      "rel": "view-paymentorder",
      "method": "GET",
      "contentType": "application/javascript"
    }
  ]
}
```

### 4.2 Recurring Payment
When the consumer has completed their payment in the initially created payment order, you are able to retrieve the recurrenceToken from the payment order.
<p>&nbsp;</p>

{:.code-header}
**Request**
```http
GET /psp/paymentorders/<paymentOrderId>/currentpayment HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json
```


{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "recurrenceToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
    "menuElementName": "creditcard",
    "payment": {
        "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
        "number": 1234567890,
        "instrument": "CreditCard",
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "operation": "Purchase",
        "intent": "Authorization",
        "state": "Ready",
        "currency": "SEK",
        "amount": 1500,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "paymentToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
        "prices": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/prices" },
        "transactions": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions" },
        "authorizations": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/authorizations" },
        "captures": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/captures" },
        "cancellations": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/cancellations" },
        "reversals": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals" },
        "verifications": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/verifications" },
        "urls" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
        "payeeInfo" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
        "metadata" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/metadata" },
        "settings": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" }
    },
    "operations": []
}
```
<p>&nbsp;</p>

**Create a recurring payment**

When you have a recurrence token safely tucked away, you can use this token in a subsequent Recur payment. This will be a server-to-server affair, as we have tied all necessary payment instrument details related to the recurrence token during the initial payment order.
<p>&nbsp;</p>


{:.code-header}
**Request**
```http
POST /psp/paymentorders HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Recur",
    "intent": "Authorization",
    "recurrenceToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Recurrence",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls": {
      "callbackUrl": "http://test-dummy.net/payment-callback"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",
      "productCategory": "A123",
      "orderReference": "orderRef123",
      "subsite": "MySubsite"       
    }
  }
}
```

{:.table.table-striped}
| Property                  | Type       | Required | Description                                                                                                                                                                             |
|---------------------------|------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder              | object     | Y        | The payment order object.                                                                                                                                                               |
| operation                 | string     | Y        | Recur is always used for recurring payments.                                                                                                                                            |
| intent                    | string     | Y        | The intent of the payment.                                                                                                                                                              |
| recurrenceToken           | string     | Y        | The reccurenceToken to debit.                                                                                                                                                           |
| currency                  | string     | Y        | The currency of the payment.                                                                                                                                                            |
| amount                    | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                           |
| vatAmount                 | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                  |
| description               | string     | Y        | The description of the payment order.                                                                                                                                                   |
| userAgent                 | string     | Y        | The user agent of the payer.                                                                                                                                                            |
| language                  | string     | Y        | The language of the payer.                                                                                                                                                              |
| urls.callbackUrl          | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                               |
| payeeInfo.payeeId         | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                           |
| payeeInfo.payeeReference  | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                   |
| payeeInfo.payeeName       | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                |
| payeeInfo.productCategory | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process. |
| payeeInfo.orderReference  | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                 |
| payeeInfo.subsite         | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                    |

{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Recur",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
    "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
    "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
    "items": [
      {
        "creditCard": {
          "cardBrands": [ "Visa", "MasterCard", "Ica", "etc..." ]
        }
      },
      { "invoice": {} },
      { "campaignInvoice": {} },
      { "swish": {} },
      { "vipps": {} }
    ]
  },
  "operations":  [
      {
      }
  ]
}
```

### 4.3 Stored Card Payment Order
If the consumer chose to store their card in the previous payment order created in [4.1 Create Payment Order](#41-create-payment-order) you can create a new payment order and the consumers card will be presented in the payment menu.

**Important!** Use Operation Purchase when creating a payment order that should debit the consumer as Verify will not debit any amount.
Set generateRecurrenceToken value to **false** as you've already created a recurrenceToken for the consumer.

Example follows Create Payment Order [1.2 Use Case: PayEx Checkout - Merchant onboarding](#12-use-case-payex-checkout---merchant-onboarding)

{:.code-header}
**Request**
```http
POST /psp/paymentorders HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Purchase",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",                                 
    "language": "sv-SE",
    "generateRecurrenceToken": false,                         
    "disablePaymentMenu": false,                              
    "urls": {
      "hostUrls": [ "http://test-dummy.net", "http://test-dummy2.net" ],
      "completeUrl": "http://test-dummy.net/payment-completed",
      "cancelUrl": "http://test-dummy.net/payment-canceled",
      "paymentUrl": "http://test-dummy.net/payment",
      "callbackUrl": "http://test-dummy.net/payment-callback",     
      "termsOfServiceUrl": "http://test-dummy.net/termsandconditoons.pdf",
      "logoUrl": "http://test-dummy.net/logo.png"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",                                    
      "productCategory": "A123",                                   
      "subsite": "MySubsite",                                       
      "orderReference" : "or-123456"                               
    },
    "payer": {
      "nationalIdentifier": {                                      
        "socialSecurityNumber": "19XXXXXXXXXX",
        "countryCode": "SE"
      },
      "firstName": "string",                      
      "lastName": "string",                 
      "email": "string",      
      "msisdn": "string",                 
      "workPhoneNumber" : "string",                        
      "homePhoneNumber" : "string",                        
      "shippingAddress" : {                    
        "firstName" : "firstname/companyname", 
        "lastName" : "lastname",               
        "email": "string",       
        "msisdn": "string",      
        "streetAddress" : "string",      
        "coAddress" : "string",          
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "billingAddress" : {                      
        "firstName" : "firstname/companyname",  
        "lastName" : "lastname",                
        "email": "string",      
        "msisdn": "string",                
        "streetAddress" : "string",        
        "coAddress" : "string",            
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "accountInfo" : {                                 
        "accountAgeIndicator" : "01",       
        "accountChangeIndicator" : "01",       
        "accountPwdChangeIndicator" : "01", 
        "shippingAddressUsageIndicator" : "01",
        "shippingNameIndicator" : "01",              
        "suspiciousAccountActivity" : "01",        
        "addressMatchIndicator": "false"           
      }
     },
    "riskIndicator" : {
       "deliveryEmailAddress" : "string",               
       "deliveryTimeFrameindicator" : "01",    
       "preOrderDate" : "YYYYMMDD",                     
       "preOrderPurchaseIndicator" : "01",           
       "shipIndicator" : "01",        
       "giftCardPurchase" : "false",               
       "reOrderPurchaseIndicator" : "01",            
       "pickUpAddress" : {                              
           "name" : "companyname",                      
           "streetAddress" : "string",                  
           "coAddress" : "string",                      
           "city" : "string",
           "zipCode" : "string",
           "countryCode" : "string"
       }
    },
    "metadata": {                                          
      "key1": "value1",
      "key2": 2,
      "key3": 3.1,
      "key4": false
    },
    "items": [                                             
    {
      "creditCard": {
        "rejectCreditCards": false,                   
        "rejectDebitCards": false,                    
        "rejectConsumerCards": false,                 
        "rejectCorporateCards": false                 
      }
    },
    {
      "invoice": {
        "feeAmount" : 1900
      }
    },
    {
      "campaignInvoice": {
        "campaignCode" : "Campaign1",
        "feeAmount" : 2900 
      }
    },
    {
      "swish": {
        "EnableEcomOnly": false                 
      }
    }
   ]
  }
}
```

{:.table.table-striped}
| Property                                      | Type       | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|-----------------------------------------------|------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder                                  | object     | Y        | The payment order object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| operation                                     | string     | Y        | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| currency                                      | string     | Y        | The currency of the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| amount                                        | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                      |
| vatAmount                                     | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                             |
| description                                   | string     | Y        | The description of the payment order.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| userAgent                                     | string     | N        | The user agent of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| language                                      | string     | Y        | The language of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| generateRecurrenceToken                       | boolean    | N        | Determines if a recurrence token should be generated. A recurrence token is primarily used to enable recurring payments through server-to-server calls. Default value is false                                                                                                                                                                                                                                                                                                                                     |
| urls.hostUrls                                 | array      | Y        | The array of URIs valid for embedding of PayEx Hosted Views.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.completeUrl                              | string     | Y        | The URI to redirect the payer to once the payment is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.cancelUrl                                | string     | N        | The URI to redirect the payer to if the payment is canceled.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.paymentUrl                               | string     | N        | The URI that PayEx will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted views. Can not be used simultaneously with cancelUrl; only cancelUrl or paymentUrl can be used, not both.                                                                                                                                                                                                                                          |
| urls.callbackUrl                              | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                                                                                                                                                                                                                                                                                                                                                          |
| urls.termsOfServiceUrl                        | string     | Y        | The URI to the terms of service document the payer must accept in order to complete the payment. Require https.                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.logoUrl                                  | string     | Y        | The URI to the logo that will be displayed on redirect pages. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| payeeInfo.payeeId                             | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| payeeInfo.payeeReference                      | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                                                                                                                                                                                                                                                                                                                                              |
| payeeInfo.payeeName                           | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| payeeInfo.productCategory                     | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                            |
| payeeInfo.subsite                             | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                               |
| payeeInfo.orderReference                      | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                            |
| payer.nationalIdentifier                      | object     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.socialSecurityNumber | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.countryCode          | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.firstName                               | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.lastName                                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.email                                   | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.msisdn                                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.homePhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.workPhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.firstName               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.lastName                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.streetAddress           | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.coAddress               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.city                    | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.zipCode                 | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.countryCode             | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.firstName                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.lastName                 | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.streetAddress            | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.coAddress                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.city                     | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.zipCode                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.countryCode              | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| accountInfo                                   | object     | N        | Optional. If payer is known by merchant and have some kind of registered user then these fields can be set.                                                                                                                                                                                                                                                                                                                                                                                                        |
| accountInfo.accountAgeIndicator               | string     | N        | Indicates the length of time that the payments account was enrolled in the cardholder's account with merchant.01 (No account, guest)02 (Created during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                     |
| accountInfo.accountChangeIndicator            | string     | N        | Length of time since the cardholder's account information with the merchant was changed. Including billing etc.01 (Changed during transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                          |
| accountInfo.accountPwdChangeIndicator         | string     | N        | Indicates the length of time since the cardholder's account with the merchant had a password change or account reset.01 (No change)02 (Changed during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                      |
| accountInfo.shippingAddressUsageIndicator     | string     | N        | Indicates when the shipping address used for this transaction was first used with the merchant.01 (This transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                                                    |
| accountInfo.shippingNameIndicator             | string     | N        | Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.01 (Account name identical to shipping name)02 (Account name different than shipping name)                                                                                                                                                                                                                                                                                                             |
| accountInfo.suspiciousAccountActivity         | string     | N        | Indicates whether merchant has experienced suspicious activity (including previous fraud) on the cardholder account.01 (No suspicious activity has been observed)02 (Suspicious activity has been observed)                                                                                                                                                                                                                                                                                                        |
| accountInfo.addressMatchIndicator             | boolean    | N        | Allows the 3DS Requestor to indicate to the ACS whether the cardholder’s billing and shipping address are the same.                                                                                                                                                                                                                                                                                                                                                                                                |
| riskIndicator.deliveryEmailAddress            | string     | N        | For electronic delivery, the email address to which the merchandise was delivered.                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| riskIndicator.deliveryTimeFrameIndicator      | string     | N        | Indicates the merchandise delivery timeframe.01 (Electronic Delivery)02 (Same day shipping)03 (Overnight shipping)04 (Two-day or more shipping)                                                                                                                                                                                                                                                                                                                                                                    |
| riskIndicator.preOrderDate                    | string     | N        | For a pre-ordered purchase. The expected date that the merchandise will be available.FORMAT: "YYYYMMDD"                                                                                                                                                                                                                                                                                                                                                                                                            |
| riskIndicator.preOrderPurchaseIndicator       | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.shipIndicator                   | string     | N        | Indicates shipping method chosen for the transaction.01 (Ship to cardholder's billing address)02 (Ship to another verified address on file with merchant)03 (Ship to address that is different than cardholder's billing address)04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)05 (Digital goods, includes online services, electronic giftcards and redemption codes)06 (Travel and Event tickets, not shipped)07 (Other, e.g. gaming, digital service) |
| riskIndicator.giftCardPurchase                | boolean    | N        | true if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| riskIndicator.reOrderPurchaseIndicator        | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.pickUpAddress                   | object     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.name              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.streetAddress     | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.coAddress         | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.city              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.zipCode           | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.countryCode       | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| metadata                                      | object     | N        | The keys and values that should be associated with the payment order. Can be additional identifiers and data you want to associate with the payment.                                                                                                                                                                                                                                                                                                                                                               |
| items                                         | array      | N        | The array of items that will affect how the payment is performed.                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| items.creditCard.rejectDebitCards             | boolean    | N        | true if debit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                             |
| items.creditCard.rejectCreditCards            | boolean    | N        | true if credit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                            |
| items.creditCard.rejectConsumerCards          | boolean    | N        | true if consumer cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                          |
| items.creditCard.rejectCorporateCards         | boolean    | N        | true if corporate cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                         |
| items.invoice.feeAmount                       | integer    | N        | The fee amount in the lowest monetary unit to apply if the consumer chooses to pay with invoice.                                                                                                                                                                                                                                                                                                                                                                                                                   |
| items.swish.enableEcomOnly                    | boolean    | N        | true to only enable Swish on ecommerce transactions.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Purchase",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
    "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
    "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
    "items": [
      {
        "creditCard": {
          "cardBrands": [ "Visa", "MasterCard", "Ica", "etc..." ]
        }
      },
      { "invoice": {} },
      { "campaignInvoice": {} },
      { "swish": {} },
      { "vipps": {} }
    ]
  },
  "operations": [
    {
      "href": "https://ecom.payex.com/paymentorders/123456123412341234123456789012",
      "rel": "redirect-paymentorder",
      "method": "GET",
      "contentType": "application/json"
    },
    {
      "href": "https://ecom.dev.payex.com/paymentmenu/scripts/client/client-paymentmenu.js",
      "rel": "view-paymentorder",
      "method": "GET",
      "contentType": "application/javascript"
    }
  ]
}
```

## 5.0 Use Case: Multimerchant Stored Card and Recurring Combination Payment

**<u>THIS SCENARIO IS ONLY FOR MULTIMERCHANT CUSTOMERS</u>**  
In this scenario we will use 3 active merchants. Merchant One, Merchant Two and Merchant Three.  

A payment order where you allow the consumer to store their card on their profile that will be available for several merchants and you (the merchant) wants to create a recurrence token for recurring payments.  
  
**Recurring payments**: Set generateRecurrenceToken value to **true** and a recurrenceToken will be available to retrieve after the completed payment.  
**The recurrenceToken generated will only be available for the merchant whom generated it.**  

**Stored Card**: The choice to store a card is on the consumers end, this option will be available for the consumer inside the payment menu. If the consumer chooses to store their card data, the card used will be shown (masked) and available to use in future payments after the completed payment. The stored card will be available for the consumer on Merchant One, Merchant Two and Merchant Three.  

{:.table.table-striped}
| Integration                                                | Allowed |
|------------------------------------------------------------|---------|
| PayEx Checkout with Checkin                                | Yes     |
| PayEx Checkout without Checkin                             | No      |
| PayEx Checkout without Checkin. Merchant onboards consumer | Yes     |

{:.table.table-striped}
| Function         | Allowed |
|------------------|---------|
| Recurring        | Yes     |
| Store card       | Yes     |
| Operation Verify | Yes     |

**The example requests will have specific parameters set to true or false if it's required in the scenario.**  

### 5.1 Create Payment Order - Merchant One  

Set generateRecurrenceToken value to **true**

Example follows Create Payment Order [1.2 Use Case: PayEx Checkout - Merchant onboarding](#12-use-case-payex-checkout---merchant-onboarding)

{:.code-header}
**Request**
```http
POST /psp/paymentorders HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Purchase",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",                                 
    "language": "sv-SE",
    "generateRecurrenceToken": true,                         
    "disablePaymentMenu": false,                              
    "urls": {
      "hostUrls": [ "http://test-dummy.net", "http://test-dummy2.net" ],
      "completeUrl": "http://test-dummy.net/payment-completed",
      "cancelUrl": "http://test-dummy.net/payment-canceled",
      "paymentUrl": "http://test-dummy.net/payment",
      "callbackUrl": "http://test-dummy.net/payment-callback",     
      "termsOfServiceUrl": "http://test-dummy.net/termsandconditoons.pdf",
      "logoUrl": "http://test-dummy.net/logo.png"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",                                    
      "productCategory": "A123",                                   
      "subsite": "MySubsite",                                       
      "orderReference" : "or-123456"                               
    },
    "payer": {
      "nationalIdentifier": {                                      
        "socialSecurityNumber": "19XXXXXXXXXX",
        "countryCode": "SE"
      },
      "firstName": "string",                      
      "lastName": "string",                 
      "email": "string",      
      "msisdn": "string",                 
      "workPhoneNumber" : "string",                        
      "homePhoneNumber" : "string",                        
      "shippingAddress" : {                    
        "firstName" : "firstname/companyname", 
        "lastName" : "lastname",               
        "email": "string",       
        "msisdn": "string",      
        "streetAddress" : "string",      
        "coAddress" : "string",          
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "billingAddress" : {                      
        "firstName" : "firstname/companyname",  
        "lastName" : "lastname",                
        "email": "string",      
        "msisdn": "string",                
        "streetAddress" : "string",        
        "coAddress" : "string",            
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "accountInfo" : {                                 
        "accountAgeIndicator" : "01",       
        "accountChangeIndicator" : "01",       
        "accountPwdChangeIndicator" : "01", 
        "shippingAddressUsageIndicator" : "01",
        "shippingNameIndicator" : "01",              
        "suspiciousAccountActivity" : "01",        
        "addressMatchIndicator": "false"           
      }
     },
    "riskIndicator" : {
       "deliveryEmailAddress" : "string",               
       "deliveryTimeFrameindicator" : "01",    
       "preOrderDate" : "YYYYMMDD",                     
       "preOrderPurchaseIndicator" : "01",           
       "shipIndicator" : "01",        
       "giftCardPurchase" : "false",               
       "reOrderPurchaseIndicator" : "01",            
       "pickUpAddress" : {                              
           "name" : "companyname",                      
           "streetAddress" : "string",                  
           "coAddress" : "string",                      
           "city" : "string",
           "zipCode" : "string",
           "countryCode" : "string"
       }
    },
    "metadata": {                                          
      "key1": "value1",
      "key2": 2,
      "key3": 3.1,
      "key4": false
    },
    "items": [                                             
    {
      "creditCard": {
        "rejectCreditCards": false,                   
        "rejectDebitCards": false,                    
        "rejectConsumerCards": false,                 
        "rejectCorporateCards": false                 
      }
    },
    {
      "invoice": {
        "feeAmount" : 1900
      }
    },
    {
      "campaignInvoice": {
        "campaignCode" : "Campaign1",
        "feeAmount" : 2900 
      }
    },
    {
      "swish": {
        "EnableEcomOnly": false                 
      }
    }
   ]
  }
}
```

{:.table.table-striped}
| Property                                      | Type       | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|-----------------------------------------------|------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder                                  | object     | Y        | The payment order object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| operation                                     | string     | Y        | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| currency                                      | string     | Y        | The currency of the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| amount                                        | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                      |
| vatAmount                                     | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                             |
| description                                   | string     | Y        | The description of the payment order.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| userAgent                                     | string     | N        | The user agent of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| language                                      | string     | Y        | The language of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| generateRecurrenceToken                       | boolean    | N        | Determines if a recurrence token should be generated. A recurrence token is primarily used to enable recurring payments through server-to-server calls. Default value is false                                                                                                                                                                                                                                                                                                                                     |
| urls.hostUrls                                 | array      | Y        | The array of URIs valid for embedding of PayEx Hosted Views.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.completeUrl                              | string     | Y        | The URI to redirect the payer to once the payment is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.cancelUrl                                | string     | N        | The URI to redirect the payer to if the payment is canceled.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.paymentUrl                               | string     | N        | The URI that PayEx will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted views. Can not be used simultaneously with cancelUrl; only cancelUrl or paymentUrl can be used, not both.                                                                                                                                                                                                                                          |
| urls.callbackUrl                              | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                                                                                                                                                                                                                                                                                                                                                          |
| urls.termsOfServiceUrl                        | string     | Y        | The URI to the terms of service document the payer must accept in order to complete the payment. Require https.                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.logoUrl                                  | string     | Y        | The URI to the logo that will be displayed on redirect pages. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| payeeInfo.payeeId                             | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| payeeInfo.payeeReference                      | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                                                                                                                                                                                                                                                                                                                                              |
| payeeInfo.payeeName                           | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| payeeInfo.productCategory                     | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                            |
| payeeInfo.subsite                             | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                               |
| payeeInfo.orderReference                      | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                            |
| payer.nationalIdentifier                      | object     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.socialSecurityNumber | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.countryCode          | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.firstName                               | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.lastName                                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.email                                   | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.msisdn                                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.homePhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.workPhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.firstName               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.lastName                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.streetAddress           | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.coAddress               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.city                    | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.zipCode                 | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.countryCode             | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.firstName                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.lastName                 | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.streetAddress            | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.coAddress                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.city                     | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.zipCode                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.countryCode              | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| accountInfo                                   | object     | N        | Optional. If payer is known by merchant and have some kind of registered user then these fields can be set.                                                                                                                                                                                                                                                                                                                                                                                                        |
| accountInfo.accountAgeIndicator               | string     | N        | Indicates the length of time that the payments account was enrolled in the cardholder's account with merchant.01 (No account, guest)02 (Created during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                     |
| accountInfo.accountChangeIndicator            | string     | N        | Length of time since the cardholder's account information with the merchant was changed. Including billing etc.01 (Changed during transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                          |
| accountInfo.accountPwdChangeIndicator         | string     | N        | Indicates the length of time since the cardholder's account with the merchant had a password change or account reset.01 (No change)02 (Changed during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                      |
| accountInfo.shippingAddressUsageIndicator     | string     | N        | Indicates when the shipping address used for this transaction was first used with the merchant.01 (This transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                                                    |
| accountInfo.shippingNameIndicator             | string     | N        | Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.01 (Account name identical to shipping name)02 (Account name different than shipping name)                                                                                                                                                                                                                                                                                                             |
| accountInfo.suspiciousAccountActivity         | string     | N        | Indicates whether merchant has experienced suspicious activity (including previous fraud) on the cardholder account.01 (No suspicious activity has been observed)02 (Suspicious activity has been observed)                                                                                                                                                                                                                                                                                                        |
| accountInfo.addressMatchIndicator             | boolean    | N        | Allows the 3DS Requestor to indicate to the ACS whether the cardholder’s billing and shipping address are the same.                                                                                                                                                                                                                                                                                                                                                                                                |
| riskIndicator.deliveryEmailAddress            | string     | N        | For electronic delivery, the email address to which the merchandise was delivered.                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| riskIndicator.deliveryTimeFrameIndicator      | string     | N        | Indicates the merchandise delivery timeframe.01 (Electronic Delivery)02 (Same day shipping)03 (Overnight shipping)04 (Two-day or more shipping)                                                                                                                                                                                                                                                                                                                                                                    |
| riskIndicator.preOrderDate                    | string     | N        | For a pre-ordered purchase. The expected date that the merchandise will be available.FORMAT: "YYYYMMDD"                                                                                                                                                                                                                                                                                                                                                                                                            |
| riskIndicator.preOrderPurchaseIndicator       | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.shipIndicator                   | string     | N        | Indicates shipping method chosen for the transaction.01 (Ship to cardholder's billing address)02 (Ship to another verified address on file with merchant)03 (Ship to address that is different than cardholder's billing address)04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)05 (Digital goods, includes online services, electronic giftcards and redemption codes)06 (Travel and Event tickets, not shipped)07 (Other, e.g. gaming, digital service) |
| riskIndicator.giftCardPurchase                | boolean    | N        | true if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| riskIndicator.reOrderPurchaseIndicator        | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.pickUpAddress                   | object     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.name              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.streetAddress     | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.coAddress         | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.city              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.zipCode           | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.countryCode       | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| metadata                                      | object     | N        | The keys and values that should be associated with the payment order. Can be additional identifiers and data you want to associate with the payment.                                                                                                                                                                                                                                                                                                                                                               |
| items                                         | array      | N        | The array of items that will affect how the payment is performed.                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| items.creditCard.rejectDebitCards             | boolean    | N        | true if debit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                             |
| items.creditCard.rejectCreditCards            | boolean    | N        | true if credit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                            |
| items.creditCard.rejectConsumerCards          | boolean    | N        | true if consumer cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                          |
| items.creditCard.rejectCorporateCards         | boolean    | N        | true if corporate cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                         |
| items.invoice.feeAmount                       | integer    | N        | The fee amount in the lowest monetary unit to apply if the consumer chooses to pay with invoice.                                                                                                                                                                                                                                                                                                                                                                                                                   |
| items.swish.enableEcomOnly                    | boolean    | N        | true to only enable Swish on ecommerce transactions.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Purchase",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
    "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
    "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
    "items": [
      {
        "creditCard": {
          "cardBrands": [ "Visa", "MasterCard", "Ica", "etc..." ]
        }
      },
      { "invoice": {} },
      { "campaignInvoice": {} },
      { "swish": {} },
      { "vipps": {} }
    ]
  },
  "operations": [
    {
      "href": "https://ecom.payex.com/paymentorders/123456123412341234123456789012",
      "rel": "redirect-paymentorder",
      "method": "GET",
      "contentType": "application/json"
    },
    {
      "href": "https://ecom.dev.payex.com/paymentmenu/scripts/client/client-paymentmenu.js",
      "rel": "view-paymentorder",
      "method": "GET",
      "contentType": "application/javascript"
    }
  ]
}
```

### 5.2 Recurring Payment Merchant One

When the consumer has completed their payment in the created payment order from 5.1, you are able to retrieve the recurrenceToken from the payment order. Only available to use by Merchant One.

{:.code-header}
**Request**
```http
GET /psp/paymentorders/<paymentOrderId>/currentpayment HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json
```

{:.code-header}
**Response**
```http 
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "recurrenceToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
    "menuElementName": "creditcard",
    "payment": {
        "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
        "number": 1234567890,
        "instrument": "CreditCard",
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "operation": "Purchase",
        "intent": "Authorization",
        "state": "Ready",
        "currency": "SEK",
        "amount": 1500,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "paymentToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
        "prices": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/prices" },
        "transactions": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions" },
        "authorizations": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/authorizations" },
        "captures": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/captures" },
        "cancellations": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/cancellations" },
        "reversals": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals" },
        "verifications": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/verifications" },
        "urls" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
        "payeeInfo" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
        "metadata" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/metadata" },
        "settings": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" }
    },
    "operations": []
}
```

**Create a recurring payment for Merchant One**  
When you have a recurrence token safely tucked away, you can use this token in a subsequent Recur payment. This will be a server-to-server affair, as we have tied all necessary payment instrument details related to the recurrence token during the initial payment order.

{:.code-header}
**Request Merchant One**
```http
POST /psp/paymentorders HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Recur",
    "intent": "Authorization",
    "recurrenceToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Recurrence",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls": {
      "callbackUrl": "http://test-dummy.net/payment-callback"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",
      "productCategory": "A123",
      "orderReference": "orderRef123",
      "subsite": "MySubsite"       
    }
  }
}
```

{:.table.table-striped}
| Property                  | Type       | Required | Description                                                                                                                                                                             |
|---------------------------|------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder              | object     | Y        | The payment order object.                                                                                                                                                               |
| operation                 | string     | Y        | Recur is always used for recurring payments.                                                                                                                                            |
| intent                    | string     | Y        | The intent of the payment.                                                                                                                                                              |
| recurrenceToken           | string     | Y        | The reccurenceToken to debit.                                                                                                                                                           |
| currency                  | string     | Y        | The currency of the payment.                                                                                                                                                            |
| amount                    | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                           |
| vatAmount                 | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                  |
| description               | string     | Y        | The description of the payment order.                                                                                                                                                   |
| userAgent                 | string     | Y        | The user agent of the payer.                                                                                                                                                            |
| language                  | string     | Y        | The language of the payer.                                                                                                                                                              |
| urls.callbackUrl          | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                               |
| payeeInfo.payeeId         | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                           |
| payeeInfo.payeeReference  | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                   |
| payeeInfo.payeeName       | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                |
| payeeInfo.productCategory | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process. |
| payeeInfo.orderReference  | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                 |
| payeeInfo.subsite         | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                    |

{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Recur",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
    "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
    "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
    "items": [
      {
        "creditCard": {
          "cardBrands": [ "Visa", "MasterCard", "Ica", "etc..." ]
        }
      },
      { "invoice": {} },
      { "campaignInvoice": {} },
      { "swish": {} },
      { "vipps": {} }
    ]
  },
  "operations":  [
      {
      }
  ]
}
```

### 5.3 Stored Card Payment Order Merchant One

If the consumer chose to store their card in the previous payment order created in [5.1 Create Payment Order](#51-create-payment-order---merchant-one) you can create a new payment order and the consumers card will be presented in the payment menu.

**Important!** Use Operation Purchase when creating a payment order that should debit the consumer as Verify will not debit any amount.
Set generateRecurrenceToken value to **false** as you've already created a recurrenceToken for the consumer.

Example follows Create Payment Order [1.2 Use Case: PayEx Checkout - Merchant onboarding](#12-use-case-payex-checkout---merchant-onboarding)

{:.code-header}
**Request**
```http
POST /psp/paymentorders HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Purchase",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",                                 
    "language": "sv-SE",
    "generateRecurrenceToken": false,                         
    "disablePaymentMenu": false,                              
    "urls": {
      "hostUrls": [ "http://test-dummy.net", "http://test-dummy2.net" ],
      "completeUrl": "http://test-dummy.net/payment-completed",
      "cancelUrl": "http://test-dummy.net/payment-canceled",
      "paymentUrl": "http://test-dummy.net/payment",
      "callbackUrl": "http://test-dummy.net/payment-callback",     
      "termsOfServiceUrl": "http://test-dummy.net/termsandconditoons.pdf",
      "logoUrl": "http://test-dummy.net/logo.png"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",                                    
      "productCategory": "A123",                                   
      "subsite": "MySubsite",                                       
      "orderReference" : "or-123456"                               
    },
    "payer": {
      "nationalIdentifier": {                                      
        "socialSecurityNumber": "19XXXXXXXXXX",
        "countryCode": "SE"
      },
      "firstName": "string",                      
      "lastName": "string",                 
      "email": "string",      
      "msisdn": "string",                 
      "workPhoneNumber" : "string",                        
      "homePhoneNumber" : "string",                        
      "shippingAddress" : {                    
        "firstName" : "firstname/companyname", 
        "lastName" : "lastname",               
        "email": "string",       
        "msisdn": "string",      
        "streetAddress" : "string",      
        "coAddress" : "string",          
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "billingAddress" : {                      
        "firstName" : "firstname/companyname",  
        "lastName" : "lastname",                
        "email": "string",      
        "msisdn": "string",                
        "streetAddress" : "string",        
        "coAddress" : "string",            
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "accountInfo" : {                                 
        "accountAgeIndicator" : "01",       
        "accountChangeIndicator" : "01",       
        "accountPwdChangeIndicator" : "01", 
        "shippingAddressUsageIndicator" : "01",
        "shippingNameIndicator" : "01",              
        "suspiciousAccountActivity" : "01",        
        "addressMatchIndicator": "false"           
      }
     },
    "riskIndicator" : {
       "deliveryEmailAddress" : "string",               
       "deliveryTimeFrameindicator" : "01",    
       "preOrderDate" : "YYYYMMDD",                     
       "preOrderPurchaseIndicator" : "01",           
       "shipIndicator" : "01",        
       "giftCardPurchase" : "false",               
       "reOrderPurchaseIndicator" : "01",            
       "pickUpAddress" : {                              
           "name" : "companyname",                      
           "streetAddress" : "string",                  
           "coAddress" : "string",                      
           "city" : "string",
           "zipCode" : "string",
           "countryCode" : "string"
       }
    },
    "metadata": {                                          
      "key1": "value1",
      "key2": 2,
      "key3": 3.1,
      "key4": false
    },
    "items": [                                             
    {
      "creditCard": {
        "rejectCreditCards": false,                   
        "rejectDebitCards": false,                    
        "rejectConsumerCards": false,                 
        "rejectCorporateCards": false                 
      }
    },
    {
      "invoice": {
        "feeAmount" : 1900
      }
    },
    {
      "campaignInvoice": {
        "campaignCode" : "Campaign1",
        "feeAmount" : 2900 
      }
    },
    {
      "swish": {
        "EnableEcomOnly": false                 
      }
    }
   ]
  }
}
```

{:.table.table-striped}
| Property                                      | Type       | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|-----------------------------------------------|------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder                                  | object     | Y        | The payment order object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| operation                                     | string     | Y        | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| currency                                      | string     | Y        | The currency of the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| amount                                        | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                      |
| vatAmount                                     | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                             |
| description                                   | string     | Y        | The description of the payment order.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| userAgent                                     | string     | N        | The user agent of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| language                                      | string     | Y        | The language of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| generateRecurrenceToken                       | boolean    | N        | Determines if a recurrence token should be generated. A recurrence token is primarily used to enable recurring payments through server-to-server calls. Default value is false                                                                                                                                                                                                                                                                                                                                     |
| urls.hostUrls                                 | array      | Y        | The array of URIs valid for embedding of PayEx Hosted Views.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.completeUrl                              | string     | Y        | The URI to redirect the payer to once the payment is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.cancelUrl                                | string     | N        | The URI to redirect the payer to if the payment is canceled.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.paymentUrl                               | string     | N        | The URI that PayEx will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted views. Can not be used simultaneously with cancelUrl; only cancelUrl or paymentUrl can be used, not both.                                                                                                                                                                                                                                          |
| urls.callbackUrl                              | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                                                                                                                                                                                                                                                                                                                                                          |
| urls.termsOfServiceUrl                        | string     | Y        | The URI to the terms of service document the payer must accept in order to complete the payment. Require https.                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.logoUrl                                  | string     | Y        | The URI to the logo that will be displayed on redirect pages. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| payeeInfo.payeeId                             | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| payeeInfo.payeeReference                      | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                                                                                                                                                                                                                                                                                                                                              |
| payeeInfo.payeeName                           | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| payeeInfo.productCategory                     | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                            |
| payeeInfo.subsite                             | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                               |
| payeeInfo.orderReference                      | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                            |
| payer.nationalIdentifier                      | object     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.socialSecurityNumber | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.countryCode          | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.firstName                               | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.lastName                                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.email                                   | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.msisdn                                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.homePhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.workPhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.firstName               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.lastName                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.streetAddress           | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.coAddress               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.city                    | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.zipCode                 | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.countryCode             | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.firstName                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.lastName                 | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.streetAddress            | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.coAddress                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.city                     | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.zipCode                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.countryCode              | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| accountInfo                                   | object     | N        | Optional. If payer is known by merchant and have some kind of registered user then these fields can be set.                                                                                                                                                                                                                                                                                                                                                                                                        |
| accountInfo.accountAgeIndicator               | string     | N        | Indicates the length of time that the payments account was enrolled in the cardholder's account with merchant.01 (No account, guest)02 (Created during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                     |
| accountInfo.accountChangeIndicator            | string     | N        | Length of time since the cardholder's account information with the merchant was changed. Including billing etc.01 (Changed during transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                          |
| accountInfo.accountPwdChangeIndicator         | string     | N        | Indicates the length of time since the cardholder's account with the merchant had a password change or account reset.01 (No change)02 (Changed during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                      |
| accountInfo.shippingAddressUsageIndicator     | string     | N        | Indicates when the shipping address used for this transaction was first used with the merchant.01 (This transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                                                    |
| accountInfo.shippingNameIndicator             | string     | N        | Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.01 (Account name identical to shipping name)02 (Account name different than shipping name)                                                                                                                                                                                                                                                                                                             |
| accountInfo.suspiciousAccountActivity         | string     | N        | Indicates whether merchant has experienced suspicious activity (including previous fraud) on the cardholder account.01 (No suspicious activity has been observed)02 (Suspicious activity has been observed)                                                                                                                                                                                                                                                                                                        |
| accountInfo.addressMatchIndicator             | boolean    | N        | Allows the 3DS Requestor to indicate to the ACS whether the cardholder’s billing and shipping address are the same.                                                                                                                                                                                                                                                                                                                                                                                                |
| riskIndicator.deliveryEmailAddress            | string     | N        | For electronic delivery, the email address to which the merchandise was delivered.                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| riskIndicator.deliveryTimeFrameIndicator      | string     | N        | Indicates the merchandise delivery timeframe.01 (Electronic Delivery)02 (Same day shipping)03 (Overnight shipping)04 (Two-day or more shipping)                                                                                                                                                                                                                                                                                                                                                                    |
| riskIndicator.preOrderDate                    | string     | N        | For a pre-ordered purchase. The expected date that the merchandise will be available.FORMAT: "YYYYMMDD"                                                                                                                                                                                                                                                                                                                                                                                                            |
| riskIndicator.preOrderPurchaseIndicator       | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.shipIndicator                   | string     | N        | Indicates shipping method chosen for the transaction.01 (Ship to cardholder's billing address)02 (Ship to another verified address on file with merchant)03 (Ship to address that is different than cardholder's billing address)04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)05 (Digital goods, includes online services, electronic giftcards and redemption codes)06 (Travel and Event tickets, not shipped)07 (Other, e.g. gaming, digital service) |
| riskIndicator.giftCardPurchase                | boolean    | N        | true if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| riskIndicator.reOrderPurchaseIndicator        | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.pickUpAddress                   | object     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.name              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.streetAddress     | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.coAddress         | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.city              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.zipCode           | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.countryCode       | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| metadata                                      | object     | N        | The keys and values that should be associated with the payment order. Can be additional identifiers and data you want to associate with the payment.                                                                                                                                                                                                                                                                                                                                                               |
| items                                         | array      | N        | The array of items that will affect how the payment is performed.                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| items.creditCard.rejectDebitCards             | boolean    | N        | true if debit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                             |
| items.creditCard.rejectCreditCards            | boolean    | N        | true if credit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                            |
| items.creditCard.rejectConsumerCards          | boolean    | N        | true if consumer cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                          |
| items.creditCard.rejectCorporateCards         | boolean    | N        | true if corporate cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                         |
| items.invoice.feeAmount                       | integer    | N        | The fee amount in the lowest monetary unit to apply if the consumer chooses to pay with invoice.                                                                                                                                                                                                                                                                                                                                                                                                                   |
| items.swish.enableEcomOnly                    | boolean    | N        | true to only enable Swish on ecommerce transactions.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Purchase",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
    "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
    "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
    "items": [
      {
        "creditCard": {
          "cardBrands": [ "Visa", "MasterCard", "Ica", "etc..." ]
        }
      },
      { "invoice": {} },
      { "campaignInvoice": {} },
      { "swish": {} },
      { "vipps": {} }
    ]
  },
  "operations": [
    {
      "href": "https://ecom.payex.com/paymentorders/123456123412341234123456789012",
      "rel": "redirect-paymentorder",
      "method": "GET",
      "contentType": "application/json"
    },
    {
      "href": "https://ecom.dev.payex.com/paymentmenu/scripts/client/client-paymentmenu.js",
      "rel": "view-paymentorder",
      "method": "GET",
      "contentType": "application/javascript"
    }
  ]
}
```

### 5.4 Stored Card Payment Order Merchant Two

Merchant Two wants to create a payment order for the same consumer as Merchant One in 5.1 but doesn't want to create a recurrenceToken as recurring payments isn't needed. The consumer will have their stored card from 5.1 available to use in the payment menu.

Set generateRecurrenceToken value to **false**

Example follows Create Payment Order [1.2 Use Case: PayEx Checkout - Merchant onboarding](#12-use-case-payex-checkout---merchant-onboarding)

{:.code-header}
**Request**
```http
POST /psp/paymentorders HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Purchase",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",                                 
    "language": "sv-SE",
    "generateRecurrenceToken": false,                         
    "disablePaymentMenu": false,                              
    "urls": {
      "hostUrls": [ "http://test-dummy.net", "http://test-dummy2.net" ],
      "completeUrl": "http://test-dummy.net/payment-completed",
      "cancelUrl": "http://test-dummy.net/payment-canceled",
      "paymentUrl": "http://test-dummy.net/payment",
      "callbackUrl": "http://test-dummy.net/payment-callback",     
      "termsOfServiceUrl": "http://test-dummy.net/termsandconditoons.pdf",
      "logoUrl": "http://test-dummy.net/logo.png"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",                                    
      "productCategory": "A123",                                   
      "subsite": "MySubsite",                                       
      "orderReference" : "or-123456"                               
    },
    "payer": {
      "nationalIdentifier": {                                      
        "socialSecurityNumber": "19XXXXXXXXXX",
        "countryCode": "SE"
      },
      "firstName": "string",                      
      "lastName": "string",                 
      "email": "string",      
      "msisdn": "string",                 
      "workPhoneNumber" : "string",                        
      "homePhoneNumber" : "string",                        
      "shippingAddress" : {                    
        "firstName" : "firstname/companyname", 
        "lastName" : "lastname",               
        "email": "string",       
        "msisdn": "string",      
        "streetAddress" : "string",      
        "coAddress" : "string",          
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "billingAddress" : {                      
        "firstName" : "firstname/companyname",  
        "lastName" : "lastname",                
        "email": "string",      
        "msisdn": "string",                
        "streetAddress" : "string",        
        "coAddress" : "string",            
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "accountInfo" : {                                 
        "accountAgeIndicator" : "01",       
        "accountChangeIndicator" : "01",       
        "accountPwdChangeIndicator" : "01", 
        "shippingAddressUsageIndicator" : "01",
        "shippingNameIndicator" : "01",              
        "suspiciousAccountActivity" : "01",        
        "addressMatchIndicator": "false"           
      }
     },
    "riskIndicator" : {
       "deliveryEmailAddress" : "string",               
       "deliveryTimeFrameindicator" : "01",    
       "preOrderDate" : "YYYYMMDD",                     
       "preOrderPurchaseIndicator" : "01",           
       "shipIndicator" : "01",        
       "giftCardPurchase" : "false",               
       "reOrderPurchaseIndicator" : "01",            
       "pickUpAddress" : {                              
           "name" : "companyname",                      
           "streetAddress" : "string",                  
           "coAddress" : "string",                      
           "city" : "string",
           "zipCode" : "string",
           "countryCode" : "string"
       }
    },
    "metadata": {                                          
      "key1": "value1",
      "key2": 2,
      "key3": 3.1,
      "key4": false
    },
    "items": [                                             
    {
      "creditCard": {
        "rejectCreditCards": false,                   
        "rejectDebitCards": false,                    
        "rejectConsumerCards": false,                 
        "rejectCorporateCards": false                 
      }
    },
    {
      "invoice": {
        "feeAmount" : 1900
      }
    },
    {
      "campaignInvoice": {
        "campaignCode" : "Campaign1",
        "feeAmount" : 2900 
      }
    },
    {
      "swish": {
        "EnableEcomOnly": false                 
      }
    }
   ]
  }
}
```

{:.table.table-striped}
| Property                                      | Type       | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|-----------------------------------------------|------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder                                  | object     | Y        | The payment order object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| operation                                     | string     | Y        | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| currency                                      | string     | Y        | The currency of the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| amount                                        | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                      |
| vatAmount                                     | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                             |
| description                                   | string     | Y        | The description of the payment order.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| userAgent                                     | string     | N        | The user agent of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| language                                      | string     | Y        | The language of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| generateRecurrenceToken                       | boolean    | N        | Determines if a recurrence token should be generated. A recurrence token is primarily used to enable recurring payments through server-to-server calls. Default value is false                                                                                                                                                                                                                                                                                                                                     |
| urls.hostUrls                                 | array      | Y        | The array of URIs valid for embedding of PayEx Hosted Views.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.completeUrl                              | string     | Y        | The URI to redirect the payer to once the payment is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.cancelUrl                                | string     | N        | The URI to redirect the payer to if the payment is canceled.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.paymentUrl                               | string     | N        | The URI that PayEx will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted views. Can not be used simultaneously with cancelUrl; only cancelUrl or paymentUrl can be used, not both.                                                                                                                                                                                                                                          |
| urls.callbackUrl                              | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                                                                                                                                                                                                                                                                                                                                                          |
| urls.termsOfServiceUrl                        | string     | Y        | The URI to the terms of service document the payer must accept in order to complete the payment. Require https.                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.logoUrl                                  | string     | Y        | The URI to the logo that will be displayed on redirect pages. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| payeeInfo.payeeId                             | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| payeeInfo.payeeReference                      | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                                                                                                                                                                                                                                                                                                                                              |
| payeeInfo.payeeName                           | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| payeeInfo.productCategory                     | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                            |
| payeeInfo.subsite                             | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                               |
| payeeInfo.orderReference                      | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                            |
| payer.nationalIdentifier                      | object     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.socialSecurityNumber | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.countryCode          | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.firstName                               | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.lastName                                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.email                                   | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.msisdn                                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.homePhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.workPhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.firstName               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.lastName                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.streetAddress           | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.coAddress               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.city                    | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.zipCode                 | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.countryCode             | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.firstName                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.lastName                 | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.streetAddress            | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.coAddress                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.city                     | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.zipCode                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.countryCode              | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| accountInfo                                   | object     | N        | Optional. If payer is known by merchant and have some kind of registered user then these fields can be set.                                                                                                                                                                                                                                                                                                                                                                                                        |
| accountInfo.accountAgeIndicator               | string     | N        | Indicates the length of time that the payments account was enrolled in the cardholder's account with merchant.01 (No account, guest)02 (Created during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                     |
| accountInfo.accountChangeIndicator            | string     | N        | Length of time since the cardholder's account information with the merchant was changed. Including billing etc.01 (Changed during transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                          |
| accountInfo.accountPwdChangeIndicator         | string     | N        | Indicates the length of time since the cardholder's account with the merchant had a password change or account reset.01 (No change)02 (Changed during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                      |
| accountInfo.shippingAddressUsageIndicator     | string     | N        | Indicates when the shipping address used for this transaction was first used with the merchant.01 (This transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                                                    |
| accountInfo.shippingNameIndicator             | string     | N        | Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.01 (Account name identical to shipping name)02 (Account name different than shipping name)                                                                                                                                                                                                                                                                                                             |
| accountInfo.suspiciousAccountActivity         | string     | N        | Indicates whether merchant has experienced suspicious activity (including previous fraud) on the cardholder account.01 (No suspicious activity has been observed)02 (Suspicious activity has been observed)                                                                                                                                                                                                                                                                                                        |
| accountInfo.addressMatchIndicator             | boolean    | N        | Allows the 3DS Requestor to indicate to the ACS whether the cardholder’s billing and shipping address are the same.                                                                                                                                                                                                                                                                                                                                                                                                |
| riskIndicator.deliveryEmailAddress            | string     | N        | For electronic delivery, the email address to which the merchandise was delivered.                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| riskIndicator.deliveryTimeFrameIndicator      | string     | N        | Indicates the merchandise delivery timeframe.01 (Electronic Delivery)02 (Same day shipping)03 (Overnight shipping)04 (Two-day or more shipping)                                                                                                                                                                                                                                                                                                                                                                    |
| riskIndicator.preOrderDate                    | string     | N        | For a pre-ordered purchase. The expected date that the merchandise will be available.FORMAT: "YYYYMMDD"                                                                                                                                                                                                                                                                                                                                                                                                            |
| riskIndicator.preOrderPurchaseIndicator       | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.shipIndicator                   | string     | N        | Indicates shipping method chosen for the transaction.01 (Ship to cardholder's billing address)02 (Ship to another verified address on file with merchant)03 (Ship to address that is different than cardholder's billing address)04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)05 (Digital goods, includes online services, electronic giftcards and redemption codes)06 (Travel and Event tickets, not shipped)07 (Other, e.g. gaming, digital service) |
| riskIndicator.giftCardPurchase                | boolean    | N        | true if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| riskIndicator.reOrderPurchaseIndicator        | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.pickUpAddress                   | object     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.name              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.streetAddress     | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.coAddress         | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.city              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.zipCode           | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.countryCode       | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| metadata                                      | object     | N        | The keys and values that should be associated with the payment order. Can be additional identifiers and data you want to associate with the payment.                                                                                                                                                                                                                                                                                                                                                               |
| items                                         | array      | N        | The array of items that will affect how the payment is performed.                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| items.creditCard.rejectDebitCards             | boolean    | N        | true if debit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                             |
| items.creditCard.rejectCreditCards            | boolean    | N        | true if credit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                            |
| items.creditCard.rejectConsumerCards          | boolean    | N        | true if consumer cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                          |
| items.creditCard.rejectCorporateCards         | boolean    | N        | true if corporate cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                         |
| items.invoice.feeAmount                       | integer    | N        | The fee amount in the lowest monetary unit to apply if the consumer chooses to pay with invoice.                                                                                                                                                                                                                                                                                                                                                                                                                   |
| items.swish.enableEcomOnly                    | boolean    | N        | true to only enable Swish on ecommerce transactions.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Purchase",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
    "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
    "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
    "items": [
      {
        "creditCard": {
          "cardBrands": [ "Visa", "MasterCard", "Ica", "etc..." ]
        }
      },
      { "invoice": {} },
      { "campaignInvoice": {} },
      { "swish": {} },
      { "vipps": {} }
    ]
  },
  "operations": [
    {
      "href": "https://ecom.payex.com/paymentorders/123456123412341234123456789012",
      "rel": "redirect-paymentorder",
      "method": "GET",
      "contentType": "application/json"
    },
    {
      "href": "https://ecom.dev.payex.com/paymentmenu/scripts/client/client-paymentmenu.js",
      "rel": "view-paymentorder",
      "method": "GET",
      "contentType": "application/javascript"
    }
  ]
}
```

### 5.5 Stored Card Payment Order Merchant Three

Merchant Three wants to create a payment order for the same consumer as Merchant One in 5.1 and Merchant Two in 5.4 but in addition wants to generate their own recurrenceToken for recurring payments. The consumer will have their stored card from 5.1 available to use in the payment menu.

Set generateRecurrenceToken value to **true**

Example follows Create Payment Order [1.2 Use Case: PayEx Checkout - Merchant onboarding](#12-use-case-payex-checkout---merchant-onboarding)

{:.code-header}
**Request**
```http
POST /psp/paymentorders HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Purchase",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",                                 
    "language": "sv-SE",
    "generateRecurrenceToken": true,                         
    "disablePaymentMenu": false,                              
    "urls": {
      "hostUrls": [ "http://test-dummy.net", "http://test-dummy2.net" ],
      "completeUrl": "http://test-dummy.net/payment-completed",
      "cancelUrl": "http://test-dummy.net/payment-canceled",
      "paymentUrl": "http://test-dummy.net/payment",
      "callbackUrl": "http://test-dummy.net/payment-callback",     
      "termsOfServiceUrl": "http://test-dummy.net/termsandconditoons.pdf",
      "logoUrl": "http://test-dummy.net/logo.png"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",                                    
      "productCategory": "A123",                                   
      "subsite": "MySubsite",                                       
      "orderReference" : "or-123456"                               
    },
    "payer": {
      "nationalIdentifier": {                                      
        "socialSecurityNumber": "19XXXXXXXXXX",
        "countryCode": "SE"
      },
      "firstName": "string",                      
      "lastName": "string",                 
      "email": "string",      
      "msisdn": "string",                 
      "workPhoneNumber" : "string",                        
      "homePhoneNumber" : "string",                        
      "shippingAddress" : {                    
        "firstName" : "firstname/companyname", 
        "lastName" : "lastname",               
        "email": "string",       
        "msisdn": "string",      
        "streetAddress" : "string",      
        "coAddress" : "string",          
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "billingAddress" : {                      
        "firstName" : "firstname/companyname",  
        "lastName" : "lastname",                
        "email": "string",      
        "msisdn": "string",                
        "streetAddress" : "string",        
        "coAddress" : "string",            
        "city" : "string",
        "zipCode" : "string",
        "countryCode" : "string"
      },
      "accountInfo" : {                                 
        "accountAgeIndicator" : "01",       
        "accountChangeIndicator" : "01",       
        "accountPwdChangeIndicator" : "01", 
        "shippingAddressUsageIndicator" : "01",
        "shippingNameIndicator" : "01",              
        "suspiciousAccountActivity" : "01",        
        "addressMatchIndicator": "false"           
      }
     },
    "riskIndicator" : {
       "deliveryEmailAddress" : "string",               
       "deliveryTimeFrameindicator" : "01",    
       "preOrderDate" : "YYYYMMDD",                     
       "preOrderPurchaseIndicator" : "01",           
       "shipIndicator" : "01",        
       "giftCardPurchase" : "false",               
       "reOrderPurchaseIndicator" : "01",            
       "pickUpAddress" : {                              
           "name" : "companyname",                      
           "streetAddress" : "string",                  
           "coAddress" : "string",                      
           "city" : "string",
           "zipCode" : "string",
           "countryCode" : "string"
       }
    },
    "metadata": {                                          
      "key1": "value1",
      "key2": 2,
      "key3": 3.1,
      "key4": false
    },
    "items": [                                             
    {
      "creditCard": {
        "rejectCreditCards": false,                   
        "rejectDebitCards": false,                    
        "rejectConsumerCards": false,                 
        "rejectCorporateCards": false                 
      }
    },
    {
      "invoice": {
        "feeAmount" : 1900
      }
    },
    {
      "campaignInvoice": {
        "campaignCode" : "Campaign1",
        "feeAmount" : 2900 
      }
    },
    {
      "swish": {
        "EnableEcomOnly": false                 
      }
    }
   ]
  }
}
```

{:.table.table-striped}
| Property                                      | Type       | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|-----------------------------------------------|------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder                                  | object     | Y        | The payment order object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| operation                                     | string     | Y        | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| currency                                      | string     | Y        | The currency of the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| amount                                        | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                      |
| vatAmount                                     | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                                                                                                                                                                                                                                                                                                                                             |
| description                                   | string     | Y        | The description of the payment order.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| userAgent                                     | string     | N        | The user agent of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| language                                      | string     | Y        | The language of the payer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| generateRecurrenceToken                       | boolean    | N        | Determines if a recurrence token should be generated. A recurrence token is primarily used to enable recurring payments through server-to-server calls. Default value is false                                                                                                                                                                                                                                                                                                                                     |
| urls.hostUrls                                 | array      | Y        | The array of URIs valid for embedding of PayEx Hosted Views.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.completeUrl                              | string     | Y        | The URI to redirect the payer to once the payment is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.cancelUrl                                | string     | N        | The URI to redirect the payer to if the payment is canceled.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| urls.paymentUrl                               | string     | N        | The URI that PayEx will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted views. Can not be used simultaneously with cancelUrl; only cancelUrl or paymentUrl can be used, not both.                                                                                                                                                                                                                                          |
| urls.callbackUrl                              | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                                                                                                                                                                                                                                                                                                                                                          |
| urls.termsOfServiceUrl                        | string     | Y        | The URI to the terms of service document the payer must accept in order to complete the payment. Require https.                                                                                                                                                                                                                                                                                                                                                                                                    |
| urls.logoUrl                                  | string     | Y        | The URI to the logo that will be displayed on redirect pages. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| payeeInfo.payeeId                             | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| payeeInfo.payeeReference                      | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                                                                                                                                                                                                                                                                                                                                              |
| payeeInfo.payeeName                           | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| payeeInfo.productCategory                     | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                            |
| payeeInfo.subsite                             | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                               |
| payeeInfo.orderReference                      | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                            |
| payer.nationalIdentifier                      | object     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.socialSecurityNumber | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.nationalIdentifier.countryCode          | string     | Y        | Required when merchant onboards consumer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.firstName                               | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.lastName                                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.email                                   | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.msisdn                                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.homePhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.workPhoneNumber                         | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.firstName               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.lastName                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.streetAddress           | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.coAddress               | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.city                    | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.zipCode                 | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.shippingAddress.countryCode             | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.firstName                | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.lastName                 | string     | N        | Optional (increases chance for challenge flow if not set) If buyer is a company, use only firstName for companyName.                                                                                                                                                                                                                                                                                                                                                                                               |
| payer.billingAddress.streetAddress            | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.coAddress                | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.city                     | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.zipCode                  | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| payer.billingAddress.countryCode              | string     | N        | Optional (increases chance for challenge flow if not set)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| accountInfo                                   | object     | N        | Optional. If payer is known by merchant and have some kind of registered user then these fields can be set.                                                                                                                                                                                                                                                                                                                                                                                                        |
| accountInfo.accountAgeIndicator               | string     | N        | Indicates the length of time that the payments account was enrolled in the cardholder's account with merchant.01 (No account, guest)02 (Created during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                     |
| accountInfo.accountChangeIndicator            | string     | N        | Length of time since the cardholder's account information with the merchant was changed. Including billing etc.01 (Changed during transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                          |
| accountInfo.accountPwdChangeIndicator         | string     | N        | Indicates the length of time since the cardholder's account with the merchant had a password change or account reset.01 (No change)02 (Changed during transaction)03 (Less than 30 days)04 (30-60 days)05 (More than 60 days)                                                                                                                                                                                                                                                                                      |
| accountInfo.shippingAddressUsageIndicator     | string     | N        | Indicates when the shipping address used for this transaction was first used with the merchant.01 (This transaction)02 (Less than 30 days)03 (30-60 days)04 (More than 60 days)                                                                                                                                                                                                                                                                                                                                    |
| accountInfo.shippingNameIndicator             | string     | N        | Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.01 (Account name identical to shipping name)02 (Account name different than shipping name)                                                                                                                                                                                                                                                                                                             |
| accountInfo.suspiciousAccountActivity         | string     | N        | Indicates whether merchant has experienced suspicious activity (including previous fraud) on the cardholder account.01 (No suspicious activity has been observed)02 (Suspicious activity has been observed)                                                                                                                                                                                                                                                                                                        |
| accountInfo.addressMatchIndicator             | boolean    | N        | Allows the 3DS Requestor to indicate to the ACS whether the cardholder’s billing and shipping address are the same.                                                                                                                                                                                                                                                                                                                                                                                                |
| riskIndicator.deliveryEmailAddress            | string     | N        | For electronic delivery, the email address to which the merchandise was delivered.                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| riskIndicator.deliveryTimeFrameIndicator      | string     | N        | Indicates the merchandise delivery timeframe.01 (Electronic Delivery)02 (Same day shipping)03 (Overnight shipping)04 (Two-day or more shipping)                                                                                                                                                                                                                                                                                                                                                                    |
| riskIndicator.preOrderDate                    | string     | N        | For a pre-ordered purchase. The expected date that the merchandise will be available.FORMAT: "YYYYMMDD"                                                                                                                                                                                                                                                                                                                                                                                                            |
| riskIndicator.preOrderPurchaseIndicator       | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.shipIndicator                   | string     | N        | Indicates shipping method chosen for the transaction.01 (Ship to cardholder's billing address)02 (Ship to another verified address on file with merchant)03 (Ship to address that is different than cardholder's billing address)04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)05 (Digital goods, includes online services, electronic giftcards and redemption codes)06 (Travel and Event tickets, not shipped)07 (Other, e.g. gaming, digital service) |
| riskIndicator.giftCardPurchase                | boolean    | N        | true if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| riskIndicator.reOrderPurchaseIndicator        | string     | N        | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.01 (Merchandise available)02 (Future availability)                                                                                                                                                                                                                                                                                                                                                     |
| riskIndicator.pickUpAddress                   | object     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.name              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.streetAddress     | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.coAddress         | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.city              | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.zipCode           | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| riskIndicator.pickUpAddress.countryCode       | string     | N        | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| metadata                                      | object     | N        | The keys and values that should be associated with the payment order. Can be additional identifiers and data you want to associate with the payment.                                                                                                                                                                                                                                                                                                                                                               |
| items                                         | array      | N        | The array of items that will affect how the payment is performed.                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| items.creditCard.rejectDebitCards             | boolean    | N        | true if debit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                             |
| items.creditCard.rejectCreditCards            | boolean    | N        | true if credit cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                            |
| items.creditCard.rejectConsumerCards          | boolean    | N        | true if consumer cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                          |
| items.creditCard.rejectCorporateCards         | boolean    | N        | true if corporate cards should be declined; otherwise false per default. Default value is set by PayEx and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                         |
| items.invoice.feeAmount                       | integer    | N        | The fee amount in the lowest monetary unit to apply if the consumer chooses to pay with invoice.                                                                                                                                                                                                                                                                                                                                                                                                                   |
| items.swish.enableEcomOnly                    | boolean    | N        | true to only enable Swish on ecommerce transactions.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Purchase",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
    "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
    "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
    "items": [
      {
        "creditCard": {
          "cardBrands": [ "Visa", "MasterCard", "Ica", "etc..." ]
        }
      },
      { "invoice": {} },
      { "campaignInvoice": {} },
      { "swish": {} },
      { "vipps": {} }
    ]
  },
  "operations": [
    {
      "href": "https://ecom.payex.com/paymentorders/123456123412341234123456789012",
      "rel": "redirect-paymentorder",
      "method": "GET",
      "contentType": "application/json"
    },
    {
      "href": "https://ecom.dev.payex.com/paymentmenu/scripts/client/client-paymentmenu.js",
      "rel": "view-paymentorder",
      "method": "GET",
      "contentType": "application/javascript"
    }
  ]
}
```

### 5.6 Recurring Payment Merchant Three
When the consumer has completed their payment for Merchant Three in the created payment order from 5.5, you are able to retrieve the recurrenceToken from the payment order. Only available to use by Merchant Three.


{:.code-header}
**Request Merchant Three**
```http
GET /psp/paymentorders/<paymentOrderId>/currentpayment HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json
```

{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "recurrenceToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
    "menuElementName": "creditcard",
    "payment": {
        "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
        "number": 1234567890,
        "instrument": "CreditCard",
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "operation": "Purchase",
        "intent": "Authorization",
        "state": "Ready",
        "currency": "SEK",
        "amount": 1500,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "paymentToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
        "prices": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/prices" },
        "transactions": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions" },
        "authorizations": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/authorizations" },
        "captures": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/captures" },
        "cancellations": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/cancellations" },
        "reversals": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals" },
        "verifications": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/verifications" },
        "urls" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
        "payeeInfo" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
        "metadata" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/metadata" },
        "settings": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" }
    },
    "operations": []
}
```

**Create a recurring payment for Merchant Three**  
When you have a recurrence token safely tucked away, you can use this token in a subsequent Recur payment. This will be a server-to-server affair, as we have tied all necessary payment instrument details related to the recurrence token during the initial payment order.

{:.code-header}
**Request Merchant Three**
```http
POST /psp/paymentorders HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Recur",
    "intent": "Authorization",
    "recurrenceToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "description": "Test Recurrence",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls": {
      "callbackUrl": "http://test-dummy.net/payment-callback"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant3",
      "productCategory": "A123",
      "orderReference": "orderRef123",
      "subsite": "MySubsite"       
    }
  }
}
```

{:.table.table-striped}
| Property                  | Type       | Required | Description                                                                                                                                                                             |
|---------------------------|------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| paymentorder              | object     | Y        | The payment order object.                                                                                                                                                               |
| operation                 | string     | Y        | Recur is always used for recurring payments.                                                                                                                                            |
| intent                    | string     | Y        | The intent of the payment.                                                                                                                                                              |
| recurrenceToken           | string     | Y        | The reccurenceToken to debit.                                                                                                                                                           |
| currency                  | string     | Y        | The currency of the payment.                                                                                                                                                            |
| amount                    | integer    | Y        | The amount including VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                           |
| vatAmount                 | integer    | Y        | The amount of VAT in the lowest monetary unit of the currency. E.g. 10000 equals 100.00 NOK and 5000 equals 50.00 NOK.                                                                  |
| description               | string     | Y        | The description of the payment order.                                                                                                                                                   |
| userAgent                 | string     | Y        | The user agent of the payer.                                                                                                                                                            |
| language                  | string     | Y        | The language of the payer.                                                                                                                                                              |
| urls.callbackUrl          | string     | N        | The URI to the API endpoint receiving POST requests on transaction activity related to the payment order.                                                                               |
| payeeInfo.payeeId         | string     | Y        | The ID of the payee, usually the merchant ID.                                                                                                                                           |
| payeeInfo.payeeReference  | string(30) | Y        | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See payeeReference for details.                   |
| payeeInfo.payeeName       | string     | N        | The name of the payee, usually the name of the merchant.                                                                                                                                |
| payeeInfo.productCategory | string     | N        | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process. |
| payeeInfo.orderReference  | string(50) | N        | The order reference should reflect the order reference found in the merchant's systems.                                                                                                 |
| payeeInfo.subsite         | string(40) | N        | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.                                    |

{:.code-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "paymentorder": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Recur",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 0,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
    "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
    "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
    "items": [
      {
        "creditCard": {
          "cardBrands": [ "Visa", "MasterCard", "Ica", "etc..." ]
        }
      },
      { "invoice": {} },
      { "campaignInvoice": {} },
      { "swish": {} },
      { "vipps": {} }
    ]
  },
  "operations":  [
      {
      }
  ]
}
```