## Transactions

A payment contains sub-resources in the form of `transactions`. 
Most operations performed on a payment ends up as a transaction. 
The different types of operations that alter the state of the payment by 
creating a transaction is described below.

The `transactions` resource will list the transactions (one or more) 
on a specific payment.

{:.code-header}
**Request**

```http
GET /psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions HTTP/1.1
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
    "payment": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "transactions": {
        "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions",
        "transactionList": [{
            "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions/12345678-1234-1234-1234-123456789012",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Authorization",
            "state": "Initialized|Completed|Failed",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test authorization",
            "payeeReference": "PR1004",
            "failedReason": "",
            "isOperational": "TRUE|FALSE",
            "operations": []
        }]
    }
}
```

{:.table .table-striped}
| Property                         | Data type | Required                                                                |
| :------------------------------- | :-------- | :---------------------------------------------------------------------- |
| `payment`                        | `string`  | The relative URI of the payment this list of transactions belong to.    |
| `transactions.id`                | `string`  | The relative URI of the current `transactions` resource.                |
| `transactions.transactionList`   | `array`   | The array of transaction objects.                                       |
| `transactions.transactionList[]` | `object`  | The transaction object (described in the `transaction` resource below). |

### Transaction

The `transaction` resource contains the generic details of a 
transaction on a specific payment. 

When a transaction is created it will have one of three states:

* `Initialized` - if there is some error where the source is undeterminable 
  (network failure, etc), the transaction will remain Initialized. 
  The corresponding state of the payment order will in this case be set 
  to pending. 
  No further transactions can be created.
* `Completed` - if everything went ok the transaction will follow 
  through to completion..
* `Failed` - if the transaction has failed 
  (i.e. a denial from the acquiring bank) it is possible to retry 
  (i.e the consumer tries using another credit card) up to a maximum amount 
  of retries (in that case which the payment order gets 
  the state `failed` as well). 

{:.code-header}
**Request**

```http
GET /psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions HTTP/1.1
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
    "payment": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "transaction": {
        "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions/12345678-1234-1234-1234-123456789012",
        "created": "2016-09-14T01:01:01.01Z",
        "updated": "2016-09-14T01:01:01.03Z",
        "type": "Capture",
        "state": "Initialized",
        "number": 1234567890,
        "amount": 1000,
        "vatAmount": 250,
        "description": "Test transaction",
        "payeeReference": "AH123456",
        "failedReason": "",
        "isOperational": true,
        "operations": []
    }
}
```

{:.table .table-striped}
| Property | Data type | Description |
| :------- | :-------- | :---------- ||
| `payment`                    | `string`  | The relative URI of the payment this transaction belongs to.                                                                                                                                                 |
| `transaction.id`             | `string`  | The relative URI of the current `transaction` resource.                                                                                                                                                      |
| `transaction.created`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| `transaction.updated`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| `transaction.type`           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| `transaction.state`          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| `transaction.number`         | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead. |
| `transaction.amount`         | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 SEK.                                                                                     |
| `transaction.vatAmount`      | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                           |
| `transaction.description`    | `string`  | A human readable description of maximum 40 characters of the transaction.                                                                                                                                    |
| `transaction.payeeReference` | `string`  | A unique reference for the transaction. See [`payeeReference`][payee-reference] for details.                                                                                                                 |
| `transaction.failedReason`   | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                    |
| `transaction.isOperational`  | `boolean` | `true` if the transaction is operational; otherwise `false`.                                                                                                                                                 |
| `transaction.operations`     | `array`   | The array of [operations][operations] that are possible to perform on the transaction in its current state.                                                                                                  |

[operations]: #operations
[payee-reference]: #payee-reference
