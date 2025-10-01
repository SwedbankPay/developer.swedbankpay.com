{% capture techref_url %}{% include utils/documentation-section-url.md %}{% endcapture %}

**Recommended version*

{: .h2 }

### Payment order v3.1

<div class="slab mb-5">
  <ul class="toc-list" role="navigation" aria-label="Article content">
    <li>
      <a href="#create-payment-order-v31">
        Create Payment Order
      </a>
      <ul role="list">
        <li>
          <a href="#payment-order-request-v31">
          Payment Order Request
          </a>
        </li>
        <li>
          <a href="#payment-order-response-v31">
          Payment Order Response
          </a>
        </li>
      </ul>
    </li>
    <li>
      <a href="#adding-to-your-request-v31">
        Adding To Your Request
      </a>
    </li>
  </ul>
</div>

The integration consists of four main steps. **Creating** the payment order,
**displaying** the payment menu, **validating** the payment's status and
**capturing** the funds. In addition, there are other post-purchase options you
need. We get to them later on.

{: .h3 }

#### Before You Start

Both the payment request and other API calls are available and ready to use in
our [collection of Online Payment APIs][testsuite]{:target="_blank"}. You can
use the collection with your own test account or with the provided generic test
merchant.

Depending on what you plan to include in your offering, we recommend stopping
by the pages specific to each payment method.

Some of them – like the digital wallets [Apple Pay][apple-pay]{:target="_blank"},
[Click to Pay][c2p]{:target="_blank"} and [Google Pay][google-pay]{:target="_blank"} –
have steps which must be completed before the payment method can be activated.

For [Swish][swish]{:target="_blank"} and [Trustly][trustly]{:target="_blank"},
we provide useful integration recommendations.

{: .h2 }

### Create Payment Order v3.1

When your customer has initiated a purchase, you need to create a payment order.
Start by performing a `POST` request towards the `paymentorder` resource with
payer information and a `completeUrl`.

`POST`, `PATCH`, `GET` and `PUT` requests use this header for v3.1:

`Content-Type: application/json;version=3.1`

`GET` requests can also use this header:

`Accept: application/json;version=3.1`

The `productName` field has been removed in v3.1, so the only way of specifying
that you are using v3.1 is through the header.

To accompany the new version, we have also added a
[v3.1 post-purchase section][post-31], [v3.1 callback][callback-31], a new
resource model for [`failedPostPurchaseAttempts`][fppa] and additions to the
[`history`][history] resource model.

Supported features for this integration are subscriptions (`recur`, `one-click`
and `unscheduled MIT`), `MOTO`, instrument mode, split settlement (`subsite`)
and the possibility to use your own `logo`.

There is also a guest mode option for the payers who don't wish to store their
information. The way to trigger this is to not include the `payerReference`
field in your `paymentOrder` request. If the `payer` field is included in your
request, you can find the `payerReference` there.

Sometimes you might need to abort purchases. An example could be if a payer does
not complete the purchase within a reasonable timeframe. For those instances we
have `abort`, which you can read about in the [payment operations][abort-feature].
You can only use `abort` if the payer **has not** completed an `authorize` or a
`sale`. If the payer is performing an action at a 3rd party, like the MobilePay,
Swish or Vipps apps, `abort` is unavailable.

To avoid unnecessary calls, we recommend doing a `GET` on your `paymentOrder` to
check if `abort` is an available operation before performing it.

### GDPR

When adding information to the `Payer` object for the purpose of pre-filling or
storing any data connected to the payer, you must first obtain their **explicit**
**consent**. In general, this consent can be collected when the payer provides
their delivery information, such as during the checkout or registration process.

Examples of such fields include:

*   `firstName`
*   `lastName`
*   `email`
*   `MSISDN`

If you are linking payer information to a profile (`payerReference`) or using
stored credentials for express checkouts, **do not use sensitive identifiers** —
such as email addresses, phone numbers, or social security numbers—in fields
like `payerReference`. These fields are **not intended to hold personal data**,
and therefore **do not offer the same level of protection or processing**
**safeguards** as fields explicitly designed for sensitive information under
GDPR.

If the use of sensitive data is absolutely necessary, it must be **hashed**
before being sent in any request to Swedbank Pay. The hash must be meaningful
only to you, the merchant or integrator, and **does not need to be reversible by**
**Swedbank Pay**. This means you are solely responsible for generating the hash
and, if needed, securely mapping it back to the original data on your side. The
responsibility for ensuring the **lawful processing, protection, and handling**
**of personal data** — both during and after the transaction — **rests entirely**
**with you**.

{% include alert-risk-indicator.md %}

{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{% assign features_url = documentation_section | prepend: '/' | append: '/features' %}

{: .text-right}

[Top of page](#payment-order-v31)

{: .h3 .text-left}

#### Payment Order Request v3.1

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.1{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "paymentUrl": "https://example.com/perform-payment", //Seamless View only
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled", //Redirect only
            "callbackUrl": "https://api.example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png",
            "termsOfServiceUrl": "https://example.com/termsandconditoons.pdf"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "orderReference": "or-123456"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture op_md %}{% include fields/operation.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture user_agent_md %}{% include fields/user-agent.md %}{% endcapture %}
{% capture language_md %}{% include fields/language.md %}{% endcapture %}
{% capture payment_url_md %}{% include fields/payment-url-paymentorder.md %}{% endcapture %}
{% capture complete_url_md %}{% include fields/complete-url.md %}{% endcapture %}
{% capture callback_url_md %}{% include fields/callback-url.md %}{% endcapture %}
{% capture logo_url_md %}{% include fields/logo-url.md %}{% endcapture %}
{% capture tos_url_md %}{% include fields/terms-of-service-url.md %}{% endcapture %}
{% capture payee_info_md %}{% include fields/payee-info.md %}{% endcapture %}
{% capture payee_ref_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}

<div class="api-compact" role="table" aria-label="API Fields">
  <div class="header" role="row">
    <div role="columnheader">Field</div>
    <div role="columnheader">Type</div>
    <div role="columnheader">Required</div>
  </div>
  <!-- LEVEL 0 -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f paymentOrder, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-1">The payment order object.</div></div>
    <!-- ALL LEVEL 1 CHILDREN -->
    <div class="api-children">
      <!-- LEVEL 1 -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f operation %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-2">{{ op_md | markdownify }}</div></div>
      </details>
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f currency %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-2">The currency of the payment.</div></div>
      </details>
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f amount %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-2">{{ amount_md | markdownify }}</div></div>
      </details>
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f vatAmount %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-2">{{ vat_amount_md | markdownify }}</div></div>
      </details>
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f description %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-2">The description of the payment order.</div></div>
      </details>
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f userAgent %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-2">{{ user_agent_md | markdownify }}</div></div>
      </details>
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f language %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-2">{{ language_md | markdownify }}</div></div>
      </details>
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f implementation %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-2">Indicates which implementation to use.</div></div>
      </details>
      <!-- urls (LEVEL 1) + LEVEL 2 children -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f urls %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-2">The <code>urls</code> object, containing the URLs relevant for the payment order.</div></div>
        <div class="api-children">
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f hostUrls, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>array</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-3">The array of valid host URLs.</div></div>
          </details>
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f paymentUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-3">{{ payment_url_md | markdownify }}</div></div>
          </details>
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f completeUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-3">{{ complete_url_md | markdownify }}</div></div>
          </details>
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f cancelUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-3">The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an <code>abort</code> request of the <code>payment</code> or <code>paymentorder</code>.</div></div>
          </details>
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f callbackUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-3">{{ callback_url_md | markdownify }}</div></div>
          </details>
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f logoUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-3">{{ logo_url_md | markdownify }}</div></div>
          </details>
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f termsOfServiceUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-3">{{ tos_url_md | markdownify }}</div></div>
          </details>
        </div>
      </details>
      <!-- payeeInfo (LEVEL 1) + LEVEL 2 children -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f payeeInfo %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-2">{{ payee_info_md | markdownify }}</div></div>
        <div class="api-children">
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f payeeId, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-3">The ID of the payee, usually the merchant ID.</div></div>
          </details>
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f payeeReference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(30)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-3">{{ payee_ref_md | markdownify }}</div></div>
          </details>
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f payeeName, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-3">The name of the payee, usually the name of the merchant.</div></div>
          </details>
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f orderReference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(50)</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-3">The order reference should reflect the order reference found in the merchant's systems.</div></div>
          </details>
        </div>
      </details>
    </div><!-- /level-1 children -->
  </details>
</div>

{: .text-right .mt-3}
[Top of page](#payment-order-v31)

{: .h3 }

#### Payment Order Response v3.1

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.1
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",
        "created": "2020-06-22T10:56:56.2927632Z",
        "updated": "2020-06-22T10:56:56.4035291Z",
        "operation": "Purchase",
        "status": "Initialized",
        "currency": "SEK",
        "vatAmount": 375,
        "amount": 1500,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [
          "CreditCard",
          "Invoice-PayExFinancingSe",
          "Invoice-PayMonthlyInvoiceSe",
          "Swish",
          "CreditAccount",
          "Trustly" ],
        "implementation": "PaymentsOnly", {% if include.integration_mode=="seamless-view" %}
        "integration": "HostedView", {% endif %} {% if include.integration_mode=="redirect" %}
        "integration": "Redirect",
        {% endif %}
        "instrumentMode": false,
        "guestMode": false,
        "orderItems": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderitems"
        },
        "urls": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/urls"
        },
        "payeeInfo": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/payeeinfo"
        },
        "payer": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/payers"
        },
        "history": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/history"
        },
        "failed": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/failed"
        },
        "aborted": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/aborted"
        },
        "paid": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/paid"
        },
        "cancelled": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/cancelled"
        },
        "reversed": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/reversed"
        },
        "financialTransactions": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/financialtransactions"
        },
        "failedAttempts": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/failedattempts"
        },
        "postPurchaseFailedAttempts": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/failedattempts"
        },
        "metadata": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/metadata"
        }
    },
    "operations": [
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "redirect-checkout",
          "contentType": "text/html"
        },
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "view-checkout",
          "contentType": "application/javascript"
        },
        {
          "href": "https://api.payex.com/psp/paymentorders/{{ page.payment_order_id }}",
          "rel":"update-order",
          "method":"PATCH",
          "contentType":"application/json"
        },
        {
          "href": "https://api.payex.com/psp/paymentorders/{{ page.payment_order_id }}",
          "rel": "abort",
          "method": "PATCH",
          "contentType": "application/json"
        },
        {
          "href": "https://api.payex.com/psp/paymentorders/{{ page.payment_order_id }}",
          "rel": "abort-paymentattempt",
          "method": "PATCH",
          "contentType": "application/json"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture id_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture op_md %}{% include fields/operation.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture description_md %}{% include fields/description.md %}{% endcapture %}
{% capture init_sys_ua_md %}{% include fields/initiating-system-user-agent.md %}{% endcapture %}
{% capture language_md %}{% include fields/language.md %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" role="table" aria-label="Payment Order – Fields">
  <div class="header" role="row">
    <div role="columnheader">Field</div>
    <div role="columnheader">Type</div>
  </div>

  <!-- LEVEL 0: paymentOrder -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f paymentOrder, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-1">The payment order object.</div></div>

    <!-- LEVEL 1 children of paymentOrder -->
    <div class="api-children">

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f id %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">{{ id_md | markdownify }}</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f created %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The ISO-8601 date of when the payment order was created.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f updated %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The ISO-8601 date of when the payment order was updated.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f operation %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">{{ op_md | markdownify }}</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f status %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-2">
            Indicates the payment order's current status. <code>Initialized</code> is returned when the payment is created and still ongoing. The request example above has this status.
            <code>Paid</code> is returned when the payer has completed the payment successfully. See the <a href="{{ features_url }}/technical-reference/status-models#paid"><code>Paid</code> response</a>.
            <code>Failed</code> is returned when a payment has failed. You will find an error message in <a href="{{ features_url }}/technical-reference/status-models#failed">the <code>Failed</code> response</a>.
            <code>Cancelled</code> is returned when an authorized amount has been fully cancelled. See the <a href="{{ features_url }}/technical-reference/status-models#cancelled"><code>Cancelled</code> response</a>. It will contain fields from both the cancelled description and paid section.
            <code>Aborted</code> is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). See the <a href="{{ features_url }}/technical-reference/status-models#aborted"><code>Aborted</code> response</a>.
          </div>
        </div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f currency %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The currency of the payment order.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f amount %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-2">{{ amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f vatAmount %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-2">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f description %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        <div class="desc"><div class="indent-2">{{ description_md | markdownify }}</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f initiatingSystemUserAgent %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">{{ init_sys_ua_md | markdownify }}</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f language %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">{{ language_md | markdownify }}</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f availableInstruments %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">A list of payment methods available for this payment.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f implementation %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The merchant's Online Payments implementation type. <code>Enterprise</code> or <code>PaymentsOnly</code>. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f integration %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The merchant's Online Payments integration type. <code>HostedView</code> (Seamless View) or <code>Redirect</code>. This field will not be populated until the payer has opened the payment UI…</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f instrumentMode %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-2">Set to <code>true</code> or <code>false</code>. Indicates if the payment is initialized with Instrument Mode (only one payment method available).</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f guestMode %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-2">Set to <code>true</code> or <code>false</code>. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a <code>payerReference</code> in the original <code>paymentOrder</code> request.</div></div>
      </details>

      <!-- id-type links (level 1) -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f orderItems %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <code>orderItems</code> resource where information about the order items can be retrieved.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f urls %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <code>urls</code> resource where all URLs related to the payment order can be retrieved.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f payeeInfo %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <code>payeeInfo</code> resource where information related to the payee can be retrieved.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f payer %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#payer"><code>payer</code> resource</a> where information about the payer can be retrieved.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f history %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#history"><code>history</code> resource</a> where information about the payment's history can be retrieved.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f failed %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#failed"><code>failed</code> resource</a> where information about the failed transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f aborted %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#aborted"><code>aborted</code> resource</a> where information about the aborted transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f paid %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#paid"><code>paid</code> resource</a> where information about the paid transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f cancelled %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#cancelled"><code>cancelled</code> resource</a> where information about the cancelled transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f reversed %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <code>reversed</code> resource where information about the reversed transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f financialTransactions %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#financialtransactions"><code>financialTransactions</code> resource</a> where information about the financial transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f failedAttempts %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#failedattempts"><code>failedAttempts</code> resource</a> where information about the failed attempts can be retrieved.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f postPurchaseFailedAttempts %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <code>postPurchaseFailedAttempts</code> resource where information about the failed capture, cancel or reversal attempts can be retrieved.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f metadata %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The URL to the <code>metadata</code> resource where information about the metadata can be retrieved.</div></div>
      </details>

    </div><!-- /level-1 children -->
  </details>

  <!-- LEVEL 0: operations -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f operations, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>array</code></span>
    </summary>
    <div class="desc"><div class="indent-1">{{ operations_md | markdownify }}</div></div>
  </details>
</div>

{: .text-right .mt-3}
[Top of page](#payment-order-v31)

{: .h2 }

### Adding To Your Request v3.1

The request shown above includes what you need to create the payment, but you
can add more sections if you need or want.

Examples can be to include [order items][order-items] by adding a separate node,
or provide risk indicators and information about the payer to
[make the payment process as frictionless as possible][frictionless].

Read more about possible additions to the request in our
[feature section][features].

{: .text-right}
[Top of page](#payment-order-v31)

{% include iterator.html prev_href="/checkout-v3/get-started"
                         prev_title="Back To Get Started"
                         next_href="/checkout-v3/get-started/display-ui"
                         next_title="Display Payment UI" %}

[abort-feature]: /checkout-v3/features/payment-operations/abort
[callback-31]: /checkout-v3/features/payment-operations/callback
[features]: /checkout-v3/features/
[fppa]: /checkout-v3/technical-reference/resource-sub-models#failedpostpurchaseattempts
[frictionless]: /checkout-v3/features/customize-payments/frictionless-payments
[history]: /checkout-v3/technical-reference/resource-sub-models#history
[order-items]: /checkout-v3/features/optional/order-items
[post-31]: /checkout-v3/get-started/post-purchase/
[trustly]: /checkout-v3/trustly-presentation
[swish]: /checkout-v3/swish-presentation
[apple-pay]: /checkout-v3/apple-pay-presentation
[c2p]: /checkout-v3/click-to-pay-presentation
[google-pay]: /checkout-v3/google-pay-presentation
[testsuite]: https://www.postman.com/swedbankpay/swedbank-pay-online/collection/000bv9t/testsuite
