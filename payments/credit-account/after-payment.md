---
title: Swedbank Pay Payments Credit Account After Payment
sidebar:
  navigation:
  - title: Credit Account Payments
    items:
    - url: /payments/credit-account/
      title: Introduction
    - url: /payments/credit-account/after-payment
      title: After Payment
    - url: /payments/credit-account/other-features
      title: Other Features
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="This section of the Developer Portal is under construction and
                      should not be used to integrate against Swedbank Pay's
                      APIs yet." %}

## Create capture transaction

To `capture` a `CreditAccountSe` transaction, you need to perform the
`create-capture` operation.

{:.code-header}
**Request**

```HTTP
POST /psp/creditcard/payments/<paymentId>/captures HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
 "transaction": {
    "amount": 1000,
   "vatAmount": 250,
   "description" : "description for transaction",
   "payeeReference": "customer reference-unique"
  }
}
```

{:.table .table-striped}
| Required | Property               | Type   | Description                                                                                                               |
| :------: | :--------------------- | :---------- | :------------------------------------------------------------------------------------------------------------------------ |
|    ✔︎    | capture.amount         | integer     | Amount Entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 NOK`, `5000` = `50.00 SEK`. |
|    ✔︎    | capture.vatAmount      | integer     | Amount Entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 NOK`, `5000` = `50.00 SEK`. |
|    ✔︎    | capture.description    | string      | A textual description of the capture transaction.                                                                         |
|    ✔︎    | capture.payeeReference | string(30*) | A unique reference for the capture transaction. See [payeeReference][payee-reference] for details.                        |

The `capture` resource contains information about the capture transaction.

{:.code-header}
**Response**

```HTTP
HTTP/1.1 200 OK
Content-Type: application/json

{
 "payment": "/psp/creditaccount/payments/<paymentId>",
 "captures": [
    {
      "transaction": {
       "id": "/psp/creditaccount/payments/<paymentId>/transactions/<transactionId>",
       "created": "2016-09-14T01:01:01.01Z",
       "updated": "2016-09-14T01:01:01.03Z",
       "type": "Capture",
       "state": "Initialized|Completed|Failed",
       "number": 1234567890,
       "amount": 1000,
       "vatAmount": 250,
       "description": "Test transaction",
       "payeeReference": "AH123456",
       "failedReason": "ExternalResponseError",
       "failedActivityName": "Authorize",
       "failedErrorCode": "ThirdPartyErrorCode",
       "failedErrorDescription": "ThirdPartyErrorMessage",
       "isOperational": "TRUE|FALSE",
       "activities": { "id": "/psp/creditaccount/payments/<paymentId>/transactions/<transactionId>/activities" },
       "operations": [
        ]
      }
    },
    {
      "transaction": {
       "id": "/psp/creditaccount/payments/<paymentId>/transactions/<transactionId>",
       "created": "2016-09-14T01:01:01.01Z",
       "updated": "2016-09-14T01:01:01.03Z",
       "type": "Capture",
       "state": "Initialized|Completed|Failed",
       "number": 1234567890,
       "amount": 1000,
       "vatAmount": 250,
       "description": "Test transaction",
       "payeeReference": "AH123456",
       "failedReason": "ExternalResponseError",
       "failedActivityName": "Authorize",
       "failedErrorCode": "ThirdPartyErrorCode",
       "failedErrorDescription": "ThirdPartyErrorMessage",
       "isOperational": "TRUE|FALSE",
       "activities": { "id": "/psp/creditaccount/payments/<paymentId>/transactions/<transactionId>/activities" },
       "operations": [
        ]
      }
    }
  ]
}
```

{:.table .table-striped}
| Property              | Type | Description                                                                           |
| :-------------------- | :-------- | :------------------------------------------------------------------------------------ |
| `payment`             | `string`  | The relative URI of the payment this capture transaction belongs to.                  |
| `capture.id`          | `string`  | The relative URI of the created capture transaction.                                  |
| `capture.transaction` | `object`  | The object representation of the generic [transaction resource][transaction-resource] |

{% include iterator.html
        prev_href="index"
        prev_title="Back: Introduction"
        next_href="other-features"
        next_title="Next: Other Features" %}

[payee-reference]: /payments/credit-account/other-features#payeereference
[transaction-resource]: /payments/credit-account/other-features#transactions
