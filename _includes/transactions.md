A payment contains sub-resources in the form of `transactions`. Most operations
performed on a payment ends up as a transaction. The different types of
operations that alter the state of the payment by creating a transaction is
described below.

The `transactions` resource will list the transactions (one or more) on a
specific payment.

{:.code-header}
**Request**

```http
GET /psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions HTTP/1.1
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
| Property                    | Type     | Description                                                             |
| :-------------------------- | :------- | :---------------------------------------------------------------------- |
| `payment`                   | `string` | The relative URI of the payment this list of transactions belong to.    |
| `transactions`              | `object` | The transactions object.                                                |
| └➔&nbsp;`id`                | `string` | The relative URI of the current `transactions` resource.                |
| └➔&nbsp;`transactionList`   | `array`  | The array of transaction objects.                                       |
| └➔&nbsp;`transactionList[]` | `object` | The transaction object (described in the `transaction` resource below). |
