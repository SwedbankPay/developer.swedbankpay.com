## Capture

The capture transaction is where you ensure that the funds are charged from
the payer. This step usually takes place when the product has exchanged
possession. You must first do a `GET` request on the payment to find the
`create-capture` operation.

### Create Capture Transaction

To create a `capture` transaction to withdraw money from the payer's card, you
need to perform the `create-capture` operation.

## Capture Request

{% capture request_header %}POST /psp/creditcard/payments/{{ page.payment_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "amount": 1500,
        "vatAmount": 250,
        "description": "Test Capture",
        "payeeReference": "ABC123"
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
| {% icon check %} | {% f payeeReference %} | `string` | {% include fields/payee-reference.md %}                               |

## Capture Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/creditcard/payments/{{ page.payment_id }}",
    "capture": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}/captures/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Capture",
            "state": "Completed",
            "number": 1234567890,
            "amount": 1500,
            "vatAmount": 250,
            "description": "Test Capture",
            "payeeReference": "ABC123",
            "isOperational": false,
            "operations": []
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Property                  | Type      | Description                                                                                                                                                                                                  |
| :------------------------ | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}                 | `string`  | The relative URL of the payment this `capture` transaction belongs to.                                                                                                                                       |
| {% f capture, 0 %}                 | `object`  | The `capture` resource contains information about the `capture` transaction made against a card payment.                                                                                                     |
| {% f id %}              | `string`  | The relative URL of the created `capture` transaction.                                                                                                                                                       |
| {% f transaction %}     | `object`  | {% include fields/transaction.md %}                                                                                                                     |
| {% f id, 2 %}             | `string`  | The relative URL of the current  `transaction`  resource.                                                                                                                                                    |
| {% f created, 2 %}        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| {% f updated, 2 %}        | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| {% f type, 2 %}           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| {% f state, 2 %}          | `string`  | {% include fields/state.md %} |
| {% f number, 2 %}         | `integer` | {% include fields/number.md %} |
| {% f amount, 2 %}         | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 NOK, 5000 = 50.00 SEK.                                                                                         |
| {% f vatAmount, 2 %}      | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                           |
| {% f description, 2 %}    | `string`  | A human readable description of maximum 40 characters of the transaction                                                                                                                                     |
| {% f payeeReference, 2 %} | `string`  | {% include fields/payee-reference.md %}                                                                                                                              |
| {% f failedReason, 2 %}   | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                    |
| {% f isOperational, 2 %}  | `boolean` | `true`  if the transaction is operational; otherwise  `false` .                                                                                                                                              |
| {% f operations, 2 %}     | `array`   | {% include fields/operations.md %}                                                                                                  |
{% endcapture %}
{% include accordion-table.html content=table %}

## List Capture Transactions

The `captures` resource list the capture transactions (one or more) on a
specific payment.

{% capture request_header %}GET /psp/creditcard/payments/{{ page.payment_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% include transaction-list-response.md transaction="capture" %}

## Capture Sequence Diagram

`Capture` can only be done on an authorized transaction. It is possible to do a
partial capture where you only capture a part of the authorized amount. You can
do more captures on the same payment up to the total authorization amount later.

```mermaid
sequenceDiagram
  activate Merchant
  Merchant->>-SwedbankPay: POST [Credit card captures]
  activate SwedbankPay
  SwedbankPay-->>-Merchant: transaction resource
```
