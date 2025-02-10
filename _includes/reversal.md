{% capture techref_url %}{% include utils/documentation-section-url.md href='/features/technical-reference' %}{% endcapture %}
{% assign transactions_url = '/transactions' | prepend: techref_url %}
{% assign operations_url = '/operations' | prepend: techref_url %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}

## Reversal

This transaction is used when a captured payment needs to be reversed.

Please note that you have a maximum of 5 **consecutive** failed attempts at a
reversal. The payment will be locked after this, and you need to contact us for
another attempt.

## Reversal Request

{% if documentation_section contains "checkout-v3" %}

The `reversal` operation will reverse a previously captured payment.

{% else %}

The `create-reversal` operation will reverse a previously captured payment.

{% endif %}

{% capture request_header %}POST /psp/{{ include.api_resource }}/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "amount": 1500,
        "vatAmount": 0,
        "description": "Test Reversal",
        "payeeReference": "ABC123"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture request_table%}
{:.table .table-striped .mb-5}
|     Required     | Field                    | Type          | Description                                                                              |
| :--------------: | :----------------------- | :------------ | :--------------------------------------------------------------------------------------- | {% if documentation_section contains "checkout-v3" %}
| {% icon check %} | `transaction`            | `object`      | The `object` representation of the generic transaction resource. | {% else %}
| {% icon check %} | `transaction`            | `object`      | The `object` representation of the generic [transaction resource]({{ transactions_url }}). | {% endif %}
| {% icon check %} | {% f amount %}         | `integer`     | {% include fields/amount.md %}                                                |
| {% icon check %} | {% f vatAmount %}      | `integer`     | {% include fields/vat-amount.md %}                                             |
| {% icon check %} | {% f description %}    | `string`      | A textual description of the `reversal`.                                                 |
| {% icon check %} | {% f payeeReference %} | `string` | {% include fields/payee-reference.md documentation_section=include.documentation_section %}          |
{% endcapture %}
{% include accordion-table.html content = request_table
%}

## Reversal Response

The `reversal` resource contains information about the newly created reversal
transaction.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
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
            "amount": 1500,
            "vatAmount": 375,
            "description": "Test transaction",
            "payeeReference": "ABC123",
            "failedReason": "",
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

{% capture response_table %}
{:.table .table-striped .mb-5}
| Property                  | Type      | Description                                                                                                                                                                                                  |
| :------------------------ | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}                 | `string`  | The relative URL of the payment this `reversal` transaction belongs to.                                                                                                                                      |
| {% f reversal, 0 %}                | `object`  | The `reversal` resource contains information about the `reversal` transaction made against a card payment.                                                                                                    |
| {% f id %}              | `string`  | The relative URL of the created `reversal` transaction.                                                                                                                                                       |{% if documentation_section contains "checkout-v3" %}
| {% icon check %} | `transaction`            | `object`      | The `object` representation of the generic transaction resource. | {% else %}
| {% icon check %} | `transaction`            | `object`      | The `object` representation of the generic [transaction resource]({{ transactions_url }}). | {% endif %}
| {% f id, 2 %}             | `string`  | The relative URL of the current  transaction  resource.                                                                                                                                                      |
| {% f created, 2 %}        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| {% f updated, 2 %}        | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| {% f type, 2 %}           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| {% f state, 2 %}          | `string`  | {% include fields/state.md %}        |
| {% f number, 2 %}         | `string`  | The transaction number, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, where `id` should be used instead.      |
| {% f amount, 2 %}         | `integer` | {% include fields/amount.md %}                                                                                                                                                                    |
| {% f vatAmount, 2 %}      | `integer` | {% include fields/vat-amount.md %}                                                                                                                                                                 |
| {% f description, 2 %}    | `string`  | {% include fields/description.md documentation_section=include.documentation_section %}                                                                                                                                  |
| {% f payeeReference, 2 %} | `string`  | {% include fields/payee-reference.md documentation_section=include.documentation_section %}                                                                                                                              |
| {% f failedReason, 2 %}   | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                    |
| {% f isOperational, 2 %}  | `boolean` | `true`  if the transaction is operational; otherwise  `false` .                                                                                                                                              |
| {% f operations, 2 %}     | `array`   | {% include fields/operations.md resource="transaction" %}                                                                                                  |
{% endcapture %}
{% include accordion-table.html content = response_table %}

## List Reversal Transactions

The `reversals` resource lists the reversal transactions (one or more) on a
specific payment.

{% capture request_header %}GET /psp/{{ include.api_resource }}/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% include transaction-list-response.md api_resource=include.api_resource documentation_section=include.api_resource transaction="reversal" %}

## Reversal Sequence Diagram

```mermaid
sequenceDiagram
  activate Merchant
  Merchant->>-SwedbankPay: POST [reversals]
  activate SwedbankPay
  SwedbankPay-->>-Merchant: transaction resource
```
