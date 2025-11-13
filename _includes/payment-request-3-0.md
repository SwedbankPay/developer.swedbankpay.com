{% capture techref_url %}{% include utils/documentation-section-url.md %}{% endcapture %}

{% include alert.html type="informative" icon="info" body="If you hesitate which version to use, we recommend the version marked with *." %}

{: .h2 }

### Payment order v3.0

<div class="slab mb-5">
  <ul class="toc-list" role="navigation" aria-label="Article content">
    <li>
      <a href="#create-payment-order-v30">
        Create Payment Order
      </a>
      <ul role="list">
        <li>
          <a href="#payment-order-request-v30">
          Payment Order Request
          </a>
        </li>
        <li>
          <a href="#payment-order-response-v30">
          Payment Order Response
          </a>
        </li>
      </ul>
    </li>
    <li>
      <a href="#adding-to-your-request-v30">
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

### Create Payment Order v3.0

When your customer has initiated a purchase, you need to create a payment order.

Start by performing a `POST` request towards the `paymentorder` resource
with payer information and a `completeUrl`.

`POST`, `PATCH` and `PUT` requests use this header for v3.0:

`Content-Type: application/json;version=3.0`

`GET` requests use this header:

`Accept: application/json;version=3.0`

We have added `productName` to the payment order request in this integration.
You can find it in the `paymentorder` field. This is no longer required, but is
an option to use v3.0 of Online Payments. To use `productName`, simply put
`Checkout3` as the value in that field in the request. If you specify version in
the header, you can leave out the `productName` field.

When `productName` is set to `checkout3`, `digitalProducts` will be set to
`false` by default.

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
[Top of page](#payment-order-v30)

{: .h3 }

#### Payment Order Request v3.0

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.0     // Version optional{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "productName": "Checkout3", // Removed in 3.1, can be excluded in 3.0 if version is added in header
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "paymentUrl": "https://example.com/perform-payment", //Seamless View only
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled", //Redirect only
            "callbackUrl": "https://api.example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png"
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
{% capture order_items_md %}{% include fields/order-items.md %}{% endcapture %}
{% capture payee_info_md %}{% include fields/payee-info.md %}{% endcapture %}
{% capture payee_ref_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}

<div class="api-compact" aria-label="Payment Order Requeste">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- LEVEL 0 -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <!-- LEVEL 1 children -->
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ op_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment in the ISO 4217 format (e.g. <code>DKK</code>, <code>EUR</code>, <code>NOK</code> or <code>SEK</code>). Some payment methods are only available with selected currencies.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(40)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Human-readable description for the payment order.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ user_agent_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f productName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Used to tag the payment as Online Payments v3.0. Mandatory for Online Payments v3.0, either in this field or the header, as you won't get the operations in the response without submitting this field.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates which implementation to use.</div></div>
      </details>

      <!-- urls (LEVEL 1) + LEVEL 2 children -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/urls/">urls</a> object, containing the URLs relevant for the payment order.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f hostUrls, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>array</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The array of valid host URLs.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f paymentUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payment_url_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f completeUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ complete_url_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f cancelUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an <code>abort</code> request of the <code>payment</code> or <code>paymentorder</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f callbackUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ callback_url_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f logoUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ logo_url_md | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <!-- orderItems (LEVEL 1) + LEVEL 2 children -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ order_items_md | markdownify }}</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f reference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">A reference that identifies the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>enum</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2"><code>PRODUCT</code>, <code>SERVICE</code>, <code>SHIPPING_FEE</code>, <code>DISCOUNT</code>, <code>VALUE_CODE</code>, or <code>OTHER</code>. The type of the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f class, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The classification of the order item. Can be used for assigning the order item to a specific product category, such as <code>MobilePhone</code>. Note that <code>class</code> cannot contain spaces and must follow the regex pattern <code>[\w-]*</code>. Swedbank Pay may use this field for statistics.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f itemUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to a page that can display the purchased item, such as a product page</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f imageUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to an image of the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/description/">description</a> description of the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountDescription, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the possible discount.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f quantity, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>number</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The 4 decimal precision quantity of order items being purchased.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f quantityUnit, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The unit of the quantity, such as <code>pcs</code>, <code>grams</code>, or similar.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f unitPrice, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The price per unit of order item, including VAT.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountPrice, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">If the order item is purchased at a discounted price. This field should contain that price, including VAT.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatPercent, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The percent value of the VAT multiplied by 100, so <code>25%</code> becomes <code>2500</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ amount_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ vat_amount_md | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <!-- payeeInfo (LEVEL 1) + LEVEL 2 children -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payee_info_md | markdownify }}</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeId, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The ID of the payee, usually the merchant ID.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_ref_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the payee, usually the name of the merchant.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f orderReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The order reference should reflect the order reference found in the merchant's systems.</div></div>
          </details>
        </div>
      </details>
    </div><!-- /level-1 -->
  </details>
</div>

{: .text-right .mt-3}
[Top of page](#payment-order-v30)

{: .h3 }

#### Payment Order Response v3.0

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.0
api-supported-versions: 3.0{% endcapture %}

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
        "payer": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payers"
        },
        "orderItems": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderitems"
        },
        "history": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/history"
        },
        "failed": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/failed"
        },
        "aborted": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/aborted"
        },
        "paid": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/paid"
        },
        "cancelled": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/cancelled"
        },
        "financialTransactions": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/financialtransactions"
        },
        "failedAttempts": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/failedattempts"
        },
        "metadata": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/metadata"
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

<div class="api-compact" aria-label="Payment Order Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- LEVEL 0: paymentOrder -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <!-- LEVEL 1: children of paymentOrder -->
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a>{:target="_blank"} date and time when the payment order was created.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a>{:target="_blank"} date and time when the payment order was updated.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ op_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f status %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Indicates the payment order's current status. <code>Initialized</code> is returned when the payment is created and still ongoing. The request example above has this status.
            <code>Paid</code> is returned when the payer has completed the payment successfully. See the <a href="{{ techref_url }}/technical-reference/status-models#paid"><code>Paid</code> response</a>.
            <code>Failed</code> is returned when a payment has failed. You will find an error message in <a href="{{ techref_url }}/technical-reference/status-models#failed">the <code>Failed</code> response</a>.
            <code>Cancelled</code> is returned when an authorized amount has been fully cancelled. See the <a href="{{ techref_url }}/technical-reference/status-models#cancelled"><code>Cancelled</code> response</a>. It will contain fields from both the cancelled description and paid section.
            <code>Aborted</code> is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). See the <a href="{{ techref_url }}/technical-reference/status-models#aborted"><code>Aborted</code> response</a>.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment order in the ISO 4217 format (e.g. <code>DKK</code>, <code>EUR</code>, <code>NOK</code> or <code>SEK</code>). Some payment methods are only available with selected currencies.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f initiatingSystemUserAgent %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ init_sys_ua_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f availableInstruments %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of methods available for this payment.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments implementation type. <code>Enterprise</code> or <code>PaymentsOnly</code>. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integration %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments integration type. <code>HostedView</code> (Seamless View) or <code>Redirect</code>. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrumentMode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payment is initialized with Instrument Mode (only one payment method available).</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f guestMode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a <code>payerReference</code> in the original <code>paymentOrder</code> request.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The id for the <a href="https://developer.swedbankpay.com/checkout-v3/features/optional/order-items/">Order Items</a> resource where information about the order items can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The id for the <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/urls/">urls</a> resource where all URLs related to the payment order can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The id for the <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/payee-info/">payeeInfo</a> resource where information related to the payee can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The id for the <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/resource-sub-models/#payer">payer</a> resource where information about the payer can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f history, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The id for the <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/resource-sub-models/#history">history</a> resource where information about the payment's history can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failed, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The id for the <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/resource-sub-models/#failed">failed</a> resource where information about the failed transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f aborted, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The id for the <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/resource-sub-models/#aborted">aborted</a> resource where information about the aborted transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paid, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The id for the <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/resource-sub-models/#paid">paid</a> resource where information about the paid transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cancelled, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The id for the <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/resource-sub-models/#cancelled">cancelled</a> resource where information about the cancelled transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f reversed, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The id for the <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/resource-sub-models/#reversed">reversed</a> resource where information about the reversed transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f financialTransactions, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The id for the <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/resource-sub-models/#financialtransactions">financialTransactions</a> resource where information about the financial transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failedAttempts, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The id for the <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/resource-sub-models/#failedattempts">failedAttempts</a> resource where information about the failed attempts can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f postPurchaseFailedAttempts, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The id for the <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/resource-sub-models/#postpurchasefailedattempts">postPurchaseFailedAttempts</a> resource where information about the failed capture, cancel or reversal attempts can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The id for the <a href="https://developer.swedbankpay.com/checkout-v3/technical-reference/metadata">metadata</a> resource where information about the metadata can be retrieved.</div></div>
      </details>
    </div><!-- /level-1 -->
  </details>

  <!-- LEVEL 0: operations -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>array</code></span>
    </summary>
    <div class="desc"><div class="indent-0">{{ operations_md | markdownify }}</div></div>
  </details>
</div>

{: .text-right .mt-3}
[Top of page](#payment-order-v30)

{: .h2 }

### Adding To Your Request v3.0

The request shown above includes what you need to create the payment, but you
can add more sections if you need or want.

Examples can be to include [order items][order-items] by adding a separate node,
or provide risk indicators and information about the payer to
[make the payment process as frictionless as possible][frictionless].

Read more about possible additions to the request in our
[feature section][features].

{: .text-right}
[Top of page](#payment-order-v30)

{% include iterator.html prev_href="/checkout-v3/get-started"
                         prev_title="Back to Get Started"
                         next_href="/checkout-v3/get-started/display-ui"
                         next_title="Display Payment UI" %}

[abort-feature]: /checkout-v3/features/payment-operations/abort
[features]: /checkout-v3/features/
[frictionless]: /checkout-v3/features/customize-payments/frictionless-payments
[order-items]: /checkout-v3/features/optional/order-items
[trustly]: /checkout-v3/trustly-presentation
[swish]: /checkout-v3/swish-presentation
[apple-pay]: /checkout-v3/apple-pay-presentation
[c2p]: /checkout-v3/click-to-pay-presentation
[google-pay]: /checkout-v3/google-pay-presentation
[testsuite]: https://www.postman.com/swedbankpay/swedbank-pay-online/collection/000bv9t/testsuite
