{% capture documentation_section %}{%- include documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include documentation-section-url.md href='/features' %}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}

## Automated Fuel Dispenser Payments

{% include alert-agreement-required.md %}

An Automated Fuel Dispenser (AFD) payment is a purchase where the user
requests an authorization transaction for an automatic fuel dispenser. The
request contains the maximum purchase amount, but the issuer can reply with a
partial approval to lower the maximum purchase amount. This can be used to stop
the fuel dispension at the maximum price.

The only supported use case is automated fuel dispensers. To be able to verify
this, it is required that the Merchant Category Code `mcc` is passed in the
request under `PayeeInfo`. This feature is only supported with the `Purchase`
operation. It does not support with [order items][order-items].

By default the available instruments and card types will be limited to those
which support AFD payments. To enable other payment options for the payer, pass
in `restrictedToAfdInstruments` with the value `false`.

See the abbreviated example below on how to implement AFD payments by setting
the `generateAfdPayment` to `true`.

{:.code-view-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 10000,
        "vatAmount": 2500,
        "generateAfdPayment": true,
        "restrictedToAfdInstruments": true,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "productName": "Checkout3",
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ], {% if include.integration_mode=="seamless-view" %}
            "paymentUrl": "https://example.com/perform-payment", {% endif %}
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditions.pdf"{% if include.integration_mode=="redirect" %},
            "logoUrl": "https://example.com/logo.png" {% endif %}
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456",
            "mcc": 5542
        },
        "orderItems": null
    }
}
```

Request fields not covered in the common Checkout v3 [`Initialized`]({{
features_url }}/technical-reference/status-models#initialized) redirect or
seamless view table:

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| └➔&nbsp;`generateAfdPayment`     | `bool`      | Set to `true` if the payment order is an AFD payment, `false` if not. |
| └➔&nbsp;`restrictedToAfdInstruments`     | `bool`      | Set to `true` if the payment menu should show only payment options that support AFD, `false` to show all options. Default is true when using `generateAfdPayment`. |
| └➔&nbsp;`payeeInfo`                | `string`     | {% include field-description-payeeinfo.md %}                                                                                                                                                                                                                                                             |
| └─➔&nbsp;`mcc`     | `integer`      | The merchant category code used for the purchase, 4 digits. |

{% if include.integration_mode=="redirect" %}

To authorize the payment, find the operation with `rel` equal to
`redirect-checkout` in the response, and redirect the merchant employee to the
provided `href` to fill out the payer’s card details. You will find an example
of the response provided below.

{% endif %}

{% if include.integration_mode=="seamless-view" %}

To authorize the payment, find the operation with `rel` equal to `view-checkout`
in the response, and display the the provided `href` to the merchant's employee
so they can fill out the payer’s card details. You will find an example of the
response provided below.

{% endif %}

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",
        "created": "2020-06-22T10:56:56.2927632Z",
        "updated": "2020-06-22T10:56:56.4035291Z",
        "operation": "Purchase",
        "status": "Initialized",
        "currency": "SEK",
        "amount": 10000,
        "vatAmount": 2500,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [ "CreditCard" ],
        "implementation": "PaymentsOnly", { {% if include.integration_mode=="seamless-view" %}
        "integration": "Seamless View", {% endif %} { {% if include.integration_mode=="redirect" %}
        "integration": "Redirect", {% endif %}
        "instrumentMode": false,
        "guestMode": false,
        "orderItems": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/orderitems"
        },
        "urls": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/payeeinfo"
        },
        "payer": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/payers"
        },
        "history": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/history"
        },
        "failed": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/failed"
        },
        "aborted": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/aborted"
        },
        "paid": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/paid"
        },
        "cancelled": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/cancelled"
        },
        "financialTransactions": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/financialtransactions"
        },
        "failedAttempts": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/failedattempts"
        },
        "metadata": {
            "id": "/psp/paymentorders/08090909-626e-4b90-1943-08d9eaebca86/metadata"
        }
    },
      "operations": [ {% if include.integration_mode=="redirect" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}",
          "rel": "redirect-checkout",
          "contentType": "text/html"
        },{% endif %} {% if include.integration_mode=="seamless-view" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO",
          "rel": "view-checkout",
          "contentType": "application/javascript"
        },{% endif %}
        {
          "href": "https://api.payex.com/psp/paymentorders/222a50ca-b268-4b32-16fa-08d6d3b73224",
          "rel":"update-order",
          "method":"PATCH",
          "contentType":"application/json"
        },
        {
          "href": "https://api.payex.com/psp/paymentorders/222a50ca-b268-4b32-16fa-08d6d3b73224",
          "rel": "abort",
          "method": "PATCH",
          "contentType": "application/json"
        }
       ]
      }
```

## When The Authorization Is Completed

The authorized amount might be a lower value than the requested amount, known as
partial approval. In this case, the original submitted amount might be found by
requesting `rel:paid-paymentorder` and checking the field `submittedAmount`.
Then the `amount` and `vatAmount` will contain the value that is authorized. The
final amount to be paid must be passed in the capture request, and if the
authorized amount is larger than the final amount the rest should be cancelled.

[order-items]: /checkout-v3/payments-only/features/technical-reference/order-items
