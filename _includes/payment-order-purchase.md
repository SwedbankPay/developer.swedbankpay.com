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

      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/operation.md %}</div></div>
      </details>

      <!-- currency -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment.</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/amount.md %}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/vat-amount.md %}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The description of the payment order.</div></div>
      </details>

      {% if documentation_section contains "payment-menu" %}
      <!-- generatePaymentToken (conditional) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f generatePaymentToken %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Determines if a payment token should be generated. A payment token is used to enable future one-click payments – with the same token. Default value is <code>false</code>.</div></div>
      </details>
      {% endif %}

      <!-- generateRecurrenceToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f generateRecurrenceToken %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Determines if a recurrence token should be generated. A recurrence token is primarily used to enable future <a href="{{ features_url }}/optional/recur">recurring payments</a> – with the same token – through server-to-server calls. Default value is <code>false</code>.</div></div>
      </details>

      <!-- generateUnscheduledToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f generateUnscheduledToken %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Determines if an unscheduled token should be generated. An unscheduled token is primarily used to enable future <a href="{{ features_url }}/optional/unscheduled">unscheduled payments</a> – with the same token – through server-to-server calls. Default value is <code>false</code>.</div></div>
      </details>

      <!-- userAgent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/user-agent.md %}</div></div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The language of the payer.</div></div>
      </details>

      <!-- urls object -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>urls</code> object, containing the URLs relevant for the payment order.</div></div>

        <!-- Children of urls (Level 2) -->
        <div class="api-children">

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f hostUrls, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>array</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The array of URLs valid for embedding of Swedbank Pay Seamless Views.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f completeUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/complete-url.md %}</div></div>
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
              <span class="field">{% f paymentUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/payment-url-paymentorder.md %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f callbackUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/callback-url.md %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f termsOfServiceUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/terms-of-service-url.md %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f logoUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/logo-url.md %}</div></div>
          </details>

        </div>
      </details>

      <!-- payeeInfo object -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/payee-info.md %}</div></div>

        <!-- Children of payeeInfo (Level 2) -->
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
            <div class="desc"><div class="indent-2">{% include fields/payee-reference.md describe_receipt=true %}</div></div>
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
            <div class="desc"><div class="indent-2">{% include fields/subsite.md %}</div></div>
          </details>

        </div>
      </details>

      <!-- payer object -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>payer</code> object containing information about the payer relevant for the payment order.</div></div>

        <!-- Children of payer (Level 2) -->
        <div class="api-children">

          {% if documentation_section contains "checkout" -%}
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f consumerProfileRef, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The consumer profile reference as obtained through <a href="/{{ documentation_section }}/checkin#step-1-initiate-session-for-consumer-identification">initiating a consumer session</a>.</div></div>
          </details>
          {%- endif %}

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f email, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The e-mail address of the payer. Will be used to prefill the Checkin as well as on the payer's profile, if not already set. Increases the chance for {% if documentation_section contains "checkout-v3" %} <a href="{{ features_url }}/customize-payments/frictionless-payments">frictionless 3-D Secure 2 flow</a> {% else %} <a href="{{ features_url }}/core/frictionless-payments">frictionless 3-D Secure 2 flow</a> {% endif %}.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f msisdn, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The mobile phone number of the Payer. Will be prefilled on Checkin page and used on the payer's profile, if not already set. The mobile number must have a country code prefix and be 8 to 15 digits in length. The field is related to {% if documentation_section contains "checkout-v3" %} <a href="{{ features_url }}/customize-payments/frictionless-payments">3-D Secure 2</a> {% else %} <a href="{{ features_url }}/core/frictionless-payments">3-D Secure 2</a> {% endif %}.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f workPhoneNumber, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The work phone number of the payer. Optional (increased chance for frictionless flow if set) and is related to {% if documentation_section contains "checkout-v3" %} <a href="{{ features_url }}/customize-payments/frictionless-payments">3-D Secure 2</a> {% else %} <a href="{{ features_url }}/core/frictionless-payments">3-D Secure 2</a> {% endif %}.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f homePhoneNumber, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The home phone number of the payer. Optional (increased chance for frictionless flow if set) and is related to {% if documentation_section contains "checkout-v3" %} <a href="{{ features_url }}/customize-payments/frictionless-payments">3-D Secure 2</a> {% else %} <a href="{{ features_url }}/core/frictionless-payments">3-D Secure 2</a> {% endif %}.</div></div>
          </details>

        </div>
      </details>

      <!-- riskIndicator (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f riskIndicator %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc">
          <div class="indent-1">This <strong>optional</strong> object consists of information that helps verifying the payer. Providing these fields decreases the likelihood of having to prompt for 3-D Secure 2 authentication.</div>
        </div>

        <!-- Children of riskIndicator (Level 2) -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f deliveryEmailAdress, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">For electronic delivery, the email address to which the merchandise was delivered.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f deliveryTimeFrameIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the merchandise delivery timeframe. <br><code>01</code> (Electronic Delivery) <br><code>02</code> (Same day shipping) <br><code>03</code> (Overnight shipping) <br><code>04</code> (Two-day or more shipping)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f preOrderDate, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">For a pre-ordered purchase. The expected date that the merchandise will be available. Format: <code>YYYYMMDD</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f preOrderPurchaseIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br><code>01</code> (Merchandise available) <br><code>02</code> (Future availability)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shipIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates shipping method chosen for the transaction. <br><code>01</code> (Ship to cardholder's billing address) <br><code>02</code> (Ship to another verified address on file with merchant) <br><code>03</code> (Ship to address different than billing) <br><code>04</code> (Ship to Store / Pick-up at local store) <br><code>05</code> (Digital goods) <br><code>06</code> (Travel/Event tickets) <br><code>07</code> (Other)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f giftCardPurchase, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>bool</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>true</code> if this is a purchase of a gift card.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f reOrderPurchaseIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates whether the cardholder is reordering previously purchased merchandise. <br><code>01</code> (First time ordered) <br><code>02</code> (Reordered)</div></div>
          </details>

          <!-- pickUpAddress (object) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f pickUpAddress %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>object</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">If <code>shipIndicator</code> is <code>04</code>, provide the payer’s pick-up address to decrease the risk factor of the purchase.</div></div>

            <!-- Children of pickUpAddress (Level 3) -->
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f name, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Name of the addressee for pickup.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Street address. Maximum 50 characters.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Care of address, if applicable.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">City.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">ZIP/Postal code.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Country code.</div></div>
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

        <!-- Children of orderItems items (Level 2) -->
        <div class="api-children">
          <!-- (unchanged children as in your snippet) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f reference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">A reference that identifies the order item.</div></div>
          </details>
          <!-- ... (resten av orderItems-fälten som du redan hade) ... -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/vat-amount.md %}</div></div>
          </details>
        </div>
      </details>

    </div><!-- /.api-children (paymentOrder) -->
  </details><!-- /.level-0 -->
</div><!-- /.api-compact -->

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

{% capture id_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
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

      <!-- instrument -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrument %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The payment method used.</div></div>
      </details>

      <!-- paymentToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paymentToken %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The payment token created if <code>generatePaymentToken: true</code> was used. Enables future one-click payments – with the same token.</div></div>
      </details>

      <!-- recurrenceToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f recurrenceToken %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The recurrence token created if <code>generateRecurrenceToken: true</code> was used. Enables future <a href="{{ features_url }}/optional/recur">recurring payments</a> – with the same token.</div></div>
      </details>

      <!-- unscheduledToken -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f unscheduledToken %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The unscheduled token created if <code>generateUnscheduledToken: true</code> was used. Enables future <a href="{{ features_url }}/optional/unscheduled">unscheduled payments</a> – with the same token.</div></div>
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
        <div class="desc"><div class="indent-1"><code>Purchase</code></div></div>
      </details>

      <!-- state -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f state %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Ready</code>, <code>Pending</code>, <code>Failed</code> or <code>Aborted</code>. Indicates the state of the payment order. Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes.</div></div>
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

      <!-- userAgent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ user_agent_md | markdownify }}</div></div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <!-- urls (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>urls</code> resource where all URLs related to the payment order can be retrieved.</div></div>
      </details>

      <!-- payeeInfo (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payeeInfo</code> resource where information related to the payee can be retrieved.</div></div>
      </details>

      <!-- payers (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payers %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payer</code> resource where information about the payer can be retrieved.</div></div>
      </details>

      <!-- orderItems (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>orderItems</code> resource where information about the order items can be retrieved.</div></div>
      </details>

      <!-- metadata (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>metadata</code> resource where information about the metadata can be retrieved.</div></div>
      </details>

      <!-- payments (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payments %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payments</code> resource where information about all underlying payments can be retrieved.</div></div>
      </details>

      <!-- currentPayment (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currentPayment %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>currentPayment</code> resource where information about the current – and sole active – payment can be retrieved.</div></div>
      </details>

      <!-- operations (array) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operations %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operations_md | markdownify }}</div></div>
      </details>

    </div><!-- /.api-children -->
  </details><!-- /.level-0 -->
</div>
