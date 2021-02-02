{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include documentation-section.md fallback="card" %}{% endcapture %}
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

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
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
}
```

{:.table .table-striped}
| Field                             | Type      | Required                                                                                                                                                                                                     |
| :-------------------------------- | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                         | `string`  | {% include field-description-id.md sub_resource=plural %}                                                                                                                                                    |
| `{{ plural }}`                    | `object`  | The current `{{ plural }}` resource.                                                                                                                                                                         |
| └➔&nbsp;`id`                      | `string`  | {% include field-description-id.md resource=plural %}                                                                                                                                                        |
| └➔&nbsp;`{{ transaction }}List`   | `array`   | The array of {{ transaction }} transaction objects.                                                                                                                                                          |
| └➔&nbsp;`{{ transaction }}List[]` | `object`  | The {{ transaction }} transaction object described in the `{{ transaction }}` resource below.                                                                                                                |
| └─➔&nbsp;`id`                     | `string`  | {% include field-description-id.md resource="transaction" %}                                                                                                                                                 |
| └─➔&nbsp;`created`                | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`updated`                | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| └─➔&nbsp;`type`                   | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └─➔&nbsp;`state`                  | `string`  | {% include field-description-state.md %}   |
| └─➔&nbsp;`number`                 | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, where `id` should be used instead. |
| └─➔&nbsp;`amount`                 | `integer` | {% include field-description-amount.md %}                                                                                                                                                                    |
| └─➔&nbsp;`vatAmount`              | `integer` | {% include field-description-vatamount.md %}                                                                                                                                                                 |
| └─➔&nbsp;`description`            | `string`  | {% include field-description-description.md %}                                                                                                                   |
| └─➔&nbsp;`payeeReference`         | `string`  | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                         | {% if api_resource == "invoice" %}
| └─➔&nbsp;`receiptReference`       | `string`  | A unique reference for the transaction. This reference is used as an invoice/receipt number.                                                                                                                 | {% endif %}
| └─➔&nbsp;`isOperational`          | `bool`    | `true` if the transaction is operational; otherwise `false`.                                                                                                                                                 |
| └─➔&nbsp;`operations`             | `array`   | The array of [operations][operations] that are possible to perform on the transaction in its current state.                                                                                                                |

[operations]: /payment-instruments/{{ documentation_section }}/other-features#operations
