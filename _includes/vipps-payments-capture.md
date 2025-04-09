## Capture

The capture transaction is where you ensure that the funds are drawn from
the payer. This step usually takes place when the product has exchanged
possession. You must first do a `GET` request on the payment to find the
`create-capture` operation.

Please note that you have a maximum of 5 **consecutive** failed attempts at a
reversal. The payment will be locked after this, and you need to contact us for
another attempt.

## Create Capture Transaction

To create a `capture` transaction to withdraw money from the payer's Vipps
account, you need to perform the `create-capture` operation.

## Capture Request

{% capture request_header %}POST /psp/vipps/payments/{{ page.payment_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "amount": 1500,
        "vatAmount": 250,
        "payeeReference": "cpttimestamp",
        "description" : "description for transaction"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{:.table .table-striped}
|     Required     | Field                    | Type          | Description                                                                                                   |
| :--------------: | :----------------------- | :------------ | :------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | `transaction`            | `object`      | {% include fields/transaction.md %}                        |
| {% icon check %} | {% f amount %}         | `integer`     | Amount Entered in the lowest momentary units of the selected currency. E.g. 10000 100.00 NOK, 5000 50.00 SEK. |
| {% icon check %} | {% f vatAmount %}      | `integer`     | Amount Entered in the lowest momentary units of the selected currency. E.g. 10000 100.00 NOK, 5000 50.00 SEK. |
| {% icon check %} | {% f description %}    | `string`      | A textual description of the capture transaction.                                                             |
| {% icon check %} | {% f payeeReference %} | `string(30)` | {% include fields/payee-reference.md %}                               |

## Capture Response

{% include transaction-response.md transaction="capture" %}

## List Capture Transactions

The `captures` resource lists the capture transactions (one or more) on a
specific payment.

## Transaction List Request

{% capture request_header %}GET /psp/vipps/vipps/{{ page.payment_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% include transaction-list-response.md transaction="capture" %}

### Capture Sequence Diagram

`Capture` can only be done on an authorized transaction. It is possible to do a
partial capture where you only capture a part of the authorized amount. You can
do more captures on the same payment up to the total authorization amount later.

```mermaid
sequenceDiagram
  activate Merchant
  Merchant->>-SwedbankPay: POST [Vipps captures]
  activate SwedbankPay
  SwedbankPay-->>-Merchant: transaction resource
```

[transaction-resource]: /old-implementations/payment-instruments-v1/vipps/features/technical-reference/transactions
