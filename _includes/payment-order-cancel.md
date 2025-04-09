{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}

## Cancel

The `cancellations` resource lists the cancellation transactions on a
specific payment.

## Create Cancel Transaction

{% if documentation_section contains "checkout-v3" %}

To cancel a previously created payment, you must perform the `cancel` operation
against the accompanying `href` returned in the `operations` list. You can only
cancel a payment - or part of a payment - which has not been captured yet. There
must be funds left that are only authorized. If you cancel before any capture
has been done, no captures can be performed later.

{% else %}

To cancel a previously created payment, you must perform the
`create-paymentorder-cancel` operation against the accompanying `href` returned
in the `operations` list. You can only cancel a payment - or part of a payment -
which has not been captured yet. If you cancel before any capture has been done,
no captures can be performed later.

{% endif %}

## Cancel Request

{% capture request_header %}POST /psp/paymentorders/{{ page.payment_order_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.0/2.0      // Version optional{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "description": "Test Cancellation",
        "payeeReference": "ABC123"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{:.table .table-striped}
|     Required     | Field                    | Type         | Description                                                                                    |
| :--------------: | :----------------------- | :----------- | :--------------------------------------------------------------------------------------------- |
| {% icon check %} | `transaction`            | `object`     | The transaction object.                                                                        |
| {% icon check %} | {% f description %}    | `string`     | A textual description of why the transaction is cancelled.                                     |
| {% icon check %} | {% f payeeReference %} | `string(30)` | {% include fields/payee-reference.md %} |

## Cancel Response

If the cancel request succeeds, the response should be similar to the
example below:

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.0/2.0
api-supported-versions: 3.0/2.0{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/creditcard/payments/{{ page.payment_id }}",
    "cancellation": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}/cancellations/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2022-01-31T09:49:13.7567756Z",
            "updated": "2022-01-31T09:49:14.7374165Z",
            "type": "Cancellation",
            "state": "Completed",
            "number": 71100732065,
            "amount": 1500,
            "vatAmount": 375,
            "description": "Test Cancellation",
            "payeeReference": "AB123"
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
| {% f payment, 0 %}                 | `string`  | The relative URL of the payment this cancellation transaction belongs to.                                                                                                                                    |
| {% f cancellation, 0 %}            | `object`  | The cancellation object, containing information about the cancellation transaction.                                                                                                                          |
| {% f id %}              | `string`  | The relative URL of the cancellation transaction.                                                                                                                                                            |
| {% f transaction %}     | `object`  | {% include fields/transaction.md %}                                                                                                                                |
| {% f id, 2 %}             | `string`  | The relative URL of the current `transaction` resource.                                                                                                                                                      |
| {% f created, 2 %}        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| {% f updated, 2 %}        | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| {% f type, 2 %}           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| {% f state, 2 %}          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| {% f number, 2 %}         | `integer` | {% include fields/number.md %} |
| {% f amount, 2 %}         | `integer` | {% include fields/amount.md %}                                                                                                                                                                    |
| {% f vatAmount, 2 %}      | `integer` | {% include fields/vat-amount.md %}                                                                                                                                                                 |
| {% f description, 2 %}    | `string`  | A human readable description of maximum 40 characters of the transaction.                                                                                                                                    |
| {% f payeeReference, 2 %} | `string(30)`  | {% include fields/payee-reference.md describe_receipt=true %}                                                                                         |
{% endcapture %}
{% include accordion-table.html content=table %}

## Cancel Sequence Diagram

Cancel can only be done on an authorized transaction. As a cancellation does not
have an amount associated with it, it will release the entire reserved amount.
If your intention is to make detailed handling, such as only capturing a partial
amount of the transaction, you must start with the capture of the desired amount
before performing a cancel for the remaining reserved funds.

```mermaid
sequenceDiagram
    participant SwedbankPay as Swedbank Pay

    Merchant->>SwedbankPay: POST < {{ include.api_resource }} cancellation>
    activate Merchant
    activate SwedbankPay
    SwedbankPay-->>Merchant: transaction resource
    deactivate SwedbankPay
    deactivate Merchant
```
