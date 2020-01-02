If we want to reverse a previously captured amount, we need to perform
`create-paymentorder-reversal` against the accompanying `href` returned in the
`operations` list. See the abbreviated request and response below:

{:.code-header}
**Request**

```http
POST /psp/paymentorders/{{ page.paymentOrderId }}/reversals HTTP/1.1
Host: {{ page.apiUrl }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "amount": 15610,
        "vatAmount": 3122,
        "payeeReference": "ABC123",
        "description": "description for transaction"
    }
}
```

{:.table .table-striped}
| Required | Property                 | Type         | Description                                                                                                                                                                              |
| :------: | :----------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `transaction`            | `object`     | The transaction object.                                                                                                                                                                  |
|  ✔︎︎︎︎︎  | └➔&nbsp;`amount`         | `integer`    | The amount including VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.                                                        |
|  ✔︎︎︎︎︎  | └➔&nbsp;`vatAmount`      | `integer`    | The amount of VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.                                                               |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeReference` | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details. |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`    | `string`     | Textual description of why the transaction is reversed.                                                                                                                                  |

If the reversal request succeeds, the response should be similar to the example below:

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/creditcard/payments/{{ page.paymentOrderId }}",
    "reversals": {
        "id": "/psp/creditcard/payments/{{ page.paymentOrderId }}/cancellations/{{ page.transactionId }}",
        "transaction": {
            "id": "/psp/creditcard/payments/{{ page.paymentOrderId }}/transactions/{{ page.transactionId }}",
            "type": "Reversal",
            "state": "Completed",
            "amount": 15610,
            "vatAmount": 3122,
            "description": "Reversing the capture amount",
            "payeeReference": "ABC987"
        }
    }
}
```

{:.table .table-striped}
| Property                  | Type      | Description                                                                                                                                                                                                  |
| :------------------------ | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                 | `string`  | The relative URI of the payment this reversal transaction belongs to.                                                                                                                                        |
| `reversals`               | `object`  | The reversal object, containing information about the reversal transaction.                                                                                                                                  |
| └➔&nbsp;`id`              | `string`  | The relative URI of the reversal transaction.                                                                                                                                                                |
| └➔&nbsp;`transaction`     | `object`  | The transaction object, containing information about the current transaction.                                                                                                                                |
| └─➔&nbsp;`id`             | `string`  | The relative URI of the current `transaction` resource.                                                                                                                                                      |
| └─➔&nbsp;`created`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`updated`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`type`           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └─➔&nbsp;`state`          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| └─➔&nbsp;`number`         | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead. |
| └─➔&nbsp;`amount`         | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 SEK.                                                                                     |
| └─➔&nbsp;`vatAmount`      | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                           |
| └─➔&nbsp;`description`    | `string`  | A human readable description of maximum 40 characters of the transaction.                                                                                                                                    |
| └─➔&nbsp;`payeeReference` | `string`  | A unique reference for the transaction. See [`payeeReference`][payee-reference] for details.                                                                                                                 |
