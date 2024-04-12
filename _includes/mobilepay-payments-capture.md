## Capture

{% include transaction-list-response.md %}

## Create Capture Transaction

A `capture` transaction to withdraw money from the payer's MobilePay can be
created after a completed authorization by performing the `create-capture`
operation.

## Capture Request

{% capture request_header %}POST /psp/mobilepay/payments/{{ page.payment_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "amount": 1000,
        "vatAmount": 250,
        "payeeReference": 1234,
        "description" : "description for transaction"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{:.table .table-striped}
|     Required     | Field                    | Type         | Description                                                                           |
| :--------------: | :----------------------- | :----------- | :------------------------------------------------------------------------------------ |
| {% icon check %}︎ | `transaction`            | `object`     | Object representing the capture transaction.                                          |
| {% icon check %}︎ | {% f amount %}         | `integer`    | {% include fields/amount.md %}                                             |
| {% icon check %}︎ | {% f vatAmount %}      | `integer`    | {% include fields/vat-amount.md %}                                          |
| {% icon check %}︎ | {% f description %}    | `string`     | A textual description of the capture transaction.                                     |
| {% icon check %}︎ | {% f payeeReference %} | `string` | {% include fields/payee-reference.md %} |

## Capture Response

{% include transaction-response.md %}

## Capture Sequence Diagram

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
