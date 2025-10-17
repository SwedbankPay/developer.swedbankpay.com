{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{% assign features_url = documentation_section | prepend: '/' | append: '/features' %}
{% capture techref_url %}{% include utils/documentation-section-url.md %}{% endcapture %}
{% assign implementation = documentation_section | split: "/"  | last | capitalize | remove: "-" %}

## Payment Order Request

{:.code-view-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0

{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "productName": "Checkout3", // Removed in 3.1, can be excluded in 3.0 if version is added in header
        "urls": { {% if include.integration_mode=="seamless-view" %}
            "hostUrls": [ "https://example.com", "https://example.net" ],
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
            "subsite": "MySubsite",
            "siteId": "MySiteId"
        },
        "payer": {
            "digitalProducts": false,
            "nationalIdentifier": {
                "socialSecurityNumber": "{{ page.consumer_ssn_se }}",
                "countryCode": "SE"
            }
            "firstName": "Leia"
            "lastName": "Ahlström"
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
                "city": "string",
                "zipCode": "string",
                "countryCode": "string"
            },
            "billingAddress": {
                "firstName": "firstname/companyname",
                "lastName": "lastname",
                "email": "karl.anderssson@mail.se",
                "msisdn": "+46759123456",
                "streetAddress": "string",
                "coAddress": "string",
                "city": "string",
                "zipCode": "string",
                "countryCode": "string"
            },
            "accountInfo": {
                "accountAgeIndicator": "04",
                "accountChangeIndicator": "04",
                "accountPwdChangeIndicator": "01",
                "shippingAddressUsageIndicator": "01",
                "shippingNameIndicator": "01",
                "suspiciousAccountActivity": "01",
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
                "quantity": 4,
                "quantityUnit": "pcs",
                "unitPrice": 300,
                "discountPrice": 200,
                "vatPercent": 2500,
                "amount": 1000,
                "vatAmount": 250
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
}
```

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
    <div class="api-children">

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% capture _inc %}{% include fields/operation.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% capture _inc %}{% include fields/amount.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% capture _inc %}{% include fields/vat-amount.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The description of the payment order.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% capture _inc %}{% include fields/user-agent.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The language of the payer.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f productName, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Used to tag the payment as Online Payments v3.0. Mandatory for Online Payments v3.0, either in this field or the header, as you won't get the operations in the response without submitting this field.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates which implementation to use.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>urls</code> object, containing the URLs relevant for the payment order.</div></div>
        <div class="api-children">
          {% if include.integration_mode=="seamless-view" %}
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f hostUrls, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>array</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The array of valid host URLs.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f paymentUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% capture _inc %}{% include fields/payment-url.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
          </details>
          {% endif %}

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f completeUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% capture _inc %}{% include fields/complete-url.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f cancelUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an <code>abort</code> request of the <code>payment</code> or <code>paymentorder</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f callbackUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% capture _inc %}{% include fields/callback-url.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f termsOfServiceUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% capture _inc %}{% include fields/terms-of-service-url.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
          </details>

          {% if include.integration_mode=="redirect" %}
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f logoUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% capture _inc %}{% include fields/logo-url.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
          </details>
          {% endif %}
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% capture _inc %}{% include fields/payee-info.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
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
            <div class="desc"><div class="indent-2">{% capture _inc %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}{{ _inc | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeName, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the payee, usually the name of the merchant.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f productCategory, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(50)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f orderReference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(50)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The order reference should reflect the order reference found in the merchant's systems.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f subsite, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(40)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% capture _inc %}{% include fields/subsite.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f siteId, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(15)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% capture _inc %}{% include fields/site-id.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>payer</code> object containing information about the payer relevant for the payment order.</div></div>
        <div class="api-children">

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f digitalProducts, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Set to <code>true</code> for merchants who only sell digital goods and only require <code>email</code> and/or <code>msisdn</code> as shipping details. Set to <code>false</code> if the merchant also sells physical goods.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f nationalIdentifier, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The national identifier object.</div></div>
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f socialSecurityNumber, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The payer's social security number.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 3 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The country code of the payer.</div></div>
              </details>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f firstName, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The first name of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f lastName, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The last name of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f email, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The e-mail address of the payer. Will be used to prefill the Checkin as well as on the payer's profile, if not already set. Increases the chance for {% if documentation_section contains "checkout-v3" %} [frictionless 3-D Secure 2 flow]({{ features_url }}/customize-payments/frictionless-payments) {% else %} [frictionless 3-D Secure 2 flow]({{ features_url }}/core/frictionless-payments) {% endif %}.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f msisdn, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The mobile phone number of the Payer. Will be prefilled on Checkin page and used on the payer's profile, if not already set. The mobile number must have a country code prefix and be 8 to 15 digits in length. The field is related to {% if documentation_section contains "checkout-v3" %} [3-D Secure 2]({{ features_url }}/customize-payments/frictionless-payments) {% else %} [3-D Secure 2]({{ features_url }}/core/frictionless-payments) {% endif %}.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payerReference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A reference used in Enterprise integrations to recognize the payer in the absence of SSN and/or a secure login. Read more about this in the <a href="/old-implementations/enterprise/features/optional/enterprise-payer-reference">payerReference</a> feature section.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shippingAddress, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-1">The shipping address object related to the <code>payer</code>. The field is related to {% if documentation_section contains "checkout-v3" %} [3-D Secure 2]({{ features_url }}/customize-payments/frictionless-payments) {% else %} [3-D Secure 2]({{ features_url }}/core/frictionless-payments) {% endif %}.</div></div>
            <div class="api-children">
              <details class="api-item" data-level="2">
                <summary>
                  <span class="field">{% f firstName, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-2">The first name of the addressee – the receiver of the shipped goods.</div></div>
              </details>

              <details class="api-item" data-level="2">
                <summary>
                  <span class="field">{% f lastName, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-2">The last name of the addressee – the receiver of the shipped goods.</div></div>
              </details>

              <details class="api-item" data-level="2">
                <summary>
                  <span class="field">{% f streetAddress, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-2">Payer's street address. Maximum 50 characters long.</div></div>
              </details>

              <details class="api-item" data-level="2">
                <summary>
                  <span class="field">{% f coAddress, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-2">Payer's c/o address, if applicable.</div></div>
              </details>

              <details class="api-item" data-level="2">
                <summary>
                  <span class="field">{% f zipCode, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-2">Payer's zip code</div></div>
              </details>

              <details class="api-item" data-level="2">
                <summary>
                  <span class="field">{% f city, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-2">Payer's city of residence.</div></div>
              </details>

              <details class="api-item" data-level="2">
                <summary>
                  <span class="field">{% f countryCode, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-2">Country code for country of residence.</div></div>
              </details>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f billingAddress, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-1">The billing address object containing information about the payer's billing address.</div></div>
            <div class="api-children">
              <details class="api-item" data-level="2">
                <summary>
                  <span class="field">{% f firstName %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-2">The first name of the payer.</div></div>
              </details>

              <details class="api-item" data-level="2">
                <summary>
                  <span class="field">{% f lastName %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-2">The last name of the payer.</div></div>
              </details>

              <details class="api-item" data-level="2">
                <summary>
                  <span class="field">{% f streetAddress %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-2">The street address of the payer. Maximum 50 characters long.</div></div>
              </details>

              <details class="api-item" data-level="2">
                <summary>
                  <span class="field">{% f coAddress %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-2">The CO-address (if used)</div></div>
              </details>

              <details class="api-item" data-level="2">
                <summary>
                  <span class="field">{% f zipCode %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-2">The postal number (ZIP code) of the payer.</div></div>
              </details>

              <details class="api-item" data-level="2">
                <summary>
                  <span class="field">{% f city %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-2">The city of the payer.</div></div>
              </details>

              <details class="api-item" data-level="2">
                <summary>
                  <span class="field">{% f countryCode %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-2"><code>SE</code>, <code>NO</code>, or <code>FI</code>.</div></div>
              </details>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f accountInfo, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Object related to the <code>payer</code> containing info about the payer's account.</div></div>
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountAgeIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates the age of the payer's account. <br><code>01</code> (No account, guest checkout) <br><code>02</code> (Created during this transaction) <br><code>03</code> (Less than 30 days old) <br><code>04</code> (30 to 60 days old) <br><code>05</code> (More than 60 days old)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountChangeIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates when the last account changes occurred. <br><code>01</code> (Changed during this transaction) <br><code>02</code> (Less than 30 days ago) <br><code>03</code> (30 to 60 days ago) <br><code>04</code> (More than 60 days ago)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountChangePwdIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates when the account's password was last changed. <br><code>01</code> (No changes) <br><code>02</code> (Changed during this transaction) <br><code>03</code> (Less than 30 days ago) <br><code>04</code> (30 to 60 days ago) <br><code>05</code> (More than 60 days old)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f shippingAddressUsageIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates when the payer's shipping address was last used. <br><code>01</code>(This transaction) <br><code>02</code> (Less than 30 days ago) <br><code>03</code> (30 to 60 days ago) <br><code>04</code> (More than 60 days ago)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f shippingNameIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates if the account name matches the shipping name. <br><code>01</code> (Account name identical to shipping name) <br><code>02</code> (Account name different from shipping name)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f suspiciousAccountActivity, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates if there have been any suspicious activities linked to this account. <br><code>01</code> (No suspicious activity has been observed) <br><code>02</code> (Suspicious activity has been observed)</div></div>
              </details>
            </div>
          </details>

        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>array</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% capture _inc %}{% include fields/order-items.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
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
            </summary>
            <div class="desc"><div class="indent-2">The URL to a page that can display the purchased item, product or similar.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f imageUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to an image of the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% capture _inc %}{% include fields/description.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountDescription, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
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
            <div class="desc"><div class="indent-2">The unit of the quantity, such as <code>pcs</code>, <code>grams</code>, or similar. This is used for your own book keeping.</div></div>
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
            <div class="desc"><div class="indent-2">{% capture _inc %}{% include fields/amount.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% capture _inc %}{% include fields/vat-amount.md %}{% endcapture %}{{ _inc | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f restrictedToInstruments, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of the payment methods you wish to restrict the payment to. Currently <code>Invoice</code> only. <code>Invoice</code> supports the subtypes <code>PayExFinancingNo</code>, <code>PayExFinancingSe</code> and <code>PayMonthlyInvoiceSe</code>, separated by a dash, e.g.; <code>Invoice-PayExFinancingNo</code>. Default value is all supported payment methods. Use of this field requires an agreement with Swedbank Pay. You can restrict fees and/or discounts to certain payment methods by adding this field to the orderline you want to restrict. Use positive amounts to add fees and negative amounts to add discounts.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f riskIndicator, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">This <strong>optional</strong> object consist of information that helps verifying the payer. Providing these fields decreases the likelihood of having to prompt for 3-D Secure 2.0 authentication of the payer when they are authenticating the purchase.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f deliveryEmailAdress, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">For electronic delivery, the email address to which the merchandise was delivered. Providing this field when appropriate decreases the likelihood of a 3-D Secure authentication for the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f deliveryTimeFrameIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the merchandise delivery timeframe. <br><code>01</code> (Electronic Delivery) <br><code>02</code> (Same day shipping) <br><code>03</code> (Overnight shipping) <br><code>04</code> (Two-day or more shipping)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f preOrderDate, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">For a pre-ordered purchase. The expected date that the merchandise will be available. Format: <code>YYYYMMDD</code></div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f preOrderPurchaseIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br><code>01</code> (Merchandise available) <br><code>02</code> (Future availability)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shipIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates shipping method chosen for the transaction. <br><code>01</code> (Ship to cardholder's billing address) <br><code>02</code> (Ship to another verified address on file with merchant)<br><code>03</code> (Ship to address that is different than cardholder's billing address)<br><code>04</code> (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)<br><code>05</code> (Digital goods, includes online services, electronic giftcards and redemption codes) <br><code>06</code> (Travel and Event tickets, not shipped) <br><code>07</code> (Other, e.g. gaming, digital service)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f giftCardPurchase, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>true</code> if this is a purchase of a gift card.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f reOrderPurchaseIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates whether the cardholder is reordering previously purchased merchandise. <br><code>01</code> (First time ordered) <br><code>02</code> (Reordered).</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f pickUpAddress %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If <code>shipIndicator</code> set to <code>04</code>, then prefill this with the payers <code>pickUpAddress</code> of the purchase to decrease the risk factor of the purchase.</div></div>
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f name, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, then prefill this with the payers <code>name</code> of the purchase to decrease the risk factor of the purchase.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, then prefill this with the payers <code>streetAddress</code> of the purchase to decrease the risk factor of the purchase. Maximum 50 characters long.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, then prefill this with the payers <code>coAddress</code> of the purchase to decrease the risk factor of the purchase.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, then prefill this with the payers <code>city</code> of the purchase to decrease the risk factor of the purchase.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, then prefill this with the payers <code>zipCode</code> of the purchase to decrease the risk factor of the purchase.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, then prefill this with the payers <code>countryCode</code> of the purchase to decrease the risk factor of the purchase.</div></div>
              </details>
            </div>
          </details>

        </div>
      </details>

    </div>
  </details>
</div>

## Payment Order Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0

{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",{% if documentation_section contains "payment-menu" %}
        "instrument": "CreditCard",
        "paymentToken" : "{{ page.payment_token }}",{% endif %}
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
        },{% if include.integration_mode=="redirect" %}
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
}
```

{%- capture id_md -%}{% include fields/id.md resource="paymentorder" %}{%- endcapture -%}
{%- capture operation_md -%}{% include fields/operation.md %}{%- endcapture -%}
{%- capture amount_md -%}{% include fields/amount.md %}{%- endcapture -%}
{%- capture vat_amount_md -%}{% include fields/vat-amount.md %}{%- endcapture -%}
{%- capture description_md -%}{% include fields/description.md %}{%- endcapture -%}
{%- capture user_agent_md -%}{% include fields/user-agent.md %}{%- endcapture -%}
{%- capture language_md -%}{% include fields/language.md %}{%- endcapture -%}
{%- capture payee_info_md -%}{% include fields/payee-info.md %}{%- endcapture -%}
{%- capture operations_md -%}{% include fields/operations.md %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0, all nodes CLOSED by default (original order) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <!-- Children of paymentOrder -->
    <div class="api-children">
      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      {% if documentation_section contains "payment-menu" %}
      <!-- instrument (payment-menu only) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrument %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The payment method used. Selected by using the <a href="{{ features_url }}/customize-ui/instrument-mode">Instrument Mode</a>.</div></div>
      </details>

      <!-- paymentToken (payment-menu only) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paymentToken %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The payment token created for the purchase used in the authorization to create <a href="{{ documentation_section }}/features/#one-click-payments">One Click Payments</a>.</div></div>
      </details>
      {% endif %}

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

      <!-- urls (link to resource) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>urls</code> resource where all URLs related to the payment order can be retrieved.</div></div>
      </details>

      <!-- payeeInfo (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payee_info_md | markdownify }}</div></div>
      </details>

      <!-- payers (link to resource) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payers %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#payer"><code>payer</code> resource</a> where information about the payer can be retrieved.</div></div>
      </details>

      <!-- orderItems (link to resource) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>orderItems</code> resource where information about the order items can be retrieved.</div></div>
      </details>

      <!-- payments (link to resource) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payments %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payments</code> resource where information about all underlying payments can be retrieved.</div></div>
      </details>

      <!-- currentPayment (link to resource) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currentPayment %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>currentPayment</code> resource where information about the current – and sole active – payment can be retrieved.</div></div>
      </details>

      <!-- operations (array) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operations %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operations_md | markdownify }} <a href="{{ features_url }}/technical-reference/operations">See Operations for details</a>.</div></div>
      </details>
    </div>
  </details>
</div>
