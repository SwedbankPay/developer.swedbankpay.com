## Reversal

This transaction is used when a captured payment needs to be reversed.

### Create reversal transaction

The `create-reversal` operation will reverse a previously captured payment.

{:.code-view-header}
**Request**

```http
POST /psp/{{ include.api_resource }}/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
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
|     Required     | Field                    | Type          | Description                                                                              |
| :--------------: | :----------------------- | :------------ | :--------------------------------------------------------------------------------------- |
| {% icon check %} | `transaction`            | `object`      | The `object` representation of the generic [transaction resource][transaction-resource]. |
| {% icon check %} | └➔&nbsp;`amount`         | `integer`     | {% include field-description-amount.md %}                                                |
| {% icon check %} | └➔&nbsp;`vatAmount`      | `integer`     | {% include field-description-vatamount.md %}                                             |
| {% icon check %} | └➔&nbsp;`description`    | `string`      | A textual description of the `reversal`.                                                 |
| {% icon check %} | └➔&nbsp;`payeeReference` | `string(30*)` | {% include field-description-payee-reference.md documentation_section=include.documentation_section %}          |

The `reversal` resource contains information about the newly created reversal
transaction.

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/{{ include.api_resource }}/payments/{{ page.payment_id }}",
    "reversal": {
        "id": "/psp/{{ include.api_resource }}/payments/{{ page.payment_id }}/reversal/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/{{ include.api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Reversal",
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
    }
}
```

{:.table .table-striped}
| Property                  | Type      | Description                                                                                                                                                                                                  |
| :------------------------ | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                 | `string`  | The relative URI of the payment this `reversal` transaction belongs to.                                                                                                                                      |
| `reversal`                | `object`  | The `reversal` resource contains information about the `reversal` transaction made against a card payment.                                                                                                    |
| └➔&nbsp;`id`              | `string`  | The relative URI of the created `reversal`transaction.                                                                                                                                                       |
| └➔&nbsp;`transaction`     | `object`  | The object representation of the generic [transaction resource][transaction-resource].                                                                                                                       |
| └─➔&nbsp;`id`             | `string`  | The relative URI of the current  transaction  resource.                                                                                                                                                      |
| └─➔&nbsp;`created`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`updated`        | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| └─➔&nbsp;`type`           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └─➔&nbsp;`state`          | `string`  | {% include field-description-state.md %}        |
| └─➔&nbsp;`number`         | `string`  | The transaction number, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, where `id` should be used instead.      |
| └─➔&nbsp;`amount`         | `integer` | {% include field-description-amount.md %}                                                                                                                                                                    |
| └─➔&nbsp;`vatAmount`      | `integer` | {% include field-description-vatamount.md %}                                                                                                                                                                 |
| └─➔&nbsp;`description`    | `string`  | {% include field-description-description.md documentation_section=include.documentation_section %}                                                                                                                                  |
| └─➔&nbsp;`payeeReference` | `string`  | {% include field-description-payee-reference.md documentation_section=include.documentation_section %}                                                                                                                              |
| └─➔&nbsp;`failedReason`   | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                    |
| └─➔&nbsp;`isOperational`  | `boolean` | `true`  if the transaction is operational; otherwise  `false` .                                                                                                                                              |
| └─➔&nbsp;`operations`     | `array`   | The array of [operations][operations] that are possible to perform on the transaction in its current state.                                                                                                  |

The `reversals` resource lists the reversal transactions (one or more) on a
specific payment.

{:.code-view-header}
**Request**

```http
GET /psp/{{ include.api_resource }}/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{% include transaction-list-response.md api_resource=include.api_resource documentation_section=include.api_resource transaction="reversal" %}

### Reversal Sequence

```mermaid
sequenceDiagram
  activate Merchant
  Merchant->>-SwedbankPay: POST [reversals]
  activate SwedbankPay
  SwedbankPay-->>-Merchant: transaction resource
```

[transaction-resource]: /payment-instruments/card/features/technical-reference/transactions
