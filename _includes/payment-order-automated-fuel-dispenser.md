<!-- Captures for tables -->
{% capture payee_info_desc %}{% include fields/payee-info.md %}{% endcapture %}
<!-- Captures for tables -->

{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% capture techref_url %}{% include utils/documentation-section-url.md %}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{% assign implementation = documentation_section | split: "/"  | last | capitalize | remove: "-" %}

## Automated Fuel Dispenser Payments

{% include alert-agreement-required.md %}

An Automated Fuel Dispenser payment is a purchase where the merchant
requests an authorization transaction for an automatic fuel dispenser. The
request contains the maximum purchase amount, but the issuer can reply with a
partial approval to lower the maximum purchase amount. This can be used to stop
the fuel dispension at the maximum price.

The only supported use case is automated fuel dispensers. To be able to verify
this, it is required that the Merchant Category Code `mcc` is passed in the
request under `PayeeInfo`. This feature is only supported with the `Purchase`
operation. It does not support [order items][order-items].

By default the available payment methods and card types will be limited to those
which support Automated Fuel Dispenser payments. To enable other payment options
for the payer, send in `restrictedToAfdInstruments` with the value `false`.

See the abbreviated example below on how to implement Automated Fuel Dispenser
payments by setting the `generateAfdPayment` to `true`.

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=<PaymentOrderVersion>{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "generateAfdPayment": true,
        "restrictedToAfdInstruments": true,
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 10000,
        "vatAmount": 2500,
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
            "mcc": 5542,
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456"
        },
        "orderItems": null
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

Request fields not covered in the common Online Payments [`Initialized`]({{
techref_url }}/technical-reference/status-models#initialized) redirect or
seamless view table:

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">The paymentOrder object.</div>
    </div>

    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f generateAfdPayment %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Set to <code>true</code> if the payment order is an Automated Fuel Dispenser payment, <code>false</code> if not.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f restrictedToAfdInstruments %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Set to <code>true</code> if the payment menu should show only payment options that support Automated Fuel Dispenser payments, <code>false</code> to show all options. Default is true when using <code>generateAfdPayment</code>.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            {{ payee_info_desc | markdownify }}
          </div>
        </div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f mcc, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                The merchant category code used for the purchase, 4 digits.
              </div>
            </div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

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

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=<PaymentOrderVersion>
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
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
        "implementation": "PaymentsOnly", {% if include.integration_mode=="seamless-view" %}
        "integration": "Seamless View", {% endif %} {% if include.integration_mode=="redirect" %}
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
        }{% if documentation_section contains "checkout-v3" %},
        {
          "href": "https://api.payex.com/psp/paymentorders/{{ page.payment_order_id }}",
          "rel": "abort-paymentattempt",
          "method": "PATCH",
          "contentType": "application/json"
        }{% endif %}
       ]
      }{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

## When The Authorization Is Completed

The authorized amount might be a lower value than the requested amount, known as
partial approval. In this case, the original submitted amount might be found by
requesting `rel:paid-paymentorder` and checking the field `submittedAmount`.
Then the `amount` and `vatAmount` will contain the value that is authorized. The
final amount to be paid must be passed in the capture request, and if the
authorized amount is larger than the final amount the rest should be cancelled.

[order-items]: /checkout-v3/features/optional/order-items
