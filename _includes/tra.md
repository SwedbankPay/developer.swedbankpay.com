{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% assign api_resource_field_name = 'paymentorder' %}
{% if api_resource != 'paymentorders' %}
    {% assign api_resource_field_name = 'payment' %}
{% endif %}
{% assign implementation = documentation_section | split: "/"  | last | capitalize | remove: "-" %}

## Transaction Risk Analysis Exemption

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "requestTraExemption": true,
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0",
        "language": "sv-SE", {% if documentation_section contains "checkout-v3" %}
        "productName": "Checkout3", // Removed in 3.1, can be excluded in 3.0 if version is added in header
        {% endif %}
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
            "siteId": "MySiteId", {% endif %}
        },
        "payer": {
            "nationalIdentifier": {
                "socialSecurityNumber": "{{ page.consumer_ssn_se }}",
                "countryCode": "SE"
            "requireConsumerInfo": false,
            "digitalProducts": false,
            "email": "olivia.nyhuus@swedbankpay.com",
            "msisdn": "+4798765432",
            "authentication" : {
                "type" : "Digital",
                "method" : "OneFactor",
                "nationalIdentityCardType": null,
                "reference" : null
            },
            "shippingAddress": {
                "firstName": "Olivia",
                "lastName": "Nyhuus",
                "email": "olivia.nyhuus@swedbankpay.com",
                "msisdn": "+4798765432",
                "streetAddress": "Saltnestoppen 43",
                "coAddress": "",
                "city": "Saltnes",
                "zipCode": "1642",
                "countryCode": "NO"
              },
              "billingAddress": {
                "firstName": "Olivia",
                "lastName": "Nyhuus",
                "email": "olivia.nyhuus@swedbankpay.com",
                "msisdn": "+4798765432",
                "streetAddress": "Saltnestoppen 43",
                "coAddress": "",
                "city": "Saltnes",
                "zipCode": "1642",
                "countryCode": "NO"
              },
              "accountInfo": {
                "accountAgeIndicator": "01",
                "accountChangeIndicator": "01",
                "accountPwdChangeIndicator": "01",
                "shippingAddressUsageIndicator": "01",
                "shippingNameIndicator": "01",
                "suspiciousAccountActivity": "01",
                "addressMatchIndicator": true
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
            "deliveryTimeFrameindicator": "01",
            "preOrderDate": "20210220",
            "preOrderPurchaseIndicator": "01",
            "shipIndicator": "01",
            "giftCardPurchase": false,
            "reOrderPurchaseIndicator": "01",
            "pickUpAddress": {
            "name": "Company Megashop Sarpsborg",
            "streetAddress": "Hundskinnveien 92",
            "coAddress": "",
            "city": "Sarpsborg",
            "zipCode": "1711",
            "countryCode": "NO"
            },
            "items": [
            {
                "gpcNumber": 11220000,
                "amount": 5000
            },
            {
                "gpcNumber": 12340000,
                "amount": 3000
            }
            ]
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

  <!-- paymentOrder (root) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    {% capture paymentorder_md %}{% include fields/id.md resource="paymentorder" sub_resource="payer" %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ paymentorder_md | markdownify }}</div></div>

    <div class="api-children">
      <!-- requestTraExemption -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f requestTraExemption %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> if the merchant requests a TRA exemption.</div></div>
      </details>

      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture operation_md %}{% include fields/operation.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }}</div></div>
      </details>

      <!-- currency -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment in the ISO 4217 format (e.g. `EUR`, `DKK`, `NOK` or `SEK`). Some payment methods are only available with selected currencies.</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The description of the payment order.</div></div>
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
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The language of the payer.</div></div>
      </details>

      <!-- productName -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f productName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Used to tag the payment as Online Payments v3.0, either in this field or the header, as you won't get the operations in the response without submitting this field.</div></div>
      </details>

      <!-- implementation (optional) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates which implementation to use.</div></div>
      </details>

      <!-- urls -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
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
            <div class="desc"><div class="indent-2">The array of valid host URLs.</div></div>
          </details>

          <!-- paymentUrl (conditional, seamless-view) -->
          {% if include.integration_mode=="seamless-view" %}
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f paymentUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            {% capture payment_url_md %}{% include fields/payment-url.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ payment_url_md | markdownify }}</div></div>
          </details>
          {% endif %}

          <!-- completeUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f completeUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            {% capture complete_url_md %}{% include fields/complete-url.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ complete_url_md | markdownify }}</div></div>
          </details>

          <!-- cancelUrl (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f cancelUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an <code>abort</code> request of the <code>payment</code> or <code>paymentorder</code>.</div></div>
          </details>

          <!-- callbackUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f callbackUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            {% capture callback_url_md %}{% include fields/callback-url.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ callback_url_md | markdownify }}</div></div>
          </details>

          <!-- termsOfServiceUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f termsOfServiceUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            {% capture tos_url_md %}{% include fields/terms-of-service-url.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ tos_url_md | markdownify }}</div></div>
          </details>

          <!-- logoUrl (conditional, redirect) -->
          {% if include.integration_mode=="redirect" %}
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f logoUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            {% capture logo_url_md %}{% include fields/logo-url.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ logo_url_md | markdownify }}</div></div>
          </details>
          {% endif %}
        </div>
      </details>

      <!-- payeeInfo -->
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
            <div class="desc"><div class="indent-2">The ID of the payee, usually the merchant ID.</div></div>
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
            <div class="desc"><div class="indent-2">The name of the payee, usually the name of the merchant.</div></div>
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

          <!-- subsite (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f subsite, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(40)</code></span>
            </summary>
            {% capture subsite_md %}{% include fields/subsite.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ subsite_md | markdownify }}</div></div>
          </details>

          <!-- siteId (conditional section) -->
          {% if documentation_section contains "checkout-v3" %}
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f siteId, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(15)</code></span>
            </summary>
            {% capture site_id_md %}{% include fields/site-id.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ site_id_md | markdownify }}</div></div>
          </details>
          {% endif %}
        </div>
      </details>

      <!-- payer -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The payer object.</div></div>

        <div class="api-children">
          <!-- nationalIdentifier -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f nationalIdentifier, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The national identifier object.</div></div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f socialSecurityNumber, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The payer's social security number.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The country code of the payer.</div></div>
              </details>
            </div>
          </details>

          <!-- requireConsumerInfo -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f requireConsumerInfo %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Set to <code>true</code> if the merchant wants to receive profile information from Swedbank Pay. Applicable for when the merchant only needs <code>email</code> and/or <code>msisdn</code> for digital goods, or when the full shipping address is necessary. If set to <code>false</code>, Swedbank Pay will depend on the merchant to send <code>email</code> and/or <code>msisdn</code> for digital products and shipping address for physical orders.</div></div>
          </details>

          <!-- digitalProducts -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f digitalProducts %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Set to <code>true</code> for merchants who only sell digital goods and only require <code>email</code> and/or <code>msisdn</code> as shipping details. Set to <code>false</code> if the merchant also sells physical goods.</div></div>
          </details>

          <!-- email -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f email %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payer's registered email address.</div></div>
          </details>

          <!-- msisdn -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f msisdn %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payer's registered mobile phone number.</div></div>
          </details>

          <!-- authentication -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f authentication %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The authentication object related to the <code>payer</code>.</div></div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f type %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Set to <code>Physical</code> or <code>Digital</code>, depending on how the authentication was done.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f method %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicator of the authentication method. Set to <code>OneFactor</code>, <code>MultiFactor</code>, <code>BankId</code>, <code>nationalIdentityCard</code> or <code>RecurringToken</code>.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f nationalIdentityCardType %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Form of identity card used for the authentication. Set to <code>Passport</code>, <code>DriversLicense</code> or <code>BankCard</code>.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f reference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Used if the authentication method has an associated reference. Use the passport number for <code>Passport</code> authentications, session numbers for <code>BankID</code> sessions etc.</div></div>
              </details>
            </div>
          </details>

          <!-- shippingAddress -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shippingAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The shipping address object related to the <code>payer</code>.</div></div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f firstName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The first name of the addressee – the receiver of the shipped goods.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f lastName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The last name of the addressee – the receiver of the shipped goods.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f email %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's registered email address.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f msisdn %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's registered mobile phone number.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's street address. Maximum 50 characters long.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's c/o address, if applicable.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's city of residence.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's zip code.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Country code for the payer's country of residence.</div></div>
              </details>
            </div>
          </details>

          <!-- billingAddress -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f billingAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The billing address object related to the <code>payer</code>.</div></div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f firstName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The first name of the addressee – the receiver of the shipped goods.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f lastName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The last name of the addressee – the receiver of the shipped goods.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f email %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's registered email address.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f msisdn %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's registered mobile phone number.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's street address. Maximum 50 characters long.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's c/o address, if applicable.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's city of residence.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's zip code.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Country code for the payer's country of residence.</div></div>
              </details>
            </div>
          </details>

          <!-- accountInfo -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f accountInfo %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Object related to the <code>payer</code> containing info about the payer's account.</div></div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountAgeIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates the age of the payer's account. <br><code>01</code> (No account, guest checkout) <br><code>02</code> (Created during this transaction) <br><code>03</code> (Less than 30 days old) <br><code>04</code> (30 to 60 days old) <br><code>05</code> (More than 60 days old)</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountChangeIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates when the last account changes occurred. <br><code>01</code> (Changed during this transaction) <br><code>02</code> (Less than 30 days ago) <br><code>03</code> (30 to 60 days ago) <br><code>04</code> (More than 60 days ago)</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountChangePwdIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates when the account's password was last changed. <br><code>01</code> (No changes) <br><code>02</code> (Changed during this transaction) <br><code>03</code> (Less than 30 days ago) <br><code>04</code> (30 to 60 days ago) <br><code>05</code> (More than 60 days old)</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f shippingAddressUsageIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates when the payer's shipping address was last used. <br><code>01</code>(This transaction) <br><code>02</code> (Less than 30 days ago) <br><code>03</code> (30 to 60 days ago) <br><code>04</code> (More than 60 days ago)</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f shippingNameIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates if the account name matches the shipping name. <br><code>01</code> (Account name identical to shipping name) <br><code>02</code> (Account name different from shipping name)</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f suspiciousAccountActivity, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates if there have been any suspicious activities linked to this account. <br><code>01</code> (No suspicious activity has been observed) <br><code>02</code> (Suspicious activity has been observed)</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f addressMatchIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>bool</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Allows the antifraud system to indicate if the payer's billing and shipping address are the same.</div></div>
              </details>
            </div>
          </details>
        </div>
      </details>

      <!-- orderItems -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The object containing items being purchased with the order, and info about them. If you have GPC codes for the items and add them here, you won't have to include the items at the bottom of the code example.</div></div>

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
            </summary>
            <div class="desc"><div class="indent-2">The URL to a page that can display the purchased item, such as a product page</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f imageUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to an image of the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field>{% f discountDescription, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
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
            {% capture orderitems_amount_md %}{% include fields/amount.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ orderitems_amount_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            {% capture orderitems_vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ orderitems_vat_amount_md | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <!-- riskIndicator -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f riskIndicator %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">This object consists of information that helps verifying the payer. Providing these fields decreases the likelihood of having to prompt for 3-D Secure authentication of the payer when they are authenticating the purchase.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f deliveryEmailAdress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">For electronic delivery (see <code>shipIndicator</code> below), the email address to which the merchandise was delivered. Providing this field when appropriate decreases the likelihood of a 3-D Secure authentication for the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f deliveryTimeFrameIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the merchandise delivery timeframe. <br><code>01</code> (Electronic Delivery) <br><code>02</code> (Same day shipping) <br><code>03</code> (Overnight shipping) <br><code>04</code> (Two-day or more shipping).</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f preOrderDate, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">For a pre-ordered purchase. The expected date that the merchandise will be available. Format: <code>YYYYMMDD</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f preOrderPurchaseIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br><code>01</code> (Merchandise available) <br><code>02</code> (Future availability).</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shipIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates shipping method chosen for the transaction. <br><code>01</code> (Ship to cardholder's billing address) <br><code>02</code> (Ship to another verified address on file with merchant)<br><code>03</code> (Ship to address that is different than cardholder's billing address)<br><code>04</code> (Ship to Store / Pick-up at local store. Store address shall be populated in the <code>riskIndicator.pickUpAddress</code> and <code>payer.shippingAddress</code> fields)<br><code>05</code> (Digital goods, includes online services, electronic giftcards and redemption codes) <br><code>06</code> (Travel and Event tickets, not shipped) <br><code>07</code> (Other, e.g. gaming, digital service)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f giftCardPurchase, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>true</code> if this is a purchase of a gift card.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f reOrderPurchaseIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates whether the cardholder is reordering previously purchased merchandise. <br><code>01</code> (First time ordered) <br><code>02</code> (Reordered).</div></div>
          </details>

          <!-- pickUpAddress -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f pickUpAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Object related to the <code>riskIndicator</code>, containing info about the merchant's pick-up address. If the <code>shipIndicator</code> is set to <code>04</code>, this should be filled out with the merchant's pick-up address. Do not use if the shipment is sent or delivered to a consumer address (ShipIndicator <code>01</code>, <code>02</code> or <code>03</code>). In those cases, the shipping address in the <code>Payer</code> field should be used instead.</div></div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f pickUpAddress.Name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The name of the shop or merchant.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f pickUpAddress.streetAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The shop or merchant's street address. Maximum 50 characters long.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f pickUpAddress.coAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The shop or merchant's c/o address, if applicable.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f pickUpAddress.City, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The city where the shop or merchant is located.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f pickUpAddress.zipCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The zip code where the shop or merchant is located.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f pickUpAddress.countryCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The country code where the shop or merchant is located.</div></div>
              </details>
            </div>
          </details>

          <!-- items -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f items %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Object related to the <code>riskIndicator</code>, containing info about the items ordered. Should be added if the GPC codes for the items are available. If the <code>orderItems</code> object is used and includes the GPC codes, there is no need to add this field. Should only be used by merchants who don't use the <code>orderItems</code> object.</div></div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f gpcNumber, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The specific <a href="https://www.gs1.org/standards/gpc">GPC Number</a> for the order line.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The amount of the specific order line.</div></div>
              </details>
            </div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>
