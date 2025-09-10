{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{%- capture operations_href -%}
    {%- if documentation_section == nil or documentation_section == empty -%}
        /checkout-v3/get-started/fundamental-principles#operations
    {%- else -%}
        {%- include utils/documentation-section-url.md href='/technical-reference/operations' -%}
    {%- endif -%}
{%- endcapture -%}
{% assign transaction = include.transaction | default: "capture" %}
{% assign mcom = include.mcom | default: false %}

{% if transaction == "cancel" %}
    {% assign plural = "cancellations" %}
{% else %}
    {% assign plural = transaction | append: "s" %}
{% endif %}

The created `{{ transaction }}` resource contains information about the
`{{ transaction }}` transaction made against a `{{ api_resource }}` payment.

## Capture Response

{% if documentation_section contains "checkout" or "payment-menu" %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentorder": "/psp/paymentorders/{{ page.payment_id }}",
    "{{ transaction }}": {
        "id": "/psp/paymentorders/{{ page.payment_id }}/currentpayment/{{ page.transaction_id }}",{% if api_resource == "creditcard" %}
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
            "id": "/psp/paymentorders/{{ page.payment_id }}/currentpayment/{{ page.transaction_id }}/itemDescriptions"
        },
        "transaction": {
            "id": "/psp/paymentorders/{{ page.payment_id }}/currentpayment/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "{{ transaction | capitalize }}",
            "state": {% if transaction == "transaction" %}"Failed"{% else %}"Completed"{% endif %},
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "ABC123", {% if api_resource == "invoice" %}
            "receiptReference": "ABC123", {% endif %}
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
                    "href": "/psp/paymentorders/{{ page.payment_id }}/currentpayment/{{ page.transaction_id }}",
                    "rel": "edit-{{ transaction }}",
                    "method": "PATCH"
                }
            ]{% endunless %}
        }
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
            "payeeReference": "ABC123", {% if api_resource == "invoice" %}
            "receiptReference": "ABC123", {% endif %}
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
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% endif %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                             | Type      | Description                                                                                                                                                                                                  |
| :-------------------------------- | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |{% if documentation_section contains "checkout" or "payment-menu" %}
| {% f paymentOrder, 0 %}                         | `string`  | {% include fields/id.md %}                                                                                                                                                    | {% else %}
| {% f payment, 0 %}                         | `string`  | {% include fields/id.md sub_resource=plural %}                                                                                                                                                    |
| `{{ plural }}`                    | `object`  | The current `{{ plural }}` resource.                                                                                                                                                                         | {% endif %}
| {% f id %}                      | `string`  | {% include fields/id.md resource=transaction %}                                                                                                                                                   | {% if api_resource == "creditcard" %} |
| {% f paymentToken %}            | `string`  | The payment token created for the card used in the authorization.                                                                                                                                            |
| {% f maskedPan %}               | `string`  | The masked PAN number of the card.                                                                                                                                                                           |
| {% f expireDate %}              | `string`  | The month and year of when the card expires.                                                                                                                                                                 |
| {% f panToken %}                | `string`  | The token representing the specific PAN of the card.                                                                                                                                                         |
| {% f cardBrand %}               | `string`  | `Visa`, `MC`, etc. The brand of the card.                                                                                                                                                                    |
| {% f cardType %}                | `string`  | `Credit Card` or `Debit Card`. Indicates the type of card used for the authorization.                                                                                                                        |
| {% f issuingBank %}             | `string`  | The name of the bank that issued the card used for the authorization.                                                                                                                                        |
| {% f countryCode %}             | `string`  | The country the card is issued in.                                                                                                                                                                           |
| {% f acquirerTransactionType %} | `string`  | `3DSECURE` or `SSL`. Indicates the transaction type of the acquirer.                                                                                                                                         |
| {% f acquirerStan %}            | `string`  | The System Trace Audit Number assigned by the acquirer to uniquely identify the transaction.                                                                                                                 |
| {% f acquirerTerminalId %}      | `string`  | The ID of the acquirer terminal.                                                                                                                                                                             |
| {% f acquirerTransactionTime %} | `string`  | The ISO-8601 date and time of the acquirer transaction.                                                                                                                                                      |
| {% f authenticationStatus %}    | `string`  | `Y`, `A`, `U` or `N`. Indicates the status of the authentication.                                                                                                                                            | {% endif %}                           |
| {% f itemDescriptions %}        | `object`  | The object representation of the `itemDescriptions` resource.                                                                                                                                                |
| {% f id, 2 %}                     | `string`  | {% include fields/id.md resource="itemDescriptions" %}                                                                                                                                            |
| {% f transaction %}             | `object`  | {% include fields/transaction.md %}                                                                                                                                               |
| {% f id, 2 %}                     | `string`  | {% include fields/id.md resource="transaction" %}                                                                                                                                                 |
| {% f created, 2 %}                | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| {% f updated, 2 %}                | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| {% f type, 2 %}                   | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| {% f state, 2 %}                  | `string`  |{% include fields/state.md %}    |
| {% f number, 2 %}                 | `integer` | {% include fields/number.md %} |
| {% f amount, 2 %}                 | `integer` | {% include fields/amount.md %}                                                                                                                                                                    |
| {% f vatAmount, 2 %}              | `integer` | {% include fields/vat-amount.md %}                                                                                                                                                                 |
| {% f description, 2 %}            | `string`  | {% include fields/description.md %}                                                                                                                   |
| {% f payeeReference, 2 %}         | `string(30)`  | {% include fields/payee-reference.md describe_receipt=true %}                                                                                         |
| {% f receiptReference, 2 %}       | `string`  | {% include fields/receipt-reference.md %}                                                                                                                 |
| {% f failedReason, 2 %}           | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                    |
| {% f isOperational, 2 %}          | `bool`    | `true` if the transaction is operational; otherwise `false`.                                                                                                                                                 |
| {% f operations, 2 %}             | `array`   | {% include fields/operations.md resource="transaction" %}                                                                                                  |
{% endcapture %}
{% include accordion-table.html content=table %}
