## Capture

{% include transaction-list-response.md %}

## Create capture transaction

A `capture` transaction to withdraw money from the payer's MobilePay can be
created after a completed authorization by performing the `create-capture`
operation.

{:.code-header}
**Request**

```http
POST /psp/mobilepay/payments/{{ page.payment_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "amount": 1000,
        "vatAmount": 250,
        "payeeReference": 1234,
        "description" : "description for transaction"
    }
}
```

{:.table .table-striped}
|     Required     | Field                    | Type         | Description                                                                           |
| :--------------: | :----------------------- | :----------- | :------------------------------------------------------------------------------------ |
| {% icon check %}︎ | `transaction`            | `object`     | Object representing the capture transaction.                                          |
| {% icon check %}︎ | └➔&nbsp;`amount`         | `integer`    | {% include field-description-amount.md %}                                             |
| {% icon check %}︎ | └➔&nbsp;`vatAmount`      | `integer`    | {% include field-description-vatamount.md %}                                          |
| {% icon check %}︎ | └➔&nbsp;`description`    | `string`     | A textual description of the capture transaction.                                     |
| {% icon check %}︎ | └➔&nbsp;`payeeReference` | `string(50)` | {% include field-description-payee-reference.md %} |

{% include transaction-response.md %}

## Capture Sequence

`Capture` can only be done on an authorized transaction. It is possible to do a
partial capture where you only capture a smaller amount than the authorization
amount. You can do more captures on the same payment later, up to the total
authorization amount.

```mermaid
sequenceDiagram
    participant SwedbankPay as Swedbank Pay

    Merchant->>SwedbankPay: POST <mobilepay capture>
    activate Merchant
    activate SwedbankPay
    SwedbankPay-->>Merchant: transaction resource
    deactivate SwedbankPay
    deactivate Merchant
```
