{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}

## Abort

{% if documentation_section contains "checkout-v3" %}

To abort a payment order, perform the `abort` operation that is returned in the
payment order response. You need to include the following in the request body:

{% else %}

To abort a payment order, perform the `update-paymentorder-abort` operation that
is returned in the payment order response. You need to include the following
in the request body:

{% endif %}

## Abort PATCH Request

{:.code-view-header}
**Request**

```http
PATCH /psp/paymentorders/{{ page.payment_order_id }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Abort",
    "abortReason": "CancelledByConsumer"
  }
}
```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                                                                                                                                                                                                 |
| {% f operation %}      | `string`     | `Abort`                                                                                                                                                                                                                |
| {% f abortReason %}      | `string`     | `CancelledByConsumer` or `CancelledByCustomer`. Why the payment was aborted.                                                                                                                                                                         |

## Abort PATCH Response

{% if documentation_section contains "checkout-v3" %}

The response given when aborting a payment order is equivalent to a `GET`
request towards the `paymentorders` resource, as displayed above, with its
`status` set to `Aborted`.

{% else %}

The response given when aborting a payment order is equivalent to a `GET`
request towards the `paymentorders` resource, as displayed above, with its
`state` set to `Aborted`.

{% endif %}

{% if documentation_section contains "checkout-v3" %}

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentOrder": {
        "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd",
        "created": "2022-01-24T10:54:05.6243371Z",
        "updated": "2022-01-24T10:54:19.2679591Z",
        "operation": "Purchase",
        "status": "Aborted",
        "currency": "SEK",
        "amount": 32000,
        "vatAmount": 0,
        "description": "Abort test",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [
            "CreditCard",
            "Invoice-PayExFinancingSe",
            "Invoice-PayMonthlyInvoiceSe",
            "Swish",
            "CreditAccount",
            "Trustly"
        ], {% if documentation_section contains "checkout-v3/enterprise" %}
        "implementation": "Enterprise", {% endif %} {% if documentation_section contains "checkout-v3/payments-only" %}
        "implementation": "PaymentsOnly", {% endif %} {% if include.integration_mode=="seamless-view" %}
        "integration": "HostedView", {% endif %} {% if include.integration_mode=="redirect" %}
        "integration": "Redirect", {% endif %}
        "instrumentMode": false,
        "guestMode": false,
        "orderItems": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/orderitems"
        },
        "urls": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/payeeinfo"
        },
        "payer": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/payers"
        },
        "history": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/history"
        },
        "failed": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/paid"
        },
        "cancelled": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/cancelled"
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/financialtransactions"
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/failedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/metadata"
        }
    },
    "operations": [ {% if include.integration_mode=="redirect" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "redirect-checkout",
          "contentType": "text/html"
        }{% endif %} {% if include.integration_mode=="seamless-view" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "view-checkout",
          "contentType": "application/javascript"
        }{% endif %}
    ]
}
```

{% capture table %}
{:.table .table-striped .mb-5}
| Field                                  | Type         | Description                                                                                                                                                                                                               |
| :------------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f paymentOrder, 0 %}                         | `object`     | The payment order object.                                                                                                                                                                                                 |
| {% f id %}                           | `string`     | {% include fields/id.md resource="paymentorder" %}                                                                                                                                                             |
| {% f created %}                      | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| {% f updated %}                      | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| {% f operation %}                    | `string`     | `Purchase`                                                                                                                                                                                                                |
| {% f status %}                       | `string`     | `Initialized`, `Paid`, `Failed`, `Cancelled` or `Aborted`. Indicates the state of the payment order. |
| {% f currency %}                     | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| {% f amount %}                       | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                 |
| {% f vatAmount %}                    | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                              |
| {% f description %}                  | `string(40)` | {% include fields/description.md %}                                                                                                                        |
| {% f initiatingSystemUserAgent %}    | `string`     | {% include fields/initiating-system-user-agent.md %}                                                                                                                                                          |
| {% f language %}                     | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f availableInstruments %}         | `string`     | A list of instruments available for this payment.                                                                                                                                                   |
| {% f implementation %}               | `string`     | {% include fields/implementation.md %}                                                                                                                                                  |
| {% f integration %}                  | `string`     | The merchant's Checkout v3 integration type. `HostedView` (Seamless View) or `Redirect`.                                                                                                                                                  |
| {% f instrumentMode %}               | `bool`       | Set to `true` or `false`. Indicates if the payment is initialized with only one payment instrument available.                                                                                    |
| {% f guestMode %}                    | `bool`       | {% include fields/guest-mode.md %}                                                                                                                                                |
| {% f orderItems %}                   | `string`     | {% include fields/order-items.md %}                                                                                                                            |
| {% f urls %}                         | `string`     | The URL to the `urls` resource where information about the urls can be retrieved.                                                                                                                            |
| {% f payeeInfo %}                    | `string`     | {% include fields/payee-info.md %}                                                                                                                            |
| {% f payer %}                        | `string`     | {% include fields/payer.md %}                                                                                                                 |
| {% f history %}                      | `string`     | {% include fields/history.md %}                                                                                                                            |
| {% f failed %}                       | `string`     | {% include fields/failed.md %}                                                                                                                           |
| {% f aborted %}                      | `string`     | {% include fields/aborted.md %}                                                                                                                            |
| {% f paid %}                         | `string`     | {% include fields/paid.md %}                                                                                                                            |
| {% f cancelled %}                    | `string`     | {% include fields/cancelled.md %}                                                                                                                            |
| {% f financialTransactions %}        | `string`     | {% include fields/financial-transactions.md %}                                                                                                                            |
| {% f failedAttempts %}               | `string`     | {% include fields/failed-attempts.md %}                                                                                                                             |
| {% f metadata %}                     | `string`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| {% f operations %}                   | `array`      | {% include fields/operations.md %} [See Operations for details]({{ features_url }}/technical-reference/operations).                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

{% else %}

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
            "href": "{{ page.api_url }}/psp/{{ api.resource }}/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/{{ api.resource }}/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/{{ api.resource }}/core/scripts/client/px.paymentmenu.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
        }
    ]
}
```

{% endif %}
