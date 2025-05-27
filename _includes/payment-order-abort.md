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

{% capture request_header %}PATCH /psp/paymentorders/{{ page.payment_order_id }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
{
  "paymentorder": {
    "operation": "Abort",
    "abortReason": "CancelledByConsumer"
  }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

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

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
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
        ], {% if documentation_section contains "old-implementations/enterprise" %}
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
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

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
| {% f availableInstruments %}         | `string`     | A list of payment methods available for this payment.                                                                                                                                                   |
| {% f implementation %}               | `string`     | {% include fields/implementation.md %}                                                                                                                                                  |
| {% f integration %}                  | `string`     | The merchant's Online Payments integration type. `HostedView` (Seamless View) or `Redirect`. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe.                                                                                                                               |
| {% f instrumentMode %}               | `bool`       | Set to `true` or `false`. Indicates if the payment is initialized with only one payment method available.                                                                                    |
| {% f guestMode %}                    | `bool`       | {% include fields/guest-mode.md %}                                                                                                                                                |
| {% f orderItems %}                   | `string`     | {% include fields/order-items.md %}                                                                                                                            |
| {% f urls %}                         | `string`     | The URL to the `urls` resource where information about the urls can be retrieved.                                                                                                                            |
| {% f payeeInfo %}                    | `id`     | {% include fields/payee-info.md %}                                                                                                                            |
| {% f payer %}                        | `id`     | {% include fields/payer.md %}                                                                                                                 |
| {% f history %}                      | `id`     | {% include fields/history.md %}                                                                                                                            |
| {% f failed %}                       | `id`     | {% include fields/failed.md %}                                                                                                                           |
| {% f aborted %}                      | `id`     | {% include fields/aborted.md %}                                                                                                                            |
| {% f paid %}                         | `id`     | {% include fields/paid.md %}                                                                                                                            |
| {% f cancelled %}                    | `id`     | {% include fields/cancelled.md %}                                                                                                                            |
| {% f financialTransactions %}        | `id`     | {% include fields/financial-transactions.md %}                                                                                                                            |
| {% f failedAttempts %}               | `id`     | {% include fields/failed-attempts.md %}                                                                                                                             |
| {% f metadata %}                     | `id`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| {% f operations %}                   | `array`      | {% include fields/operations.md %} [See Operations for details]({{ features_url }}/technical-reference/operations).                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

{% else %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=2.0
api-supported-versions: 2.0{% endcapture %}

{% capture response_content %}{
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
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% endif %}

## Abort Payment Attempt

{% if documentation_section contains "checkout-v3" %}

The `abort-paymentattempt` operation should be used when you want to abort a
payment _attempt_, but not the whole payment order. It is returned in the
payment order response, but is only available for Online Payments v3.x. Include
the following in the request body when perfoming it:

## Abort Payment Attempt PATCH Request

{% capture request_header %}PATCH /psp/paymentorders/{{ page.payment_order_id }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x{% endcapture %}

{% capture request_content %}{
{
  "paymentorder": {
    "operation": "PaymentAttemptAborted",
    "abortReason": "AbortedByUI"
  }
}{% endcapture %}

{% include code-example.html
    title='Abort Payment Attempt PATCH Request'
    header=request_header
    json= request_content
    %}

## Abort Payment Attempt PATCH Response

The response after doing this `PATCH` will appear as an initial payment order
response, since the payment order is still active and re-attempts are possible.

To see traces of the aborted payment attempt, you need to perform the `PATCH`
with `history` expanded. It will appear as shown below.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
    "paymentOrder": {
        "id": "/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72",
        "created": "2024-12-05T14:19:17.1687855Z",
        "updated": "2024-12-05T14:20:34.3940075Z",
        "operation": "Purchase",
        "status": "Initialized",
        "currency": "SEK",
        "amount": 15572,
        "vatAmount": 0,
        "description": "Abort Payment Attempt Example",
        "initiatingSystemUserAgent": "PostmanRuntime/7.43.0",
        "language": "sv-SE",
        "availableInstruments": [
            "CreditCard",
            "Invoice-PayExFinancingSe",
            "CarPay",
            "Swish",
            "CreditAccount-CreditAccountSe",
            "Trustly",
            "MobilePay"
        ],
        "viewableInstruments": [
            "Swish"
        ],
        "implementation": "PaymentsOnly",
        "integration": "Redirect",
        "instrumentMode": false,
        "guestMode": true,
        "urls": {
            "id": "/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72/payeeinfo"
        },
        "payer": {
            "id": "/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72/payers"
        },
        "history": {
            "id": "/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72/history",
            "historyList": [
                {
                    "created": "2024-12-05T14:19:17.1687855Z",
                    "name": "PaymentCreated",
                    "initiatedBy": "Merchant"
                },
                {
                    "created": "2024-12-05T14:19:17.1687855Z",
                    "name": "PaymentInstrumentSet",
                    "instrument": "Swish",
                    "initiatedBy": "Merchant"
                },
                {
                    "created": "2024-12-05T14:19:26.5750791Z",
                    "name": "PaymentLoaded",
                    "initiatedBy": "System"
                },
                {
                    "created": "2024-12-05T14:19:37.7938659Z",
                    "name": "PaymentAttemptStarted",
                    "instrument": "Swish",
                    "prefill": false,
                    "initiatedBy": "Payer"
                },
                {
                    "created": "2024-12-05T14:20:34.3879102Z",
                    "name": "PaymentAttemptAborted",
                    "instrument": "Swish",
                    "initiatedBy": "Payer"
                }
            ]
        },
        "failed": {
            "id": "/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72/paid"
        },
        "cancelled": {
            "id": "/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72/cancelled"
        },
        "reversed": {
            "id": "/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72/reversed"
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72/financialtransactions"
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72/failedattempts",
            "failedAttemptList": []
        },
        "postPurchaseFailedAttempts": {
            "id": "/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72/postpurchasefailedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72/metadata"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.stage.payex.com/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72",
            "rel": "update-order",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "https://api.stage.payex.com/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72",
            "rel": "abort",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "https://api.stage.payex.com/psp/paymentorders/c37b8e5f-65a0-4a19-351b-08dd143bbe72",
            "rel": "set-instrument",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.stage.payex.com/checkout/ecf2299debe471b2ade9df0e47e997dd590a7da62de1af4b5f71fc935227e996?_tc_tid=e8653437c60e410ca3fd3150395b1156",
            "rel": "redirect-checkout",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.stage.payex.com/checkout/client/ecf2299debe471b2ade9df0e47e997dd590a7da62de1af4b5f71fc935227e996?culture=sv-SE&_tc_tid=e8653437c60e410ca3fd3150395b1156",
            "rel": "view-checkout",
            "contentType": "application/javascript"
        },
        {
            "method": "GET",
            "href": "https://api.stage.payex.com/psp/paymentsessions/ecf2299debe471b2ade9df0e47e997dd590a7da62de1af4b5f71fc935227e996?_tc_tid=e8653437c60e410ca3fd3150395b1156",
            "rel": "view-paymentsession",
            "contentType": "application/json"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Abort Payment Attempt Response'
    header=response_header
    json= response_content
    %}

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
| {% f availableInstruments %}         | `string`     | A list of payment methods available for this payment.                                                                                                                                                   |
| {% f viewableInstruments %}         | `string`     | A list of payment methods with viewable details for this payment.                                                                                                                                                   |
| {% f implementation %}               | `string`     | {% include fields/implementation.md %}                                                                                                                                                  |
| {% f integration %}                  | `string`     | The merchant's Online Payments integration type. `HostedView` (Seamless View) or `Redirect`. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe.                                                                                                                               |
| {% f instrumentMode %}               | `bool`       | Set to `true` or `false`. Indicates if the payment is initialized with only one payment method available.                                                                                    |
| {% f guestMode %}                    | `bool`       | {% include fields/guest-mode.md %}                                                                                                                                                |
| {% f orderItems %}                   | `string`     | {% include fields/order-items.md %}                                                                                                                            |
| {% f urls %}                         | `string`     | The URL to the `urls` resource where information about the urls can be retrieved.                                                                                                                            |
| {% f payeeInfo %}                    | `id`     | {% include fields/payee-info.md %}                                                                                                                            |
| {% f payer %}                        | `id`     | {% include fields/payer.md %}                                                                                                                 |
| {% f history %}                      | `id`     | {% include fields/history.md %}                                                                                                                            |
| {% f failed %}                       | `id`     | {% include fields/failed.md %}                                                                                                                           |
| {% f aborted %}                      | `id`     | {% include fields/aborted.md %}                                                                                                                            |
| {% f paid %}                         | `id`     | {% include fields/paid.md %}                                                                                                                            |
| {% f cancelled %}                    | `id`     | {% include fields/cancelled.md %}                                                                                                                            |
| {% f financialTransactions %}        | `id`     | {% include fields/financial-transactions.md %}                                                                                                                            |
| {% f failedAttempts %}               | `id`     | {% include fields/failed-attempts.md %}                                                                                                                             |
| {% f metadata %}                     | `id`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| {% f operations %}                   | `array`      | {% include fields/operations.md %} [See Operations for details]({{ features_url }}/technical-reference/operations).                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

{% endif %}
