{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% capture techref_url %}{% include utils/documentation-section-url.md %}{% endcapture %}
{%- capture documentation_section -%}{%- include utils/documentation-section.md -%}{%- endcapture -%}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% assign implementation = documentation_section | split: "/"  | last | capitalize | remove: "-" %}

## Unscheduled Purchase

An `unscheduled purchase`, also called a Merchant Initiated Transaction (MIT),
is a payment which uses a `unscheduledToken` generated through a previous
payment in order to charge the same card at a later time. They are done by the
merchant without the cardholder being present.

`Unscheduled purchase`s can be used in cases where you have an agreement with
your customer which handles both recurring orders and/or singular transactions.
Observe - it’s important that the Terms of Service clearly and understandably
states how the payment will be done towards your customer. Example use cases are
car rental companies charging the payer’s card for toll road expenses after the
rental period, or different subscription services and recurring orders where the
periodicity and/or amount varies.

Please note that you need to do a capture after sending the unscheduled request.
We have added a capture section at the end of this page for that reason.

## Generating The Token

First, you need an initial transaction where the `unscheduledToken` is generated
and connected. You do that by adding the field `generateUnscheduledToken` in the
`PaymentOrder` request and set the value to `true`. The payer must complete the
purchase to activate the token. You can also use [Verify][verify] to activate
tokens.

(Read more about [deleting the unscheduled token][delete-token] here.)

## Initial Unscheduled Request

The initial request should look like this:

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
        "language": "sv-SE",
        "generateUnscheduledToken": true, {% if documentation_section contains "checkout-v3" %}
        "productName": "Checkout3", // Removed in 3.1, can be excluded in 3.0 if version is added in header
        {% endif %}
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "paymentUrl": "https://example.com/perform-payment", // Seamless View only
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
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
            "subsite": "MySubsite",  {% if documentation_section contains "checkout-v3" %}
            "siteId": "MySiteId", {% endif %}
        },
        "payer": {
            "digitalProducts": false,
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

{% capture operation_md %}{% include fields/operation.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture user_agent_md %}{% include fields/user-agent.md %}{% endcapture %}
{% capture payment_url_md %}{% include fields/payment-url.md %}{% endcapture %}
{% capture complete_url_md %}{% include fields/complete-url.md %}{% endcapture %}
{% capture callback_url_md %}{% include fields/callback-url.md %}{% endcapture %}
{% capture terms_md %}{% include fields/terms-of-service-url.md %}{% endcapture %}
{% capture logo_url_md %}{% include fields/logo-url.md %}{% endcapture %}
{% capture payee_info_md %}{% include fields/payee-info.md %}{% endcapture %}
{% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}
{% capture subsite_md %}{% include fields/subsite.md %}{% endcapture %}
{% capture site_id_md %}{% include fields/site-id.md %}{% endcapture %}
{% capture order_items_md %}{% include fields/order-items.md %}{% endcapture %}
{% capture item_description_md %}{% include fields/description.md %}{% endcapture %}

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- Root: paymentOrder (level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <div class="api-children">
      <!-- operation (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }}</div></div>
      </details>

      <!-- currency (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment.</div></div>
      </details>

      <!-- amount (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- description (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The description of the payment order.</div></div>
      </details>

      <!-- userAgent (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ user_agent_md | markdownify }}</div></div>
      </details>

      <!-- language (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The language of the payer.</div></div>
      </details>

      {% if documentation_section contains "checkout-v3" %}
      <!-- generateUnscheduledToken (opt, inside v3 block) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f generateUnscheduledToken, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>boolean</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>true</code> or <code>false</code>. Set to <code>true</code> if you want to generate an <code>unscheduledToken</code> for future unscheduled purchases (Merchant Initiated Transactions).</div></div>
      </details>

      <!-- productName (req, v3) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f productName, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Used to tag the payment as Online Payments v3.0. Mandatory for Online Payments v3.0, either in this field or the header, as you won't get the operations in the response without submitting this field.</div></div>
      </details>

      <!-- implementation (opt, v3) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates which implementation to use.</div></div>
      </details>
      {% endif %}

      <!-- urls (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
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

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f paymentUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
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
            </summary>
            <div class="desc"><div class="indent-2">The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an <code>abort</code> request of the <code>payment</code> or <code>paymentorder</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f callbackUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ callback_url_md | markdownify }} For recurring transactions, the callback will only be sent for Trustly transactions, not card.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f termsOfServiceUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ terms_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f logoUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ logo_url_md | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <!-- payeeInfo (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
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
            <div class="desc"><div class="indent-2">{{ payee_reference_md | markdownify }}</div></div>
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
            </summary>
            <div class="desc"><div class="indent-2">A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f orderReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The order reference should reflect the order reference found in the merchant's systems.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f subsite, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(40)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ subsite_md | markdownify }}</div></div>
          </details>

          {% if documentation_section contains "checkout-v3" %}
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f siteId, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(15)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ site_id_md | markdownify }}</div></div>
          </details>
          {% endif %}
        </div>
      </details>

      <!-- payer (opt) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>payer</code> object containing information about the payer relevant for the payment order.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f digitalProducts, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Set to <code>true</code> for merchants who only sell digital goods and only require <code>email</code> and/or <code>msisdn</code> as shipping details. Set to <code>false</code> if the merchant also sells physical goods.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f firstName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
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

          <!-- shippingAddress (object under payer) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shippingAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The shipping address object related to the <code>payer</code>. The field is related to {% if documentation_section contains "checkout-v3" %}<a href="{{ features_url }}/customize-payments/frictionless-payments">3-D Secure 2</a>{% else %}<a href="{{ features_url }}/core/frictionless-payments">3-D Secure 2</a>{% endif %}.</div></div>
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f firstName, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The first name of the addressee – the receiver of the shipped goods.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f lastName, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The last name of the addressee – the receiver of the shipped goods.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's street address. Maximum 50 characters long.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's c/o address, if applicable.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's zip code</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Payer's city of residence.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Country code for country of residence.</div></div>
              </details>
            </div>
          </details>

          <!-- billingAddress (object, required with some required fields) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f billingAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The billing address object containing information about the payer's billing address.</div></div>
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f firstName, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The first name of the payer.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f lastName, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The last name of the payer.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req">{% icon check %}</span>
                </summary>
                <div class="desc"><div class="indent-3">The street address of the payer. Maximum 50 characters long.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The CO-address (if used)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req">{% icon check %}</span>
                </summary>
                <div class="desc"><div class="indent-3">The postal number (ZIP code) of the payer.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req">{% icon check %}</span>
                </summary>
                <div class="desc"><div class="indent-3">The city of the payer.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                  <span class="req">{% icon check %}</span>
                </summary>
                <div class="desc"><div class="indent-3"><code>SE</code>, <code>NO</code>, or <code>FI</code>.</div></div>
              </details>
            </div>
          </details>

          <!-- accountInfo (object under payer) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f accountInfo, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Object related to the <code>payer</code> containing info about the payer's account.</div></div>
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountAgeIndicator, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates the age of the payer's account. <br><code>01</code> (No account, guest checkout) <br><code>02</code> (Created during this transaction) <br><code>03</code> (Less than 30 days old) <br><code>04</code> (30 to 60 days old) <br><code>05</code> (More than 60 days old)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountChangeIndicator, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates when the last account changes occurred. <br><code>01</code> (Changed during this transaction) <br><code>02</code> (Less than 30 days ago) <br><code>03</code> (30 to 60 days ago) <br><code>04</code> (More than 60 days ago)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f accountChangePwdIndicator, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates when the account's password was last changed. <br><code>01</code> (No changes) <br><code>02</code> (Changed during this transaction) <br><code>03</code> (Less than 30 days ago) <br><code>04</code> (30 to 60 days ago) <br><code>05</code> (More than 60 days old)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f shippingAddressUsageIndicator, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates when the payer's shipping address was last used. <br><code>01</code>(This transaction) <br><code>02</code> (Less than 30 days ago) <br><code>03</code> (30 to 60 days ago) <br><code>04</code> (More than 60 days ago)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f shippingNameIndicator, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates if the account name matches the shipping name. <br><code>01</code> (Account name identical to shipping name) <br><code>02</code> (Account name different from shipping name)</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f suspiciousAccountActivity, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates if there have been any suspicious activities linked to this account. <br><code>01</code> (No suspicious activity has been observed) <br><code>02</code> (Suspicious activity has been observed)</div></div>
              </details>
            </div>
          </details>
        </div>
      </details>

      <!-- orderItems (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
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
            <div class="desc"><div class="indent-2"><code>PRODUCT</code>, <code>SERVICE</code>, <code>SHIPPING_FEE</code>, <code>PAYMENT_FEE</code> <code>DISCOUNT</code>, <code>VALUE_CODE</code> or <code>OTHER</code>. The type of the order item. <code>PAYMENT_FEE</code> is the amount you are charged with when you are paying with invoice. The amount can be defined in the <code>amount</code> field below.</div></div>
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
            <div class="desc"><div class="indent-2">The URL to a page that can display the purchased item, product or similar.</div></div>
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
            <div class="desc"><div class="indent-2">{{ item_description_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountDescription, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
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
      <!-- riskIndicator (opt, sibling to orderItems) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f riskIndicator, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">This <strong>optional</strong> object consists of information that helps verifying the payer. Providing these fields decreases the likelihood of having to prompt for 3-D Secure 2.0 authentication of the payer when they are authenticating the purchase.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f deliveryEmailAdress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">For electronic delivery, the email address to which the merchandise was delivered. Providing this field when appropriate decreases the likelihood of a 3-D Secure authentication for the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f deliveryTimeFrameIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the merchandise delivery timeframe. <br><code>01</code> (Electronic Delivery) <br><code>02</code> (Same day shipping) <br><code>03</code> (Overnight shipping) <br><code>04</code> (Two-day or more shipping)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f preOrderDate, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">For a pre-ordered purchase. The expected date that the merchandise will be available. Format: <code>YYYYMMDD</code></div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f preOrderPurchaseIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br><code>01</code> (Merchandise available) <br><code>02</code> (Future availability)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shipIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates shipping method chosen for the transaction. <br><code>01</code> (Ship to cardholder's billing address) <br><code>02</code> (Ship to another verified address on file with merchant)<br><code>03</code> (Ship to address that is different than cardholder's billing address)<br><code>04</code> (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)<br><code>05</code> (Digital goods, includes online services, electronic giftcards and redemption codes) <br><code>06</code> (Travel and Event tickets, not shipped) <br><code>07</code> (Other, e.g. gaming, digital service)</div></div>
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

          <!-- pickUpAddress object under riskIndicator -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f pickUpAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If <code>shipIndicator</code> set to <code>04</code>, then prefill this with the payers <code>pickUpAddress</code> of the purchase to decrease the risk factor of the purchase.</div></div>
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f name, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, then prefill this with the payers <code>name</code> of the purchase to decrease the risk factor of the purchase.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f streetAddress, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, then prefill this with the payers <code>streetAddress</code> of the purchase to decrease the risk factor of the purchase. Maximum 50 characters long.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f coAddress, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, then prefill this with the payers <code>coAddress</code> of the purchase to decrease the risk factor of the purchase.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f city, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, then prefill this with the payers <code>city</code> of the purchase to decrease the risk factor of the purchase.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f zipCode, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">If <code>shipIndicator</code> set to <code>04</code>, then prefill this with the payers <code>zipCode</code> of the purchase to decrease the risk factor of the purchase.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
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

## Initial Unscheduled Response

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
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [
          "CreditCard",
          "Trustly" ],
        "integration": "HostedView", //For Seamless View integrations
        "integration": "Redirect", //For Redirect integrations
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

{% capture id_paymentorder_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture operation_md %}{% include fields/operation.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture description_md %}{% include fields/description.md %}{% endcapture %}
{% capture initiating_system_user_agent_md %}{% include fields/initiating-system-user-agent.md %}{% endcapture %}
{% capture language_md %}{% include fields/language.md %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Root: paymentOrder (level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <!-- Children of paymentOrder (level 1) -->
    <div class="api-children">

      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_paymentorder_md | markdownify }}</div></div>
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
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }}</div></div>
      </details>

      {% if documentation_section contains "checkout-v3" %}
      <!-- status (v3) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f status, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates the payment order's current status. <code>Initialized</code> is returned when the payment is created and still ongoing. The request example above has this status. <code>Paid</code> is returned when the payer has completed the payment successfully. See the <a href="{{ techref_url }}/technical-reference/status-models#paid">Paid response</a>. <code>Failed</code> is returned when a payment has failed. You will find an error message in <a href="{{ techref_url }}/technical-reference/status-models#failed">the Failed response</a>. <code>Cancelled</code> is returned when an authorized amount has been fully cancelled. See the <a href="{{ techref_url }}/technical-reference/status-models#cancelled">Cancelled response</a>. It will contain fields from both the cancelled description and paid section. <code>Aborted</code> is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). See the <a href="{{ techref_url }}/technical-reference/status-models#aborted">Aborted response</a>.</div></div>
      </details>
      {% else %}
      <!-- state (non-v3) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f state, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Ready</code>, <code>Pending</code>, <code>Failed</code> or <code>Aborted</code>. Indicates the state of the payment order. Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes.</div></div>
      </details>
      {% endif %}

      <!-- currency -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment order in the ISO 4217 format (e.g. `EUR`, `DKK`, `NOK` or `SEK`). Some payment methods are only available with selected currencies.</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <!-- initiatingSystemUserAgent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f initiatingSystemUserAgent, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ initiating_system_user_agent_md | markdownify }}</div></div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <!-- availableInstruments (v3 only) / implementation+integration -->
      {% if documentation_section contains "checkout-v3" %}
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f availableInstruments, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of payment methods available for this payment.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments implementation type. <code>Enterprise</code> or <code>PaymentsOnly</code>. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integration, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The merchant's Online Payments integration type. <code>HostedView</code> (Seamless View) or <code>Redirect</code>. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.</div></div>
      </details>
      {% endif %}

      <!-- instrumentMode -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrumentMode, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payment is initialized with only one payment method available.</div></div>
      </details>

      <!-- guestMode -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f guestMode, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a <code>payerReference</code> in the original <code>paymentOrder</code> request.</div></div>
      </details>

      <!-- payer link (conditional text) -->
      {% if documentation_section contains "checkout-v3" %}
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#payer">payer resource</a> where information about the payer can be retrieved.</div></div>
      </details>
      {% else %}
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payer</code> resource where information about the payer can be retrieved.</div></div>
      </details>
      {% endif %}

      <!-- orderItems link -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>orderItems</code> resource where information about the order items can be retrieved.</div></div>
      </details>

      {% if documentation_section contains "checkout-v3" %}
      <!-- v3 resource links -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f history, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>ic</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#history">history resource</a> where information about the payment's history can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failed, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#failed">failed resource</a> where information about the failed transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f aborted, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#aborted">aborted resource</a> where information about the aborted transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paid, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#paid">paid resource</a> where information about the paid transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cancelled, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#cancelled">cancelled resource</a> where information about the cancelled transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f financialTransactions, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#financialtransactions">financialTransactions resource</a> where information about the financial transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failedAttempts, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ techref_url }}/technical-reference/resource-sub-models#failedattempts">failedAttempts resource</a> where information about the failed attempts can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>metadata</code> resource where information about the metadata can be retrieved.</div></div>
      </details>
      {% endif %}
    </div>
  </details>

    <!-- operations array -->
    <details class="api-item" data-level="01">
        <summary>
        <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-0">{{ operations_md | markdownify }}</div></div>
  </details>
</div>

## GET The Token

{% if documentation_section contains "checkout-v3" %}

The token can be retrieved by performing a [`GET` towards
`paid`][paid-resource-model]. It will be visible under `tokens` in the `paid`
field.

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

As an alternative, you can also retrieve it by using the expand option when you
`GET` your payment. The `GET` request should look like the one below, with a
`?$expand=paid` after the `paymentOrderId`. The response should match the
initial payment response, but with an expanded `paid` field.

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% else %}

You can retrieve it by using the expand option when you `GET` your payment. The
`GET` request should look like the one below, with a `?$expand=paid` after the
`paymentOrderId`. The response should match the initial payment response, but
with an expanded `paid` field.

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% endif %}

## Performing The Unscheduled Purchase

When you are ready to perform the unscheduled purchase, simply add the
`unscheduledToken` field to the `paymentOrder` request and use the token as the
value. Your request should look like the example below, and the response will
match the `paymentOrder` response from the initial purchase.

{% if documentation_section contains "checkout-v3" %}

## After The Unscheduled Purchase

Please remember that the `unscheduled` request will reserve the amount, but not
charge it. You will (i.e. when you are ready to ship purchased physical
products) have to perform a [Capture][payment-order-capture] request later on to
complete the unscheduled purchase. You can also [Cancel][payment-order-cancel]
it if needed.

{% else %}

## After The Unscheduled Purchase

Please remember that the `unscheduled` request will reserve the amount, but not
charge it. You will (i.e. when you are ready to ship purchased physical
products) have to perform a [Capture][old-payment-order-capture] request later
on to complete the unscheduled purchase. You can also
[Cancel][old-payment-order-cancel] it if needed.

{% endif %}

## Unscheduled Request

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "UnscheduledPurchase",
        "unscheduledToken": "{{ page.payment_id }}",
        "currency": "NOK",
        "amount": 1500,
        "vatAmount": 0,
        "description": "Test Unscheduled Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO", {% if documentation_section contains "checkout-v3" %}
        "productName": "Checkout3", // Removed in 3.1, can be excluded in 3.0 if version is added in header
        {% endif %}
        "urls": {
            "callbackUrl": "https://example.com/payment-callback" // Callbacks will only be sent for Trustly
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}"
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite", {% if documentation_section contains "checkout-v3" %}
            "siteId": "MySiteId", {% endif %}
        },
        "payer": {
            "payerReference": "AB1234",
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
            }
        ]
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture description_md %}{% include fields/description.md %}{% endcapture %}
{% capture user_agent_md %}{% include fields/user-agent.md %}{% endcapture %}
{% capture language_md %}{% include fields/language.md %}{% endcapture %}
{% capture callback_url_md %}{% include fields/callback-url.md %}{% endcapture %}
{% capture payee_info_md %}{% include fields/payee-info.md %}{% endcapture %}
{% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}
{% capture receipt_reference_md %}{% include fields/receipt-reference.md %}{% endcapture %}
{% capture subsite_md %}{% include fields/subsite.md %}{% endcapture %}
{% capture site_id_md %}{% include fields/site-id.md %}{% endcapture %}
{% capture order_items_md %}{% include fields/order-items.md %}{% endcapture %}

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- Root: paymentOrder (level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The payment object.</div></div>

    <div class="api-children">
      <!-- operation (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1"><code>UnscheduledPurchase</code>.</div></div>
      </details>

      <!-- unscheduledToken (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f unscheduledToken, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The generated <code>unscheduledToken</code>, if <code>operation: Verify</code>, <code>operation: UnscheduledPurchase</code> or <code>generateUnscheduledToken: true</code> was used.</div></div>
      </details>

      <!-- currency (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment order in the ISO 4217 format (e.g. `EUR`, `DKK`, `NOK` or `SEK`). Some payment methods are only available with selected currencies.</div></div>
      </details>

      <!-- amount (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- description (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <!-- userAgent (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ user_agent_md | markdownify }}</div></div>
      </details>

      <!-- language (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      {% if documentation_section contains "checkout-v3" %}
      <!-- productName (req in v3) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f productName, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Used to tag the payment as Online Payments v3.0. Mandatory for Online Payments v3.0, either in this field or the header, as you won't get the operations in the response without submitting this field.</div></div>
      </details>
      {% endif %}

      <!-- implementation (opt) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates which implementation to use.</div></div>
      </details>

      <!-- urls link (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>urls</code> resource where all URLs related to the payment order can be retrieved.</div></div>
      </details>

      <!-- callbackUrl (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f callbackUrl, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ callback_url_md | markdownify }} For recurring transactions, the callback will only be sent for Trustly transactions, not card.</div></div>
      </details>

      <!-- payeeInfo (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
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
            <div class="desc"><div class="indent-2">This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_reference_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f receiptReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ receipt_reference_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.</div></div>
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
            <div class="desc"><div class="indent-2">{{ subsite_md | markdownify }}</div></div>
          </details>

          {% if documentation_section contains "checkout-v3" %}
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f siteId, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(15)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ site_id_md | markdownify }}</div></div>
          </details>
          {% endif %}
        </div>
      </details>

      <!-- payer (opt, string/id) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>payer</code> object, containing information about the payer.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payerReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/payer-reference.md %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f metadata, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/metadata.md %}</div></div>
          </details>
        </div>
      </details>

      <!-- orderItems (req) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
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
            <div class="desc"><div class="indent-2"><code>PRODUCT</code>, <code>SERVICE</code>, <code>SHIPPING_FEE</code>, <code>PAYMENT_FEE</code> <code>DISCOUNT</code>, <code>VALUE_CODE</code> or <code>OTHER</code>. The type of the order item. <code>PAYMENT_FEE</code> is the amount you are charged with when you are paying with invoice. The amount can be defined in the <code>amount</code> field below.</div></div>
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
            <div class="desc"><div class="indent-2">The URL to a page that can display the purchased item, product or similar.</div></div>
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
            <div class="desc"><div class="indent-2">{{ description_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountDescription, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the possible discount.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f quantity, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
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

      <!-- restrictedToInstruments (opt) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f restrictedToInstruments, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of the payment methods you wish to restrict the payment to. Currently <code>Invoice</code> only. <code>Invoice</code> supports the subtypes <code>PayExFinancingNo</code>, <code>PayExFinancingSe</code> and <code>PayMonthlyInvoiceSe</code>, separated by a dash, e.g.; <code>Invoice-PayExFinancingNo</code>. Default value is all supported payment methods. Use of this field requires an agreement with Swedbank Pay. You can restrict fees and/or discounts to certain payment methods by adding this field to the orderline you want to restrict. Use positive amounts to add fees and negative amounts to add discounts.</div></div>
      </details>

    </div>
  </details>
</div>

{% include payment-order-capture.md %}

<!--lint disable final-definition -->

[delete-token]: {{ features_url }}/optional/delete-token
[paid-resource-model]: {{ techref_url }}/technical-reference/resource-sub-models#paid
[old-payment-order-cancel]: /old-implementations/checkout-v2/after-payment#cancel
[old-payment-order-capture]: /old-implementations/checkout-v2/capture
[payment-order-cancel]: /checkout-v3/get-started/post-purchase/#cancel-v31
[payment-order-capture]: /checkout-v3/get-started/post-purchase/#capture-v31
[verify]: {{ features_url }}/optional/verify
