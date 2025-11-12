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
{{ product }}. The payment order is a container for the payment method
object selected by the payer. This will generate a payment that is accessed
through the sub-resources `payments` and `currentPayment`.

## GET Payment Order Request

{% capture request_content %}GET /psp/paymentorders/{{ page.payment_order_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

## GET Payment Order Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

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
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture id_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture operation_md %}{% include fields/operation.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture description_md %}{% include fields/description.md %}{% endcapture %}
{% capture user_agent_md %}{% include fields/user-agent.md %}{% endcapture %}
{% capture language_md %}{% include fields/language.md %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0 (root; node closed by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <!-- Children of paymentOrder (Level 1) -->
    <div class="api-children">

      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      <!-- created -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO-8601 date of when the payment order was created.</div></div>
      </details>

      <!-- updated -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO-8601 date of when the payment order was updated.</div></div>
      </details>

      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }}</div></div>
      </details>

      <!-- state -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f state %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Ready</code>, <code>Pending</code>, <code>Failed</code> or <code>Aborted</code>. Indicates the state of the payment order. Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes.</div></div>
      </details>

      <!-- currency -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment order in the ISO 4217 format (e.g. `EUR`, `DKK`, `NOK` or `SEK`). Some payment methods are only available with selected currencies.</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <!-- userAgent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ user_agent_md | markdownify }}</div></div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <!-- paymentToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paymentToken %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The payment token created for the purchase used in the authorization to create One-Click Payments.</div></div>
      </details>

      <!-- recurrenceToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f recurrenceToken %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The created recurrenceToken, if <code>operation: Verify</code>, <code>operation: Recur</code> or <code>generateRecurrenceToken: true</code> was used.</div></div>
      </details>

      <!-- unscheduledToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f unscheduledToken %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The generated unscheduledToken, if <code>operation: Verify</code>, <code>operation: UnscheduledPurchase</code> or <code>generateUnscheduledToken: true</code> was used.</div></div>
      </details>

      <!-- transactionOnFileToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f transactionOnFileToken %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The created transactionOnFileToken, if <code>operation: Verify</code> and <code>generateTransactionOnFileToken: true</code> was used.</div></div>
      </details>

      <!-- nonPaymentToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f nonPaymentToken %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The result of our own card tokenization. Activated in POS for the merchant or merchant group.</div></div>
      </details>

      <!-- externalNonPaymentToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f externalNonPaymentToken %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, transactions redeemed by Visa will be populated with PAR. For Mastercard and Amex, it will be our own token.</div></div>
      </details>

      <!-- urls (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>urls</code> resource where all URLs related to the payment order can be retrieved.</div></div>
      </details>

      <!-- payeeInfo (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payeeInfo</code> resource where information related to the payee can be retrieved.</div></div>
      </details>

      <!-- payers (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payers %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payer</code> resource where information about the payer can be retrieved.</div></div>
      </details>

      <!-- orderItems (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>orderItems</code> resource where information about the order items can be retrieved.</div></div>
      </details>

      <!-- metadata (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payments</code> resource where information about all underlying payments can be retrieved.</div></div>
      </details>

      <!-- payments (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payments %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payments</code> resource where information about all underlying payments can be retrieved.</div></div>
      </details>

      <!-- currentPayment (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currentPayment %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>currentPayment</code> resource where information about the current – and sole active – payment can be retrieved.</div></div>
      </details>

    </div><!-- /.api-children -->
  </details>

  <!-- operations (array; sibling of root) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>array</code></span>
    </summary>
    <div class="desc"><div class="indent-0">{{ operations_md | markdownify }}</div></div>
  </details>
</div>

-----------------------------------------
[payment-menu]: /old-implementations/payment-menu-v2
[checkout]: /{{ documentation_section }}
