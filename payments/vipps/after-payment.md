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

{% include alert-development-section.md %}

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
| Operation                | Description                                                                                 |
| :----------------------- | :------------------------------------------------------------------------------------------ |
| `update-payment-abort`   | [Aborts][other-features-abort] the payment before any financial transactions are performed. |
| `redirect-authorization` | Used to redirect the consumer to Swedbank Pay Payments and the authorization UI.            |
| `create-capture`         | Creates a [`capture`][other-features-capture].                                              |
| `create-cancellation`    | Creates a [`cancellation`][other-features-cancel].                                          |
| `create-reversal`        | Creates a [`reversal`][other-features-reverse].                                             |

## Vipps transactions

All Vipps after payment transactions are described below.

## Authorizations

The `authorizations` resource contains information about the authorization
transactions made on a specific payment.

{:.code-header}
**Request**

```http
GET /psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/authorizations HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d",
    "authorizations": {
        "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/authorizations",
        "authorizationList": [
            {
                "vippsTransactionId": "5619328800",
                "msisdn": "+4798765432",
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
GET /psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/authorizations/<transactionId> HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d",
    "authorization": {
        "vippsTransactionId": "5619328800",
        "msisdn": "+4798765432",
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
| └➔&nbsp; `transaction` | `object` | The object representation of the generic [transaction][other-features-transaction]. |

## Captures

The `captures` resource lists the capture transactions (one or more) on a specific payment.

{:.code-header}
**Request**

```HTThP
GET /psp/vipps/vipps/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/captures HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d",
    "captures": {
        "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/captures",
        "captureList": [
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
POST /psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/captures HTTP/1.1
Host: api.externalintegration.payex.com
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
|    ✔︎    | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the capture transaction. See [`payeeReference`][other-features-payeeReference] for details.        |

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
            "operations": []
        }
    }
}
```

{:.table .table-striped}
| Property              | Type     | Description                                                                           |
| :-------------------- | :------- | :------------------------------------------------------------------------------------ |
| `payment`             | `string` | The relative URI of the payment this capture transaction belongs to.                  |
| `capture`             | `string` | The capture object, containing a transaction object.                                  |
| └➔&nbsp;`id`          | `string` | The relative URI of the created capture transaction.                                  |
| └➔&nbsp;`transaction` | `object` | The object representation of the generic [`transaction`][other-features-transaction]. |

## Cancellations

The `cancellations` resource lists the cancellation transactions on a
specific payment.

{:.code-header}
**Request**

```http
GET /psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/cancellations HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/vipps/payments/754c378d-dd77-40cf-3811-08d613932ad6",
    "cancellations": {
        "id": "/psp/vipps/payments/754c378d-dd77-40cf-3811-08d613932ad6/cancellations",
        "cancellationList": [
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
POST /psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/cancellations HTTP/1.1
Host: api.externalintegration.payex.com
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
| Required | Property                 | Type         | Description                                                                                                             |
| :------: | :----------------------- | :----------- | :---------------------------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `transaction`            | `object`     | The transaction object describing the cancellation request.                                                             |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`    | `string`     | A textual description of the reason for the cancellation.                                                               |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the cancellation transaction. See [`payeeReference`][other-features-payeeReference] for details. |

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
            "operations": []
        }
    }
}
```

{:.table .table-striped}
| Property              | Type     | Description                                                                         |
| :-------------------- | :------- | :---------------------------------------------------------------------------------- |
| `payment`             | `string` | The relative URI of the payment this cancellation transaction belongs to.           |
| `cancellation`        | `object` | The cancellation resource.                                                          |
| └➔&nbsp;`id`          | `string` | The relative URI of the current cancellation transaction resource.                  |
| └➔&nbsp;`transaction` | `object` | The object representation of the generic [transaction][other-features-transaction]. |

## Reversals

The `reversals` resource lists the reversal transactions (one or more)
on a specific payment.

{:.code-header}
**Request**

```http
GET /psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/reversals HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json
{
    "payment": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d",
    "reversals": {
        "id": "/psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/reversals",
        "reversalList": [
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
POST /psp/vipps/payments/84b9e6aa-b8f5-4e7f-fa2f-08d612f7dd5d/reversals HTTP/1.1
Host: api.externalintegration.payex.com
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
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the reversal transaction. See [`payeeReference`][other-features-payeeReference] for details.       |

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
            "operations": []
        }
    }
}
```

{:.table .table-striped}
| Property              | Type     | Description                                                                           |
| :-------------------- | :------- | :------------------------------------------------------------------------------------ |
| `payment`             | `string` | The relative URI of the payment this capture transaction belongs to.                  |
| `reversal`            | `object` | The reversal object.                                                                  |
| └➔&nbsp;`id`          | `string` | The relative URI of the created capture transaction.                                  |
| └➔&nbsp;`transaction` | `object` | The object representation of the generic [`transaction`][other-features-transaction]. |

{% include iterator.html
        prev_href="seamless-view"
        prev_title="Back: Seamless View"
        next_href="other-features"
        next_title="Next: Other Features" %}

[other-features-abort]: /payments/vipps/other-features#abort
[other-features-cancel]: /payments/vipps/other-features#cancel
[other-features-capture]: /payments/vipps/other-features#capture-sequence
[other-features-payeeReference]: /payments/vipps/other-features#payee-reference
[other-features-reverse]: /payments/vipps/other-features#reversal
[other-features-transaction]: /payments/vipps/other-features#transactions
