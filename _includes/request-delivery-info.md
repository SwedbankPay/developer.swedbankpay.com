{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% capture techref_url %}{% include utils/documentation-section-url.md %}{% endcapture %}
{% assign implementation = documentation_section | split: "/"  | last | capitalize | remove: "-" %}

## Request Delivery Information

Swedbank Pay provides the possibility to return delivery information from
payment methods which support this. You do this by adding the field
`requestDeliveryInfo` in your payment order request and setting it to `true`.
The returned delivery information will appear in the `payer` field after the
payment has been `paid`, and **not** the initial response. You have to
perform a GET to see it.

Only payment methods which support this will return delivery information. If you
only want to show payment methods which support this in you menu, you can also
add the field `restrictedToDeliveryInfoInstruments` and setting it to `true`.
This will leave out all payment methods which can't return delivery information.

You are currently only able to request delivery information from **Apple Pay**,
**Click to Pay** and **Google Pay&trade;**, but we will add support for more
payment methods going forward. No changes are required at your (the merchant's)
end to be able to offer more payment methods at a later time.

## Request Delivery Info Request

The fields themselves are `bool`s which must be added in the `paymentorder`
field of the request, like the example below.

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "requestDeliveryInfo": true,
        "restrictedToDeliveryInfoInstruments": true,
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
        },  {% if documentation_section contains "old-implementations/enterprise" %}
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

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- ROOT: paymentOrder -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <div class="api-children">

      <!-- requestDeliveryInfo -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f requestDeliveryInfo %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> if you want Swedbank Pay to return delivery information from the payment methods which support this. It will be visible in a GET response after the payment has been completed.</div></div>
      </details>

      <!-- restrictedToDeliveryInfoInstruments -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f restrictedToDeliveryInfoInstruments %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> if you want to restrict your payment menu to only include payment methods which return delivery info.</div></div>
      </details>

      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/operation.md %}</div></div>
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
        <div class="desc"><div class="indent-1">{% include fields/amount.md %}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/vat-amount.md %}</div></div>
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
        <div class="desc"><div class="indent-1">{% include fields/user-agent.md %}</div></div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
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
        <div class="desc"><div class="indent-1">Used to tag the payment as Online Payments v3.0. Mandatory for Online Payments v3.0, either in this field or the header, as you won't get the operations in the response without submitting this field.</div></div>
      </details>

      <!-- implementation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates which implementation to use.</div></div>
      </details>

      <!-- urls (object) -->
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

          {% if include.integration_mode=="seamless-view" %}
          <!-- paymentUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f paymentUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/payment-url.md %}</div></div>
          </details>
          {% endif %}

          <!-- completeUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f completeUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/complete-url.md %}</div></div>
          </details>

          <!-- cancelUrl -->
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
            <div class="desc"><div class="indent-2">{% include fields/callback-url.md %}</div></div>
          </details>

          <!-- termsOfServiceUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f termsOfServiceUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/terms-of-service-url.md %}</div></div>
          </details>

          {% if include.integration_mode=="redirect" %}
          <!-- logoUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f logoUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/logo-url.md %}</div></div>
          </details>
          {% endif %}
        </div>
      </details>

      <!-- payeeInfo (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/payee-info.md %}</div></div>

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
            <div class="desc"><div class="indent-2">{% include fields/payee-reference.md describe_receipt=true %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the payee, usually the name of the merchant.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f productCategory, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f orderReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The order reference should reflect the order reference found in the merchant's systems.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f subsite, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(40)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/subsite.md %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f siteId, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(15)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/site-id.md %}</div></div>
          </details>
        </div>
      </details>

      <!-- payer (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>payer</code> object containing information about the payer relevant for the payment order.</div></div>

        <div class="api-children">
          <!-- digitalProducts -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f digitalProducts %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Set to <code>true</code> for merchants who only sell digital goods and only require <code>email</code> and/or <code>msisdn</code> as shipping details. Set to <code>false</code> if the merchant also sells physical goods.</div></div>
          </details>

          {% if documentation_section contains "old-implementations/enterprise" %}
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
          {% endif %}

          <!-- firstName / lastName / email / msisdn / payerReference -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f firstName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The first name of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f lastName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The last name of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f email, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The e-mail address of the payer. Will be used to prefill the Checkin as well as on the payer's profile, if not already set. Increases the chance for {% if documentation_section contains "checkout-v3" %}<a href="{{ features_url }}/customize-payments/frictionless-payments">frictionless 3-D Secure 2 flow</a>{% else %}<a href="{{ features_url }}/core/frictionless-payments">frictionless 3-D Secure 2 flow</a>{% endif %}.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f msisdn, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The mobile phone number of the Payer. Will be prefilled on Checkin page and used on the payer's profile, if not already set. The mobile number must have a country code prefix and be 8 to 15 digits in length. The field is related to {% if documentation_section contains "checkout-v3" %}<a href="{{ features_url }}/customize-payments/frictionless-payments">3-D Secure 2</a>{% else %}<a href="{{ features_url }}/core/frictionless-payments">3-D Secure 2</a>{% endif %}.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payerReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A reference used in Enterprise integrations to recognize the payer in the absence of SSN and/or a secure login. Read more about this in the <a href="/old-implementations/enterprise/features/optional/enterprise-payer-reference">payerReference</a> feature section.</div></div>
          </details>

          <!-- shippingAddress (object) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shippingAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The shipping address object related to the <code>payer</code>. The field is related to {% if documentation_section contains "checkout-v3" %}<a href="{{ features_url }}/customize-payments/frictionless-payments">3-D Secure 2</a>{% else %}<a href="{{ features_url }}/core/frictionless-payments">3-D Secure 2</a>{% endif %}.</div></div>
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
                  <span class="field">{% f zipCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's zip code.</div></div>
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
                  <span class="field">{% f countryCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Country code for country of residence.</div></div>
              </details>
            </div>
          </details>

          <!-- billingAddress (object) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">billingAddress<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The billing address object containing information about the payer's billing address.</div></div>
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f firstName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The first name of the payer.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f lastName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The last name of the payer.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The street address of the payer. Maximum 50 characters long.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The CO-address (if used).</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The postal number (ZIP code) of the payer.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The city of the payer.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3"><code>SE</code>, <code>NO</code>, or <code>FI</code>.</div></div>
              </details>
            </div>
          </details>

          <!-- accountInfo (object) -->
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
                <div class="desc"><div class="indent-3">Indicates when the payer's shipping address was last used. <br><code>01</code> (This transaction) <br><code>02</code> (Less than 30 days ago) <br><code>03</code> (30 to 60 days ago) <br><code>04</code> (More than 60 days ago)</div></div>
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
            </div>
          </details>
        </div>
      </details>

      <!-- orderItems (array) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/order-items.md %}</div></div>

        <div class="api-children">
          <!-- Typical order item fields -->
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
            <div class="desc"><div class="indent-2"><code>PRODUCT</code>, <code>SERVICE</code>, <code>SHIPPING_FEE</code>, <code>PAYMENT_FEE</code> <code>DISCOUNT</code>, <code>VALUE_CODE</code> or <code>OTHER</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f class, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">Classification of the order item. No spaces; must match <code>[\w-]*</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f itemUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">URL to a page that can display the purchased item, product or similar.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f imageUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">URL to an image of the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/description.md %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountDescription, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Human readable description of the possible discount.</div></div>
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
            <div class="desc"><div class="indent-2">{% include fields/amount.md %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/vat-amount.md %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f restrictedToInstruments %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>array</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Restrict this order line to certain instruments. Requires agreement with Swedbank Pay.</div></div>
          </details>
        </div>
      </details>

      <!-- riskIndicator (sibling to orderItems) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f riskIndicator %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Optional info to help verify the payer; reduces likelihood of 3-D Secure 2.0 step-up.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f deliveryEmailAdress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Email address used for electronic delivery.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f deliveryTimeFrameIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Delivery timeframe: <code>01</code> Electronic, <code>02</code> Same day, <code>03</code> Overnight, <code>04</code> Two-day or more.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f preOrderDate, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Expected availability date for pre-order. <code>YYYYMMDD</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f preOrderPurchaseIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Pre-order status: <code>01</code> Merchandise available, <code>02</code> Future availability.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shipIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Shipping method selected (01–07), incl. Digital goods and Travel/Event.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f giftCardPurchase, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>true</code> if this purchase is a gift card.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f reOrderPurchaseIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Reorder status: <code>01</code> First time ordered, <code>02</code> Reordered.</div></div>
          </details>

          <!-- pickUpAddress -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f pickUpAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Required when <code>shipIndicator</code> is <code>04</code> (store pickup).</div></div>
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Pickup name.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Pickup street address. Max 50 chars.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Pickup c/o address.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Pickup city.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Pickup ZIP code.</div></div>
              </details>
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Pickup country code.</div></div>
              </details>
            </div>
          </details>
        </div>
      </details>

    </div>
  </details>
</div>

## Request Delivery Info Response

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
        ], {% if include.integration_mode=="seamless-view" %}
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

<div class="api-compact" aria-label="GET Payment Order (utan required)">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- ROOT: paymentOrder -->
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
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/id.md resource="paymentorder" %}</div></div>
      </details>

      <!-- created -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO-8601 date of when the payment order was created.</div></div>
      </details>

      <!-- updated -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO-8601 date of when the payment order was updated.</div></div>
      </details>

      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/operation.md %}</div></div>
      </details>

      <!-- status OR state (Liquid-conditional block) -->
      {% if documentation_section contains "checkout-v3" %}
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f status %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Indicates the payment order's current status. <code>Initialized</code> is returned when the payment is created and still ongoing.
            The request example above has this status. <code>Paid</code> is returned when the payer has completed the payment successfully.
            See the <a href="{{ techref_url }}/technical-reference/status-models#paid">Paid section for further information</a>.
            <code>Failed</code> is returned when a payment has failed. You will find an error message in the failed section.
            <a href="{{ techref_url }}/technical-reference/status-models#failed">Further information here</a>.
            <code>Cancelled</code> is returned when an authorized amount has been fully cancelled.
            See the <a href="{{ techref_url }}/technical-reference/status-models#cancelled">Cancel feature section for further information</a>.
            It will contain fields from both the cancelled description and paid section.
            <code>Aborted</code> is returned when the merchant has aborted the payment or if the payer cancelled the payment
            in the redirect integration (on the redirect page). See the
            <a href="{{ techref_url }}/technical-reference/status-models#aborted">Abort feature section for further information</a>.
          </div>
        </div>
      </details>
      {% else %}
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f state %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            <code>Ready</code>, <code>Pending</code>, <code>Failed</code> or <code>Aborted</code>. Indicates the state of the payment order.
            Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes.
          </div>
        </div>
      </details>
      {% endif %}

      <!-- currency -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment order in the ISO 4217 format (e.g. `EUR`, `DKK`, `NOK` or `SEK`). Some payment methods are only available with selected currencies.</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/amount.md %}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/vat-amount.md %}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/description.md %}</div></div>
      </details>

      <!-- initiatingSystemUserAgent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f initiatingSystemUserAgent %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/initiating-system-user-agent.md %}</div></div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/language.md %}</div></div>
      </details>

      <!-- availableInstruments -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f availableInstruments %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of payment methods available for this payment.</div></div>
      </details>

      <!-- implementation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            The merchant's Online Payments implementation type. <code>Enterprise</code> or <code>PaymentsOnly</code>. Informational only.
          </div>
        </div>
      </details>

      <!-- integration -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integration %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Integration type: <code>HostedView</code> (Seamless View) or <code>Redirect</code>. Populated after UI is opened.
          </div>
        </div>
      </details>

      <!-- instrumentMode -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrumentMode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates if only one payment method is available.</div></div>
      </details>

      <!-- guestMode -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f guestMode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Indicates if the payer chose to pay as a guest. With Enterprise, this is triggered by not including
            <code>payerReference</code> or <code>nationalIdentifier</code> in the original payment order request.
          </div>
        </div>
      </details>

      <!-- payer (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#payer"><code>payer</code> resource</a>.</div></div>
      </details>

      <!-- orderItems (id link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>orderItems</code> resource.</div></div>
      </details>

      <!-- Conditional block with several *id* resources -->
      {% if documentation_section contains "checkout-v3" %}
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f history %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#history"><code>history</code> resource</a>.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failed %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#failed"><code>failed</code> resource</a>.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f aborted %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#aborted"><code>aborted</code> resource</a>.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paid %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#paid"><code>paid</code> resource</a>.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cancelled %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#cancelled"><code>cancelled</code> resource</a>.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f financialTransactions %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#financialtransactions"><code>financialTransactions</code> resource</a>.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failedAttempts %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#failedattempts"><code>failedAttempts</code> resource</a>.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">URL to the <code>metadata</code> resource.</div></div>
      </details>
      {% endif %}

    </div>
  </details>

  <!-- ROOT: operations -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>array</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        {% include fields/operations.md %}
        As this is an initialized payment, the available operations are
        <code>abort</code>, <code>update-order</code> and <code>redirect-checkout</code> or <code>view-checkout</code>, depending on the integration.
        <a href="{{ techref_url }}/technical-reference/operations">See Operations for details</a>.
      </div>
    </div>
  </details>

</div>
