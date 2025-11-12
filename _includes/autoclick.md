{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% capture techref_url %}{% include utils/documentation-section-url.md %}{% endcapture %}
{% assign implementation = documentation_section | split: "/"  | last | capitalize | remove: "-" %}

## AutoClick

AutoClick is a feature which automatically forwards the payer from the payment
window when a payment method is selected, just as if they used the Pay button.
It is only available when using **Online Payments**, for all wallets **except**
**Apple Pay**. Support for more payment methods will be added going forward.
Apart from adding the field in your payment order request, no changes are
required at your (the merchant's) end for AutoClick to work.

There are a couple of limitations in place for this feature. First of all, it is
restricted to payment methods which require **no input** from the payer
before pressing the Pay button. It will also be limited to payment methods with
**no terms and conditions**. This will for example exclude Invoice, as
there are terms and conditions attached. As a consequence, activating AutoClick
in a request which also contains a `termsOfServiceUrl` will result in an error
message.

## Request

The field itself is a `bool` which must be added in the `paymentorder` field of
the request, like the example below.

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "autoClick": true,
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "productName": "Checkout3", // Removed in 3.1, can be excluded in 3.0 if version is added in header
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ], {% if include.integration_mode=="seamless-view" %}
            "paymentUrl": "https://example.com/perform-payment", {% endif %}
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "callbackUrl": "https://api.example.com/payment-callback"{% if include.integration_mode=="redirect" %},
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
        }, {% if documentation_section contains "old-implementations/enterprise" %}
        "payer": {
            "digitalProducts": false,
            "nationalIdentifier": {
                "socialSecurityNumber": "{{ page.consumer_ssn_se }}",
                "countryCode": "SE"
            }
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
                "streetAddress": "Helgestavägen 9",
                "coAddress": "",
                "city": "Solna",
                "zipCode": "17674",
                "countryCode": "SE"
            },
            "billingAddress": {
                "firstName": "firstname/companyname",
                "lastName": "lastname",
                "email": "karl.anderssson@mail.se",
                "msisdn": "+46759123456",
                "streetAddress": "Helgestavägen 9",
                "coAddress": "",
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
        }, {% endif %} {% if documentation_section contains "checkout-v3/payments-only" %}
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
        }, {% endif %}
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
{% capture callback_url_md %}{% include fields/callback-url.md %}{% endcapture %}
{% capture complete_url_md %}{% include fields/complete-url.md %}{% endcapture %}
{% capture payment_url_md %}{% include fields/payment-url.md %}{% endcapture %}
{% capture terms_md %}{% include fields/terms-of-service-url.md %}{% endcapture %}
{% capture logo_url_md %}{% include fields/logo-url.md %}{% endcapture %}
{% capture payee_info_md %}{% include fields/payee-info.md %}{% endcapture %}
{% capture payee_ref_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}
{% capture subsite_md %}{% include fields/subsite.md %}{% endcapture %}
{% capture site_id_md %}{% include fields/site-id.md %}{% endcapture %}
{% capture order_items_md %}{% include fields/order-items.md %}{% endcapture %}
{% capture description_md %}{% include fields/description.md %}{% endcapture %}

<div class="api-compact" aria-label="Payment Order Request">
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

    <!-- LEVEL 1: paymentOrder children -->
    <div class="api-children">

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f autoClick %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Set to <code>true</code> or <code>false</code>. Used to indicate if the payer should be automatically redirected from the payment window when selecting supported payment methods.
            If set to <code>true</code>, the <code>termsOfServiceUrl</code> can't be included in the request.
          </div>
        </div>
      </details>

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
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The description of the payment order.</div></div>
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
        <div class="desc"><div class="indent-1">The language of the payer.</div></div>
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
        <div class="desc"><div class="indent-1">The <code>urls</code> object, containing the URLs relevant for the payment order.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f hostUrls, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>array</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The array of valid host URLs.</div></div>
          </details>

          {% if include.integration_mode=="seamless-view" %}
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f paymentUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payment_url_md | markdownify }}</div></div>
          </details>
          {% endif %}

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
              <span class="req"></span>
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
              <span class="field">{% f termsOfServiceUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ terms_md | markdownify }}</div></div>
          </details>

          {% if include.integration_mode=="redirect" %}
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f logoUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ logo_url_md | markdownify }}</div></div>
          </details>
          {% endif %}
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
              <span class="type"><code>string(30)</code></span>
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
              <span class="field">{% f productCategory, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f orderReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The order reference should reflect the order reference found in the merchant's systems.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f subsite, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(40)</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ subsite_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f siteId, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(15)</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ site_id_md | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <!-- payer (LEVEL 1) + nested structures -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>payer</code> object containing information about the payer relevant for the payment order.</div></div>

        <div class="api-children">
          <!-- payer direct fields (LEVEL 2) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f digitalProducts %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>bool</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                Set to <code>true</code> for merchants who only sell digital goods and only require <code>email</code> and/or <code>msisdn</code> as shipping details.
                Set to <code>false</code> if the merchant also sells physical goods.
              </div>
            </div>
          </details>

          {% if documentation_section contains "old-implementations/enterprise" %}
          <!-- nationalIdentifier under payer -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f nationalIdentifier, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The national identifier object.</div></div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f socialSecurityNumber, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The payer's social security number.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The country code of the payer.</div></div>
              </details>
            </div>
          </details>
          {% endif %}

          <!-- payer name & contact (LEVEL 2) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f firstName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The first name of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f lastName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The last name of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f email, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                The e-mail address of the payer. Will be used to prefill the Checkin as well as on the payer's profile, if not already set.
                Increases the chance for {% if documentation_section contains "checkout-v3" %}
                <a href="{{ features_url }}/customize-payments/frictionless-payments">frictionless 3-D Secure 2 flow</a>
                {% else %}
                <a href="{{ features_url }}/core/frictionless-payments">frictionless 3-D Secure 2 flow</a>
                {% endif %}.
              </div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f msisdn, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                The mobile phone number of the Payer. Will be prefilled on Checkin page and used on the payer's profile, if not already set.
                Must have a country code prefix and be 8 to 15 digits in length.
                Related to {% if documentation_section contains "checkout-v3" %}
                <a href="{{ features_url }}/customize-payments/frictionless-payments">3-D Secure 2</a>
                {% else %}
                <a href="{{ features_url }}/core/frictionless-payments">3-D Secure 2</a>
                {% endif %}.
              </div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payerReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                A reference used in Enterprise integrations to recognize the payer in the absence of SSN and/or a secure login.
                Read more about this in the <a href="/old-implementations/enterprise/features/optional/enterprise-payer-reference">payerReference</a> feature section.
              </div>
            </div>
          </details>

          <!-- shippingAddress under payer -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shippingAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                The shipping address object related to the <code>payer</code>. Related to
                {% if documentation_section contains "checkout-v3" %}
                <a href="{{ features_url }}/customize-payments/frictionless-payments">3-D Secure 2</a>
                {% else %}
                <a href="{{ features_url }}/core/frictionless-payments">3-D Secure 2</a>
                {% endif %}.
              </div>
            </div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f firstName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The first name of the addressee – the receiver of the shipped goods.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f lastName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The last name of the addressee – the receiver of the shipped goods.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's street address. Maximum 50 characters long.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's c/o address, if applicable.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's zip code</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's city of residence.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">Country code for country of residence.</div></div>
              </details>
            </div>
          </details>

          <!-- billingAddress under payer -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field"><code>billingAddress</code><i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The billing address object containing information about the payer's billing address.</div></div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f firstName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The first name of the payer.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f lastName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The last name of the payer.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The street address of the payer. Maximum 50 characters long.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The CO-address (if used)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The postal number (ZIP code) of the payer.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3">The city of the payer.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc"><div class="indent-3"><code>SE</code>, <code>NO</code>, or <code>FI</code>.</div></div>
              </details>
            </div>
          </details>

          <!-- accountInfo under payer -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f accountInfo %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">Object related to the <code>payer</code> containing info about the payer's account.</div></div>

            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountAgeIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc">
                  <div class="indent-3">
                    Indicates the age of the payer's account. <br>
                    <code>01</code> (No account, guest checkout) <br>
                    <code>02</code> (Created during this transaction) <br>
                    <code>03</code> (Less than 30 days old) <br>
                    <code>04</code> (30 to 60 days old) <br>
                    <code>05</code> (More than 60 days old)
                  </div>
                </div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountChangeIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc">
                  <div class="indent-3">
                    Indicates when the last account changes occurred. <br>
                    <code>01</code> (Changed during this transaction) <br>
                    <code>02</code> (Less than 30 days ago) <br>
                    <code>03</code> (30 to 60 days ago) <br>
                    <code>04</code> (More than 60 days ago)
                  </div>
                </div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountChangePwdIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc">
                  <div class="indent-3">
                    Indicates when the account's password was last changed. <br>
                    <code>01</code> (No changes) <br>
                    <code>02</code> (Changed during this transaction) <br>
                    <code>03</code> (Less than 30 days ago) <br>
                    <code>04</code> (30 to 60 days ago) <br>
                    <code>05</code> (More than 60 days old)
                  </div>
                </div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f shippingAddressUsageIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc">
                  <div class="indent-3">
                    Indicates when the payer's shipping address was last used. <br>
                    <code>01</code> (This transaction) <br>
                    <code>02</code> (Less than 30 days ago) <br>
                    <code>03</code> (30 to 60 days ago) <br>
                    <code>04</code> (More than 60 days ago)
                  </div>
                </div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f shippingNameIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc">
                  <div class="indent-3">
                    Indicates if the account name matches the shipping name. <br>
                    <code>01</code> (Account name identical to shipping name) <br>
                    <code>02</code> (Account name different from shipping name)
                  </div>
                </div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f suspiciousAccountActivity, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req"></span>
                </summary>
                <div class="desc">
                  <div class="indent-3">
                    Indicates if there have been any suspicious activities linked to this account. <br>
                    <code>01</code> (No suspicious activity has been observed) <br>
                    <code>02</code> (Suspicious activity has been observed)
                  </div>
                </div>
              </details>
            </div>
          </details>
          {% endunless %}
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
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                <code>PRODUCT</code>, <code>SERVICE</code>, <code>SHIPPING_FEE</code>, <code>PAYMENT_FEE</code>, <code>DISCOUNT</code>, <code>VALUE_CODE</code> or <code>OTHER</code>.
                <br><code>PAYMENT_FEE</code> is the amount you are charged with when you are paying with invoice. The amount can be defined in the <code>amount</code> field below.
              </div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f class, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                The classification of the order item. Can be used for assigning the order item to a specific product category, such as <code>MobilePhone</code>.
                Note that <code>class</code> cannot contain spaces and must follow the regex pattern <code>[\w-]*</code>. Swedbank Pay may use this field for statistics.
              </div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f itemUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to a page that can display the purchased item, product or similar.</div></div>
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
            <div class="desc"><div class="indent-2">{{ description_md | markdownify }}</div></div>
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
            <div class="desc"><div class="indent-2">The unit of the quantity, such as <code>pcs</code>, <code>grams</code>, or similar. This is used for your own book keeping.</div></div>
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

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f restrictedToInstruments %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>array</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                A list of the payment methods you wish to restrict the payment to. Currently <code>Invoice</code> only.
                <code>Invoice</code> supports the subtypes <code>PayExFinancingNo</code>, <code>PayExFinancingSe</code> and <code>PayMonthlyInvoiceSe</code>, separated by a dash, e.g.; <code>Invoice-PayExFinancingNo</code>.
                Default value is all supported payment methods. Use of this field requires an agreement with Swedbank Pay.
                You can restrict fees and/or discounts to certain payment methods by adding this field to the orderline you want to restrict.
                Use positive amounts to add fees and negative amounts to add discounts.
              </div>
            </div>
          </details>
        </div>
      </details>

    </div><!-- /level-1 (children of paymentOrder) -->
  </details>
</div>

## Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentOrder": {
        "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b",
        "created": "2022-01-07T07:58:26.1300282Z",
        "updated": "2022-01-07T08:17:44.6839034Z",
        "operation": "Purchase", {% if documentation_section contains "checkout-v3" %}
        "status": "Initialized", {% else %}
        "state": "Ready", {% endif %}
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [
            "CreditCard",
            "Invoice-PayExFinancingSe",
            "Invoice-PayMonthlyInvoiceSe",
            "Swish",
            "CreditAccount",
            "Trustly"
        ],{% if documentation_section contains "old-implementations/enterprise" %}
        "implementation": "Enterprise", {% endif %} {% if documentation_section contains "checkout-v3/payments-only" %}
        "implementation": "PaymentsOnly", {% endif %} {% if include.integration_mode=="seamless-view" %}
        "integration": "HostedView", {% endif %} {% if include.integration_mode=="redirect" %}
        "integration": "Redirect", {% endif %}
        "instrumentMode": false,
        "guestMode": false,
       "payer": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payers"
        },
        "orderItems": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderitems"
        }{% if documentation_section contains "checkout-v3" %},
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
        } {% endif %}
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

{% capture op_md %}{% include fields/operation.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture desc_md %}{% include fields/description.md %}{% endcapture %}
{% capture init_sys_ua_md %}{% include fields/initiating-system-user-agent.md %}{% endcapture %}
{% capture language_md %}{% include fields/language.md %}{% endcapture %}
{% capture guest_mode_md %}{% include fields/guest-mode.md %}{% endcapture %}
{% capture status_md %}{% include fields/status.md %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" aria-label="Payment Order Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- LEVEL 0 -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <!-- LEVEL 1 children of paymentOrder -->
    <div class="api-children">

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/id.md resource="paymentorder" %}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO 8601 date of when the payment order was created. Written in the format YYYY-MM-DDTHH:MM:SSZ, where Z indicates UTC.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO 8601 date of when the payment order was updated. Written in the format YYYY-MM-DDTHH:MM:SSZ, where Z indicates UTC.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ op_md | markdownify }}</div></div>
      </details>

      {% if documentation_section contains "checkout-v3" %}
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f status %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ status_md | markdownify }}</div></div>
      </details>
      {% else %}
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f state %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Ready</code>, <code>Pending</code>, <code>Failed</code> or <code>Aborted</code>. Indicates the state of the payment order. Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes.</div></div>
      </details>
      {% endif %}

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
        <div class="desc"><div class="indent-1">{{ desc_md | markdownify }}</div></div>
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
        <div class="desc"><div class="indent-1">A list of payment methods available for this payment.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments implementation type. <code>Enterprise</code> or <code>PaymentsOnly</code>. Do not build logic around this field’s response; names may change.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integration %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments integration type. <code>HostedView</code> (Seamless View) or <code>Redirect</code>. Populated after the payer opens the payment UI and the hosting container is identified.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrumentMode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payment is initialized with only one payment method available.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f guestMode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ guest_mode_md | markdownify }}</div></div>
      </details>

      <!-- Links -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#payer"><code>payer</code> resource</a> where information about the payer can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>orderItems</code> resource where information about the order items can be retrieved.</div></div>
      </details>

      {% if documentation_section contains "checkout-v3" %}
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f history %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#history"><code>history</code> resource</a> where information about the payment's history can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failed %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#failed"><code>failed</code> resource</a> where information about the failed transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f aborted %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#aborted"><code>aborted</code> resource</a> where information about the aborted transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paid %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#paid"><code>paid</code> resource</a> where information about the paid transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cancelled %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#cancelled"><code>cancelled</code> resource</a> where information about the cancelled transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f financialTransactions %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#financialtransactions"><code>financialTransactions</code> resource</a> where information about the financial transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failedAttempts %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#failedattempts"><code>failedAttempts</code> resource</a> where information about the failed attempts can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>metadata</code> resource where information about the metadata can be retrieved.</div></div>
      </details>
      {% endif %}

    </div><!-- /level-1 children -->
  </details>

  <!-- LEVEL 0: operations -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>array</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        {{ operations_md | markdownify }}
        <p>As this is an initialized payment, the available operations are <code>abort</code>, <code>update-order</code> and <code>redirect-checkout</code> or <code>view-checkout</code>, depending on the integration. See <a href="{{ techref_url }}/technical-reference/operations">Operations</a> for details.</p>
      </div>
    </div>
  </details>
</div>
