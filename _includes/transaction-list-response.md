{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{%- capture documentation_section -%}{%- include utils/documentation-section.md -%}{%- endcapture -%}
{% assign operations_url = '/technical-reference/operations' | prepend: features_url %}
{% assign transaction = include.transaction | default: "capture" %}
{% if transaction == "cancel" %}
    {% assign plural = "cancellations" %}
{% else %}
    {% assign plural = transaction | append: "s" %}
{% endif %}

The `{{ transaction }}` resource contains information about the
`{{ transaction }}` transaction made against a {{ api_resource }} payment. You can
return a specific `{{ transaction }}` transaction by performing a `GET` request
towards the specific transaction's `id`.

## Transaction List Response

{% if documentation_section contains "checkout-v2" or "checkout-v3" or "payment-menu-v2" %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "paymentorder": "/psp/paymentorders/{{ page.payment_id }}",
    "{{ plural }}": { {% if api_resource == "invoice" %}
        "receiptReference": "AH12355", {% endif %}
        "id": "/psp/paymentorders/{{ page.payment_id }}/currentpayment",
        "{{ transaction }}List": [{
            "id": "/psp/paymentorders/{{ page.payment_id }}/currentpayment/{{ page.transaction_id }}",{% if api_resource == "swish" %}
            "swishPaymentReference": "8D0A30A7804E40479F88FFBA26111F04",
            "swishStatus": "PAID",{% endif %}{% if transaction == "authorization" %}
            "consumer": {
                    "id": "/psp/paymentorders/{{ page.payment_id }}/consumer"
                },
                "legalAddress": {
                    "id": "/psp/paymentorders/{{ page.payment_id }}/legaladdress"
                },
                "billingAddress": {
                    "id": "/psp/paymentorders/{{ page.payment_id }}/billingaddress"
                },{% endif %}
            "transaction": {
                "id": "/psp/paymentorders/{{ page.payment_id }}/currentpayment/{{ page.transaction_id }}",
                "created": "2016-09-14T01:01:01.01Z",
                "updated": "2016-09-14T01:01:01.03Z",
                "type": "{{ transaction | capitalize }}",
                "state": "Completed",
                "number": 1234567890,
                "amount": 1000,
                "vatAmount": 250,
                "description": "Test transaction",
                "payeeReference": "AH123456",
                "isOperational": false,
                "operations": [{% if transaction == "authorization" %}
                       {
                            "method": "POST",
                            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_id }}/authorizations",
                            "rel": "create-authorization",
                            "contentType": "application/json"
                        },
                        {
                            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_id }}",
                            "rel": "edit-authorization",
                            "method": "PATCH"
                        }
                {% endif %}]
            }
        }]
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% else %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "{{ plural }}": { {% if api_resource == "invoice" %}
        "receiptReference": "AH12355", {% endif %}
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/{{ plural }}",
        "{{ transaction }}List": [{
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/{{ plural }}/{{ page.transaction_id }}",{% if api_resource == "swish" %}
            "swishPaymentReference": "8D0A30A7804E40479F88FFBA26111F04",
            "swishStatus": "PAID",{% endif %}{% if transaction == "authorization" %}
            "consumer": {
                    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/consumer"
                },
                "legalAddress": {
                    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/legaladdress"
                },
                "billingAddress": {
                    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/billingaddress"
                },{% endif %}
            "transaction": {
                "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
                "created": "2016-09-14T01:01:01.01Z",
                "updated": "2016-09-14T01:01:01.03Z",
                "type": "{{ transaction | capitalize }}",
                "state": "Completed",
                "number": 1234567890,
                "amount": 1000,
                "vatAmount": 250,
                "description": "Test transaction",
                "payeeReference": "AH123456",
                "isOperational": false,
                "operations": [{% if transaction == "authorization" %}
                       {
                            "method": "POST",
                            "href": "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations",
                            "rel": "create-authorization",
                            "contentType": "application/json"
                        },
                        {
                            "href": "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
                            "rel": "edit-authorization",
                            "method": "PATCH"
                        }
                {% endif %}]
            }
        }]
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% endif %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                             | Type      | Required                                                                                                                                                                                                     |
| :-------------------------------- | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | {% if documentation_section contains "checkout" or "payment-menu" %}
| {% f paymentOrder, 0 %}                         | `string`  | {% include fields/id.md %}                                                                                                                                                    | {% else %}
| {% f payment, 0 %}                         | `string`  | {% include fields/id.md sub_resource=plural %}                                                                                                                                                    |
| `{{ plural }}`                    | `object`  | The current `{{ plural }}` resource.                                                                                                                                                                         | {% endif %}
| {% f id %}                      | `string`  | {% include fields/id.md resource=plural %}                                                                                                                                                        |
| {% f {{ transaction }}List %}   | `array`   | The array of {{ transaction }} transaction objects.                                                                                                                                                          |
| {% f {{ transaction }}List[] %} | `object`  | The {{ transaction }} transaction object described in the `{{ transaction }}` resource below.                                                                                                                |
| {% f id, 2 %}                     | `string`  | {% include fields/id.md resource="transaction" %}                                                                                                                                                 |
| {% f created, 2 %}                | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| {% f updated, 2 %}                | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| {% f type, 2 %}                   | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| {% f state, 2 %}                  | `string`  | {% include fields/state.md %}   |
| {% f number, 2 %}                 | `integer` | {% include fields/number.md %} |
| {% f amount, 2 %}                 | `integer` | {% include fields/amount.md %}                                                                                                                                                                    |
| {% f vatAmount, 2 %}              | `integer` | {% include fields/vat-amount.md %}                                                                                                                                                                 |
| {% f description, 2 %}            | `string`  | {% include fields/description.md %}                                                                                                                   |
| {% f payeeReference, 2 %}         | `string`  | {% include fields/payee-reference.md describe_receipt=true %}                                                                                         | {% if api_resource == "invoice" %}
| {% f receiptReference, 2 %}       | `string`  | {% include fields/receipt-reference.md %}                                                                                                                 | {% endif %}
| {% f isOperational, 2 %}          | `bool`    | `true` if the transaction is operational; otherwise `false`.                                                                                                                                                 |
| {% f operations, 2 %}             | `array`   | {% include fields/operations.md resource="transaction" %}                                                                                                                |
{% endcapture %}
{% include accordion-table.html content=table %}
