{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}

## Restrict Payments To A Social Security Number

Swedbank Pay provides the possibility to restrict payments to a Social Security
Number when the payment methods support this. This can be used when you
want to make sure you only accept payments from an already identified
individual.

You do this by adding the field `restrictedToSocialSecurityNumber` in the
`payer` field, in your payment order request, and setting it to `true`. This
will leave out all payment methods which do not support this feature.

It will then use the `socialSecurityNumber` located in the `nationalIdentifier`
field (found within the `payer` field). The `nationalIdentifier` must be
included to use this feature. Payment methods supporting the feature will reject
payments that do not match the restriction.

{% if documentation_section contains "old-implementations/enterprise" %} If you want to
use the Social Security Number just for payment restrictions, and not do a
checkout profile lookup, add the parameter `guestMode` in the
`nationalIdentifier` field and set it to `true`. {% endif %}

You are currently only able to restrict Swish and Trustly payments to a Social
Security Number, but we will add support for more payment methods going
forward. No changes are required at your (the merchant’s) end to be able to
offer more payment methods at a later time.

## Restrict To Social Security Number Request

The field itself is a `bool` which must be added in the `payer` field of the
request. Below is a shortened example of a payment order request. Apart from the
new field, the payment request is similar to a standard payment order request.
For an example of a payment order request, {% if documentation_section contains
"old-implementations/enterprise" %} [click
here.](/old-implementations/enterprise/redirect#payment-order-request) {% endif %} {% if
documentation_section contains "checkout-v3/payments-only" %} [click
here.](/checkout-v3/get-started/payment-request) {% endif %}
The response will be similar to a standard payment order response, which is also
documented on the page linked above.

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "payer": {
            "digitalProducts": false,
            "nationalIdentifier": {
                "socialSecurityNumber": "{{ page.consumer_ssn_se }}",
                "countryCode": "SE",
                "guestMode": true
            },
            "restrictedToSocialSecurityNumber": true,
            "firstName": "Leia",
            "lastName": "Ahlström",
            "email": "leia@swedbankpay.com",
            "msisdn": "+46787654321",
            "payerReference": "AB1234"
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

  <!-- Root: paymentOrder (level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The <code>paymentOrder</code> object.</div></div>

    <!-- Children of paymentOrder -->
    <div class="api-children">

      <!-- payer (first child at level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>payer</code> object containing information about the payer relevant for the payment order.</div></div>

        <!-- Children of payer (all level 2) -->
        <div class="api-children">
          <!-- digitalProducts -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f digitalProducts, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Set to <code>true</code> for merchants who only sell digital goods and only require <code>email</code> and/or <code>msisdn</code> as shipping details. Set to <code>false</code> if the merchant also sells physical goods.</div></div>
          </details>

          <!-- nationalIdentifier (now included, object) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f nationalIdentifier, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The national identifier object.</div></div>

            <!-- Children of nationalIdentifier (level 3) -->
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f socialSecurityNumber, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The payer's social security number.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f countryCode, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The country code of the payer.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f guestMode, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
                  <span class="type"><code>bool</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Set to <code>true</code> if you do not want to do a lookup to checkout profile, and only want to use the Social Security Number to restrict a payment.</div></div>
              </details>
            </div>
          </details>

          <!-- restrictedToSocialSecurityNumber -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f restrictedToSocialSecurityNumber, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Set to <code>true</code> if you want to restrict your payment to a Social Security Number.</div></div>
          </details>

          <!-- firstName (required) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f firstName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The first name of the payer.</div></div>
          </details>

          <!-- lastName (required) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f lastName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The last name of the payer.</div></div>
          </details>

          <!-- email -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f email, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The e-mail address of the payer. Will be used to prefill the Checkin as well as on the payer's profile, if not already set. Increases the chance for {% if documentation_section contains "checkout-v3" %}<a href="{{ features_url }}/customize-payments/frictionless-payments">frictionless 3-D Secure 2 flow</a>{% else %}<a href="{{ features_url }}/core/frictionless-payments">frictionless 3-D Secure 2 flow</a>{% endif %}.</div></div>
          </details>

          <!-- msisdn -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f msisdn, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The mobile phone number of the Payer. Will be prefilled on Checkin page and used on the payer's profile, if not already set. The mobile number must have a country code prefix and be 8 to 15 digits in length. The field is related to {% if documentation_section contains "checkout-v3" %}<a href="{{ features_url }}/customize-payments/frictionless-payments">3-D Secure 2</a>{% else %}<a href="{{ features_url }}/core/frictionless-payments">3-D Secure 2</a>{% endif %}.</div></div>
          </details>

          <!-- payerReference -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payerReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A reference used in Enterprise integrations to recognize the payer in the absence of SSN and/or a secure login. Read more about this in the <a href="/old-implementations/enterprise/features/optional/enterprise-payer-reference">payerReference</a> feature section.</div></div>
          </details>

        </div>
      </details>

    </div>
  </details>
</div>
