---
title: Swedbank Pay Payments Vipps
sidebar:
  navigation:
  - title: Vipps Payments
    items:
    - url: /payments/vipps
      title: Introduction
    - url: /payments/vipps/redirect
      title: Redirect
    - url: /payments/vipps/seamless-view
      title: Seamless View
    - url: /payments/vipps/after-payment
      title: After After Payment
    - url: /payments/vipps/other-features    
      title: Other Features
---

## Payment Resource

The payment resource and all general sub-resources can be found in the [core payment resources][core-payments-resources] section.

## Create Payment

To create a Vipps payment, you perform an HTTP POST against the /psp/vipps/payments resource. Please read the [general information][general-information] on how to compose a valid HTTP request before proceeding.

An example of a payment creation request is provided below. Each individual Property of the JSON document is described in the following section. Use the [expand][expand] request parameter to get a response that includes one or more expanded sub-resources inlined.

{:.code-header}
**Request**

```HTTP
HTTP
POST /psp/vipps/payments HTTP/1.1  
Host: api.payex.com  
Authorization: Bearer <MerchantToken>  
Content-Type: application/json  
  
{  
   "payment": {  
       "operation": "Purchase",  
       "intent": "Authorization",  
       "currency": "NOK",  
       "prices": \[  
            {  
               "type": "Vipps",  
               "amount": 1500,  
               "vatAmount": 0  
            }  
        \],  
       "description": "Vipps Test",  
       "payerReference": "ABtimestamp",  
       "userAgent": "Mozilla/5.0",  
       "language": "nb-NO",  
       "urls": {  
           "hostUrls": \["https://example.com", "https://example.net"\],  
           "completeUrl": "http://example.com/payment-completed",  
           "cancelUrl": "http://example.com/payment-canceled",  
           "paymentUrl": "http://example.com/perform-payment",  
           "callbackUrl": "https://api.externalintegration.payex.com/psp/payment-callback",  
           "logoUrl": "https://example.com/path/to/logo.png",  
           "termsOfServiceUrl": "https://example.com/terms.pdf"  
  
        },  
       "payeeInfo": {  
           "payeeId": "3387e01f-a323-428b-a954-8c1e2baf7186",  
           "payeeReference": "payeeReference",  
           "payeeName": "Merchant1",  
           "productCategory": "A123",  
           "orderReference": "or-12456",  
           "subsite": "MySubsite"  
            },  
       "prefillInfo": {  
        "msisdn": "+47xxxxxxxx"  
        }  
    }  
}
```

{:.table .table-striped}
| **Property** | **Data type** | **Required** | **Description** |
| payment.operation | string | Y| Purchase | 
| payment.intent | string | ✔︎ | Authorization |
| payment.currency | string | ✔︎ | NOK |
| payment.prices.type | string | ✔︎ | vipps
| payment.prices.amount | integer | ✔︎ | Amount is entered in the lowest momentary units of the selected currency. <br> E.g. 10000 = 100.00 NOK, 5000 = 50.00 NOK. |
| payment.prices.vatAmount | integer | ✔︎ | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant. |
| payment.description | string(40) | ✔︎ | A textual description max 40 characters of the purchase. |
| payment.payerReference | string | N | The reference to the payer (consumer/end-user) from the merchant system, like mobile number, customer number etc. |
| payment.userAgent | string | ✔︎ | The user agent reference of the consumer's browser - [see user agent definition][see-user-agent-definition] | 
| payment.language | string | ✔︎ | nb-NO, sv-SE or en-US. |
| payment.urls.hostUrls | array | ✔︎ | The array of URIs valid for embedding of PayEx Hosted Views. | 
| payment.urls.completeUrl | string | ✔︎ | The URI that PayEx will redirect back to when the payment page is completed. | 
| payment.urls.cancelUrl | string | N | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with paymentUrl; only cancelUrl or paymentUrl can be used, not both. |
| payment.urls.paymentUrl | string | N | The URI that PayEx will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted views. Can not be used simultaneously with cancelUrl; only cancelUrl or paymentUrl can be used, not both. |
| payment.urls.callbackUrl | string | N | The URI that PayEx will perform an HTTP POST against every time a transaction is created on the payment. See [callback][callback] |
| payment.urls.logoUrl | string | N | The URI that will be used for showing the customer logo. Must be a picture with at most 50px height and 400px width. Requires https. | 
| payment.urls.termsOfServiceUrl | string | N | A URI that contains your terms and conditions for the payment, to be linked on the payment page. Requires https. | 
| payeeInfo.payeeId | string | ✔︎ | This is the unique id that identifies this payee (like merchant) set by PayEx. |
| payeeInfo.payeeReference | string(30) | ✔︎ | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payeeReference] for details. |
| payeeInfo.payeeName | string | N | The payee name (like merchant name) that will be displayed to consumer when redirected to PayEx. | 
| payeeInfo.productCategory | string | N | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process. |
| payeeInfo.orderReference | string(50) | N | The order reference should reflet the order reference found in the merchant's systems. | 
| payeeInfo.prefillInfo | string | N | The mobile number that will be prefilled in the PayEx payment pages. The consumer may change this number in the UI. | 
| payeeInfo.subsite | string(40) | N | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used. | 

{:.code-header}
**Response** 

```HTTP
HTTP/1.1 200 OK  
Content-Type: application/json  
  
{  
   "payment": {  
       "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d",  
       "number": 72100003079,  
       "created": "2018-09-05T14:18:44.4259255Z",  
       "instrument": "Vipps",  
       "operation": "Purchase",  
       "intent": "Authorization",  
       "state": "Ready",  
       "currency": "NOK",  
       "prices": {  
           "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/prices"  
        },  
       "amount": 0,  
       "description": "Vipps Test",  
       "payerReference": "AB1536157124",  
       "initiatingSystemUserAgent": "PostmanRuntime/7.2.0",  
       "userAgent": "Mozilla/5.0 weeeeee",  
       "language": "nb-NO",  
       "urls": {  
           "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/urls"  
        },  
       "payeeInfo": {  
           "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/payeeinfo"  
        },  
       "metadata": {  
           "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/metadata"  
        }  
    },  
   "operations": \[  
        {  
           "method": "PATCH",  
           "href": "https://api.externalintegration.payex.com/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d",  
           "rel": "update-payment-abort"  
        },  
        {  
           "method": "GET",  
           "href": "https://ecom.externalintegration.payex.com/vipps/payments/authorize/afccf3d0016340620756d5ff3e08f69b555fbe2e45ca71f4bd159ebdb0f00065",  
           "rel": "redirect-authorization"  
        }  
    \]  
}
```

### Purchase

Posting a payment (operation purchase) returns the options of aborting the payment altogether or creating an authorization transaction through the redirect-authorization hyperlink. 

{:.code-header}
**Request**

```JS
{  
   "payment": {  
       "operation": "Purchase"  
    }  
}
```

### Operations

When a payment resource is created and during its lifetime, it will have a set of operations that can be performed on it. Which operations are available will vary depending on the state of the payment resource, what the access token is authorized to do, etc. A list of possible operations and their explanation is given below.

{:.code-header}
**Operations**

```JS
{  
   "payment": {},  
   "operations": [  
        {  
           "href": "http://api.externalintegration.payex.com/psp/vipps/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",  
           "rel": "update-payment-abort",  
           "method": "PATCH"  
        },  
        {  
           "href": "https://ecom.externalintegration.payex.com/vipps/payments/authorize/123456123412341234123456789012",  
           "rel": "redirect-authorization",  
           "method": "GET"  
        },  
        {  
           "href": "https://api.externalintegration.payex.com/psp/mobilepay/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/captures",  
           "rel": "create-capture",  
           "method": "POST"  
        },  
        {  
           "href": "https://api.externalintegration.payex.com/psp/mobilepay/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/cancellations",  
           "rel": "create-cancellation",  
           "method": "POST"  
        },  
        {  
           "href": "https://api.externalintegration.payex.com/psp/mobilepay/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/reversals",  
           "rel": "create-reversal",  
           "method": "POST"  
        },  
    ]  
}
```

{:.code-header}
**Properties**

{:.table .table-striped}
| **Property** | **Description** |
| *href* | The target URI to perform the operation against. |
| *rel* | The name of the relation the operation has to the current resource. |
| *method* | The HTTP method to use when performing the operation. |

The operations should be performed as described in each response and not as described here in the documentation. Always use the href and method as specified in the response by finding the appropriate operation based on its rel value. The only thing that should be hard coded in the client is the value of the rel and the request that will be sent in the HTTP body of the request for the given operation.

{:.table .table-striped}
| **Operation** | **Description** |
| update-payment-abort | [Aborts][abort] the payment before any financial transactions are performed. |
| redirect-authorization | Used to redirect the consumer to PayEx payment pages and the authorization UI. |
| create-capture | Creates a [capture transaction](#Captures). |
| create-cancellation | Creates a [cancellation transaction](#Cancellations). |
| create-reversal | Creates a [reversal transaction](#Reversals). | 

### Vipps transactions

All card specific transactions are described below. Read more about the general transaction resource [here][general-transaction-resource].

#### Authorizations

The authorizations resource contains information about the authorization transactions made on a specific payment.

{:.code-header}
**Request**

```HTTP
GET /psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/authorizations HTTP/1.1  
Host: api.payex.com  
Authorization: Bearer <MerchantToken>  
Content-Type: application/json
```

{:.code-header}
**Response**

```HTTP
HTTP/1.1 200 OK  
Content-Type: application/json  
  
{  
   "payment": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d",  
   "authorizations": {  
       "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/authorizations",  
       "authorizationList": \[  
            {  
               "vippsTransactionId": "5619328800",  
               "msisdn": "+47xxxxxxxx",  
               "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/authorizations/3bfb8c66-33be-4871-465b-08d612f01a53",  
               "transaction": {  
                   "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/transactions/3bfb8c66-33be-4871-465b-08d612f01a53",  
                   "created": "2018-09-05T15:01:39.8658084Z",  
                   "updated": "2018-09-05T15:01:42.2119509Z",  
                   "type": "Authorization",  
                   "state": "Completed",  
                   "number": 72100003090,  
                   "amount": 1500,  
                   "vatAmount": 0,  
                   "description": "Vipps Test",  
                   "payeeReference": "Postman1536157124",  
                   "isOperational": false,  
                   "operations": \[\]  
                }  
            }  
        \]  
    }  
}
```

{:.table .table-striped}
| **Property** | **Data type** | **Description** |
| payment | string | The relative URI of the payment this authorization transactions resource belongs to. |
| authorizations.id | string | The relative URI of the current authorization transactions resource. |
| authorizations.authorizationList | array | The array of authorization transaction objects. |
| authorizations.authorizationList\[\] | object | The authorization transaction object described in the authorization resource below. The authorization resource contains information about an authorization transaction made on a specific payment. |

You can return a specific authorization transaction by adding the transaction id to the GET request.

{:.code-header}
**Request**

```HTTP
GET /psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/authorizations/<transactionId> HTTP/1.1  
Host: api.payex.com  
Authorization: Bearer <MerchantToken>  
Content-Type: application/json
```

{:.code-header}
**Response**

```HTTP
HTTP/1.1 200 OK  
Content-Type: application/json  
  
{  
   "payment": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d",  
   "authorization": {  
       "vippsTransactionId": "5619328800",  
       "msisdn": "+47xxxxxxxx",  
       "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/authorizations/3bfb8c66-33be-4871-465b-08d612f01a53",  
       "transaction": {  
           "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/transactions/3bfb8c66-33be-4871-465b-08d612f01a53",  
           "created": "2018-09-05T15:01:39.8658084Z",  
           "updated": "2018-09-05T15:01:42.2119509Z",  
           "type": "Authorization",  
           "state": "Completed",  
           "number": 72100003090,  
           "amount": 1500,  
           "vatAmount": 0,  
           "description": "Vipps Test",  
           "payeeReference": "Postman1536157124",  
           "isOperational": false,  
           "operations": \[\]  
        }  
    }  
}
```

{:.table .table-striped}
| **Property** | **Data type** | **Description** |
| payment | string | The relative URI of the payment this authorization transaction resource belongs to. |
| authorization.id | string | The relative URI of the current authorization transaction resource. |
| authorization.transaction | object | The object representation of the generic [transaction resource][transaction-resource]. |

### Captures

The captures resource lists the capture transactions (one or more) on a specific payment.

{:.code-header}
**Request**

```HTTP
GET /psp/vipps/vipps/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/captures HTTP/1.1  
Host: api.payex.com  
Authorization: Bearer <MerchantToken>  
Content-Type: application/json
```

{:.code-header}
**Response**

```HTTP
HTTP/1.1 200 OK  
Content-Type: application/json  
  
{  
   "payment": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d",  
   "captures": {  
       "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/captures",  
       "captureList": \[  
            {  
               "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/captures/643cafb6-8b69-4ad9-b2c8-08d612f03245",  
               "transaction": {  
                   "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/transactions/643cafb6-8b69-4ad9-b2c8-08d612f03245",  
                   "created": "2018-09-05T15:03:56.5180218Z",  
                   "updated": "2018-09-06T08:05:01.4179654Z",  
                   "type": "Capture",  
                   "state": "Completed",  
                   "number": 72100003092,  
                   "amount": 1500,  
                   "vatAmount": 250,  
                   "description": "description for transaction",  
                   "payeeReference": "cpt1536159837",  
                   "isOperational": false,  
                   "reconciliationNumber": 736941,  
                   "operations": \[\]  
                }  
            }  
        \]  
    }  
}
```

{:.table .table-striped}
| **Property** | **Data type** | **Description** |
| payment | string | The relative URI of the payment this list of capture transactions belong to. |
| captures.id | string | The relative URI of the current captures resource. |
| captures.captureList | array | The array of capture transaction objects. |
| captures.captureList\[\] | object | The capture transaction object described in the capture resource below. |

#### Create capture transaction

A capture transaction can be created after a completed authorization by performing the create-capture operation.

{:.code-header}
**Request**

```HTTP
POST /psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/captures HTTP/1.1  
Host: api.payex.com  
Authorization: Bearer <MerchantToken>  
Content-Type: application/json  
  
{  
   "transaction": {  
       "amount": 1500,  
       "vatAmount": 250,  
       "payeeReference": "cpttimestamp",  
       "description" : "description for transaction"  
    }  
}
```

{:.table .table-striped}
| **Property** | **Data type** | **Required** | **Description** |
| capture.amount | integer | ✔︎ | Amount Entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 NOK, 5000 = 50.00 NOK. |
| capture.vatAmount | integer | ✔︎ | Amount Entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 NOK, 5000 = 50.00 NOK. |
| capture.description | string | ✔︎ | A textual description of the capture transaction. |
| capture.payeeReference | string(50) | ✔︎ | A unique reference for the capture transaction. See [payeeReference][payeeReference] for details.

The capture resource contains information about the capture transaction made against a Vipps payment. You can return a specific capture transaction by adding the transaction id to the GET request.

{:.code-header}
**Response**

```HTTP
HTTP/1.1 200 OK  
Content-Type: application/json  
  
{  
   "payment": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d",  
   "capture": {  
       "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/captures/643cafb6-8b69-4ad9-b2c8-08d612f03245",  
       "transaction": {  
           "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/transactions/643cafb6-8b69-4ad9-b2c8-08d612f03245",  
           "created": "2018-09-05T15:03:56.5180218Z",  
           "updated": "2018-09-05T15:03:57.6300566Z",  
           "type": "Capture",  
           "state": "Completed",  
           "number": 72100003092,  
           "amount": 1500,  
           "vatAmount": 250,  
           "description": "description for transaction",  
           "payeeReference": "cpt1536159837",  
           "isOperational": false,  
           "operations": \[\]  
        }  
    }  
}  
```

{:.table .table-striped}
| **Property** | **Data type** | **Description** |
| payment | string | The relative URI of the payment this capture transaction belongs to. |
| capture.id | string | The relative URI of the created capture transaction. |
| capture.transaction |object | The object representation of the generic [transaction resource][transaction-resource]. |

### Cancellations

The cancellations resource lists the cancellation transactions on a specific payment.

{:.code-header}
**Request**

```HTTP
GET /psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/cancellations HTTP/1.1  
Host: api.payex.com  
Authorization: Bearer <MerchantToken>  
Content-Type: application/json
```

{:.code-header}
**Response**

```HTTP
HTTP/1.1 200 OK  
Content-Type: application/json  
  
{  
   "payment": "/psp/vipps/payments/754c378d-dd77-40cf-3811-08d613932ad6",  
   "cancellations": {  
       "id": "/psp/vipps/payments/754c378d-dd77-40cf-3811-08d613932ad6/cancellations",  
       "cancellationList": \[  
            {  
               "id": "/psp/vipps/payments/754c378d-dd77-40cf-3811-08d613932ad6/cancellations/808a2929-6673-4b40-32b6-08d6139342aa",  
               "transaction": {  
                   "id": "/psp/vipps/payments/754c378d-dd77-40cf-3811-08d613932ad6/transactions/808a2929-6673-4b40-32b6-08d6139342aa",  
                   "created": "2018-09-06T10:03:43.9615Z",  
                   "updated": "2018-09-06T10:03:45.9503625Z",  
                   "type": "Cancellation",  
                   "state": "Completed",  
                   "number": 72100003192,  
                   "amount": 2000,  
                   "vatAmount": 0,  
                   "description": "description for transaction",  
                   "payeeReference": "testabc",  
                   "isOperational": false,  
                   "operations": \[\]  
                }  
            }  
        \]  
    }  
}
```

{:.table .table-striped}
| **Property** | **Data type** | **Description** | 
| payment | string | The relative URI of the payment this list of cancellation transactions belong to. |
| cancellations.id | string | The relative URI of the current cancellations resource. |
| cancellations.cancellationList | array | The array of the cancellation transaction objects. |
| cancellations.cancellationList\[\] | object | The object representation of the cancellation transaction resource described below. |

#### Create cancellation transaction

Perform the create-cancel operation to cancel a previously created payment. You can only cancel a payment - or part of payment - not yet captured.

{:.code-header}
**Request**

```HTTP
POST /psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/cancellations HTTP/1.1  
Host: api.payex.com  
Authorization: Bearer <MerchantToken>  
Content-Type: application/json  
  
{  
   "transaction": {  
       "payeeReference": "testabc",  
       "description" : "description for transaction"  
    }  
}
```

{:.table .table-striped}
| **Property** | **Data type** | **Required** | **Description** |
| cancellation.description | string | ✔︎ | A textual description of the reason for the cancellation. |
| cancellation.payeeReference | string(50) | ✔︎ | A unique reference for the cancellation transaction. See [payeeReference][payeeReference] for details. |

The cancel resource contains information about a cancellation transaction made against a payment. You can return a specific cancellation transaction by adding the transaction id to the GET request.

{:.code-header}
**Response**

```HTTP
HTTP/1.1 200 OK  
Content-Type: application/json  
  
{  
   "payment": "/psp/vipps/payments/754c378d-dd77-40cf-3811-08d613932ad6",  
   "cancellation": {  
       "id": "/psp/vipps/payments/754c378d-dd77-40cf-3811-08d613932ad6/cancellations/808a2929-6673-4b40-32b6-08d6139342aa",  
       "transaction": {  
           "id": "/psp/vipps/payments/754c378d-dd77-40cf-3811-08d613932ad6/transactions/808a2929-6673-4b40-32b6-08d6139342aa",  
           "created": "2018-09-06T10:03:43.9615Z",  
           "updated": "2018-09-06T10:03:45.9503625Z",  
           "type": "Cancellation",  
           "state": "Completed",  
           "number": 72100003192,  
           "amount": 2000,  
           "vatAmount": 0,  
           "description": "description for transaction",  
           "payeeReference": "testabc",  
           "isOperational": false,  
           "operations": \[\]  
        }  
    }  
}
```

{:.table .table-striped}
| **Property** | **Data type** | **Description** |
| payment | string | The relative URI of the payment this cancellation transaction belongs to. |
| cancellation.id | string | The relative URI of the current cancellation transaction resource. | 
| cancellation.transaction | object | The object representation of the generic [transaction resource][transaction-resource] |

### Reversals

The reversals resource lists the reversal transactions (one or more) on a specific payment.

{:.code-header}
**Request**

```HTTP
GET /psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/reversals HTTP/1.1  
Host: api.payex.com  
Authorization: Bearer <MerchantToken>  
Content-Type: application/json
```

{:.code-header}
**Response**

```HTTP
HTTP/1.1 200 OK  
Content-Type: application/json  
  
{  
   "payment": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d",  
   "reversals": {  
       "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/reversals",  
       "reversalList": \[  
            {  
               "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/reversals/b3ac5f69-3d24-4c66-32b7-08d6139342aa",  
               "transaction": {  
                   "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/transactions/b3ac5f69-3d24-4c66-32b7-08d6139342aa",  
                   "created": "2018-09-06T10:12:54.738174Z",  
                   "updated": "2018-09-06T10:12:55.0671912Z",  
                   "type": "Reversal",  
                   "state": "Completed",  
                   "number": 72100003193,  
                   "amount": 1500,  
                   "vatAmount": 250,  
                   "description": "description for transaction",  
                   "payeeReference": "cpt1536228775",  
                   "isOperational": false,  
                   "operations": \[\]  
                }  
            }  
        \]  
    }  
}
```

{:.table .table-striped}
| **Property** | **Type** | **Description** |
| payment | string | The relative URI of the payment that the reversal transactions belong to. |
| reversalList | array | The array of reversal transaction objects. |
| reversalList\[\] | object | The reversal transaction object representation of the reversal transaction resource described below. |

#### Create reversal transaction

The create-reversal operation reverses a previously created and captured payment.

{:.code-header}
**Request**

```HTTP
POST /psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/reversals HTTP/1.1  
Host: api.payex.com  
Authorization: Bearer <MerchantToken>  
Content-Type: application/json  
  
{  
   "transaction": {  
       "amount": 1500,  
       "vatAmount": 250,  
       "payeeReference": "cpttimestamp",  
       "description" : "description for transaction"  
    }  
}
```

{:.table .table-striped}
| **Property** | **Data type** | **Required** | **Description** |
| transaction.amount | integer | ✔︎ | Amount Entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 NOK, 5000 = 50.00 NOK. |
| transaction.vatAmount | integer | ✔︎ | Amount Entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 NOK, 5000 = 50.00 NOK. |
| transaction.description | string | ✔︎ | A textual description of the capture |
| transaction.payeeReference | string(50) | ✔︎ | A unique reference for the reversal transaction. See [payeeReference][payeeReference]. |

The reversal resource contains information about a reversal transaction made against a payment. You can return a specific reversal transaction by adding the transaction id to the GET request.

{:.code-header}
**Response**

```HTTP
HTTP/1.1 200 OK  
Content-Type: application/json  
  
{  
   "payment": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d",  
   "reversal": {  
       "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/reversals/b3ac5f69-3d24-4c66-32b7-08d6139342aa",  
       "transaction": {  
           "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/transactions/b3ac5f69-3d24-4c66-32b7-08d6139342aa",  
           "created": "2018-09-06T10:12:54.738174Z",  
           "updated": "2018-09-06T10:12:55.0671912Z",  
           "type": "Reversal",  
           "state": "Completed",  
           "number": 72100003193,  
           "amount": 1500,  
           "vatAmount": 250,  
           "description": "description for transaction",  
           "payeeReference": "cpt1536228775",  
           "isOperational": false,  
           "operations": \[\]  
        }  
    }  
}
```

{:.table .table-striped}
| **Property** | **Data type** | **Description** |
| payment | string | The relative URI of the payment this capture transaction belongs to. |
| reversal.id | string |The relative URI of the created capture transaction. |
| reversal.transaction | object | The object representation of the generic [transaction resource][transaction-resource]. |

## Callback

When a change or update from the back-end system are made on a payment or transaction, PayEx will perform a callback to inform the payee (merchant) about this update. Callback functionality is explaned in more detail [here][callback].

[abort]: #
[callback]: #callback
[core-payments-resources]: #
[expand]: #
[general-information]: #
[general-transaction-resource]: #
[payeeReference]: #
[see-user-agent-definition]: https://en.wikipedia.org/wiki/User_agent
[transaction-resource]: #
