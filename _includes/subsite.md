## Subsite

### Payment Resource ###

The payment resource and all general sub-resources can be found in the [core payment resources][core-payment-resources] section.

### Create Payment ###

To create a Direct Debit payment, you perform an HTTP `POST` against the `/psp/directdebit/payments` resource. Please read the [general information][technical-reference] on how to compose a valid HTTP request before proceeding.

An example of a payment creation request is provided below. Each individual Property of the JSON document is described in the following section. Use the [expand][technical-reference-expansion] request parameter to get a response that includes one or more expanded sub-resources inlined.

{:.code-header}
**Request**

```HTTP
POST /psp/directdebit/payments HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Sale",
        "currency": "EUR",
        "prices": [
            {
                "type": "NordeaFi",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
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

{:.table .table-striped}
| **Property** | **Data type** | **Required** | **Description**
| payment.operation | string | ✔︎ | Purchase ##is the only type used for direct debit payments.
| payment.intent | string | ✔︎ | Sale ##is the only type used for direct debit payments 
| payment.currency |string | Y |The currency used.
| payment.prices.type | string | Y |(((Use the generic type `Directdebit` if you want to enable all bank types supported by merchant contract, otherwise specify a specific bank type. [See the Prices object types for more information][core-payment-resources-pPrices-objecttypes].)))
| payment.prices.amount | integer | ✔︎ | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` `100.00 SEK` `5000` `50.00 SEK`.
| payment.prices.vatAmount | integer | ✔︎ | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.
| payment.description | string(40) | ✔︎ | A textual description max 40 characters of the purchase.
| payment.payerReference | string | N | The reference to the payer (consumer/end-user) from the merchant system, like mobile number, customer number etc.
| payment.userAgent | string | Y |The user agent reference of the consumer's browser - [see user agent definition][user-agent]
| payment.language | string | ✔︎ | nb-NO, sv-SE or en-US.
| payment.urls.completeUrl | string | ✔︎ | The URI that PayEx will redirect back to when the payment is followed through.
| payment.urls.cancelUrl | string | ✔︎ | The URI that PayEx will redirect back to when the user presses the cancel button in the payment page.
| payment.urls.callbackUrl | string | N |The URI that PayEx will perform an HTTP POST against every time a transaction is created on the payment. See [callback][technical-reference-callback] for details.
| payment.urls.logoUrl | string | N | The URI that will be used for showing the customer logo. Must be a picture with at most 50px height and 400px width. Require https.
| payment.urls.termsOfServiceUrl | string | N | A URI that contains your terms and conditions for the payment, to be linked on the payment page. Require https.
| payeeInfo.payeeId | string | ✔︎ | This is the unique id that identifies this payee (like merchant) set by PayEx.
| payeeInfo.payeeReference | string(35) | Y |A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][technical-reference-payeereference] for details.
| payeeInfo.payeeName | string | N | The payee name (like merchant name) that will be displayed to consumer when redirected to PayEx.
| payeeInfo.productCategory | string | N | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.
| payeeInfo.orderReference | string(50) | N | The order reference should reflect the order reference found in the merchant's systems.
| payeeInfo.subsite | String(40) | N | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with PayEx reconciliation before being used.

{:.code-header}
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

### Operations

A payment resource has a set of operations that can be performed on it, from its creation to its end. The operations available at any given time vary between payment methods and depends on the current state of the payment resource. A list of possible operations for Direct Debit Payments and their explanation is given below.

{:.code-header}
**Operations**

```JS
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

{:.table .table-striped}
| **Property** | **Description**
| href |The target URI to perform the operation against.
| rel |The name of the relation the operation has to the current resource.
| method |The HTTP method to use when performing the operation.

The operations should be performed as described in each response and not as described here in the documentation. Always use the `href` and `method` as specified in the response by finding the appropriate operation based on its `rel` value. The only thing that should be hard coded in the client is the value of the `rel` and the request that will be sent in the HTTP body of the request for the given operation.

| **Operation** | **Description**
| update-payment-abort |[Aborts][technical-reference-abort] the payment before any financial transactions are performed.
| redirect-sale |Contains the redirect-URI that redirects the consumer to a PayEx hosted payments page prior to creating a sales transaction.

### Direct Debit transactions 

All Direct Debit specific transactions are described below. Read more about the general transaction resource [here][core-payment-resources-transactions].

#### Sales ####

The `Sales` resource lists the sales transactions (one or more) on a specific payment.

{:.code-header}
**Request**

```HTTP
GET /psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/sales HTTP/1.1
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

##### Create Sales transaction #####

The sales transaction This is managed either by by redirecting the end-user to the hosted payment pages.

#### Reversals ####

The `Reversals` resource list the reversals transactions (one or more) on a specific payment.

{:.code-header}
**Request**

```HTTP
GET /psp/directdebit/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals HTTP/1.1
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

{:.table .table-striped}
| **Property** | **Type** | **Description**
| payment | string | The relative URI of the payment that the reversal transactions belong to.
| reversalList | array | The array of reversal transaction objects.
| reversalList[] | object | The reversal transaction object representation of the reversal transaction resource described below.

##### Create Reversal transaction

You can create a reversal transaction against a completed sales transaction by adding that transaction's `payeeReference` in the request body.  A callback request will follow from PayEx. 


{:.code-header}
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
| Property| Data type| Required| Description
| transaction.amount | integer | ✔︎ | Amount Entered in the lowest momentary units of the selected currency. E.g. `10000` `100.00 SEK`, `5000` `50.00 SEK`.
| transaction.vatAmount | integer | ✔︎ | Amount Entered in the lowest momentary units of the selected currency. E.g. `10000` `100.00 SEK`, `5000` `50.00 SEK`.
| transaction.description | string | ✔︎ | A textual description of the capture
| transaction.payeeReference | string(35) | ✔︎ | A  reference that must match the  ##payeeReference## of the sales transaction you want to reverse. See [`payeeReference`][technical-reference-payeereference] for details.


{:.code-header}
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
            "operations": []
        }
    }
}
``` 


{:.table .table-striped}
| **Property** | **Data type** | **Description**
| payment | string |The relative URI of the payment this capture transaction belongs to.
| reversal.id | string |The relative URI of the created capture transaction.
| reversal.transaction | object |The object representation of the generic [transaction][core-payment-resources-transactions].

### Callback ###

When a change or update from the back-end system are made on a payment or transaction, PayEx will perform a callback to inform the payee (merchant) about this update. Callback functionality is explaned in more detail [here][technical-reference-callback].


```mermaid
sequenceDiagram
  activate Merchant
  activate PayEx
  PayEx->Merchant: POST <callbackUrl>
  note left of Merchant: Callback by PayEx
  Merchant-->PayEx: HTTP response
  deactivate PayEx
  deactivate Merchant

  Merchant->PayEx: GET Direct Debit payment
  note left of Merchant: First API request
  activate PayEx
  PayEx-->Merchant: payment resource
  deactivate PayEx
```

[core-payment-resources]: #
[core-payment-resources-transactions]: #
[technical-reference]: #
[technical-reference-expansion]: #
[technical-reference-callback]: #
[technical-reference-callbackurl]: #
[technical-reference-abort]: #
[technical-reference-payeereference]: #
[core-payment-resources]: #
[core-payment-resources-pPrices-objecttypes]: #
[user-agent]: https://en.wikipedia.org/wiki/User_agent

