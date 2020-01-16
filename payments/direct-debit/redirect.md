---
title: Swedbank Pay Payments Direct Debit Redirect
sidebar:
  navigation:
  - title: Direct Debit Payments
    items:
    - url: /payments/direct-debit
      title: Introduction
    - url: /payments/direct-debit/redirect
      title: Redirect
    - url: /payments/direct-debit/after-payment
      title: After Payment
    - url: /payments/direct-debit/other-features
      title: Other Features
---

{% include alert-development-section.md %}

### Create Payment

To create a Direct Debit payment, you perform an HTTP `POST` against the
`/psp/directdebit/payments` resource.

An example of a payment creation request is provided below.
Each individual Property of the JSON document is described in the
following section.
Use the [expand][technical-reference-expansion] request parameter to get a
response that includes one or more expanded sub-resources inlined.

```http
Request
POST /psp/directdebit/payments HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
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
           "completeUrl": "https://example.com/payment-completed",
           "cancelUrl": "https://example.com/payment-canceled",
           "callbackUrl": "https://example.com/payment-callback",
           "logoUrl": "https://example.com/logo.png",
           "termsOfServiceUrl": "https://example.com/terms.pdf"
        },
       "payeeInfo": {
           "payeeId": "{{ page.merchantId }}",
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
| Required | Property                     | Type         | Description                                                                                                                                                                                                                                               |
| :------: | :--------------------------- | :----------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `payment`                    | `object`     | The `payment` object contains information about the specific payment.                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └➔&nbsp;`operation`          | `string`     | Purchase is the only type used for direct debit payments.                                                                                                                                                                                                 |
|  ✔︎︎︎︎︎  | └➔&nbsp;`intent`             | `string`     | Sale is the only type used for direct debit payments.                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └➔&nbsp;`currency`           | `string`     | The currency used.                                                                                                                                                                                                                                        |
|  ✔︎︎︎︎︎  | └➔&nbsp;`prices`             | `object`     | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`type`              | `string`     | Use the generic type `Directdebit` if you want to enable all bank types supported by merchant contract, otherwise specify a specific bank type. [See the Prices object types for more information.][technical-reference-price-object].                      |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`amount`            | `integer`    | Amount is entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 SEK 5000 = 50.00 SEK.                                                                                                                                       |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`vatAmount`         | `integer`    | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                                                                        |
|  ✔︎︎︎︎   | └➔&nbsp;`description`        | `string(40)` | A textual description max 40 characters of the purchase.                                                                                                                                                                                                  |
|          | └➔&nbsp;`payerReference`     | `string`     | The reference to the payer (consumer/end-user) from the merchant system, like mobile number, customer number etc.                                                                                                                                         |
|  ✔︎︎︎︎   | └➔&nbsp;`userAgent`          | `string`     | The user agent reference of the consumer's browser - [see user agent definition][user-agent].                                                                                                                                                             |
|  ✔︎︎︎︎   | └➔&nbsp;`language`           | `string`     | `nb-NO`, `sv-SE` or `en-US`.                                                                                                                                                                                                                                    |
|  ✔︎︎︎︎︎  | └➔&nbsp;`urls`               | `object`     | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                    |
|  ✔︎︎︎︎   | └─➔&nbsp;`completeUrl`       | `string`     | The URI that Swedbank Pay will redirect back to when the payment is followed through. This does not indicate a successful payment, only that it has reached a completion state. A`GET`request needs to be performed on the payment to inspect it further. |
|  ✔︎︎︎︎   | └─➔&nbsp;`cancelUrl`         | `string`     | The URI that Swedbank Pay will redirect back to when the user presses the cancel button in the payment page.                                                                                                                                              |
|          | └─➔&nbsp;`callbackUrl`       | `string`     | The URI that Swedbank Pay will perform an HTTP POST against every time a transaction is created on the payment. See [callback][technical-reference-callbackurl] for details.                                                                              |
|          | └─➔&nbsp;`logoUrl`           | `string`     | The URI that will be used for showing the customer logo. Must be a picture with at most 50px height and 400px width. Require https.                                                                                                                       |
|          | └─➔&nbsp;`termsOfServiceUrl` | `string`     | A URI that contains your terms and conditions for the payment, to be linked on the payment page. Require https.                                                                                                                                           |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeenfo`           | `object`     | The `payeeInfo` contains information about the payee.                                                                                                                                                                                                     |
|  ✔︎︎︎︎   | └─➔&nbsp;`payeeId`           | `string`     | This is the unique id that identifies this payee (like merchant) set by PayEx.                                                                                                                                                                            |
|  ✔︎︎︎︎   | └─➔&nbsp;`payeeReference`    | `string(35)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][technical-reference-payeereference] for details.                                               |
|          | └─➔&nbsp;`payeeName`         | `string`     | The payee name (like merchant name) that will be displayed to consumer when redirected to PayEx.                                                                                                                                                          |
|          | └─➔&nbsp;`productCategory`   | `string`     | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                   |
|          | └─➔&nbsp;`orderReference`    | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                   |
|          | └─➔&nbsp;`subsite`           | `String(40)` | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                               |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
   "payment": {
       "id": "/psp/directdebit/payments/{{ page.paymentId }}",
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
       "prices": { "id": "/psp/directdebit/payments/{{ page.paymentId }}/prices" },
       "transactions": { "id": "/psp/directdebit/payments/{{ page.paymentId }}/transactions" },
       "sales": { "id": "/psp/directdebit/payments/{{ page.paymentId }}/sales" },
       "reversals": { "id": "/psp/directdebit/payments/{{ page.paymentId }}/reversals" },
       "payeeInfo" : { "id": "/psp/directdebit/payments/{{ page.paymentId }}/payeeInfo" },
       "urls" : { "id": "/psp/directdebit/payments/{{ page.paymentId }}/urls" },
       "settings": { "id": "/psp/directdebit/payments/{{ page.paymentId }}/settings" }
  },
   "operations": [
        {
           "href": "{{ page.apiUrl }}/psp/directdebit/payments/<paymentId>/sales",
           "rel": "redirect-sale",
           "method": "POST"
        },
        {
           "href": "http://{{ page.apiHost }}/psp/directdebit/payments/<paymentId>",
           "rel": "update-payment-abort",
           "method": "PATCH"
        }
    ]
}
```

## Operations

A payment resource has a set of operations that can be performed on it,
from its creation to its end.
The operations available at any given time vary between payment instruments and
depends on the current state of the payment resource.
A list of possible operations for Direct Debit Payments and their explanation
is given below.

{:.code-header}
**Operations**

```js
{
   "operations": [
        {
           "method": "PATCH",
           "href": "{{ page.apiUrl }}/psp/directdebit/payments/{{ page.transactionId }}",
           "rel": "update-payment-abort"
        },
        {
           "method": "GET",
           "href": "{{ page.frontEndUrl }}/directdebit/payments/sales/{{ page.paymentToken }}",
           "rel": "redirect-sale"
        }
    ]
}
```

{:.table .table-striped}
| Property | Description                                                         |
| :------- | :------------------------------------------------------------------ |
| `href`   | The target URI to perform the operation against.                    |
| `rel`    | The name of the relation the operation has to the current resource. |
| `method` | The HTTP method to use when performing the operation.               |

The operations should be performed as described in each response and not as
described here in the documentation. Always use the `href` and `method` as
specified in the response by finding the appropriate operation based on its
`rel` value. The only thing that should be hard coded in the client is the value
of the `rel` and the request that will be sent in the HTTP body of the request
for the given operation.

| Operation              | Description                                                                                                                        |
| :--------------------- | :--------------------------------------------------------------------------------------------------------------------------------- |
| `update-payment-abort` | [Aborts][technical-reference-abort-payment] the payment before any financial transactions are performed.                           |
| `redirect-sale`        | Contains the redirect-URI that redirects the consumer to a Swedbank Pay hosted payment page prior to creating a sales transaction. |

## Direct Debit transactions

All Direct Debit specific transactions are described below.

### Sales

The `Sales` resource lists the sales transactions (one or more) on a
specific payment.

{:.code-header}
**Request**

```http
GET /psp/directdebit/payments/{{ page.paymentId }}/sales HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
   "payment": "/psp/directdebit/payments/{{ page.paymentId }}",
   "sales": {
       "id": "/psp/directdebit/payments/{{ page.paymentId }}/sales",
       "salesList": [
            {
               "id": "/psp/directdebit/payments/{{ page.paymentId }}/sales/{{ page.transactionId }}",
               "selectedBank": "NordeaFI",
               "deviceIsMobile": true,
               "transaction": {
                   "id": "/psp/directdebit/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
                   "created": "2018-09-14T01:01:01.01Z",
                   "updated": "2018-09-14T01:01:01.03Z",
                   "type": "Sale",
                   "state": "Initialized",
                   "number": 1234567890,
                   "amount": 1000,
                   "vatAmount": 250,
                   "description": "Test transaction",
                   "payeeReference": "AH123456",
                   "failedReason": "",
                   "failedActivityName": "",
                   "failedErrorCode": "",
                   "failedErrorDescription": "",
                   "isOperational": true,
                   "operations": [
                    ]
                }
            },
            {
               "id": "/psp/directdebit/payments/{{ page.paymentId }}/sales/{{ page.transactionId }}",
               "selectedBank": "NordeaFI",
               "deviceIsMobile": true,
               "transaction": {
                   "id": "/psp/directdebit/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
                   "created": "2018-09-14T01:01:01.01Z",
                   "updated": "2018-09-14T01:01:01.03Z",
                   "type": "Sale",
                   "state": "Initialized",
                   "number": 1234567890,
                   "amount": 1000,
                   "vatAmount": 250,
                   "description": "Test transaction",
                   "payeeReference": "AH123456",
                   "failedReason": "",
                   "failedActivityName": "",
                   "failedErrorCode": "",
                   "failedErrorDescription": "",
                   "isOperational": false,
                   "operations": [
                        {
                           "href": "{{ page.apiUrl }}/psp/directdebit/payments/{{ page.paymentId }}",
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

The sales transaction This is managed either by by redirecting the end-user
to the hosted payment page.

### Reversals

The `Reversals` resource list the reversals transactions (one or more) on a
specific payment.

{:.code-header}
**Request**

```http
GET /psp/directdebit/payments/{{ page.paymentId }}/reversals HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
   "payment": "/psp/directdebit/payments/{{ page.paymentId }}",
   "reversals": {
       "id": "/psp/directdebit/payments/{{ page.paymentId }}/reversals",
       "reversalList": [
            {
               "id": "/psp/directdebit/payments/{{ page.paymentId }}/reversals/{{ page.transactionId }}",
               "transaction": {
                   "id": "/psp/directdebit/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
                   "created": "2016-09-14T01:01:01.01Z",
                   "updated": "2016-09-14T01:01:01.03Z",
                   "type": "Reversal",
                   "state": "Completed",
                   "number": 1234567890,
                   "amount": 1000,
                   "vatAmount": 250,
                   "description": "Test transaction",
                   "payeeReference": "AH123456",
                   "isOperational": true,
                   "operations": []
                }
            }
        ]
    }
}
```

{:.table .table-striped}
| Property         | Type     | Description                                                                                          |
| :--------------- | :------- | :--------------------------------------------------------------------------------------------------- |
| `payment`        | `string` | The relative URI of the payment that the reversal transactions belong to.                            |
| `reversalList`   | `array`  | The array of reversal transaction objects.                                                           |
| `reversalList[]` | `object` | The reversal transaction object representation of the reversal transaction resource described below. |

#### Create Reversal transaction

You can create a reversal transaction against a completed sales transaction
by adding that transaction's payeeReference in the request body.
A callback request will follow from PayEx.

{:.code-header}
**Request**

```http
POST /psp/directdebit/payments/{{ page.paymentId }}/reversals HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
   "transaction": {
       "amount": 1500,
       "vatAmount": 0,
       "description": "Test Reversal",
       "payeeReference": "ABC123"
    }
}
```

{:.table .table-striped}
| Required | Property                 | Type         | Description                                                                                                                                                          |
| :------: | :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `transaction`            | `object`     | The transaction object.                                                                                                                                              |
|  ✔︎︎︎︎︎  | └➔&nbsp;`amount`         | `integer`    | Amount entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 SEK`, `5000` = `50.00 SEK`.                                            |
|  ✔︎︎︎︎︎  | └➔&nbsp;`vatAmount`      | `integer`    | Amount entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 SEK`, `5000` = `50.00 SEK`.                                            |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`    | `string`     | A textual description of the capture.                                                                                                                                |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeReference` | `string(35)` | A  reference that must match the  payeeReference of the sales transaction you want to reverse. See [payeeReference][technical-reference-payeereference] for details. |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
   "payment": "/psp/directdebit/payments/{{ page.paymentId }}",
   "reversal": {
       "id": "/psp/directdebit/payments/{{ page.paymentId }}/reversals/{{ page.transactionId }}",
       "transaction": {
           "id": "/psp/directdebit/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
           "created": "2016-09-14T01:01:01.01Z",
           "updated": "2016-09-14T01:01:01.03Z",
           "type": "Reversal",
           "state": "Completed",
           "number": 1234567890,
           "amount": 1000,
           "vatAmount": 250,
           "description": "Test transaction",
           "payeeReference": "AH123456",
           "isOperational": true,
           "operations": []
        }
    }
}
```

{:.table .table-striped}
| Property              | Type     | Description                                                                                                       |
| :-------------------- | :------- | :---------------------------------------------------------------------------------------------------------------- |
| `payment`             | `string` | The relative URI of the payment this capture transaction belongs to.                                              |
| `reversal`            | `object` | The `reversal`resource contains information about the `reversal` transaction made against a direct debit payment. |
| └➔&nbsp;`id`          | `string` | The relative URI of the created capture transaction.                                                              |
| └➔&nbsp;`transaction` | `object` | The object representation of the generic [transaction resource][technical-reference-transactions].                |

## Callback

When a change or update from the back-end system are made on a payment or
transaction, Swedbank Pay will perform a callback to inform the payee
(merchant) about this update.

```mermaid
sequenceDiagram
  Activate Merchant
  Activate PAYEX
  PAYEX-->>Merchant: POST <callbackUrl>
  note left of Merchant: Callback by PayEx
  Merchant-->>PAYEX: HTTP response
  Deactivate PAYEX
  Deactivate Merchant

  Activate Merchant
  Merchant->>PAYEX: GET <Direct Debit payment>
  note left of Merchant: First API request
  Activate PAYEX
  PAYEX-->>Merchant: payment resource
  Deactivate PAYEX
  Deactivate Merchant
```

{% include iterator.html next_href="after-payment"
                         next_title="Next: After Payment"
                         prev_href="index"
                         prev_title="Back: Introduction" %}

[technical-reference-abort-payment]: /payments/direct-debit/other-features#abort-payment
[technical-reference-callbackurl]: /payments/direct-debit/other-features#callback
[technical-reference-expansion]: /payments/direct-debit/other-features#expansion
[technical-reference-payeereference]: /payments/direct-debit/other-features#payeereference
[technical-reference-price-object]: /payments/direct-debit/other-features#prices-object-types
[technical-reference-transactions]: /payments/direct-debit/other-features#transactions
[user-agent]: https://en.wikipedia.org/wiki/User_agent
