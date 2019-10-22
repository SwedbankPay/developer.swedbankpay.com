---
title: Swedbank Pay Payments Direct Debit Payments
sidebar:
  navigation:
  - title: Payments
    items:
    - url: /payments/
      title: Introduction
    - url: /payments/credit-account
      title: Credit Account Payments
    - url: /payments/credit-card
      title: Credit Card Payments
    - url: /payments/invoice
      title: Invoice Payments
    - url: /payments/direct-debit
      title: Direct Debit
    - url: /payments/direct-debit/payments
      title: Direct Debit Payments
    - url: /payments/mobile-pay
      title: Mobile Pay Payments
    - url: /payments/swish
      title: Swish Payments
    - url: /payments/vipps
      title: Vipps Payments
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

# Direct Debit Payment Pages

>PayEx offer Direct debit bank payments for the Baltics (Estonia, Latvia and Lithuania).

{:.table .table-striped}
| **Country** | **Supported banks** |
|![Estonia](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/direct-debit-payments/direct-debit-payment-pages/WebHome/Estonia.png) Estonia | Swedbank |
| ![Latvia](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/direct-debit-payments/direct-debit-payment-pages/WebHome/Latvia_.png) Latvia | Swedbank|
| ![Lithuania](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/direct-debit-payments/direct-debit-payment-pages/WebHome/Lithuania.png) Lithuania | Swedbank |

## Introduction

*   When the consumer/end-user starts the purchase process in your merchant/webshop site, you need to make a `POST` request towards PayEx with your Purchase information. You receive a Redirect URL in return. 
*   You need to redirect the consumer/end-user's browser to the Redirect URL.
*   A bank selection page will be presented to the consumer/end-user.
*   The consumer/end-user will be redirect to the choosen bank's login page where she have to verify her identity to continue the payment process. 
*   PayEx will redirect the consumer/end-user's browser to one of two specified URLs, depending on whether the payment session is followed through completely or cancelled beforehand. Please note that both a successful and rejected payment reach completion, in contrast to a cancelled payment.
*   When you detect that the consumer/end-user reach your completeUrl, you need to do a GET request to receive the state of the transaction.

## Screenshots

Screenshots  will be available at a later date.

## API Requests

The API requests are displayed in the [purchase flow](#HPurchaseflow). The options you can choose from when creating a payment with key operation set to Value Purchase are listed below. The general REST based API model is described in the [technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

### Options before posting a payment

All valid options when posting a payment with operation equal to Purchase, are described in [the technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/direct-debit-payments/).

#### Type of authorization (Intent).

*   **Sale**: A direct debit payment will always have intent: Sale, creating a one-phase sales transaction.

#### General

*   **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL ](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs)in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback)

## Purchase flow

The sequence diagram below shows the two requests you have to send to PayEx to make a purchase. The links will take you directly to the API description for the specific request. The diagram also shows in high level, the sequence of the process of a complete purchase.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/direct-debit-payments/direct-debit-payment-pages/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">

## Options after posting a payment

*   **Abort:** It is possible to [abort a payment](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HAbort) if the payment has no successful transactions.
*   For reversals, you will need to implement the Reversal request.
*   **If CallbackURL is set:** Whenever changes to the payment occur a [Callback request](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback) will be posted to the [CallbackURL](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs), which was generated when the payment was created.

### Reversal Sequence

Reversal can only be done on a payment where there are some captured amount not yet reversed.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/direct-debit-payments/direct-debit-payment-pages/WebHome?xpage=plain&amp;uml=2" style="max-width:100%">

# Payment Resources Direct Debit Payments

## Payment Resource

The payment resource and all general sub-resources can be found in the [core payment resources](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/) section.

## Create Payment

To create a Direct Debit payment, you perform an HTTP `POST` against the `/psp/directdebit/payments` resource. Please read the [general information ](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/)on how to compose a valid HTTP request before proceeding.

An example of a payment creation request is provided below. Each individual Property of the JSON document is described in the following section. Use the [expand](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HExpansion) request parameter to get a response that includes one or more expanded sub-resources inlined.


```HTTP
Request
POST /psp/directdebit/payments HTTP/1.1  
Host: api.payex.com  
Authorization: Bearer <MerchantToken>  
Content-Type: application/json  
  
{  
   "payment": {  
       "operation": "Purchase",  
       "intent": "Sale",  
       "currency": "EUR",  
       "prices": \[  
            {  
               "type": "NordeaFi",  
               "amount": 1500,  
               "vatAmount": 0  
            }  
        \],  
       "description": "Test Purchase",  
       "payerReference": "AB1234",  
       "userAgent": "Mozilla/5.0...",  
       "language": "sv-SE",  
       "urls": {  
           "completeUrl": "http://test-dummy.net/payment-completed",  
           "cancelUrl": "http://test-dummy.net/payment-canceled",  
           "callbackUrl": "http://test-dummy.net/payment-callback",  
           "logoUrl": "https://example.com/logo.png",  
           "termsOfServiceUrl": "https://example.com/terms.pdf"  
        },    
       "payeeInfo": {  
           "payeeId": "12345678-1234-1234-1234-123456789012",  
           "payeeReference": "PR123",  
           "payeeName": "Merchant1",  
           "productCategory": "PC1233",  
           "orderReference": "or-12456",  
           "subsite": "MySubsite"  
        }  
    }     
}   
```

**Properties**

{:.table .table-striped}
| Property | Data type | Required |Description |
| payment.operation |string | ✔︎︎︎︎︎ | Purchase is the only type used for direct debit payments. |
| payment.intent |string |✔︎︎︎︎︎  |Sale is the only type used for direct debit payments. |
| payment.currency |string | ✔︎︎︎︎︎ |The currency used. |
| payment.prices.type | string | ✔︎︎︎︎︎ | Use the generic type Directdebit if you want to enable all bank types supported by merchant contract, otherwise specify a specific bank type. [See the Prices object types for more information.](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HPricesobjecttypes). |
| payment.prices.amount | integer | ✔︎︎︎︎︎ | Amount is entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 SEK 5000 = 50.00 SEK. |
| payment.prices.vatAmount | integer | ✔︎︎︎︎︎ | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant. |
| payment.description |string(40) | ✔︎︎︎︎ | A textual description max 40 characters of the purchase. |
| payment.payerReference | string | X | The reference to the payer (consumer/end-user) from the merchant system, like mobile number, customer number etc. |
| payment.userAgent | string | ✔︎︎︎︎ | The user agent reference of the consumer's browser - [see user agent definition](https://en.wikipedia.org/wiki/User_agent) |
| payment.language | string | ✔︎︎︎︎ | nb-NO, sv-SE or en-US. |
| payment.urls.completeUrl | string | ✔︎︎︎︎ | The URI that PayEx will redirect back to when the payment is followed through. |
| payment.urls.cancelUrl | string | ✔︎︎︎︎ | The URI that PayEx will redirect back to when the user presses the cancel button in the payment page. |
| payment.urls.callbackUrl | string | X | The URI that PayEx will perform an HTTP POST against every time a transaction is created on the payment. See [callback](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/) for details. |
| payment.urls.logoUrl | string | X | The URI that will be used for showing the customer logo. Must be a picture with at most 50px height and 400px width. Require https. |
| payment.urls.termsOfServiceUrl | string | X | A URI that contains your terms and conditions for the payment, to be linked on the payment page. Require https. |
| payeeInfo.payeeId | string | ✔︎︎︎︎ | This is the unique id that identifies this payee (like merchant) set by PayEx. |
| payeeInfo.payeeReference | string(35) | ✔︎︎︎︎ | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HPayeeReference) for details. |
| payeeInfo.payeeName | string | X | The payee name (like merchant name) that will be displayed to consumer when redirected to PayEx. |
| payeeInfo.productCategory | string | X | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process. |
| payeeInfo.orderReference | string(50) | X | The order reference should reflect the order reference found in the merchant's systems. |
| payeeInfo.subsite | String(40) | X | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used. |

**Response**

```HTTP
HTTP/1.1 200 OK  
Content-Type: application/json  
  
{  
   "payment": {  
       "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",  
       "number": 1234567890,  
       "instrument": "DirectDebit",  
       "created": "2018-10-09T13:01:01Z",  
       "updated": "2018-10-09T13:01:01Z",  
       "state": "Ready",  
       "operation": "Purchase",  
       "intent": "Sale",  
       "currency": "EUR",  
       "amount": 1500,  
       "remainingReversalAmount": 0,  
       "description": "Test Purchase",  
       "userAgent": "Mozilla/5.0...",  
       "language": "nb-NO",  
       "prices": { "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/prices" },  
       "transactions": { "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions" },  
       "sales": { "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/sales" },  
       "reversals": { "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals" },  
       "payeeInfo" : { "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },  
       "urls" : { "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },  
       "settings": { "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" }  
  },  
   "operations": [  
        {  
           "href": "https://api.payex.com/psp/directdebit/payments/<paymentId>/sales",  
           "rel": "redirect-sale",  
           "method": "POST"  
        },  
        {  
           "href": "http://api.payex.com/psp/directdebit/payments/<paymentId>",  
           "rel": "update-payment-abort",  
           "method": "PATCH"  
        }  
    ]  
}
```

## Operations

A payment resource has a set of operations that can be performed on it, from its creation to its end. The operations available at any given time vary between payment methods and depends on the current state of the payment resource. A list of possible operations for Direct Debit Payments and their explanation is given below.

**Operations**
```JSON
{  
   "operations": [  
        {  
           "method": "PATCH",  
           "href": "https://api.externalintegration.payex.com/psp/directdebit/payments/3648fa94-7fd8-4e32-a14b-08d608f884ff",  
           "rel": "update-payment-abort"  
        },  
        {  
           "method": "GET",  
           "href": "https://ecom.externalintegration.payex.com/directdebit/payments/sales/993b479653da83671c074316c7455da05fced9d634431edbb64f3c5f80a863f0",  
           "rel": "redirect-sale"  
        }  
    ]  
}
```

**Properties**

{:.table .table-striped}
| **Property** | **Description** |
| href | The target URI to perform the operation against. |
| rel | The name of the relation the operation has to the current resource. |
| method | The HTTP method to use when performing the operation. |

The operations should be performed as described in each response and not as described here in the documentation. Always use the `href` and `method` as specified in the response by finding the appropriate operation based on its `rel` value. The only thing that should be hard coded in the client is the value of the `rel` and the request that will be sent in the HTTP body of the request for the given operation.

| **Operation** | **Description** |
| _update-payment-abort_ | [Aborts](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HAbort) the payment before any financial transactions are performed. |
| _redirect-sale_ | Contains the redirect-URI that redirects the consumer to a PayEx hosted payments page prior to creating a sales transaction. |

## Direct Debit transactions

All Direct Debit specific transactions are described below. Read more about the general transaction resource [here](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HTransactions).

### Sales

The `Sales` resource lists the sales transactions (one or more) on a specific payment.

**Request**

```HTTP
GET /psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/sales HTTP/1.1  
Host: api.payex.com  
Authorization: Bearer <MerchantToken>  
Content-Type: application/json
```

**Response**

```HTTP
HTTP/1.1 200 OK  
Content-Type: application/json  
  
{  
   "payment": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",  
   "sales": {  
       "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/sales",  
       "salesList": [  
            {  
               "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/sales/12345678-1234-1234-1234-123456789012",  
               "selectedBank": "NordeaFI",  
               "deviceIsMobile": "TRUE|FALSE",  
               "transaction": {  
                   "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions/12345678-1234-1234-1234-123456789012",  
                   "created": "2018-09-14T01:01:01.01Z",  
                   "updated": "2018-09-14T01:01:01.03Z",  
                   "type": "Sale",  
                   "state": "Initialized|Completed|Failed",  
                   "number": 1234567890,  
                   "amount": 1000,  
                   "vatAmount": 250,  
                   "description": "Test transaction",  
                   "payeeReference": "AH123456",  
                   "failedReason": "",  
                   "failedActivityName": "",  
                   "failedErrorCode": "",  
                   "failedErrorDescription": "",  
                   "isOperational": "TRUE|FALSE",  
                   "operations": [  
                    ]  
                }  
            },  
            {  
               "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/sales/12345678-1234-1234-1234-123456789013",  
               "selectedBank": "NordeaFI|...",  
               "deviceIsMobile": "TRUE|FALSE",  
               "transaction": {  
                   "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions/12345678-1234-1234-1234-123456789013",  
                   "created": "2018-09-14T01:01:01.01Z",  
                   "updated": "2018-09-14T01:01:01.03Z",  
                   "type": "Sale",  
                   "state": "Initialized|Completed|Failed",  
                   "number": 1234567890,  
                   "amount": 1000,  
                   "vatAmount": 250,  
                   "description": "Test transaction",  
                   "payeeReference": "AH123456",  
                   "failedReason": "",  
                   "failedActivityName": "",  
                   "failedErrorCode": "",  
                   "failedErrorDescription": "",  
                   "isOperational": "TRUE|FALSE",  
                   "operations": [  
                        {  
                           "href": "https://api.payex.com/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",            
                           "rel": "edit-sale",  
                           "method": "PATCH"  
                        }  
                    ]       
                }       
            }      
        ]  
    }  
}
```

#### Create Sales transaction

The sales transaction This is managed either by by redirecting the end-user to the hosted payment pages.

### Reversals

The `Reversals` resource list the reversals transactions (one or more) on a specific payment.

**Request**
```HTTP
GET /psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals HTTP/1.1  
Host: api.payex.com  
Authorization: Bearer <MerchantToken>  
Content-Type: application/json
```

**Response**

```HTTP  
HTTP/1.1 200 OK  
Content-Type: application/json  
  
{  
   "payment": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",  
   "reversals": {  
       "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals",  
       "reversalList": [  
            {  
               "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals/12345678-1234-1234-1234-123456789012",  
               "transaction": {  
                   "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions/12345678-1234-1234-1234-123456789012",  
                   "created": "2016-09-14T01:01:01.01Z",  
                   "updated": "2016-09-14T01:01:01.03Z",  
                   "type": "Reversal",  
                   "state": "Initialized|Completed|Failed",  
                   "number": 1234567890,  
                   "amount": 1000,  
                   "vatAmount": 250,  
                   "description": "Test transaction",  
                   "payeeReference": "AH123456",  
                   "isOperational": "TRUE|FALSE",  
                   "operations": []  
                }  
            }  
        ]  
    }  
}
```

**Properties**

{:.table .table-striped}
| **Property** | **Type** | **Description** |
| payment | string | The relative URI of the payment that the reversal transactions belong to. |
| reversalList | array | The array of reversal transaction objects. |
| reversalList\[\] | object | The reversal transaction object representation of the reversal transaction resource described below. |

#### Create Reversal transaction

You can create a reversal transaction against a completed sales transaction by adding that transaction's payeeReference in the request body.  A callback request will follow from PayEx. 

**Request**

```HTTP
POST /psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals HTTP/1.1  
Host: api.payex.com  
Authorization: Bearer <MerchantToken>  
Content-Type: application/json  
  
{  
   "transaction": {  
       "amount": 1500,  
       "vatAmount": 0,  
       "description" : "Test Reversal",  
       "payeeReference": "ABC123"  
    }  
}
```

**Properties**

{:.table .table-striped}
| **Property** | **Data type** | **Required** | **Description** |
| transaction.amount | integer | ✔︎︎︎︎︎ | Amount entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 SEK, 5000 = 50.00 SEK. |
| transaction.vatAmount | integer | ✔︎︎︎︎︎ | Amount entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 SEK, 5000 = 50.00 SEK. |
| transaction.description | string | ✔︎︎︎︎︎ | A textual description of the capture. |
| transaction.payeeReference | string(35) | ✔︎︎︎︎︎ | A  reference that must match the  payeeReference of the sales transaction you want to reverse. See [payeeReference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HPayeeReference) for details. |

**Response**

```HTTP
HTTP/1.1 200 OK  
Content-Type: application/json  
  
{  
   "payment": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",  
   "reversal": {  
       "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals/12345678-1234-1234-1234-123456789012",  
       "transaction": {  
           "id": "/psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions/12345678-1234-1234-1234-123456789012",  
           "created": "2016-09-14T01:01:01.01Z",  
           "updated": "2016-09-14T01:01:01.03Z",  
           "type": "Reversal",  
           "state": "Initialized|Completed|Failed",  
           "number": 1234567890,  
           "amount": 1000,  
           "vatAmount": 250,  
           "description": "Test transaction",  
           "payeeReference": "AH123456",  
           "isOperational": "TRUE|FALSE",  
           "operations": \[\]  
        }  
    }  
}
```

**Properties**

{:.table .table-striped}
| **Property** | **Data type** | **Description** |
| payment | string | The relative URI of the payment this capture transaction belongs to. |
| reversal.id | string | The relative URI of the created capture transaction. 
| reversal.transaction | object | The object representation of the generic [transaction resource](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HTransaction). |

## Callback

When a change or update from the back-end system are made on a payment or transaction, PayEx will perform a callback to inform the payee (merchant) about this update. Callback functionality is explaned in more detail [here](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback).

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/technical-reference/core-payment-resources/direct-debit-payments/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">
