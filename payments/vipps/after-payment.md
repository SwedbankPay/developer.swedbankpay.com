---
title: Swedbank Pay Payments Vipps After Payment
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
      title: After Payment
    - url: /payments/vipps/other-features
      title: Other Features
---

{% include alert-review-section.md %}

## Payment Resource

This section describes the general sub-resources of the API that are used to
generate payment requests.

### Create Payment

To create a Vipps payment, you perform an HTTP `POST` against the
`/psp/vipps/payments` resource.

An example of a payment creation request is provided below.
Each individual property of the JSON document is described in the following
section.
Use the [expand][technical-reference-expansion] request parameter to get a
response that includes one or more expanded sub-resources inlined.

{:.code-header}
**Request**

```http
POST /psp/vipps/payments HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "NOK",
        "prices": [
            {
                "type": "Vipps",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Vipps Test",
        "payerReference": "ABtimestamp",
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "urls": {
            "hostUrls": ["https://example.com", "https://example.net"],
            "completeUrl": "http://example.com/payment-completed",
            "cancelUrl": "http://example.com/payment-canceled",
            "paymentUrl": "http://example.com/perform-payment",
            "callbackUrl": "{{ page.apiUrl }}/psp/payment-callback",
            "logoUrl": "https://example.com/path/to/logo.png",
            "termsOfServiceUrl": "https://example.com/terms.pdf"

        },
        "payeeInfo": {
            "payeeId": "{{ page.merchantId }}"
            "payeeReference": "Postmantimestamp",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite"
            },
        "prefillInfo": {
         "msisdn": "+4793000001"
        }
    }
}
```

{:.table .table-striped}
| Required | Property                     | Type         | Description                                                                                                                                                                                                                                               |
| :------: | :--------------------------- | :----------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|    ✔︎    | `payment`                    | `object`     | The `payment` object.                                                                                                                                                                                                                                     |
|    ✔︎    | └➔&nbsp;`operation`          | `string`     | `Purchase`                                                                                                                                                                                                                                                |
|    ✔︎    | └➔&nbsp;`intent`             | `string`     | `Authorization`                                                                                                                                                                                                                                           |
|    ✔︎    | └➔&nbsp;`currency`           | `string`     | NOK                                                                                                                                                                                                                                                       |
|    ✔︎    | └➔&nbsp;`prices`             | `object`     | The [`prices`][prices] object.                                                                                                                                                                                                                            |
|    ✔︎    | └─➔&nbsp;`type`              | `string`     | `vipps`                                                                                                                                                                                                                                                   |
|    ✔︎    | └─➔&nbsp;`amount`            | `integer`    | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 NOK`, `5000` = `50.00 NOK`.                                                                                                                              |
|    ✔︎    | └─➔&nbsp;`vatAmount`         | `integer`    | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                                                                        |
|    ✔︎    | └➔&nbsp;`description`        | `string(40)` | A textual description max 40 characters of the purchase.                                                                                                                                                                                                  |
|          | └➔&nbsp;`payerReference`     | `string`     | The reference to the payer (consumer/end-user) from the merchant system, like mobile number, customer number etc.                                                                                                                                         |
|    ✔︎    | └➔&nbsp;`userAgent`          | `string`     | The user agent reference of the consumer's browser - [see user agent][user-agent]]                                                                                                                                                                        |
|    ✔︎    | └➔&nbsp;`language`           | `string`     | `nb-NO`, `sv-SE` or `en-US`.                                                                                                                                                                                                                              |
|    ✔︎    | └➔&nbsp;`urls`               | `object`     | The object containing URLs relevant for the `payment`.                                                                                                                                                                                                    |
|    ✔︎    | └─➔&nbsp;`hostUrls`          | `array`      | The array of URIs valid for embedding of Swedbank Pay Hosted Views.                                                                                                                                                                                       |
|    ✔︎    | └─➔&nbsp;`completeUrl`       | `string`     | The URI that Swedbank Pay will redirect back to when the payment page is completed. This does not indicate a successful payment, only that it has reached a completion state. A `GET` request needs to be performed on the payment to inspect it further. |
|          | └─➔&nbsp;`cancelUrl`         | `string`     | The URI to redirect the payer to if the payment is canceled, either by the payer or by the merchant trough an `abort` request of the `payment`.                                                                                                           |
|          | └─➔&nbsp;`paymentUrl`        | `string`     | The URI that Swedbank Pay will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the `payment`.                                                                                                      |
|          | └─➔&nbsp;`callbackUrl`       | `string`     | The URI that Swedbank Pay will perform an HTTP `POST` request against every time a transaction is created on the payment. See [callback][callbackreference] for details.                                                                                  |
|          | └─➔&nbsp;`logoUrl`           | `string`     | The URI that will be used for showing the customer logo. Must be a picture with at most 50px height and 400px width. Require https.                                                                                                                       |
|          | └─➔&nbsp;`termsOfServiceUrl` | `string`     | A URI that contains your terms and conditions for the payment, to be linked on the payment page. Require https.                                                                                                                                           |
|    ✔︎    | └➔&nbsp;`payeeInfo`          | `object`     | The object containing information about the payee.                                                                                                                                                                                                        |
|    ✔︎    | └─➔&nbsp;`payeeId`           | `string`     | This is the unique id that identifies this payee (like merchant) set by PayEx.                                                                                                                                                                            |
|    ✔︎    | └─➔&nbsp;`payeeReference`    | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][technical-reference-payeeReference] for details.                                               |
|          | └─➔&nbsp;`payeeName`         | `string`     | The payee name (like merchant name) that will be displayed to consumer when redirected to PayEx.                                                                                                                                                          |
|          | └─➔&nbsp;`productCategory`   | `strin`      | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                   |
|          | └─➔&nbsp;`orderReference`    | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                   |
|          | └─➔&nbsp;`prefillInfo`       | `string`     | The mobile number that will be pre-filled in the Swedbank Pay Payments. The consumer may change this number in the UI.                                                                                                                                    |
|          | └─➔&nbsp;`subsite`           | `string(40)` | The `subsite` field can be used to perform split settlement on the payment. The `subsites` must be resolved with Swedbank Pay reconciliation before being used.                                                                                           |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/vipps/payments/{{ page.paymentId }}",
        "number": 72100003079,
        "created": "2018-09-05T14:18:44.4259255Z",
        "instrument": "Vipps",
        "operation": "Purchase",
        "intent": "Authorization",
        "state": "Ready",
        "currency": "NOK",
        "prices": {
            "id": "/psp/vipps/payments/{{ page.paymentId }}/prices"
        },
        "amount": 0,
        "description": "Vipps Test",
        "payerReference": "AB1536157124",
        "initiatingSystemUserAgent": "PostmanRuntime/7.2.0",
        "userAgent": "Mozilla/5.0 weeeeee",
        "language": "nb-NO",
        "urls": {
            "id": "/psp/vipps/payments/{{ page.paymentId }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/vipps/payments/{{ page.paymentId }}/payeeinfo"
        },
        "metadata": {
            "id": "/psp/vipps/payments/{{ page.paymentId }}/metadata"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.apiUrl }}/psp/vipps/payments/{{ page.paymentId }}",
            "rel": "update-payment-abort"
        },
        {
            "method": "GET",
            "href": "{{ page.frontEndUrl }}/vipps/payments/authorize/afccf3d0016340620756d5ff3e08f69b555fbe2e45ca71f4bd159ebdb0f00065",
            "rel": "redirect-authorization"
        }
    ]
}
```

### Purchase

Posting a payment (operation `Purchase`) returns the options of aborting the
payment altogether or creating an authorization transaction through the
`redirect-authorization` hyperlink.

{:.code-header}
**Request**

```js
{
    "payment": {
        "operation": "Purchase"
    }
}
```

## Operations

When a payment resource is created and during its lifetime,
it will have a set of operations that can be performed on it.
Which operations are available will vary depending on the state of the
payment resource, what the access token is authorized to do, etc.

{:.table .table-striped}
| Property | Description                                                         |
| :------- | :------------------------------------------------------------------ |
| `href`   | The target URI to perform the operation against.                    |
| `rel`    | The name of the relation the operation has to the current resource. |
| `method` | The HTTP method to use when performing the operation.               |

The operations should be performed as described in each response and not as
described here in the documentation.
Always use the `href` and `method` as specified in the response by finding
the appropriate operation based on its `rel` value.
The only thing that should be hard coded in the client is the value of the
`rel` and the request that will be sent in the HTTP body of the request for
the given operation.

{:.table .table-striped}
| Operation                | Description                                                                      |
| :----------------------- | :------------------------------------------------------------------------------- |
| `update-payment-abort`   | [Aborts][abort] the payment before any financial transactions are performed.     |
| `redirect-authorization` | Used to redirect the consumer to Swedbank Pay Payments and the authorization UI. |
| `create-capture`         | Creates a [`capture`][capture] transaction.                                      |
| `create-cancellation`    | Creates a [`cancellation`][cancel] transaction.                                  |
| `create-reversal`        | Creates a [`reversal`][reverse] transaction.                                     |

## Vipps transactions

All Vipps after payment transactions are described below.

## Authorizations

The `authorizations` resource contains information about the authorization
transactions made on a specific payment.

{:.code-header}
**Request**

```http
GET /psp/vipps/payments/{{ page.paymentId }}/authorizations HTTP/1.1
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
    "payment": "/psp/vipps/payments/{{ page.paymentId }}",
    "authorizations": {
        "id": "/psp/vipps/payments/{{ page.paymentId }}/authorizations",
        "authorizationList": [
            {
                "vippsTransactionId": "5619328800",
                "msisdn": "+4798765432",
                "id": "/psp/vipps/payments/{{ page.paymentId }}/authorizations/{{ page.transactionId }}",
                "transaction": {
                    "id": "/psp/vipps/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
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
                    "operations": []
                }
            }
        ]
    }
}
```

{:.table .table-striped}
| Property                      | Type     | Description                                                                                                                                                                                            |
| :---------------------------- | :------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                     | `string` | The relative URI of the payment this authorization transactions resource belongs to.                                                                                                                   |
| `authorizations`              | `object` | The authorizations object giving access to authorization information pertaining to this transaction.                                                                                                   |
| └➔&nbsp;`id`                  | `string` | The relative URI of the current authorization transactions resource.                                                                                                                                   |
| └➔&nbsp;`authorizationList`   | `array`  | The array of authorization transaction objects.                                                                                                                                                        |
| └➔&nbsp;`authorizationList[]` | `object` | The authorization transaction object described in the `authorization` resource below. The `authorization` resource contains information about an authorization transaction made on a specific payment. |

You can return a specific authorization transaction by adding the transaction id
to the `GET` request.

{:.code-header}
**Request**

```http
GET /psp/vipps/payments/{{ page.paymentId }}/authorizations/<transactionId> HTTP/1.1
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
    "payment": "/psp/vipps/payments/{{ page.paymentId }}",
    "authorization": {
        "vippsTransactionId": "5619328800",
        "msisdn": "+4798765432",
        "id": "/psp/vipps/payments/{{ page.paymentId }}/authorizations/{{ page.transactionId }}",
        "transaction": {
            "id": "/psp/vipps/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
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
            "operations": []
        }
    }
}
```

{:.table .table-striped}
| Property               | Type     | Description                                                                         |
| :--------------------- | :------- | :---------------------------------------------------------------------------------- |
| `payment`              | `string` | The relative URI of the payment this authorization transaction resource belongs to. |
| `authorization`        | `string` | The authorization object.                                                           |
| └➔&nbsp;`id`           | `string` | The relative URI of the current authorization transaction resource.                 |
| └➔&nbsp; `transaction` | `object` | The object representation of the generic [transaction][transaction].                |

## Captures

The `captures` resource lists the capture transactions (one or more) on a specific payment.

{:.code-header}
**Request**

```HTThP
GET /psp/vipps/vipps/{{ page.paymentId }}/captures HTTP/1.1
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
    "payment": "/psp/vipps/payments/{{ page.paymentId }}",
    "captures": {
        "id": "/psp/vipps/payments/{{ page.paymentId }}/captures",
        "captureList": [
            {
                "id": "/psp/vipps/payments/{{ page.paymentId }}/captures/{{ page.transactionId }}",
                "transaction": {
                    "id": "/psp/vipps/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
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
                    "operations": []
                }
            }
        ]
    }
}
```

{:.table .table-striped}
| Property                | Type     | Description                                                                  |
| :---------------------- | :------- | :--------------------------------------------------------------------------- |
| `payment`               | `string` | The relative URI of the payment this list of capture transactions belong to. |
| `captures`              | `object` | The `captures` list resource.                                                |
| └➔&nbsp;`id`            | `string` | The relative URI of the current `captures` resource.                         |
| └➔&nbsp;`captureList`   | `array`  | The array of capture transaction objects.                                    |
| └➔&nbsp;`captureList[]` | `object` | The capture transaction object described in the `capture` resource below.    |

## Create capture transaction

A `capture` transaction can be created after a completed authorization by
finding the `rel` `create-capture`.

{:.code-header}
**Request**

```http
POST /psp/vipps/payments/{{ page.paymentId }}/captures HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
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
| Required | Property                 | Type         | Description                                                                                                               |
| :------: | :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------ |
|    ✔︎    | `transaction`            | `integer`    | The transaction object containing a Vipps transaction description.                                                        |
|    ✔︎    | └➔&nbsp;`amount`         | `integer`    | Amount Entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 NOK`, `5000` = `50.00 NOK`. |
|    ✔︎    | └➔&nbsp;`vatAmount`      | `integer`    | Amount Entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 NOK`, `5000` = `50.00 NOK`. |
|    ✔︎    | └➔&nbsp;`description`    | `string`     | A textual description of the capture transaction.                                                                         |
|    ✔︎    | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the capture transaction. See [`payeeReference`][payeeReference] for details.                       |

The `capture` resource contains information about the capture transaction made
against a Vipps payment.
You can return a specific capture transaction by adding the transaction id to
the `GET` request.

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/vipps/payments/{{ page.paymentId }}",
    "capture": {
        "id": "/psp/vipps/payments/{{ page.paymentId }}/captures/{{ page.transactionId }}",
        "transaction": {
            "id": "/psp/vipps/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
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
            "operations": []
        }
    }
}
```

{:.table .table-striped}
| Property              | Type     | Description                                                            |
| :-------------------- | :------- | :--------------------------------------------------------------------- |
| `payment`             | `string` | The relative URI of the payment this capture transaction belongs to.   |
| `capture`             | `string` | The capture object, containing a transaction object.                   |
| └➔&nbsp;`id`          | `string` | The relative URI of the created capture transaction.                   |
| └➔&nbsp;`transaction` | `object` | The object representation of the generic [`transaction`][transaction]. |

## Cancellations

The `cancellations` resource lists the cancellation transactions on a
specific payment.

{:.code-header}
**Request**

```http
GET /psp/vipps/payments/{{ page.paymentId }}/cancellations HTTP/1.1
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
    "payment": "/psp/vipps/payments/{{ page.paymentId }}",
    "cancellations": {
        "id": "/psp/vipps/payments/{{ page.paymentId }}/cancellations",
        "cancellationList": [
            {
                "id": "/psp/vipps/payments/{{ page.paymentId }}/cancellations/{{ page.transactionId }}",
                "transaction": {
                    "id": "/psp/vipps/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
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
                    "operations": []
                }
            }
        ]
    }
}
```

{:.table .table-striped}
| Property                     | Type     | Description                                                                         |
| :--------------------------- | :------- | :---------------------------------------------------------------------------------- |
| `payment`                    | `string` | The relative URI of the payment this list of cancellation transactions belong to.   |
| `cancellations`              | `object` | The `cancellations` object.                                                         |
| └➔&nbsp;`id`                 | `string` | The relative URI of the current `cancellations` resource.                           |
| └➔&nbsp;`cancellationList`   | `array`  | The array of the cancellation transaction objects.                                  |
| └➔&nbsp;`cancellationList[]` | `object` | The object representation of the cancellation transaction resource described below. |

## Create cancellation transaction

A payment may be cancelled if the `rel` `create-cancellation` is available.
You can only cancel a payment, or part of it, if it has yet to be captured.
To revert a capture, or part of a capture, you must perform a `reversal`.
Performing a cancellation will cancel all remaning capture amounts on a payment.

{:.code-header}
**Request**

```http
POST /psp/vipps/payments/{{ page.paymentId }}/cancellations HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "payeeReference": "testabc",
        "description" : "description for transaction"
    }
}
```

{:.table .table-striped}
| Required | Property                 | Type         | Description                                                                                              |
| :------: | :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `transaction`            | `object`     | The transaction object describing the cancellation request.                                              |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`    | `string`     | A textual description of the reason for the cancellation.                                                |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the cancellation transaction. See [`payeeReference`][payeeReference] for details. |

The `cancel` resource contains information about a cancellation transaction made
against a payment.
You can return a specific cancellation transaction by adding the transaction id
to the `GET` request.

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json
{
    "payment": "/psp/vipps/payments/{{ page.paymentId }}",
    "cancellation": {
        "id": "/psp/vipps/payments/{{ page.paymentId }}/cancellations/{{ page.transactionId }}",
        "transaction": {
            "id": "/psp/vipps/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
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
            "operations": []
        }
    }
}
```

{:.table .table-striped}
| Property              | Type     | Description                                                               |
| :-------------------- | :------- | :------------------------------------------------------------------------ |
| `payment`             | `string` | The relative URI of the payment this cancellation transaction belongs to. |
| `cancellation`        | `object` | The cancellation resource.                                                |
| └➔&nbsp;`id`          | `string` | The relative URI of the current cancellation transaction resource.        |
| └➔&nbsp;`transaction` | `object` | The object representation of the generic [transaction][transaction].      |

## Reversals

The `reversals` resource lists the reversal transactions (one or more)
on a specific payment.

{:.code-header}
**Request**

```http
GET /psp/vipps/payments/{{ page.paymentId }}/reversals HTTP/1.1
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
    "payment": "/psp/vipps/payments/{{ page.paymentId }}",
    "reversals": {
        "id": "/psp/vipps/payments/{{ page.paymentId }}/reversals",
        "reversalList": [
            {
                "id": "/psp/vipps/payments/{{ page.paymentId }}/reversals/{{ page.transactionId }}",
                "transaction": {
                    "id": "/psp/vipps/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
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
                    "operations": []
                }
            }
        ]
    }
}
```

{:.table .table-striped}
| Property                 | Type     | Description                                                                                          |
| :----------------------- | :------- | :--------------------------------------------------------------------------------------------------- |
| `payment`                | `string` | The relative URI of the payment that the reversal transactions belong to.                            |
| `reversals`              | `object` | The reversal object.                                                                                 |
| └➔&nbsp;`reversalList`   | `array`  | The array of reversal transaction objects.                                                           |
| └➔&nbsp;`reversalList[]` | `object` | The reversal transaction object representation of the reversal transaction resource described below. |

### Create reversal transaction

A `reversal` transaction can be created if the `rel` `create-reversal` is
available.

{:.code-header}
**Request**

```http
POST /psp/vipps/payments/{{ page.paymentId }}/reversals HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
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
| Required | Property                 | Type         | Description                                                                                                               |
| :------: | :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------ |
|  ✔︎︎︎︎︎  | `transaction`            | `object`     | The trnsaction object.                                                                                                    |
|  ✔︎︎︎︎︎  | └➔&nbsp;`amount`         | `integer`    | Amount Entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 NOK`, `5000` = `50.00 NOK`. |
|  ✔︎︎︎︎︎  | └➔&nbsp;`vatAmount`      | `integer`    | Amount Entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 NOK`, `5000` = `50.00 NOK`. |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`    | `string`     | A textual description of the capture                                                                                      |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the reversal transaction. See [`payeeReference`][payeeReference] for details.                      |

The `reversal` resource contains information about a reversal transaction made
against a payment.
You can return a specific reversal transaction by adding the transaction id
to the `GET` request.

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/vipps/payments/{{ page.paymentId }}",
    "reversal": {
        "id": "/psp/vipps/payments/{{ page.paymentId }}/reversals/{{ page.transactionId }}",
        "transaction": {
            "id": "/psp/vipps/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
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
            "operations": []
        }
    }
}
```

{:.table .table-striped}
| Property              | Type     | Description                                                            |
| :-------------------- | :------- | :--------------------------------------------------------------------- |
| `payment`             | `string` | The relative URI of the payment this capture transaction belongs to.   |
| `reversal`            | `object` | The reversal object.                                                   |
| └➔&nbsp;`id`          | `string` | The relative URI of the created capture transaction.                   |
| └➔&nbsp;`transaction` | `object` | The object representation of the generic [`transaction`][transaction]. |

{% include iterator.html
        prev_href="seamless-view"
        prev_title="Back: Seamless View"
        next_href="other-features"
        next_title="Next: Other Features" %}

[abort]: /payments/vipps/other-features#abort
[cancel]: #cancellations
[capture]: #captures
[payeeReference]: /payments/vipps/other-features#payee-reference
[reverse]: #reversals
[transaction]: /payments/vipps/other-features#transactions
