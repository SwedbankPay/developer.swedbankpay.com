{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{% assign features_url = documentation_section | prepend: '/' | append: '/features' %}

## Payment Order Request

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",{% if documentation_section contains "payment-menu" %}
        "generatePaymentToken": {{ operation_status_bool }},{% endif %}
        "generateRecurrenceToken": {{ operation_status_bool }},
        "generateUnscheduledToken": {{ operation_status_bool }},
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "paymentUrl": "https://example.com/perform-payment",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditions.pdf",
            "logoUrl": "https://example.com/logo.png"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456",
            "subsite": "MySubsite"
        },
        "payer": {  {% if documentation_section contains "checkout" %}
            "consumerProfileRef": "{{ page.payment_token }}"{% else %}
            "email": "olivia.nyhuus@swedbankpay.com",
            "msisdn": "+4798765432",
            "workPhoneNumber" : "+4787654321",
            "homePhoneNumber" : "+4776543210"{% endif %}
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

  <!-- paymentOrder root -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
    <div class="api-children">

      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">{% capture _inc_operation %}{% include fields/operation.md %}{% endcapture %}{{ _inc_operation | markdownify }}</div>
        </div>
      </details>

      <!-- currency -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment.</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">{% capture _inc_amount %}{% include fields/amount.md %}{% endcapture %}{{ _inc_amount | markdownify }}</div>
        </div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">{% capture _inc_vat_amount %}{% include fields/vat-amount.md %}{% endcapture %}{{ _inc_vat_amount | markdownify }}</div>
        </div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The description of the payment order.</div></div>
      </details>

      {% if documentation_section contains "payment-menu" %}
      <!-- generatePaymentToken (conditional) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f generatePaymentToken, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Determines if a payment token should be generated. A payment token is used to enable future one-click payments – with the same token. Default value is <code>false</code>.</div></div>
      </details>
      {% endif %}

      <!-- generateRecurrenceToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f generateRecurrenceToken, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Determines if a recurrence token should be generated. A recurrence token is primarily used to enable future <a href="{{ features_url }}/optional/recur">recurring payments</a> – with the same token – through server-to-server calls. Default value is <code>false</code>.</div></div>
      </details>

      <!-- generateUnscheduledToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f generateUnscheduledToken, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Determines if an unscheduled token should be generated. An unscheduled token is primarily used to enable future <a href="{{ features_url }}/optional/unscheduled">unscheduled payments</a> – with the same token – through server-to-server calls. Default value is <code>false</code>.</div></div>
      </details>

      <!-- userAgent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">{% capture _inc_user_agent %}{% include fields/user-agent.md %}{% endcapture %}{{ _inc_user_agent | markdownify }}</div>
        </div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The language of the payer.</div></div>
      </details>

      <!-- urls object -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>urls</code> object, containing the URLs relevant for the payment order.</div></div>
        <div class="api-children">

          <!-- hostUrls -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f hostUrls, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>array</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The array of URLs valid for embedding of Swedbank Pay Seamless Views.</div></div>
          </details>

          <!-- completeUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f completeUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc">
              <div class="indent-2">{% capture _inc_complete %}{% include fields/complete-url.md %}{% endcapture %}{{ _inc_complete | markdownify }}</div>
            </div>
          </details>

          <!-- cancelUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f cancelUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an <code>abort</code> request of the <code>payment</code> or <code>paymentorder</code>.</div></div>
          </details>

          <!-- paymentUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f paymentUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">{% capture _inc_payment_url %}{% include fields/payment-url-paymentorder.md %}{% endcapture %}{{ _inc_payment_url | markdownify }}</div>
            </div>
          </details>

          <!-- callbackUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f callbackUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc">
              <div class="indent-2">{% capture _inc_callback %}{% include fields/callback-url.md %}{% endcapture %}{{ _inc_callback | markdownify }}</div>
            </div>
          </details>

          <!-- termsOfServiceUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f termsOfServiceUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc">
              <div class="indent-2">{% capture _inc_tos %}{% include fields/terms-of-service-url.md %}{% endcapture %}{{ _inc_tos | markdownify }}</div>
            </div>
          </details>

          <!-- logoUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f logoUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc">
              <div class="indent-2">{% capture _inc_logo %}{% include fields/logo-url.md %}{% endcapture %}{{ _inc_logo | markdownify }}</div>
            </div>
          </details>
        </div>
      </details>

      <!-- payeeInfo -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">{% capture _inc_payeeinfo %}{% include fields/payee-info.md %}{% endcapture %}{{ _inc_payeeinfo | markdownify }}</div>
        </div>
        <div class="api-children">

          <!-- payeeId -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeId, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The ID of the payee, usually the merchant ID.</div></div>
          </details>

          <!-- payeeReference -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc">
              <div class="indent-2">{% capture _inc_payee_ref %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}{{ _inc_payee_ref | markdownify }}</div>
            </div>
          </details>

          <!-- payeeName -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the payee, usually the name of the merchant.</div></div>
          </details>

          <!-- productCategory -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f productCategory, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.</div></div>
          </details>

          <!-- orderReference -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f orderReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The order reference should reflect the order reference found in the merchant's systems.</div></div>
          </details>

          <!-- subsite -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f subsite, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(40)</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">{% capture _inc_subsite %}{% include fields/subsite.md %}{% endcapture %}{{ _inc_subsite | markdownify }}</div>
            </div>
          </details>
        </div>
      </details>

      <!-- payer -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>payer</code> object containing information about the payer relevant for the payment order.</div></div>
        <div class="api-children">

          {% if documentation_section contains "checkout" -%}
          <!-- consumerProfileRef (conditional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f consumerProfileRef, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The consumer profile reference as obtained through <a href="/{{ documentation_section }}/checkin#step-1-initiate-session-for-consumer-identification">initiating a consumer session</a>.</div></div>
          </details>
          {% endif -%}

          <!-- email -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f email, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">The e-mail address of the payer. Will be used to prefill the Checkin as well as on the payer's profile, if not already set. Increases the chance for {% if documentation_section contains "checkout-v3" %} <a href="{{ features_url }}/customize-payments/frictionless-payments">frictionless 3-D Secure 2 flow</a> {% else %} <a href="{{ features_url }}/core/frictionless-payments">frictionless 3-D Secure 2 flow</a> {% endif %}.</div>
            </div>
          </details>

          <!-- msisdn -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f msisdn, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">The mobile phone number of the Payer. Will be prefilled on Checkin page and used on the payer's profile, if not already set. The mobile number must have a country code prefix and be 8 to 15 digits in length. The field is related to {% if documentation_section contains "checkout-v3" %} <a href="{{ features_url }}/customize-payments/frictionless-payments">3-D Secure 2</a> {% else %} <a href="{{ features_url }}/core/frictionless-payments">3-D Secure 2</a> {% endif %}.</div>
            </div>
          </details>

          <!-- workPhoneNumber -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f workPhoneNumber, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">The work phone number of the payer. Optional (increased chance for frictionless flow if set) and is related to {% if documentation_section contains "checkout-v3" %} <a href="{{ features_url }}/customize-payments/frictionless-payments">3-D Secure 2</a> {% else %} <a href="{{ features_url }}/core/frictionless-payments">3-D Secure 2</a> {% endif %}.</div>
            </div>
          </details>

          <!-- homePhoneNumber -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f homePhoneNumber, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">The home phone number of the payer. Optional (increased chance for frictionless flow if set) and is related to {% if documentation_section contains "checkout-v3" %} <a href="{{ features_url }}/customize-payments/frictionless-payments">3-D Secure 2</a> {% else %} <a href="{{ features_url }}/core/frictionless-payments">3-D Secure 2</a> {% endif %}.</div>
            </div>
          </details>
        </div>
      </details>

      <!-- orderItems -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">{% capture _inc_order_items %}{% include fields/order-items.md %}{% endcapture %}{{ _inc_order_items | markdownify }}</div>
        </div>
        <div class="api-children">

          <!-- reference -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f reference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">A reference that identifies the order item.</div></div>
          </details>

          <!-- name -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the order item.</div></div>
          </details>

          <!-- type -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2"><code>PRODUCT</code>, <code>SERVICE</code>, <code>SHIPPING_FEE</code>, <code>PAYMENT_FEE</code> <code>DISCOUNT</code>, <code>VALUE_CODE</code> or <code>OTHER</code>. The type of the order item. <code>PAYMENT_FEE</code> is the amount you are charged with when you are paying with invoice. The amount can be defined in the <code>amount</code> field below.</div></div>
          </details>

          <!-- class -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f class, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The classification of the order item. Can be used for assigning the order item to a specific product category, such as <code>MobilePhone</code>. Note that <code>class</code> cannot contain spaces and must follow the regex pattern <code>[\w-]*</code>. Swedbank Pay may use this field for statistics.</div></div>
          </details>

          <!-- itemUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f itemUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to a page that can display the purchased item, product or similar.</div></div>
          </details>

          <!-- imageUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f imageUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to an image of the order item.</div></div>
          </details>

          <!-- description (order item) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">{% capture _inc_item_desc %}{% include fields/description.md %}{% endcapture %}{{ _inc_item_desc | markdownify }}</div>
            </div>
          </details>

          <!-- discountDescription -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountDescription, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the possible discount.</div></div>
          </details>

          <!-- quantity -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f quantity, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>number</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The 4 decimal precision quantity of order items being purchased.</div></div>
          </details>

          <!-- quantityUnit -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f quantityUnit, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The unit of the quantity, such as <code>pcs</code>, <code>grams</code>, or similar. This is used for your own book keeping.</div></div>
          </details>

          <!-- unitPrice -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f unitPrice, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The price per unit of order item, including VAT.</div></div>
          </details>

          <!-- discountPrice -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountPrice, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If the order item is purchased at a discounted price. This field should contain that price, including VAT.</div></div>
          </details>

          <!-- vatPercent -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatPercent, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The percent value of the VAT multiplied by 100, so <code>25%</code> becomes <code>2500</code>.</div></div>
          </details>

          <!-- amount (order item) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc">
              <div class="indent-2">{% capture _inc_item_amount %}{% include fields/amount.md %}{% endcapture %}{{ _inc_item_amount | markdownify }}</div>
            </div>
          </details>

          <!-- vatAmount (order item) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc">
              <div class="indent-2">{% capture _inc_item_vat_amount %}{% include fields/vat-amount.md %}{% endcapture %}{{ _inc_item_vat_amount | markdownify }}</div>
            </div>
          </details>

        </div>
      </details>
<details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f riskIndicator %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>array</code></span>
    </summary>
    <div class="desc"><div class="indent-0">This **optional** object consist of information that helps verifying the payer. Providing these fields decreases the likelihood of having to prompt for 3-D Secure 2.0 authentication of the payer when they are authenticating the purchase.</div></div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f deliveryEmailAdress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">For electronic delivery, the email address to which the merchandise was delivered. Providing this field when appropriate decreases the likelihood of a 3-D Secure authentication for the payer.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f deliveryTimeFrameIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates the merchandise delivery timeframe. <br>`01` (Electronic Delivery) <br>`02` (Same day shipping) <br>`03` (Overnight shipping) <br>`04` (Two-day or more shipping)</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f preOrderDate, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">For a pre-ordered purchase. The expected date that the merchandise will be available. Format: `YYYYMMDD`</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f preOrderPurchaseIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br>`01` (Merchandise available) <br>`02` (Future availability)</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f shipIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates shipping method chosen for the transaction. <br>`01` (Ship to cardholder's billing address) <br>`02` (Ship to another verified address on file with merchant)<br>`03` (Ship to address that is different than cardholder's billing address)<br>`04` (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)<br>`05` (Digital goods, includes online services, electronic giftcards and redemption codes) <br>`06` (Travel and Event tickets, not shipped) <br>`07` (Other, e.g. gaming, digital service)</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f giftCardPurchase, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">`true` if this is a purchase of a gift card.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f reOrderPurchaseIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates whether the cardholder is reordering previously purchased merchandise. <br>`01` (First time ordered) <br>`02` (Reordered).</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f pickUpAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">If `shipIndicator` set to `04`, then prefill this with the payers `pickUpAddress` of the purchase to decrease the risk factor of the purchase.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If `shipIndicator` set to `04`, then prefill this with the payers `name` of the purchase to decrease the risk factor of the purchase.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f streetAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If `shipIndicator` set to `04`, then prefill this with the payers `streetAddress` of the purchase to decrease the risk factor of the purchase. Maximum 50 characters long.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f coAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If `shipIndicator` set to `04`, then prefill this with the payers `coAddress` of the purchase to decrease the risk factor of the purchase.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f city, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If `shipIndicator` set to `04`, then prefill this with the payers `city` of the purchase to decrease the risk factor of the purchase.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f zipCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If `shipIndicator` set to `04`, then prefill this with the payers `zipCode` of the purchase to decrease the risk factor of the purchase.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f countryCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If `shipIndicator` set to `04`, then prefill this with the payers `countryCode` of the purchase to decrease the risk factor of the purchase.</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
    </div>
  </details>
</div>

## Payment Order Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",{% if documentation_section contains "payment-menu" %}
        "instrument": "CreditCard",
        "paymentToken" : "{{ page.payment_token }}",{% endif %}
        "recurrenceToken": {{ page.recurrence_token }},
        "unscheduledToken": {{ page.unscheduled_token }},
        "created": "2020-06-22T10:56:56.2927632Z",
        "updated": "2020-06-22T10:56:56.4035291Z",
        "operation": "Purchase",
        "state": "Ready",
        "currency": "SEK",
        "amount": 10000,
        "vatAmount": 0,
        "orderItems": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderitems"
        },
        "description": "test description",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0",
        "language": "sv-SE",
        "urls": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/payeeInfo"
        },
        "payments": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/payments"
        },
        "currentPayment": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/currentpayment"
        },
        "items": [
            {
                "creditCard": {
                    "cardBrands": [
                        "Visa",
                        "MasterCard"
                    ]
                }
            }
        ]
    }
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.front_end_url }}/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-updateorder",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "{{ page.front_end_url }}/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-expandinstrument",
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


<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- paymentOrder root -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
    <div class="api-children">

      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% capture _id %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}{{ _id | markdownify }}</div></div>
      </details>

      <!-- instrument -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrument, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The payment method used.</div></div>
      </details>

      <!-- paymentToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paymentToken, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The payment token created if <code>generatePaymentToken: true</code> was used. Enables future one-click payments – with the same token.</div></div>
      </details>

      <!-- recurrenceToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f recurrenceToken, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The recurrence token created if <code>generateRecurrenceToken: true</code> was used. Enables future <a href="{{ features_url }}/optional/recur">recurring payments</a> – with the same token.</div></div>
      </details>

      <!-- unscheduledToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f unscheduledToken, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The unscheduled token created if <code>generateUnscheduledToken: true</code> was used. Enables future <a href="{{ features_url }}/optional/unscheduled">unscheduled payments</a> – with the same token.</div></div>
      </details>

      <!-- created -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO-8601 date of when the payment order was created.</div></div>
      </details>

      <!-- updated -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO-8601 date of when the payment order was updated.</div></div>
      </details>

      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Purchase</code></div></div>
      </details>

      <!-- state -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f state, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Ready</code>, <code>Pending</code>, <code>Failed</code> or <code>Aborted</code>. Indicates the state of the payment order. Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes.</div></div>
      </details>

      <!-- currency -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment order.</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% capture _amount %}{% include fields/amount.md %}{% endcapture %}{{ _amount | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% capture _vat %}{% include fields/vat-amount.md %}{% endcapture %}{{ _vat | markdownify }}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% capture _desc %}{% include fields/description.md %}{% endcapture %}{{ _desc | markdownify }}</div></div>
      </details>

      <!-- userAgent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% capture _ua %}{% include fields/user-agent.md %}{% endcapture %}{{ _ua | markdownify }}</div></div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% capture _lang %}{% include fields/language.md %}{% endcapture %}{{ _lang | markdownify }}</div></div>
      </details>

      <!-- urls (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>urls</code> resource where all URLs related to the payment order can be retrieved.</div></div>
      </details>

      <!-- payeeInfo (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payeeInfo</code> resource where information related to the payee can be retrieved.</div></div>
      </details>

      <!-- payers (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payers, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payer</code> resource where information about the payer can be retrieved.</div></div>
      </details>

      <!-- orderItems (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>orderItems</code> resource where information about the order items can be retrieved.</div></div>
      </details>

      <!-- metadata (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>metadata</code> resource where information about the metadata can be retrieved.</div></div>
      </details>

      <!-- payments (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payments, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payments</code> resource where information about all underlying payments can be retrieved.</div></div>
      </details>

      <!-- currentPayment (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currentPayment, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>currentPayment</code> resource where information about the current – and sole active – payment can be retrieved.</div></div>
      </details>
    </div>
  </details>
  <!-- operations -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>array</code></span>
    </summary>
    <div class="desc"><div class="indent-0">{% capture _ops %}{% include fields/operations.md %}{% endcapture %}{{ _ops | markdownify }}</div></div>
  </details>
</div>
