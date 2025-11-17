## URLs

When creating a Payment Order, the `urls` field of the `paymentOrder`
contains the related URLs, including where the payer is redirected when
going forward with or canceling a payment session, as well as the callback URL
that is used to inform the payee (merchant) of changes or updates made to
underlying payments or transaction.

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- hostUrls -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f hostUrls, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>array</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The array of valid host URLs.</div></div>
  </details>

  <!-- completeUrl -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f completeUrl, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    {% capture complete_url_md %}{% include fields/complete-url.md resource="payment" %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ complete_url_md | markdownify }}</div></div>
  </details>

  <!-- cancelUrl -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f cancelUrl, 0%}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an <code>abort</code> request of the <code>payment</code> or <code>paymentorder</code>.</div></div>
  </details>

  <!-- paymentUrl -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentUrl, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    {% capture payment_url_md %}{% include fields/payment-url.md %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ payment_url_md | markdownify }}</div></div>
  </details>

  <!-- callbackUrl -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f callbackUrl, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    {% capture callback_url_md %}{% include fields/callback-url.md %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ callback_url_md | markdownify }}</div></div>
  </details>

  <!-- logoUrl -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f logoUrl, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    {% capture logo_url_md %}{% include fields/logo-url.md %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ logo_url_md | markdownify }}</div></div>
  </details>

  <!-- termsOfServiceUrl -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f termsOfServiceUrl, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    {% capture tos_url_md %}{% include fields/terms-of-service-url.md %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ tos_url_md | markdownify }}</div></div>
  </details>
</div>

{% include payment-url.md full_reference=true when="selecting the payment
instrument Vipps or in the 3-D Secure verification for Credit Card Payments" %}

### URLs Resource

It is possible to perform a `GET` request on the `urls` resource to retrieve its
contents.

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/urls/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=<PaymentOrderVersion>{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=<PaymentOrderVersion>
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentorder": "/psp/paymentorders/{{ page.payment_order_id }}",
    "urls": {
        "id": "/psp/payments/{{ page.payment_order_id }}/urls",
        "hostUrls": [ "https://example.com", "https://example.net" ],
        "completeUrl": "https://example.com/payment-complete",
        "cancelUrl": "https://example.com/payment-cancelled",
        "paymentUrl": "https://example.com/perform-payment",
        "callbackUrl": "http://api.example.com/payment-callback",
        "logoUrl": "http://merchant.com/path/to/logo.png",
        "termsOfServiceUrl": "https://example.com/termsandconditions.pdf"
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- paymentOrder (root sibling) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    {% capture paymentorder_urls_id_md %}{% include fields/id.md sub_resource="urls" %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ paymentorder_urls_id_md | markdownify }}</div></div>
  </details>

  <!-- urls (root with children) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f urls, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URLs object.</div></div>

    <div class="api-children">
      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        {% capture urls_id_md %}{% include fields/id.md resource="urls" %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ urls_id_md | markdownify }}</div></div>
      </details>

      <!-- hostsUrl -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f hostsUrl %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">An array of the whitelisted URLs that are allowed as parents to a Hosted View, typically the URL of the web shop or similar that will embed a Hosted View within it.</div></div>
      </details>

      <!-- completeUrl -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f completeUrl %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        {% capture complete_url_md %}{% include fields/complete-url.md resource="payment" %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ complete_url_md | markdownify }}</div></div>
      </details>

      <!-- cancelUrl -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cancelUrl %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an <code>abort</code> request of the <code>payment</code> or <code>paymentorder</code>.</div></div>
      </details>

      <!-- paymentUrl -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paymentUrl %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        {% capture payment_url_md %}{% include fields/payment-url.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ payment_url_md | markdownify }}</div></div>
      </details>

      <!-- callbackUrl -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f callbackUrl %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        {% capture callback_url_md %}{% include fields/callback-url.md resource="payment" %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ callback_url_md | markdownify }}</div></div>
      </details>

      <!-- logoUrl -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f logoUrl %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        {% capture logo_url_md %}{% include fields/logo-url.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ logo_url_md | markdownify }}</div></div>
      </details>

      <!-- termsOfServiceUrl -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f termsOfServiceUrl %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        {% capture tos_url_md %}{% include fields/terms-of-service-url.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ tos_url_md | markdownify }}</div></div>
      </details>
    </div>
  </details>
</div>
