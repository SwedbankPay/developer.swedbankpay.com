{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include documentation-section.md %}{% endcapture %}
{% if documentation_section == nil or documentation_section == empty %}
    {% assign operations_href = "/introduction#operations" %}
{% else %}
    {%- capture operations_href -%}
        {%- if documentation_section == "checkout" or documentation_section == "payment-menu" -%}
            /{{ documentation_section }}/other-features#operations
        {%- else -%}
            /payment-instruments/{{ documentation_section }}/other-features#operations
        {%- endif -%}
    {%- endcapture -%}
{%- endif -%}

{% assign transaction = include.transaction | default: "capture" %}
{% assign mcom = include.mcom | default: false %}

{% if transaction == "cancel" %}
    {% assign plural = "cancellations" %}
{% else %}
    {% assign plural = transaction | append: "s" %}
{% endif %}

The created `{{ transaction }}` resource contains information about the
`{{ transaction }}` transaction made against a `{{ api_resource }}` payment.

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "{{ transaction }}": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/{{ plural }}/{{ page.transaction_id }}",{% if api_resource == "creditcard" %}
        "paymentToken": "{{ page.payment_token }}",
        "maskedPan": "123456xxxxxx1234",
        "expireDate": "mm/yyyy",
        "panToken": "{{ page.transaction_id }}",
        "cardBrand": "Visa",
        "cardType": "Credit Card",
        "issuingBank": "UTL MAESTRO",
        "countryCode": "999",
        "acquirerTransactionType": "3DSECURE",
        "acquirerStan": "39736",
        "acquirerTerminalId": "39",
        "acquirerTransactionTime": "2017-08-29T13:42:18Z",
        "authenticationStatus": "Y",{% endif %}
        "itemDescriptions": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}/itemDescriptions"
        },
        "transaction": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "{{ transaction | capitalize }}",
            "state": {% if transaction == "transaction" %}"Failed"{% else %}"Completed"{% endif %},
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456", {% if api_resource == "invoice" %}
            "receiptReference": "AH12355", {% endif %}
            "isOperational": false,
            "problem": {
                "type": "https://api.payex.com/psp/errordetail/{{ api_resource }}/3DSECUREERROR",
                "title": "Error when complete authorization",
                "status": 400,
                "detail": "Unable to complete 3DSecure verification!",
                "problems": [
                ] {% unless transaction == "transaction" %}
            "operations": [{% if api_resource == "swish" and mcom == true %}
                {
                    "href": "swish://paymentrequest?token=LhXrK84MSpWU2RO09f8kUP-FHiBo-1pB",
                    "method": "GET",
                    "rel": "redirect-app-swish"
                },{% endif %}
                {
                    "href": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
                    "rel": "edit-{{ transaction }}",
                    "method": "PATCH"
                }
            ]{% endunless %}
        }
    }
}

```

{:.table .table-striped}
| Field                             | Type      | Description                                                                                                                                                                                                  |
| :-------------------------------- | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                         | `string`  | {% include field-description-id.md sub_resource=transaction %}                                                                                                                                               |
| `{{ transaction }}`               | `string`  | The current `{{ transaction }}` transaction resource.                                                                                                                                                        |
| └➔&nbsp;`id`                      | `string`  | {% include field-description-id.md resource=transaction %}                                                                                                                                                   | {% if api_resource == "creditcard" %} |
| └➔&nbsp;`paymentToken`            | `string`  | The payment token created for the card used in the authorization.                                                                                                                                            |
| └➔&nbsp;`maskedPan`               | `string`  | The masked PAN number of the card.                                                                                                                                                                           |
| └➔&nbsp;`expireDate`              | `string`  | The month and year of when the card expires.                                                                                                                                                                 |
| └➔&nbsp;`panToken`                | `string`  | The token representing the specific PAN of the card.                                                                                                                                                         |
| └➔&nbsp;`cardBrand`               | `string`  | `Visa`, `MC`, etc. The brand of the card.                                                                                                                                                                    |
| └➔&nbsp;`cardType`                | `string`  | `Credit Card` or `Debit Card`. Indicates the type of card used for the authorization.                                                                                                                        |
| └➔&nbsp;`issuingBank`             | `string`  | The name of the bank that issued the card used for the authorization.                                                                                                                                        |
| └➔&nbsp;`countryCode`             | `string`  | The country the card is issued in.                                                                                                                                                                           |
| └➔&nbsp;`acquirerTransactionType` | `string`  | `3DSECURE` or `SSL`. Indicates the transaction type of the acquirer.                                                                                                                                         |
| └➔&nbsp;`acquirerStan`            | `string`  | The System Trace Audit Number assigned by the acquirer to uniquely identify the transaction.                                                                                                                 |
| └➔&nbsp;`acquirerTerminalId`      | `string`  | The ID of the acquirer terminal.                                                                                                                                                                             |
| └➔&nbsp;`acquirerTransactionTime` | `string`  | The ISO-8601 date and time of the acquirer transaction.                                                                                                                                                      |
| └➔&nbsp;`authenticationStatus`    | `string`  | `Y`, `A`, `U` or `N`. Indicates the status of the authentication.                                                                                                                                            | {% endif %}                           |
| └➔&nbsp;`itemDescriptions`        | `object`  | The object representation of the `itemDescriptions` resource.                                                                                                                                                |
| └─➔&nbsp;`id`                     | `string`  | {% include field-description-id.md resource="itemDescriptions" %}                                                                                                                                            |
| └➔&nbsp;`transaction`             | `object`  | The object representation of the generic transaction resource.                                                                                                                                               |
| └─➔&nbsp;`id`                     | `string`  | {% include field-description-id.md resource="transaction" %}                                                                                                                                                 |
| └─➔&nbsp;`created`                | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`updated`                | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| └─➔&nbsp;`type`                   | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └─➔&nbsp;`state`                  | `string`  |{% include field-description-state.md %}    |
| └─➔&nbsp;`number`                 | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, where `id` should be used instead. |
| └─➔&nbsp;`amount`                 | `integer` | {% include field-description-amount.md %}                                                                                                                                                                    |
| └─➔&nbsp;`vatAmount`              | `integer` | {% include field-description-vatamount.md %}                                                                                                                                                                 |
| └─➔&nbsp;`description`            | `string`  | {% include field-description-description.md %}                                                                                                                   |
| └─➔&nbsp;`payeeReference`         | `string`  | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                         |
| └─➔&nbsp;`receiptReference`       | `string`  | A unique reference for the transaction. This reference is used as an invoice/receipt number.                                                                                                                 |
| └─➔&nbsp;`failedReason`           | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                    |
| └─➔&nbsp;`isOperational`          | `bool`    | `true` if the transaction is operational; otherwise `false`.                                                                                                                                                 |
| └─➔&nbsp;`operations`             | `array`   | The array of [operations]({{ operations_href }}) that are possible to perform on the transaction in its current state.                                                                                                  |
