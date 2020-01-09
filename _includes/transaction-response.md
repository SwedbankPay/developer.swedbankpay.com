{% assign instrument = include.payment-instrument | default: "paymentorder" %}
{% assign transaction = include.transaction | default: "capture" %}
{% assign plural = transaction | append: "s" %}
{% assign showRequest = include.showRequest | default: true %}

{% if showRequest %}
{:.code-header}
**Request**

```http
GET /psp/{{ instrument }}/payments/{{ page.paymentId }}/{{ plural }} HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% endif %}

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/{{ instrument }}/payments/{{ page.paymentId }}",
    "{{ plural }}": {
        "id": "/psp/{{ instrument }}/payments/{{ page.paymentId }}/{{ plural }}",
        "{{ transaction }}List": [{
            "id": "/psp/{{ instrument }}/payments/{{ page.paymentId }}/{{ plural }}/{{ page.transactionId }}",
            "transaction": {
                "id": "/psp/{{ instrument }}/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
                "created": "2016-09-14T01:01:01.01Z",
                "updated": "2016-09-14T01:01:01.03Z",
                "type": "{{ transaction | capitalize }}",
                "state": "Completed",
                "number": 1234567890,
                "amount": 1000,
                "vatAmount": 250,
                "description": "Test transaction",
                "payeeReference": "AH123456",
                "failedReason": "",
                "isOperational": false,
                "operations": []
            }
        }]
    }
}
```

{:.table .table-striped}
| Property                          | Type      | Required                                                                                                                                                                                                     |
| :-------------------------------- | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                         | `string`  | The relative URI of the payment this list of {{ transaction }} transactions belong to.                                                                                                                       |
| `{{ plural }}`                    | `object`  | The current `{{ plural }}` resource.                                                                                                                                                                         |
| └➔&nbsp;`id`                      | `string`  | The relative URI of the current `{{ plural }}` resource.                                                                                                                                                     |
| └➔&nbsp;`{{ transaction }}List`   | `array`   | The array of {{ transaction }} transaction objects.                                                                                                                                                          |
| └➔&nbsp;`{{ transaction }}List[]` | `object`  | The {{ transaction }} transaction object described in the `{{ transaction }}` resource below.                                                                                                                |
| └─➔&nbsp;`id`                     | `string`  | The relative URI of the current `transaction` resource.                                                                                                                                                      |
| └─➔&nbsp;`created`                | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`updated`                | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`type`                   | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └─➔&nbsp;`state`                  | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| └─➔&nbsp;`number`                 | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead. |
| └─➔&nbsp;`amount`                 | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 SEK.                                                                                     |
| └─➔&nbsp;`vatAmount`              | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                           |
| └─➔&nbsp;`description`            | `string`  | A human readable description of maximum 40 characters of the transaction.                                                                                                                                    |
| └─➔&nbsp;`payeeReference`         | `string`  | A unique reference for the transaction.                                                                                                                                                                      |
| └─➔&nbsp;`failedReason`           | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                    |
| └─➔&nbsp;`isOperational`          | `bool`    | `true` if the transaction is operational; otherwise `false`.                                                                                                                                                 |
| └─➔&nbsp;`operations`             | `array`   | The array of operations that are possible to perform on the transaction in its current state.                                                                                                                |
