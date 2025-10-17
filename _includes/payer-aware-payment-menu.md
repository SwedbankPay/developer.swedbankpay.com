{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{% assign features_url = documentation_section | prepend: '/' | append: '/features' %}
{% capture techref_url %}{% include utils/documentation-section-url.md %}{% endcapture %}

## Payer Aware Payment Menu

To give your payers the best experience possible, you should implement the Payer
Aware Payment Menu by identifying each payer with a unique identifier. It is
important that you enforce a good SCA (Strong Consumer Authentication) strategy
when authenticating the payer. The payer identifier must then be included as a
`payerReference` in the `paymentOrder` request to Swedbank Pay. This will enable
Swedbank Pay to render a unique payment menu experience for each payer. It will
also increase the chance for a frictionless payment.

By identifying your payers, their payment information can be stored for future
purchases by setting the `generatePaymentToken` value to `true`. The payer is,
by default, asked if they want to store their payment details, so even with
`generatePaymentToken` set to `true`, it is still up to the payer if they want
the details stored or not.

{% include alert.html type="informative" icon="info" body="Please note that not
all payment methods provided by Swedbank Pay support Payer Awareness today. It
is not available for Invoice, Installment Account or Monthly Payments." %}

## Trustly Express

If you are offering Trustly Express through our payment aware payment menu, we
have two recommendations to make the experience as smooth as possible.

*   Include the first and last name of the payer in the `payer`
  object.

*   Add the payer's SSN. If you provide it in the `payerReference` field, the
  SSN has to be hashed.

If you want to read about Trustly Express and the banks who offer it, you can
find more information [here][trustly-presentation].

## BYO Payment Menu

The payment UI is versatile and can be configured in such a way that it
functions like a single payment method. In such configuration, it is easy to
Bring Your Own Payment Menu, i.e. building a customized payment menu in your own
user interface.

## Add Stored Payment Method Details

When building a custom payment menu, features like adding new stored payment
method details (i.e. "Add new card") is something that needs to be provided
in your UI.

This can be achieved by forcing the creation of a `paymentToken` by setting
`disableStoredPaymentDetails` to `true` in a Purchase payment (if you want
to withdraw money and create the token in the same operation), or by performing
a [verification][verify] (without withdrawing any money).

Setting `disableStoredPaymentDetails` to `true` will turn off all stored payment
details for the current purchase. The payer will also not be asked if they want
to store the payment details that will be part of the purchase. When you use
this feature, it is important that you have asked the payer in advance if it is
ok to store their payment details for later use.

Most often you will use the `disableStoredPaymentDetails` feature in combination
with the {% if documentation_section contains "checkout-v3" %} [Instrument Mode]({{ features_url }}/customize-ui/instrument-mode) {% else %} Instrument Mode {% endif %}
capability. If you build your own menu and want to show stored payment details,
you will need to set the `disableStoredPaymentDetails` to `true`. It is
important that you then store the `paymentToken` in your system or call Swedbank
Pay with the `payerReference` to get all active payment tokens registered on
that payer when building your menu.

## GDPR

Remember that you have the responsibility of enforcing GDPR requirements and
letting the payer remove active payment tokens when they want. It is up to you
how to implement this functionality on your side, but Swedbank Pay has the API
you need to make it easy to [clean up old data][tokens]. See more below the main
`paymentOrder` request example, or follow the hyperlink above.

A Payer Aware Payment Menu request can look like this.

## Payer Aware Payment Menu Request

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
CContent-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "generatePaymentToken": true,
        "language": "sv-SE", {% if documentation_section contains "checkout-v3/payments-only" %}
        "productName": "Checkout3", // Removed in 3.1, can be excluded in 3.0 if version is added in header
        {% endif %}
        "disableStoredPaymentDetails": false,
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
            "subsite": "MySubsite", {% if documentation_section contains "checkout-v3" %}
            "siteId": "MySiteId"{% endif %}
        },
        "payer": {
            "digitalProducts": false,
            "firstName": "Leia",
            "lastName": "Ahlström",
            "email": "leia@swedbankpay.com",
            "msisdn": "+46787654321",
            "payerReference": "AB1234",
            "shippingAddress": {
                "firstName": "firstname/companyname",
                "lastName": "lastname",
                "email": "karl.anderssson@mail.se",
                "msisdn": "+46759123456",
                "streetAddress": "string",
                "coAddress": "string",
                "city": "Solna",
                "zipCode": "17674",
                "countryCode": "SE"
            },
            "billingAddress": {
                "firstName": "firstname/companyname",
                "lastName": "lastname",
                "email": "karl.anderssson@mail.se",
                "msisdn": "+46759123456",
                "streetAddress": "string",
                "coAddress": "string",
                "city": "Solna",
                "zipCode": "17674",
                "countryCode": "SE"
            },
            "accountInfo": {
                "accountAgeIndicator": "04",
                "accountChangeIndicator": "04",
                "accountPwdChangeIndicator": "01",
                "shippingAddressUsageIndicator": "01",
                "shippingNameIndicator": "01",
                "suspiciousAccountActivity": "01"
            }
        },
        "orderItems": [
            {
                "reference": "P1",
                "name": "Product1",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "itemUrl": "https://example.com/products/123",
                "imageUrl": "https://example.com/product123.jpg",
                "description": "Product 1 description",
                "discountDescription": "Volume discount",
                "quantity": 5,
                "quantityUnit": "pcs",
                "unitPrice": 300,
                "discountPrice": 0,
                "vatPercent": 2500,
                "amount": 1500,
                "vatAmount": 375
            },
            {
                "reference": "I1",
                "name": "InvoiceFee",
                "type": "PAYMENT_FEE",
                "class": "Fees",
                "description": "Fee for paying with Invoice",
                "quantity": 1,
                "quantityUnit": "pcs",
                "unitPrice": 1900,
                "vatPercent": 0,
                "amount": 1900,
                "vatAmount": 0,
                "restrictedToInstruments": [
                    "Invoice-PayExFinancingSe"
                ]
            }
        ],
        "riskIndicator": {
            "deliveryEmailAddress": "olivia.nyhuus@swedbankpay.com",
            "deliveryTimeFrameIndicator": "01",
            "preOrderDate": "19801231",
            "preOrderPurchaseIndicator": "01",
            "shipIndicator": "01",
            "giftCardPurchase": false,
            "reOrderPurchaseIndicator": "01",
            "pickUpAddress": {
                "name": "Olivia Nyhus",
                "streetAddress": "Saltnestoppen 43",
                "coAddress": "",
                "city": "Saltnes",
                "zipCode": "1642",
                "countryCode": "NO"
            }
        }
    }
} {% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{%- capture operation_md -%}{% include fields/operation.md %}{%- endcapture -%}
{%- capture amount_md -%}{% include fields/amount.md %}{%- endcapture -%}
{%- capture vat_amount_md -%}{% include fields/vat-amount.md %}{%- endcapture -%}
{%- capture description_md -%}{% include fields/description.md %}{%- endcapture -%}
{%- capture user_agent_md -%}{% include fields/user-agent.md %}{%- endcapture -%}

{%- capture payment_url_md -%}{% include fields/payment-url.md %}{%- endcapture -%}
{%- capture complete_url_md -%}{% include fields/complete-url.md %}{%- endcapture -%}
{%- capture callback_url_md -%}{% include fields/callback-url.md %}{%- endcapture -%}
{%- capture tos_url_md -%}{% include fields/terms-of-service-url.md %}{%- endcapture -%}
{%- capture logo_url_md -%}{% include fields/logo-url.md %}{%- endcapture -%}

{%- capture payee_info_md -%}{% include fields/payee-info.md %}{%- endcapture -%}
{%- capture payee_ref_md -%}{% include fields/payee-reference.md documentation_section=include.documentation_section describe_receipt=true %}{%- endcapture -%}
{%- capture subsite_md -%}{% include fields/subsite.md %}{%- endcapture -%}
{%- capture site_id_md -%}{% include fields/site-id.md %}{%- endcapture -%}

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- Level 0 (root; all nodes CLOSED by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <!-- Children of paymentOrder (Level 1) -->
    <div class="api-children">

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      {% if include.documentation_section contains "payment-menu" %}
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrument %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The payment method used. Selected by using the {% if documentation_section contains "checkout-v3" %}<a href="{{ features_url }}/customize-ui/instrument-mode">Instrument Mode</a>{% else %}<a href="{{ features_url }}/optional/instrument-mode">3-D Secure 2</a>{% endif %}.</div></div>
      </details>
      {% endif %}

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f disableStoredPaymentDetails %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>false</code> by default. Switching to <code>true</code> will turn off all stored payment details for the current purchase. When you use this feature it is important that you have asked the payer in advance if it is ok to store their payment details for later use.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ user_agent_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f generatePaymentToken %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Determines if a payment token should be generated. Default value is <code>false</code>.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/language.md %}</div></div>
      </details>

      {% if documentation_section contains "checkout-v3/payments-only" %}
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f productName %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Used to tag the payment as Online Payments v3.0. Mandatory for Online Payments v3.0, either in this field or the header, as you won't get the operations in the response without submitting this field.</div></div>
      </details>
      {% endif %}

      <!-- urls (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>urls</code> object, containing the URLs relevant for the payment order.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f hostUrls, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>array</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The array of valid host URLs.</div></div>
          </details>

          {% if include.integration_mode=="seamless-view" %}
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f paymentUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payment_url_md | markdownify }}</div></div>
          </details>
          {% endif %}

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f completeUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ complete_url_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f cancelUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an <code>abort</code> request of the <code>payment</code> or <code>paymentorder</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f callbackUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ callback_url_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f termsOfServiceUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ tos_url_md | markdownify }}</div></div>
          </details>

          {% if include.integration_mode=="redirect" %}
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f logoUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ logo_url_md | markdownify }}</div></div>
          </details>
          {% endif %}
        </div>
      </details>

      <!-- payeeInfo (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payee_info_md | markdownify }}</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeId, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The ID of the payee, usually the merchant ID.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(30)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_ref_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeName, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the payee, usually the name of the merchant.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f productCategory, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(50)</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f orderReference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(50)</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The order reference should reflect the order reference found in the merchant's systems.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f subsite, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(40)</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ subsite_md | markdownify }}</div></div>
          </details>

          {% if documentation_section contains "checkout-v3/payments-only" %}
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f siteId, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(15)</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ site_id_md | markdownify }}</div></div>
          </details>
          {% endif %}
        </div>
      </details>

      <!-- payer (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>payer</code> object containing information about the payer relevant for the payment order.</div></div>

        <div class="api-children">
          <!-- scalar children of payer -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f digitalProducts %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>bool</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">Set to <code>true</code> for merchants who only sell digital goods and only require <code>email</code> and/or <code>msisdn</code> as shipping details. Set to <code>false</code> if the merchant also sells physical goods.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f firstName, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The first name of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f lastName, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The last name of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f email, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The e-mail address of the payer. Will be used to prefill the Checkin as well as on the payer's profile, if not already set. Increases the chance for {% if documentation_section contains "checkout-v3" %}<a href="{{ features_url }}/customize-payments/frictionless-payments">frictionless 3-D Secure 2 flow</a>{% else %}<a href="{{ features_url }}/core/frictionless-payments">frictionless 3-D Secure 2 flow</a>{% endif %}.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f msisdn, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The mobile phone number of the payer. Will be prefilled on Checkin page and used on the payer's profile, if not already set. The mobile number must have a country code prefix and be 8 to 15 digits in length. The field is related to {% if documentation_section contains "checkout-v3" %}<a href="{{ features_url }}/customize-payments/frictionless-payments">3-D Secure 2</a>{% else %}<a href="{{ features_url }}/core/frictionless-payments">3-D Secure 2</a>{% endif %}.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payerReference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">A reference used in the Enterprise and Payments Only implementations to recognize the payer when no SSN is stored.</div></div>
          </details>

          <!-- shippingAddress (object) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shippingAddress %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>object</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The shipping address object related to the <code>payer</code>. The field is related to {% if documentation_section contains "checkout-v3" %}<a href="{{ features_url }}/customize-payments/frictionless-payments">3-D Secure 2</a>{% else %}<a href="{{ features_url }}/core/frictionless-payments">3-D Secure 2</a>{% endif %}.</div></div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f firstName, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The first name of the addressee – the receiver of the shipped goods.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f lastName, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The last name of the addressee – the receiver of the shipped goods.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's street address. Maximum 50 characters long.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's c/o address, if applicable.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's zip code.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's city of residence.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Country code for country of residence, e.g. <code>SE</code>, <code>NO</code>, or <code>FI</code>.</div></div>
              </details>
            </div>
          </details>

          <!-- billingAddress (object) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f billingAddress, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>object</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The billing address object containing information about the payer's billing address.</div></div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f firstName,3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The first name of the payer.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f lastName,3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The last name of the payer.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress,3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The street address of the payer. Maximum 50 characters long.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress,3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The CO-address (if used).</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode,3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The postal number (ZIP code) of the payer.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city,3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The city of the payer.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode,3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Country code for country of residence, e.g. <code>SE</code>, <code>NO</code>, or <code>FI</code>.</div></div>
              </details>
            </div>
          </details>

          <!-- accountInfo (object) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f accountInfo %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>object</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">Object related to the <code>payer</code> containing info about the payer's account.</div></div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountAgeIndicator, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates the age of the payer's account. <br><code>01</code> (No account, guest checkout) <br><code>02</code> (Created during this transaction) <br><code>03</code> (Less than 30 days old) <br><code>04</code> (30 to 60 days old) <br><code>05</code> (More than 60 days old)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountChangeIndicator, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates when the last account changes occurred. <br><code>01</code> (Changed during this transaction) <br><code>02</code> (Less than 30 days ago) <br><code>03</code> (30 to 60 days ago) <br><code>04</code> (More than 60 days ago)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountChangePwdIndicator, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates when the account's password was last changed. <br><code>01</code> (No changes) <br><code>02</code> (Changed during this transaction) <br><code>03</code> (Less than 30 days ago) <br><code>04</code> (30 to 60 days ago) <br><code>05</code> (More than 60 days old)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f shippingAddressUsageIndicator, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates when the payer's shipping address was last used. <br><code>01</code> (This transaction) <br><code>02</code> (Less than 30 days ago) <br><code>03</code> (30 to 60 days ago) <br><code>04</code> (More than 60 days ago)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f shippingNameIndicator, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates if the account name matches the shipping name. <br><code>01</code> (Account name identical to shipping name) <br><code>02</code> (Account name different from shipping name)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f suspiciousAccountActivity, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates if there have been any suspicious activities linked to this account. <br><code>01</code> (No suspicious activity has been observed) <br><code>02</code> (Suspicious activity has been observed)</div></div>
              </details>
            </div>
          </details>
        </div>
      </details>

      <!-- orderItems (array) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>array</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/order-items.md %}</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f reference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">A reference that identifies the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f name, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2"><code>PRODUCT</code>, <code>SERVICE</code>, <code>SHIPPING_FEE</code>, <code>PAYMENT_FEE</code> <code>DISCOUNT</code>, <code>VALUE_CODE</code> or <code>OTHER</code>. The type of the order item. <code>PAYMENT_FEE</code> is the amount you are charged with when you are paying with invoice. The amount can be defined in the <code>amount</code> field below.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f class, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The classification of the order item. Can be used for assigning the order item to a specific product category, such as <code>MobilePhone</code>. Note that <code>class</code> cannot contain spaces and must follow the regex pattern <code>[\w-]*</code>. Swedbank Pay may use this field for statistics.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f itemUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to a page that can display the purchased item, product or similar.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f imageUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to an image of the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ description_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountDescription, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the possible discount.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f quantity, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>number</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The 4 decimal precision quantity of order items being purchased.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f quantityUnit, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The unit of the quantity, such as <code>pcs</code>, <code>grams</code>, or similar.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f unitPrice, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The price per unit of order item, including VAT.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountPrice, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">If the order item is purchased at a discounted price. This field should contain that price, including VAT.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatPercent, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The percent value of the VAT multiplied by 100, so <code>25%</code> becomes <code>2500</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ amount_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ vat_amount_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f restrictedToInstruments %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>array</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                A list of the payment methods you wish to restrict the payment to. Currently <code>Invoice</code> only. <code>Invoice</code> supports the subtypes <code>PayExFinancingNo</code>, <code>PayExFinancingSe</code> and <code>PayMonthlyInvoiceSe</code>, separated by a dash, e.g.; <code>Invoice-PayExFinancingNo</code>. Default value is all supported payment methods. Use of this field requires an agreement with Swedbank Pay. You can restrict fees and/or discounts to certain payment methods by adding this field to the orderline you want to restrict. Use positive amounts to add fees and negative amounts to add discounts.
              </div>
            </div>
          </details>
        </div>
      </details>

      <!-- riskIndicator (array) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f riskIndicator %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>array</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            This <strong>optional</strong> object consists of information that helps verifying the payer. Providing these fields decreases the likelihood of having to prompt for 3-D Secure 2.0 authentication of the payer when they are authenticating the purchase.
          </div>
        </div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f deliveryEmailAdress, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                For electronic delivery, the email address to which the merchandise was delivered. Providing this field when appropriate decreases the likelihood of a 3-D Secure authentication for the payer.
              </div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f deliveryTimeFrameIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                Indicates the merchandise delivery timeframe. <br>
                <code>01</code> (Electronic Delivery) <br>
                <code>02</code> (Same day shipping) <br>
                <code>03</code> (Overnight shipping) <br>
                <code>04</code> (Two-day or more shipping)
              </div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f preOrderDate, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                For a pre-ordered purchase. The expected date that the merchandise will be available. Format: <code>YYYYMMDD</code>
              </div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f preOrderPurchaseIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br>
                <code>01</code> (Merchandise available) <br>
                <code>02</code> (Future availability)
              </div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shipIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                Indicates shipping method chosen for the transaction. <br>
                <code>01</code> (Ship to cardholder's billing address) <br>
                <code>02</code> (Ship to another verified address on file with merchant) <br>
                <code>03</code> (Ship to address that is different than cardholder's billing address) <br>
                <code>04</code> (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields) <br>
                <code>05</code> (Digital goods, includes online services, electronic giftcards and redemption codes) <br>
                <code>06</code> (Travel and Event tickets, not shipped) <br>
                <code>07</code> (Other, e.g. gaming, digital service)
              </div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f giftCardPurchase, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>bool</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                <code>true</code> if this is a purchase of a gift card.
              </div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f reOrderPurchaseIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                Indicates whether the cardholder is reordering previously purchased merchandise. <br>
                <code>01</code> (First time ordered) <br>
                <code>02</code> (Reordered)
              </div>
            </div>
          </details>

          <!-- pickUpAddress (object) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f pickUpAddress %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>object</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                If <code>shipIndicator</code> set to <code>04</code>, then prefill with the payer's pick-up address of the purchase to decrease the risk factor of the purchase.
              </div>
            </div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f name, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, then prefill this with the payer's <code>name</code> of the purchase to decrease the risk factor of the purchase.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, prefill with the payer's <code>streetAddress</code> (max 50 chars).</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, prefill with the payer's <code>coAddress</code>.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, prefill with the payer's <code>city</code>.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, prefill with the payer's <code>zipCode</code>.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, prefill with the payer's <code>countryCode</code>.</div></div>
              </details>
            </div>
          </details>
        </div>
      </details>

    </div> 
  </details>
</div>

## Payer Aware Payment Menu Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",
        "created": "2020-06-22T10:56:56.2927632Z",
        "updated": "2020-06-22T10:56:56.4035291Z",
        "operation": "Purchase", {% if documentation_section contains "checkout-v3" %}
        "status": "Initialized", {% else %}
        "state": "Ready", {% endif %}
        "paymentToken" : "{{ page.payment_token }}",
        "currency": "SEK",
        "vatAmount": 375,
        "amount": 1500,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [
          "CreditCard",
          "Invoice-PayExFinancingSe",
          "Invoice-PayMonthlyInvoiceSe",
          "Swish",
          "CreditAccount",
          "Trustly" ], {% if documentation_section contains "checkout-v3" %}
        "implementation": "PaymentsOnly", {% endif %} {% if include.integration_mode=="seamless-view" %}
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
    "operations": [ {% if include.integration_mode=="redirect" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "redirect-checkout",
          "contentType": "text/html"
        },{% endif %} {% if include.integration_mode=="seamless-view" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
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

{%- capture id_md -%}{% include fields/id.md resource="paymentorder" %}{%- endcapture -%}
{%- capture operation_md -%}{% include fields/operation.md %}{%- endcapture -%}
{%- capture amount_md -%}{% include fields/amount.md %}{%- endcapture -%}
{%- capture vat_amount_md -%}{% include fields/vat-amount.md %}{%- endcapture -%}
{%- capture description_md -%}{% include fields/description.md %}{%- endcapture -%}
{%- capture language_md -%}{% include fields/language.md %}{%- endcapture -%}
{%- capture operations_md -%}{% include fields/operations.md %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0 (all nodes CLOSED by default; original order retained except operations promoted to level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <!-- Level 1: children of paymentOrder -->
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

      {% if documentation_section contains "checkout-v3" %}
      <!-- status (checkout-v3) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f status %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Indicates the payment order's current status. <code>Initialized</code> is returned when the payment is created and still ongoing. The request example above has this status.
            <code>Paid</code> is returned when the payer has completed the payment successfully. See the <a href="{{ features_url }}/technical-reference/status-models#paid"><code>Paid</code> response</a>.
            <code>Failed</code> is returned when a payment has failed. You will find an error message in <a href="{{ features_url }}/technical-reference/status-models#failed">the <code>Failed</code> response</a>.
            <code>Cancelled</code> is returned when an authorized amount has been fully cancelled. See the <a href="{{ features_url }}/technical-reference/status-models#cancelled"><code>Cancelled</code> response</a>. It will contain fields from both the cancelled description and paid section.
            <code>Aborted</code> is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page).
            See the <a href="{{ features_url }}/technical-reference/status-models#aborted"><code>Aborted</code> response</a>.
          </div>
        </div>
      </details>
      {% else %}
      <!-- state (non-checkout-v3) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f state %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            <code>Ready</code>, <code>Pending</code>, <code>Failed</code> or <code>Aborted</code>. Indicates the state of the payment order. Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes.
          </div>
        </div>
      </details>
      {% endif %}

      <!-- paymentToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paymentToken %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The payment token generated in the initial purchase.</div></div>
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
        <div class="desc"><div class="indent-1">The <code>userAgent</code> of the system used when the merchant makes a call towards the resource.</div></div>
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
        <div class="desc">
          <div class="indent-1">
            The merchant's Online Payments implementation type. <code>Enterprise</code> or <code>PaymentsOnly</code>.
            We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes.
            If this should happen, updated information will be available in this table.
          </div>
        </div>
      </details>

      <!-- integration -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integration %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            The merchant's Online Payments integration type. <code>HostedView</code> (Seamless View) or <code>Redirect</code>.
            This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe.
            We ask that you don't build logic around this field's response. It is mainly for information purposes, as the integration types might be subject to name changes.
            If this should happen, updated information will be available in this table.
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
        <div class="desc">
          <div class="indent-1">
            Set to <code>true</code> or <code>false</code>. Indicates if the payer chose to pay as a guest or not.
            When using the Payments Only implementation, this is triggered by not including a <code>payerReference</code> in the original <code>paymentOrder</code> request.
          </div>
        </div>
      </details>

      <!-- payer -->
      {% if documentation_section contains "checkout-v3" %}
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#payer"><code>payer</code> resource</a> where information about the payer can be retrieved.
          </div>
        </div>
      </details>
      {% else %}
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payer</code> resource where information about the payer can be retrieved.</div></div>
      </details>
      {% endif %}

      <!-- orderItems -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>orderItems</code> resource where information about the order items can be retrieved.</div></div>
      </details>

      <!-- history -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f history %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>history</code> resource where information about the payment's history can be retrieved.</div></div>
      </details>

      <!-- failed -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failed %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>failed</code> resource where information about the failed transactions can be retrieved.</div></div>
      </details>

      <!-- aborted -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f aborted %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>aborted</code> resource where information about the aborted transactions can be retrieved.</div></div>
      </details>

      <!-- paid -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paid %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>paid</code> resource where information about the paid transactions can be retrieved.</div></div>
      </details>

      <!-- cancelled -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cancelled %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>cancelled</code> resource where information about the cancelled transactions can be retrieved.</div></div>
      </details>

      <!-- financialTransactions -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f financialTransactions %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>financialTransactions</code> resource where information about the financial transactions can be retrieved.</div></div>
      </details>

      <!-- failedAttempts -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failedAttempts %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>failedAttempts</code> resource where information about the failed attempts can be retrieved.</div></div>
      </details>

      <!-- metadata -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>metadata</code> resource where information about the metadata can be retrieved.</div></div>
      </details>
    </div>
  </details>

  <!-- operations promoted to Level 0 -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f operations,0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>array</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        {{ operations_md | markdownify }}
        <a href="{{ features_url }}/technical-reference/operations">See Operations for details</a>.
      </div>
    </div>
  </details>
</div>

{% if documentation_section contains "checkout-v3" %}

## Enable Payment Details Consent Checkbox

Use the same basic initial payment order request, and add the new field
`enablePaymentDetailsConsentCheckbox` in the `paymentOrder` node. Set it to
`true` to show the checkbox used to store payment details for card payments.
Remember to also set `disableStoredPaymentDetails` to `true`.

This option will not work with `Verify`, and will result in a validation error
if you try.

{% capture request_content %}{
 "paymentorder": {
    "enablePaymentDetailsConsentCheckbox": true,
    "disableStoredPaymentDetails": true,
  }
}{% endcapture %}

{% include code-example.html
    title='Payment Details Consent Checkbox'
    header=request_header
    json= request_content
    %}

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- Level 0 (root; node closed by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <!-- Children of paymentOrder (Level 1) -->
    <div class="api-children">

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f EnablePaymentDetailsConsentCheckbox %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Set to <code>true</code> or <code>false</code>. Used to determine if the checkbox used to save payment details is shown or not.
            Will only work if the parameter <code>disableStoredPaymentDetails</code> is set to <code>true</code>.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f disableStoredPaymentDetails %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Set to <code>true</code> or <code>false</code>. Must be set to <code>true</code> for <code>enablePaymentDetailsConsentCheckbox</code> to work.
          </div>
        </div>
      </details>

    </div>
  </details>
</div>

{% endif %}

## Tokens

It is possible to query for all active payment tokens registered on a specific
`payerReference`. After doing so, you can either remove all tokens or a subset
of the tokens registered on the payer. This is the easiest way of cleaning up
all data for **Payments Only** implementations. It is also possible to [delete a
single token][delete-tokens] if you wish to do that.

## GET Tokens Request

Querying with a `GET` request will give you a response containing all tokens and
the operation(s) available for them.

{% capture request_header %}GET /psp/paymentorders/payerownedtokens/<payerReference> HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0 {% endcapture %}

{% include code-example.html
    title='GET Tokens Request'
    header=request_header
    %}

## GET Tokens Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "payerOwnedTokens": {
        "id": "/psp/paymentorders/payerownedtokens/{payerReference}",
        "payerReference": "{payerReference}",
        "tokens": [
            {
                "token": "{paymentToken}",
                "tokenType": "Payment",
                "instrument": "CreditCard",
                "instrumentDisplayName": "492500******0004",
                "correlationId": "e2f06785-805d-4605-bf40-426a725d313d",
                "instrumentParameters": {
                    "expiryDate": "12/2022",
                    "cardBrand": "Visa"
                },
                "operations": [
                    {
                        "method": "PATCH",
                        "href": "https://api.internaltest.payex.com/psp/paymentorders/paymenttokens/0ecf804f-e68f-404e-8ae6-adeb43052559",
                        "rel": "delete-paymenttokens",
                        "contentType": "application/json"
                    }
                ]
            },
            {
                "token": "{paymentToken}",
                "tokenType": "Payment",
                "instrument": "Invoice-payexfinancingno",
                "instrumentDisplayName": "260267*****",
                "correlationId": "e2f06785-805d-4605-bf40-426a725d313d",
                "instrumentParameters": {
                    "email": "hei@hei.no",
                    "msisdn": "+4798765432",
                    "zipCode": "1642"
                },
                "operations": [
                    {
                        "method": "PATCH",
                        "href": "https://api.internaltest.payex.com/psp/paymentorders/paymenttokens/dd9c1103-3e0f-492a-95a3-a39bb32a6b59",
                        "rel": "delete-paymenttokens",
                        "contentType": "application/json"
                    }
                ]
            },
            {
                "token": "{token}",
                "tokenType": "Unscheduled",
                "instrument": "CreditCard",
                "instrumentDisplayName": "492500******0004",
                "correlationId": "e2f06785-805d-4605-bf40-426a725d313d",
                "instrumentParameters": {
                    "expiryDate": "12/2020",
                    "cardBrand": "Visa"
                },
                "operations": [
                    {
                        "method": "PATCH",
                        "href": "https://api.internaltest.payex.com/psp/paymentorders/unscheduledtokens/e2f06785-805d-4605-bf40-426a725d313d",
                        "rel": "delete-unscheduledtokens",
                        "contentType": "application/json"
                    }
                ]
            }
        ]
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.internaltest.payex.com/psp/paymentorders/payerOwnedPaymentTokens/{payerReference}",
            "rel": "delete-payerownedtokens",
            "contentType": "application/json"
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

  <!-- Level 0 (root; nodes CLOSED by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payerOwnedTokens, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The <code>payerOwnedTokens</code> object containing information about the payer relevant for the payment order.</div></div>

    <!-- Children of payerOwnedTokens (Level 1) -->
    <div class="api-children">
      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/id.md resource="paymentorder" %}</div></div>
      </details>

      <!-- payerReference -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payerReference, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A reference used in the Enterprise and Payments Only implementations to recognize the payer when no SSN is stored.</div></div>
      </details>

      <!-- tokens (list) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f tokens, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of tokens connected to the payment.</div></div>

        <!-- Children of each token item (Level 2) -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f token, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The token <code>guid</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f tokenType, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% f payment, 0 %}, <code>recurrence</code>, <code>transactionOnFile</code> or <code>unscheduled</code>. The different types of available tokens.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f instrument, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payment method connected to the token.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f instrumentDisplayName, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payment method connected to the token.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f correlationId, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A unique ID used in the system. Makes it easier to see cards, accounts etc. the token is connected to.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f instrumentParameters, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A list of additional information connected to the token. Depending on the payment method, it can e.g. be <code>expiryDate</code>, <code>cardBrand</code>, <code>email</code>, <code>msisdn</code> or <code>zipCode</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
                <span class="field">{% f operations, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                <span class="type"><code>array</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/operations.md resource="token" %}</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>

  <!-- Level 0 sibling: operations -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f operations, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>array</code></span>
    </summary>
    <div class="desc"><div class="indent-0">{% include fields/operations.md resource="token" %}</div></div>
  </details>
</div>

## PATCH Request For Removing Tokens

You can remove the tokens by using the following `PATCH` request.

{% capture request_header %}PATCH /psp/paymentorders/payerownedtokens/<payerReference> HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
  "state": "Deleted",
  "comment": "Some words about why the tokens are being deleted"
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
  </div>

  <!-- Level 0 (root; node closed by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f state, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The state you want the token to be in.</div></div>
  </details>
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f comment, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">Explanation as to why the token is being deleted.</div></div>
  </details>
</div>

Which will provide this response.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "payerOwnedTokens": {
        "id": "/psp/paymentorders/payerownedtokens/{payerReference}",
        "payerReference": "{payerReference}",
        "tokens": [
            {
                "token": "{paymentToken}",
                "tokenType": "Payment",
                "instrument": "Invoice-payexfinancingno",
                "instrumentDisplayName": "260267*****",

                "instrumentParameters": {
                    "email": "hei@hei.no",
                    "msisdn": "+4798765432",
                    "zipCode": "1642"
                }
            },
            {
                "token": "{paymentToken}",
                "tokenType": "Unscheduled",
                "instrument": "CreditCard",
                "instrumentDisplayName": "492500******0004",
                "correlationId": "e2f06785-805d-4605-bf40-426a725d313d",
                "instrumentParameters": {
                    "expiryDate": "12/2020",
                    "cardBrand": "Visa"
                }
            }
        ]
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

  <!-- Level 0 (root; node closed by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payerOwnedTokens, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The <code>payerOwnedTokens</code> object containing information about the payer relevant for the payment order.</div></div>

    <!-- Children of payerOwnedTokens (Level 1) -->
    <div class="api-children">

      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/id.md resource="paymentorder" %}</div></div>
      </details>

      <!-- payerReference -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payerReference %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A reference used in the Enterprise and Payments Only implementations to recognize the payer when no SSN is stored.</div></div>
      </details>

      <!-- tokens (array-like list; spec says integer but holds list items) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f tokens %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of tokens connected to the payment.</div></div>

        <!-- Children of each token item (Level 2) -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f token, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The token <code>guid</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f tokenType, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% f payment, 0 %}, <code>recurrence</code>, <code>transactionOnFile</code> or <code>unscheduled</code>. The different types of available tokens.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f instrument, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payment methods connected to the token.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f instrumentDisplayName, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payment method connected to the token.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f correlationId, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A unique ID used in the system. Makes it easier to see cards, accounts etc. the token is connected to.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f instrumentParameters, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A list of additional information connected to the token. Depending on the payment method, it can e.g. be <code>expiryDate</code>, <code>cardBrand</code>, <code>email</code>, <code>msisdn</code> or <code>zipCode</code>.</div></div>
          </details>
        </div>
      </details>

    </div>
  </details>
</div>

[delete-tokens]: {{ features_url }}/optional/delete-token
[tokens]: {{ features_url }}/optional/payer-aware-payment-menu#tokens
[verify]: {{ features_url }}/optional/verify
[trustly-presentation]: /checkout-v3/trustly-presentation
