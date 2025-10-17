{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% capture techref_url %}{% include utils/documentation-section-url.md %}{% endcapture %}
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

{%- capture operation_md -%}{% include fields/operation.md %}{%- endcapture -%}

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0 (root; node closed by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <!-- Children of paymentOrder (Level 1) -->
    <div class="api-children">

      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            {{ operation_md | markdownify }}
            For this request it must be <code>Abort</code>.
          </div>
        </div>
      </details>

      <!-- abortReason -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f abortReason %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1"><code>CancelledByConsumer</code> or <code>CancelledByCustomer</code>. Why the payment was aborted.</div>
        </div>
      </details>

    </div>
  </details>
</div>

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

{%- capture id_md -%}{% include fields/id.md resource="paymentorder" %}{%- endcapture -%}
{%- capture operation_md -%}{% include fields/operation.md %}{%- endcapture -%}
{%- capture amount_md -%}{% include fields/amount.md %}{%- endcapture -%}
{%- capture vat_amount_md -%}{% include fields/vat-amount.md %}{%- endcapture -%}
{%- capture description_md -%}{% include fields/description.md %}{%- endcapture -%}
{%- capture isu_md -%}{% include fields/initiating-system-user-agent.md %}{%- endcapture -%}
{%- capture language_md -%}{% include fields/language.md %}{%- endcapture -%}
{%- capture implementation_md -%}{% include fields/implementation.md %}{%- endcapture -%}
{%- capture payee_info_md -%}{% include fields/payee-info.md %}{%- endcapture -%}
{%- capture payer_md -%}{% include fields/payer.md %}{%- endcapture -%}
{%- capture history_md -%}{% include fields/history.md %}{%- endcapture -%}
{%- capture failed_md -%}{% include fields/failed.md %}{%- endcapture -%}
{%- capture aborted_md -%}{% include fields/aborted.md %}{%- endcapture -%}
{%- capture paid_md -%}{% include fields/paid.md %}{%- endcapture -%}
{%- capture cancelled_md -%}{% include fields/cancelled.md %}{%- endcapture -%}
{%- capture fin_tx_md -%}{% include fields/financial-transactions.md %}{%- endcapture -%}
{%- capture failed_attempts_md -%}{% include fields/failed-attempts.md %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0 (root; node closed by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <!-- Children of paymentOrder (Level 1) -->
    <div class="api-children">

      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      <!-- created -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO-8601 date of when the payment order was created.</div></div>
      </details>

      <!-- updated -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO-8601 date of when the payment order was updated.</div></div>
      </details>

      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            {{ operation_md | markdownify }}
            It will match the operation set in the request, in this case <code>Purchase</code>.
          </div>
        </div>
      </details>

      <!-- status -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f status %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Initialized</code>, <code>Paid</code>, <code>Failed</code>, <code>Cancelled</code> or <code>Aborted</code>. Indicates the state of the payment order.</div></div>
      </details>

      <!-- currency -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment order.</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <!-- initiatingSystemUserAgent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f initiatingSystemUserAgent %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ isu_md | markdownify }}</div></div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <!-- availableInstruments -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f availableInstruments %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of payment methods available for this payment.</div></div>
      </details>

      <!-- implementation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ implementation_md | markdownify }}</div></div>
      </details>

      <!-- integration -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integration %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments integration type. <code>HostedView</code> (Seamless View) or <code>Redirect</code>. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe.</div></div>
      </details>

      <!-- instrumentMode -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrumentMode %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payment is initialized with only one payment method available.</div></div>
      </details>

      <!-- guestMode -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f guestMode %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/guest-mode.md %}</div></div>
      </details>

      <!-- orderItems (link id as string) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/order-items.md %}</div></div>
      </details>

      <!-- urls -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>urls</code> resource where information about the urls can be retrieved.</div></div>
      </details>

      <!-- payeeInfo (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payee_info_md | markdownify }}</div></div>
      </details>

      <!-- payer (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payer_md | markdownify }}</div></div>
      </details>

      <!-- history (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f history %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ history_md | markdownify }}</div></div>
      </details>

      <!-- failed (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failed %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ failed_md | markdownify }}</div></div>
      </details>

      <!-- aborted (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f aborted %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ aborted_md | markdownify }}</div></div>
      </details>

      <!-- paid (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paid %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ paid_md | markdownify }}</div></div>
      </details>

      <!-- cancelled (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cancelled %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ cancelled_md | markdownify }}</div></div>
      </details>

      <!-- financialTransactions (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f financialTransactions %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ fin_tx_md | markdownify }}</div></div>
      </details>

      <!-- failedAttempts (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failedAttempts %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ failed_attempts_md | markdownify }}</div></div>
      </details>

      <!-- metadata (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>metadata</code> resource where information about the metadata can be retrieved.</div></div>
      </details>

    </div>
  </details>
  <!-- operations (array) -->
  <details class="api-item" data-level="0">
      <summary>
          <span class="field">{% f operations,0 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>array</code></span>
      </summary>
      <div class="desc"><div class="indent-0">{% include fields/operations.md %} <a href="{{ features_url }}/technical-reference/operations">See Operations for details</a>.</div></div>
  </details>
</div>

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

{%- capture id_md -%}{% include fields/id.md resource="paymentorder" %}{%- endcapture -%}
{%- capture operation_md -%}{% include fields/operation.md %}{%- endcapture -%}
{%- capture amount_md -%}{% include fields/amount.md %}{%- endcapture -%}
{%- capture vat_amount_md -%}{% include fields/vat-amount.md %}{%- endcapture -%}
{%- capture description_md -%}{% include fields/description.md %}{%- endcapture -%}
{%- capture isu_md -%}{% include fields/initiating-system-user-agent.md %}{%- endcapture -%}
{%- capture language_md -%}{% include fields/language.md %}{%- endcapture -%}
{%- capture implementation_md -%}{% include fields/implementation.md %}{%- endcapture -%}
{%- capture order_items_md -%}{% include fields/order-items.md %}{%- endcapture -%}
{%- capture payee_info_md -%}{% include fields/payee-info.md %}{%- endcapture -%}
{%- capture payer_md -%}{% include fields/payer.md %}{%- endcapture -%}
{%- capture history_md -%}{% include fields/history.md %}{%- endcapture -%}
{%- capture failed_md -%}{% include fields/failed.md %}{%- endcapture -%}
{%- capture aborted_md -%}{% include fields/aborted.md %}{%- endcapture -%}
{%- capture paid_md -%}{% include fields/paid.md %}{%- endcapture -%}
{%- capture cancelled_md -%}{% include fields/cancelled.md %}{%- endcapture -%}
{%- capture fin_tx_md -%}{% include fields/financial-transactions.md %}{%- endcapture -%}
{%- capture failed_attempts_md -%}{% include fields/failed-attempts.md %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0 (root; node closed by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <!-- Children of paymentOrder (Level 1) -->
    <div class="api-children">

      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      <!-- created -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO-8601 date of when the payment order was created.</div></div>
      </details>

      <!-- updated -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO-8601 date of when the payment order was updated.</div></div>
      </details>

      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }}</div></div>
      </details>

      <!-- status -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f status %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Initialized</code>, <code>Paid</code>, <code>Failed</code>, <code>Cancelled</code> or <code>Aborted</code>. Indicates the state of the payment order.</div></div>
      </details>

      <!-- currency -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment order.</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <!-- initiatingSystemUserAgent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f initiatingSystemUserAgent %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ isu_md | markdownify }}</div></div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <!-- availableInstruments -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f availableInstruments %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of payment methods available for this payment.</div></div>
      </details>

      <!-- viewableInstruments -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f viewableInstruments %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of payment methods with viewable details for this payment.</div></div>
      </details>

      <!-- implementation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ implementation_md | markdownify }}</div></div>
      </details>

      <!-- integration -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integration %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            The merchant's Online Payments integration type. <code>HostedView</code> (Seamless View) or <code>Redirect</code>. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe.
          </div>
        </div>
      </details>

      <!-- instrumentMode -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrumentMode %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payment is initialized with only one payment method available.</div></div>
      </details>

      <!-- guestMode -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f guestMode %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/guest-mode.md %}</div></div>
      </details>

      <!-- orderItems (link id as string) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ order_items_md | markdownify }}</div></div>
      </details>

      <!-- urls (string link to resource) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">The URL to the <code>urls</code> resource where information about the urls can be retrieved.</div>
        </div>
      </details>

      <!-- payeeInfo (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payee_info_md | markdownify }}</div></div>
      </details>

      <!-- payer (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payer_md | markdownify }}</div></div>
      </details>

      <!-- history (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f history %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ history_md | markdownify }}</div></div>
      </details>

      <!-- failed (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failed %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ failed_md | markdownify }}</div></div>
      </details>

      <!-- aborted (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f aborted %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ aborted_md | markdownify }}</div></div>
      </details>

      <!-- paid (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paid %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ paid_md | markdownify }}</div></div>
      </details>

      <!-- cancelled (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cancelled %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ cancelled_md | markdownify }}</div></div>
      </details>

      <!-- financialTransactions (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f financialTransactions %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ fin_tx_md | markdownify }}</div></div>
      </details>

      <!-- failedAttempts (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failedAttempts %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ failed_attempts_md | markdownify }}</div></div>
      </details>

      <!-- metadata (id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">The URL to the <code>metadata</code> resource where information about the metadata can be retrieved.</div>
        </div>
      </details>
    </div>
  </details>

  <!-- operations (array) -->
  <details class="api-item" data-level="0">
      <summary>
          <span class="field">{% f operations,0 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>array</code></span>
      </summary>
      <div class="desc">
          <div class="indent-0">
            {% include fields/operations.md %} <a href="{{ features_url }}/technical-reference/operations">See Operations for details</a>.
          </div>
      </div>
  </details>
</div>

{% endif %}
