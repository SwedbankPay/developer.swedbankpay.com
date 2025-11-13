---
title: Direct
permalink: /:path/direct/
redirect_from: /payments/invoice/direct
description: |
  **Direct** is a payment service where Swedbank
  Pay helps improve cashflow by purchasing merchant invoices. Swedbank Pay
  receives invoice data, which is used to produce and distribute invoices to the
  payer.
menu_order: 700
---

{% assign financing_consumer_url="/old-implementations/payment-instruments-v1/invoice/technical-reference/financing-consumer" %}
{% assign cancel_url="/old-implementations/payment-instruments-v1/invoice/after-payment#cancellations" %}
{% assign capture_url="/old-implementations/payment-instruments-v1/invoice/capture" %}

{% include alert.html type="warning" icon="report_problem" body="**Availability**:
Note that this invoice integration is only available for MultiPay merchants. If you
are a MultiPay merchant and wish to offer invoice as a payment option, this has to
be done through our payment order implementation." %}

## Invoice Direct Implementation Flow

1.  Collect all purchase information and send it in a `POST` request to Swedbank
   Pay. Make sure to include personal information (SSN and postal code).

2.  Make a new `POST` request towards Swedbank Pay to retrieve the name and
   address of the customer to create a purchase.

3.  Create a `POST`request to retrieve the transaction status.

4.  Send a  `GET` request with the `paymentID` to get the authorization result.

5.  Make a Capture by creating a `POST` request.

*   An invoice payment is always two-phased based - you create an Authorize
transaction, that is followed by a `Capture` or `Cancel` request.
The `Capture` , `Cancel`, `Reversal` opions are
described in [features][features].

{% include alert.html type="informative" icon="info" body="
Note that the invoice will not be created/distributed before you have
made a `capture` request. By making a Capture, Swedbank Pay will generate
the invoice to the payer and the order is ready for shipping." %}

{% include alert-callback-url.md %}

The 3 most important steps in the Invoice Direct flow are shown below.

## Step 1: Create A Purchase

Our `payment` example below uses the [`FinancingConsumer`]({{
financing_consumer_url }}) value.

{% include alert-gdpr-disclaimer.md %}

## Financing Consumer Request

{% capture request_header %}POST /psp/invoice/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "payment": {
        "operation": "FinancingConsumer",
        "intent": "Authorization",
        "currency": "SEK",
        "prices": [
            {
                "type": "Invoice",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Purchase",
        "generatePaymentToken": false,
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png",
            "termsOfServiceUrl": "https://example.com/terms.pdf"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "PR123",
            "payeeName": "Merchant1",
            "productCategory": "PC1234",
            "subsite": "MySubsite"
        },
        "payer": {
            "payerReference": "AB1234",
        }
    },
    "invoice": {
        "invoiceType": "PayExFinancingSe"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- payment (root) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The <code>payment</code> object contains information about the specific payment.</div></div>

    <div class="api-children">
      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The operation that the <code>payment</code> is supposed to perform. The <code>[FinancingConsumer]({{ financing_consumer_url }})</code> operation is used in our example.</div></div>
      </details>

      <!-- intent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f intent %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Authorization</code> is the only intent option for invoice. Reserves the amount, and is followed by a <a href="{{ cancel_url }}">cancellation</a> or <a href="{{ capture_url }}">capture</a> of funds.</div></div>
      </details>

      <!-- currency -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment in the ISO 4217 format (e.g. <code>DKK</code>, <code>EUR</code>, <code>NOK</code> or <code>SEK</code>). Some payment methods are only available with selected currencies.</div></div>
      </details>

      <!-- prices (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f prices %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>prices</code> resource lists the prices related to a specific payment.</div></div>

        <div class="api-children">
          <!-- type -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            {% capture prices_type_md %}{% include fields/prices-type.md kind="Invoice" %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ prices_type_md | markdownify }}</div></div>
          </details>

          <!-- amount -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            {% capture amount_md_lvl2 %}{% include fields/amount.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ amount_md_lvl2 | markdownify }}</div></div>
          </details>

          <!-- vatAmount -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            {% capture vat_amount_md_lvl2 %}{% include fields/vat-amount.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ vat_amount_md_lvl2 | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(40)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture description_md %}{% include fields/description.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <!-- userAgent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture user_agent_md %}{% include fields/user-agent.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ user_agent_md | markdownify }}</div></div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture language_md %}{% include fields/language.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <!-- urls (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>urls</code> resource lists urls that redirects users to relevant sites.</div></div>

        <div class="api-children">
          <!-- hostUrl (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f hostUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>array</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The array of URLs valid for embedding of Swedbank Pay Seamless Views. If not supplied, view-operation will not be available.</div></div>
          </details>

          <!-- completeUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f completeUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            {% capture complete_url_md %}{% include fields/complete-url.md resource="payment" %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ complete_url_md | markdownify }}</div></div>
          </details>

          <!-- cancelUrl (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f cancelUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to redirect the payer to if the payment is cancelled. Only used in redirect scenarios. Can not be used simultaneously with <code>paymentUrl</code>; only <code>cancelUrl</code> or <code>paymentUrl</code> can be used, not both.</div></div>
          </details>

          <!-- callbackUrl (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f callbackUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            {% capture callback_url_md %}{% include fields/callback-url.md resource="payment" %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ callback_url_md | markdownify }}</div></div>
          </details>

          <!-- logoUrl (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f logoUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            {% capture logo_url_md %}{% include fields/logo-url.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ logo_url_md | markdownify }}</div></div>
          </details>

          <!-- termsOfServiceUrl (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f termsOfServiceUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            {% capture tos_url_md %}{% include fields/terms-of-service-url.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ tos_url_md | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <!-- payeeInfo (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture payee_info_md %}{% include fields/payee-info.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ payee_info_md | markdownify }}</div></div>

        <div class="api-children">
          <!-- payeeId -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeId, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.</div></div>
          </details>

          <!-- payeeReference -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            {% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ payee_reference_md | markdownify }}</div></div>
          </details>

          <!-- payeeName (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.</div></div>
          </details>

          <!-- productCategory (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f productCategory, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.</div></div>
          </details>

          <!-- orderReference (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f orderReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The order reference should reflect the order reference found in the merchant's systems.</div></div>
          </details>

          <!-- subsite (optional, included) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f subsite, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(40)</code></span>
            </summary>
            {% capture subsite_md %}{% include fields/subsite.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ subsite_md | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <!-- payer link (optional) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>payer</code> object, containing information about the payer.</div></div>

        <div class="api-children">
          <!-- payerReference (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payerReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            {% capture payer_reference_md %}{% include fields/payer-reference.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ payer_reference_md | markdownify }}</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

## Financing Consumer Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": {
        "id": "/psp/invoice/payments/{{ page.payment_id }}",
        "number": 1234567890,
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "state": "Ready",
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "SE",
        "amount": 0,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "prices": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/prices"
        },
        "transactions": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/transactions"
        },
        "authorizations": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/authorizations"
        },
        "captures": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/captures"
        },
        "reversals": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/reversals"
        },
        "cancellations": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/cancellations"
        },
        "payeeInfo": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/payeeInfo"
        },
        "payers": {
           "id": "/psp/trustly/payments/{{ page.payment_id }}/payers"
        },
        "urls": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/urls"
        },
        "settings": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/settings"
        },
        "approvedLegalAddress": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/approvedlegaladdress"
        },
        "maskedApprovedLegalAddress": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/maskedapprovedlegaladdress"
        }
    },
    "approvedLegalAddress": {
        "id": "/psp/invoice/payments/{{ page.payment_id }}/approvedlegaladdress"
    },
    "operations": [
        {
            "href": "{{ page.api_url }}/psp/invoice/payments/{{ page.payment_id }}/captures",
            "rel": "create-capture",
            "method": "POST"
        },
        {
            "href": "{{ page.api_url }}/psp/invoice/payments/{{ page.payment_id }}/cancellations",
            "rel": "create-cancel",
            "method": "POST"
        },
        {
            "href": "{{ page.api_url }}/psp/invoice/payments/{{ page.payment_id }}/approvedlegaladdress",
            "rel": "create-approved-legal-address",
            "method": "POST"
        }
    ]
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

  <!-- payment (root) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The <code>payment</code> object contains information about the specific payment.</div></div>

    <div class="api-children">
      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        {% capture id_md %}{% include fields/id.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      <!-- number -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f number %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        {% capture number_payment_md %}{% include fields/number.md resource="payment" %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ number_payment_md | markdownify }}</div></div>
      </details>

      <!-- created -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a> date and time when the payment was created.</div></div>
      </details>

      <!-- updated -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a> date and time when the payment was updated.</div></div>
      </details>

      <!-- state -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f state %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Ready</code>, <code>Pending</code>, <code>Failed</code> or <code>Aborted</code>. Indicates the state of the payment, not the state of any transactions performed on the payment. To find the state of the payment's transactions (such as a successful authorization), see the <code>transactions</code> resource or the different specialized type-specific resources such as <code>authorizations</code> or <code>sales</code>.</div></div>
      </details>

      <!-- prices (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f prices %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>prices</code> resource lists the prices related to a specific payment.</div></div>

        <div class="api-children">
          <!-- prices.id -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            {% capture prices_id_md %}{% include fields/id.md resource="prices" %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ prices_id_md | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        {% capture description_md %}{% include fields/description.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <!-- userAgent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        {% capture user_agent_md %}{% include fields/user-agent.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ user_agent_md | markdownify }}</div></div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
        </summary>
        {% capture language_md %}{% include fields/language.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <!-- urls (link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the  urls  resource where all URLs related to the payment can be retrieved.</div></div>
      </details>

      <!-- payeeInfo (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        {% capture payee_info_md %}{% include fields/payee-info.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ payee_info_md | markdownify }}</div></div>
      </details>

      <!-- payers (link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payers %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payer</code> resource where the information about the payer can be retrieved.</div></div>
      </details>
    </div>
  </details>

  <!-- operations (root sibling) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>array</code></span>
    </summary>
    {% capture operations_payment_md %}{% include fields/operations.md resource="payment" %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ operations_payment_md | markdownify }}</div></div>

    <div class="api-children">
      <!-- method -->
      <details class="api-item" data-level="2">
        <summary>
          <span class="field">{% f method, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The HTTP method to use when performing the operation.</div></div>
      </details>

      <!-- href -->
      <details class="api-item" data-level="2">
        <summary>
          <span class="field">{% f href, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The target URL to perform the operation against.</div></div>
      </details>

      <!-- rel -->
      <details class="api-item" data-level="2">
        <summary>
          <span class="field">{% f rel, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The name of the relation the operation has to the current resource.</div></div>
      </details>
    </div>
  </details>
</div>

## Step 2: Get `approvedLegalAddress` Confirmation

Retrieve the payer's legal address, which is needed to do the next step.

## Approved Legal Address Request

{% capture request_header %}POST /psp/invoice/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "addressee": {
        "socialSecurityNumber": "194810205957",
        "zipCode": "55560"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

## Approved Legal Address Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/invoice/payments/{{ page.payment_id }}",
    "approvedLegalAddress": {
        "id": "/psp/invoice/payments/{{ page.payment_id }}/approvedlegaladdress",
        "addressee": "Leo 6",
        "streetAddress": "Gata 535",
        "zipCode": "55560",
        "city": "Vaxholm",
        "countryCode": "SE"
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

## Step 3: Complete The Payment

Add the legal address in your complete request.

## Complete Request

{% capture request_header %}POST /psp/invoice/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "activity": "FinancingConsumer"
    },
    "consumer": {
        "socialSecurityNumber": "194810205957",
        "customerNumber": "123456",
        "email": "someExample@swedbankpay.com",
        "msisdn": "+46765432198",
        "ip": "127.0.0.1"
    },
    "legalAddress": {
        "addressee": "Leo 6",
        "streetAddress": "Gata 535",
        "zipCode": "55560",
        "city": "Vaxholm",
        "countryCode": "SE"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

## Complete Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/invoice/payments/{{ page.payment_id }}",
    "authorization": {
        "shippingAddress": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/shippingaddress"
        },
        "legalAddress": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/legaladdress"
        },
        "id": "/psp/invoice/payments/{{ page.payment_id }}/authorizations/23fc8ea7-57b8-44bb-8313-08d7ca2e1a26",
        "transaction": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/transactions/23fc8ea7-57b8-44bb-8313-08d7ca2e1a26",
            "created": "2020-03-17T09:46:10.3506297Z",
            "updated": "2020-03-17T09:46:12.2512221Z",
            "type": "Authorization",
            "state": "Completed",
            "number": 71100537930,
            "amount": 4201,
            "vatAmount": 0,
            "description": "Books & Ink",
            "payeeReference": "1584438350",
            "isOperational": false,
            "operations": []
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

The sequence diagram below shows a high level description of the invoice
process, including the four requests you have to send to Swedbank Pay to create
an authorized transaction.

## Invoice Flow

```mermaid
sequenceDiagram
    Payer->>Merchant: Start purchase (collect SSN and postal number)
    activate Merchant
    note left of Merchant: First API request
    Merchant->>-Swedbank Pay: POST <Invoice Payments> (operation=FinancingConsumer)
    activate Swedbank Pay
    Swedbank Pay-->>-Merchant: payment resource
    activate Merchant
    note left of Merchant: Second API request
    Merchant->>-Swedbank Pay: POST <approvedLegalAddress> (SNN and postal number)
    activate Swedbank Pay
    Swedbank Pay->>Swedbank Pay: Update payment with payer's delivery address
    Swedbank Pay-->>-Merchant: Approved legaladdress information
    activate Merchant
    Merchant-->>-Payer: Display all details and final price
    activate Payer
    Payer->>Payer: Input email and mobile number
    Payer->>-Merchant: Confirm purchase
    activate Merchant

    note left of Merchant: Third API request
    Merchant->>-Swedbank Pay: POST <invoice authorizations> (Transaction Activity=FinancingConsumer)
    activate Swedbank Pay
    Swedbank Pay-->>-Merchant: Transaction result
    activate Merchant
    note left of Merchant: Fourth API request
    Merchant->>-Swedbank Pay: GET <invoice payments>
    activate Swedbank Pay
    Swedbank Pay-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Payer: Display result
```

## Options After Posting A Purchase Payment

Head over to [Capture][capture] to complete the Invoice Direct integration.

{% include iterator.html prev_href="/old-implementations/payment-instruments-v1/invoice/seamless-view" prev_title="Seamless View"
next_href="/old-implementations/payment-instruments-v1/invoice/capture" next_title="Capture" %}

[capture]: /old-implementations/payment-instruments-v1/invoice/capture
[features]: /old-implementations/payment-instruments-v1/invoice/features
