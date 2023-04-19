{%- capture documentation_section -%}{%- include utils/documentation-section.md -%}{%- endcapture -%}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}

{% capture product %}
    {% if documentation_section contains "payment-menu" %}
        [Payment Menu v2][payment-menu]
    {% else %}
        [Swedbank Pay Checkout][checkout]
    {% endif %}
{% endcapture %}
{% assign product = product | strip %}

The `paymentorders` resource is used when initiating a payment process through
{{ product }}. The payment order is a container for the payment instrument
object selected by the payer. This will generate a payment that is accessed
through the sub-resources `payments` and `currentPayment`.

## GET Payment Order Request

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/{{ page.payment_order_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

## GET Payment Order Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",
        "created": "2018-09-14T13:21:29.3182115Z",
        "updated": "2018-09-14T13:21:57.6627579Z",
        "operation": "Purchase",
        "state": "Ready",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 0,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "paymentToken": "12345678-1234-1234-1234-123456789010",
        "recurrenceToken": "12345678-1234-1234-1234-123456789011",
        "unscheduledToken": "12345678-1234-1234-1234-123456789012",
        "transactionsOnFileToken": "12345678-1234-1234-1234-123456789013",
        "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
        "externalNonPaymentToken": "1234567890",
        "urls" : { "id": "/psp/paymentorders/{{ page.payment_order_id }}/urls" },
        "payeeInfo" : { "id": "/psp/paymentorders/{{ page.payment_order_id }}/payeeinfo" },
        "payers": { "id": "/psp/paymentorders/{{ page.payment_order_id }}/payers" },
        "orderItems" : { "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderItems" },
        "metadata": { "id": "/psp/paymentorders/{{ page.payment_order_id }}/metadata" },
        "payments": { "id": "/psp/paymentorders/{{ page.payment_order_id }}/payments" },
        "currentPayment": { "id": "/psp/paymentorders/{{ page.payment_order_id }}/currentpayment" }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/paymentmenu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
        }
    ]
}
```

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                                                                                                                                                                                                 |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}                                                                                                                                                             |
| {% f created %}        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| {% f updated %}        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| {% f operation %}      | `string`     | `Purchase`                                                                                                                                                                                                                |
| {% f state %}          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment order. Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes. |
| {% f currency %}       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| {% f amount %}         | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                 |
| {% f vatAmount %}      | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                              |
| {% f description %}    | `string(40)` | {% include fields/description.md %}                                                                                                                        |
| {% f userAgent %}      | `string`     | {% include fields/user-agent.md %}                                                                                                                        |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f paymentToken %}   | `string`     | The payment token created for the purchase used in the authorization to create One-Click Payments.                                                          |
| {% f recurrenceToken %}      | `string`     | The created recurrenceToken, if `operation: Verify`, `operation: Recur` or `generateRecurrenceToken: true` was used.                                                                                                                                                                  |
| {% f unscheduledToken %}     | `string`     | The generated unscheduledToken, if `operation: Verify`, `operation: UnscheduledPurchase` or `generateUnscheduledToken: true` was used.                                                                                                                                                                  |
| {% f transactionOnFileToken %}     | `string`     | The created transactionOnFileToken, if `operation: Verify` and `generateTransactionOnFileToken: true` was used.                                                                                                                                                                  |
| {% f nonPaymentToken %}         | `string`     | The result of our own card tokenization. Activated in POS for the merchant or merchant group.                                                                                                                                                                                                     |
| {% f externalNonPaymentToken %} | `string`     | The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, transactions redeemed by Visa will be populated with PAR. For Mastercard and Amex, it will be our own token. |
| {% f urls %}           | `string`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                              |
| {% f payeeInfo %}      | `string`     | {% include fields/payee-info.md %}                                                                                                          |
| {% f payers %}         | `string`     | The URL to the `payer` resource where information about the payer can be retrieved.                                                                                                                |
| {% f orderItems %}     | `string`     | {% include fields/metadata.md %}                                                                                                                            |
| {% f metadata %}       | `string`     | The URL to the `payments` resource where information about all underlying payments can be retrieved.                                                                                                                      |
| {% f payments %}       | `string`     | The URL to the `payments` resource where information about all underlying payments can be retrieved.                                                                                                                      |
| {% f currentPayment %} | `string`     | The URL to the `currentPayment` resource where information about the current – and sole active – payment can be retrieved.                                                                                                |
| {% f operations %}     | `array`      | {% include fields/operations.md %}                                                                                             |
{% endcapture %}
{% include accordion-table.html content=table %}

-----------------------------------------
[payment-menu]: /old-implementations/payment-menu-v2
[checkout]: /{{ documentation_section }}
