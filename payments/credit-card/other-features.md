---
title: Swedbank Pay Payments Credit Card Other Features
sidebar:
  navigation:
  - title: Credit Card Payments
    items:
    - url: /payments/credit-card/
      title: Introduction
    - url: /payments/credit-card/redirect
      title: Redirect
    - url: /payments/credit-card/direct
      title: Direct
    - url: /payments/credit-card/after-payment
      title: After Payment
    - url: /payments/credit-card/other-features
      title: Other Features
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

## Recur

A `recur` payment is a payment that references a `recurrenceToken` created through a previous payment in order to charge the same card. Use the [expand][expansion] request parameter to get a response that includes one or more expanded sub-resources inlined.

{:.code-header}
**Request**

```HTTP
POST /psp/creditcard/payments HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
   "payment": {
       "operation": "Recur",
       "intent": "Authorization|AutoCapture",
       "recurrenceToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
       "currency": "NOK",
       "amount": 1500,
       "vatAmount": 0,
       "description": "Test Recurrence",
       "userAgent": "Mozilla/5.0...",
       "language": "nb-NO",
       "urls": {
           "callbackUrl": "http://test-dummy.net/payment-callback"
        },
       "payeeInfo": {
           "payeeId": "12345678-1234-1234-1234-123456789012",
           "payeeReference": "CD1234",
           "payeeName": "Merchant1",
           "productCategory": "A123",
           "orderReference": "or-12456",
           "subsite": "MySubsite"
        }
    }
}
```

{% include one-click-payments.md %}

{% include payment-link.md %}

{% include subsite.md %}

{% include settlement-reconciliation.md %}

### Problem messages

When performing unsuccessful operations, the eCommerce API will respond with a problem message. We generally use the problem message ##type## and ##status## code to identify the nature of the problem. The problem ##name## and ##description## will often help narrow down the specifics of the problem.

For general information about problem messages and error handling,[visit error handling and problem details][technical-reference-problems]. 

#### Contractual error types

All contract types will have the following URI in front of type: `https://api.payex.com/psp/<errordetail>/creditcard`

{:.table .table-striped}
| **Type** | **Status** | **Notes**
|*cardbranddisabled*| 403 | 
| *accountholdertyperejected* | 403 | 
| *cardtyperejected* | 403 | 
| *3dsecurerequired* | 403 | 
| *authenticationstatusrejected* | 403 | 
| *frauddetected* | 403 | 
| *3dsecuredeclined* | 403 | 

#### Error types from 3Dsecure/ Acquirer

All acquirer error types will have the following URI in front of type: `https://api.payex.com/psp/errordetail/creditcard/<errorType>`

{:.table .table-striped}
| **Type** | **Status** | **Notes**
| *3dsecureerror* | 400 | 3D Secure not working, try again some time later
| *cardblacklisted* | 400 | Card blacklisted, Consumer need to contact their Card-issuing bank
| *paymenttokenerror* | 403 |  
| *carddeclined* | 403 | 
| *acquirererror* | 403 | 
| *acquirercardblacklisted* | 403 | Card blacklisted, Consumer need to contact their Card-issuing bank
| *acquirercardexpired* | 403 | Wrong expire date or Card has expired and consumer need to contact their Card-issuing bank
| *acquirercardstolen* | 403 | Card blacklisted, Consumer need to contact their Card-issuing bank
| *acquirerinsufficientfunds* | 403 | Card does not have sufficient funds, consumer need to contact their Card-issuing bank.
| *acquirerinvalidamount* | 403 | Amount not valid by aquirer, contact support.ecom@payex.com
| *acquirerpossiblefraud* | 403 | Transaction declined due to possible fraud, consumer need to contact their Card-issuing bank.
| *3dsecureusercanceled* | 403 | Transaction was Cancelled during 3DSecure verification
| *3dsecuredeclined* | 403 | Transaction was declined during 3DSecure verification
| *frauddetected* | 403 | Fraud detected. Consumer need to contact their Card-issuing bank.
| *badrequest* | 500| Bad request, try again after some time
| *internalservererror* | 500| Server error, try again after some time
| *3dsecureacquirergatewayerror* | 502| Problems reaching 3DSecure verification, try again after some time.
| *badgateway* | 502| Problems reaching the gateway, try again after some time
| *acquirergatewayerror* | 502| Problems reaching acquirers gateway, try again after some time
| *acquirergatewaytimeout* | 504| Problems reaching acquirers gateway, try again after some time 


[expansion]: #
[technical-reference-problems]: #
