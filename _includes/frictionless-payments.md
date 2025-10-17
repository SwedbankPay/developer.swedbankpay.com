{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% assign api_resource_field_name = 'paymentorder' %}
{% if api_resource != 'paymentorders' %}
    {% assign api_resource_field_name = 'payment' %}
{% endif %}

## Frictionless Payments

3-D Secure 2 is an improved version of the old protocol, now allowing
frictionless payments where transactions can be completed without input from the
cardholder. To increase the chances of a frictionless payment, there are certain
fields that should be included in your request. The more information you add,
the better.

{% if api_resource == "creditcard" %}

## Cardholder

{% else %}

## Payer

{% endif %}

{% if api_resource == "creditcard" %}

{% capture request_content %}{
    "cardholder": {
        "firstName": "Olivia",
        "lastName": "Nyhuus",
        "email": "olivia.nyhuus@swedbankpay.com",
        "msisdn": "+4798765432",
        "homePhoneNumber": "+4787654321",
        "workPhoneNumber": "+4776543210",
        "shippingAddress": {
            "addressee": "Olivia Nyhuus",
            "email": "olivia.nyhuus@swedbankpay.com",
            "msisdn": "+4798765432",
            "streetAddress": "Saltnestoppen 43",
            "coAddress": "",
            "city": "Saltnes",
            "zipCode": "1642",
            "countryCode": "NO",
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
        },
}{% endcapture %}

{% include code-example.html
    title='Payer Node'
    header=request_header
    json= request_content
    %}

{% else %}

{% capture request_content %}{
    "payer": {
        "email": "olivia.nyhuus@swedbankpay.com",
        "msisdn": "+4798765432",
        "firstName": "Olivia",
        "lastName": "Nyhuus",
        "workPhoneNumber" : "+4787654321",
        "homePhoneNumber" : "+4776543210",
        "shippingAddress": {
            "addressee": "Olivia Nyhuus",
            "streetAddress": "Saltnestoppen 43",
            "coAddress": "",
            "city": "Saltnes",
            "zipCode": "1642",
            "countryCode": "NO"
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
        },
}{% endcapture %}

{% include code-example.html
    title='Payer Node'
    header=request_header
    json= request_content
    %}

{% endif %}

{% if api_resource == "creditcard" %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f cardholder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">Cardholder object that can hold information about a payer (private or company). The information added increases the chance for a frictionless 3-D Secure 2 flow.</div></div>
    <div class="api-children">

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f firstname, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Cardholder's first name.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f lastname, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Cardholder's last name.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f email, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Cardholder's registered email address.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f msisdn, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Cardholder's registered mobile phone number.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f homePhoneNumber, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Cardholder's registered home phone number.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f workPhoneNumber, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Cardholder's registered work phone number.</div></div>
      </details>

      <!-- shippingAddress -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f shippingAddress, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The shipping address object related to the <code>cardholder</code>.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f addressee, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the addressee – the receiver of the shipped goods.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f coAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Cardholder's c/o address, if applicable.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f streetAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Cardholder's street address. Maximum 50 characters long.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f zipCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Cardholder's zip code.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f city, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Cardholder's city of residence.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f countryCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Country Code for the country of residence.</div></div>
          </details>
        </div>
      </details>

      <!-- billingAddress -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f billingAddress, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The billing address object containing information about the payer's billing address.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f firstName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The first name of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f lastName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The last name of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f streetAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The street address of the payer. Maximum 50 characters long.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f coAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The CO-address (if used)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f zipCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The postal number (ZIP code) of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f city, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The city of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f countryCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>SE</code>, <code>NO</code>, or <code>FI</code>.</div></div>
          </details>
        </div>
      </details>

      <!-- accountInfo -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f accountInfo, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Object related to the <code>payer</code> containing info about the payer's account.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f accountAgeIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the age of the payer's account. <br><code>01</code> (No account, guest checkout) <br><code>02</code> (Created during this transaction) <br><code>03</code> (Less than 30 days old) <br><code>04</code> (30 to 60 days old) <br><code>05</code> (More than 60 days old)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f accountChangeIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates when the last account changes occurred. <br><code>01</code> (Changed during this transaction) <br><code>02</code> (Less than 30 days ago) <br><code>03</code> (30 to 60 days ago) <br><code>04</code> (More than 60 days ago)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f accountChangePwdIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates when the account's password was last changed. <br><code>01</code> (No changes) <br><code>02</code> (Changed during this transaction) <br><code>03</code> (Less than 30 days ago) <br><code>04</code> (30 to 60 days ago) <br><code>05</code> (More than 60 days old)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shippingAddressUsageIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates when the payer's shipping address was last used. <br><code>01</code>(This transaction) <br><code>02</code> (Less than 30 days ago) <br><code>03</code> (30 to 60 days ago) <br><code>04</code> (More than 60 days ago)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shippingNameIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates if the account name matches the shipping name. <br><code>01</code> (Account name identical to shipping name) <br><code>02</code> (Account name different from shipping name)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f suspiciousAccountActivity, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates if there have been any suspicious activities linked to this account. <br><code>01</code> (No suspicious activity has been observed) <br><code>02</code> (Suspicious activity has been observed)</div></div>
          </details>
        </div>
      </details>

    </div>
  </details>
</div>

{% else %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payer, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payer object.</div></div>
    <div class="api-children">

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f email, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Payer's registered email address.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f msisdn, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Payer's registered mobile phone number.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f firstname, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Payer's first name. Please note that this is not the <code>addressee</code> or from <code>shippingAddress</code>, as they might not be the same as the payer.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f lastname, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Payer's last name. Please note that this is not the <code>addressee</code> or <code>lastName</code> from <code>shippingAddress</code>, as they might not be the same as the payer.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f homePhoneNumber, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Payer's registered home phone number.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f workPhoneNumber, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Payer's registered work phone number.</div></div>
      </details>

      <!-- shippingAddress -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f shippingAddress, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The shipping address object related to the <code>payer</code>.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f addressee, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the addressee – the receiver of the shipped goods.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f coAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payer's c/o address, if applicable.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f streetAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payer's street address. Maximum 50 characters long.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f zipCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payer's zip code.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f city, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payer's city of residence.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f countryCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Country Code for the country of residence.</div></div>
          </details>
        </div>
      </details>

      <!-- billingAddress -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f billingAddress, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The billing address object containing information about the payer's billing address.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f firstName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The payer's first name.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f lastName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The payer's last name.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f streetAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The payer's street address. Maximum 50 characters long.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f coAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The payer's CO-address (if used).</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f zipCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The postal number (ZIP code) of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f city, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The city of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f countryCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>SE</code>, <code>NO</code>, or <code>FI</code>.</div></div>
          </details>
        </div>
      </details>

      <!-- accountInfo -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f accountInfo, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Object related to the <code>payer</code> containing info about the payer's account.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f accountAgeIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the age of the payer's account. <br><code>01</code> (No account, guest checkout) <br><code>02</code> (Created during this transaction) <br><code>03</code> (Less than 30 days old) <br><code>04</code> (30 to 60 days old) <br><code>05</code> (More than 60 days old)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f accountChangeIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates when the last account changes occurred. <br><code>01</code> (Changed during this transaction) <br><code>02</code> (Less than 30 days ago) <br><code>03</code> (30 to 60 days ago) <br><code>04</code> (More than 60 days ago)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f accountChangePwdIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates when the account's password was last changed. <br><code>01</code> (No changes) <br><code>02</code> (Changed during this transaction) <br><code>03</code> (Less than 30 days ago) <br><code>04</code> (30 to 60 days ago) <br><code>05</code> (More than 60 days old)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shippingAddressUsageIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates when the payer's shipping address was last used. <br><code>01</code>(This transaction) <br><code>02</code> (Less than 30 days ago) <br><code>03</code> (30 to 60 days ago) <br><code>04</code> (More than 60 days ago)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f shippingNameIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates if the account name matches the shipping name. <br><code>01</code> (Account name identical to shipping name) <br><code>02</code> (Account name different from shipping name)</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f suspiciousAccountActivity, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates if there have been any suspicious activities linked to this account. <br><code>01</code> (No suspicious activity has been observed) <br><code>02</code> (Suspicious activity has been observed)</div></div>
          </details>
        </div>
      </details>

    </div>
  </details>
</div>

{% endif %}

## Risk Indicator

{% capture request_content %}{
    "riskIndicator": {
        "deliveryEmailAddress": "olivia.nyhuus@swedbankpay.com",
        "deliveryTimeFrameIndicator": "01",
        "preOrderDate": "19801231",
        "preOrderPurchaseIndicator": "01",
        "shipIndicator": "01",
        "giftCardPurchase": false,
        "reOrderPurchaseIndicator": "01"
        "pickUpAddress" : {
            "name": "Company Megashop Sarpsborg",
            "streetAddress": "Hundskinnveien 92",
            "coAddress": "",
            "city": "Sarpsborg",
            "zipCode": "1711",
            "countryCode": "NO"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Risk Indicator Node'
    header=request_header
    json= request_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f riskIndicator, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">This object consist of information that helps verifying the payer. Providing these fields decreases the likelihood of having to prompt for a 3-D Secure authentication of the payer when they are authenticating the purchase.</div></div>
    <div class="api-children">

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f deliveryEmailAdress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">For electronic delivery, the email address to which the merchandise was delivered.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f deliveryTimeFrameIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates the merchandise delivery timeframe. <br><code>01</code> (Electronic Delivery) <br><code>02</code> (Same day shipping) <br><code>03</code> (Overnight shipping) <br><code>04</code> (Two-day or more shipping).</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f preOrderDate, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">For a pre-ordered purchase. The expected date that the merchandise will be available. Format: <code>YYYYMMDD</code>.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f preOrderPurchaseIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br><code>01</code> (Merchandise available) <br><code>02</code> (Future availability).</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f shipIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates shipping method chosen for the transaction. <br><code>01</code> (Ship to cardholder's billing address) <br><code>02</code> (Ship to another verified address on file with merchant)<br><code>03</code> (Ship to address that is different than cardholder's billing address)<br><code>04</code> (Ship to Store / Pick-up at local store. Store address shall be populated in the <code>riskIndicator.pickUpAddress</code> and <code>payer.shippingAddress</code> fields)<br><code>05</code> (Digital goods, includes online services, electronic giftcards and redemption codes) <br><code>06</code> (Travel and Event tickets, not shipped) <br><code>07</code> (Other, e.g. gaming, digital service).</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f giftCardPurchase, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>true</code> if this is a purchase of a gift card.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f reOrderPurchaseIndicator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates if the cardholder is reordering previously purchased merchandise. <br><code>01</code> (First time ordered) <br><code>02</code> (Reordered).</div></div>
      </details>

      <!-- pickUpAddress -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f pickUpAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">If the <code>shipIndicator</code> is set to <code>04</code>, you can prefill these fields with the payer's <code>pickUpAddress</code> of the purchase to decrease the risk factor of the purchase.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If the <code>shipIndicator</code> is set to <code>04</code>, prefill this with the payer's <code>name</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f streetAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If the <code>shipIndicator</code> is set to <code>04</code>, prefill this with the payer's <code>streetAddress</code>. Maximum 50 characters long.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f coAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If the <code>shipIndicator</code> is set to <code>04</code>, prefill this with the payer's <code>coAddress</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f city, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If the <code>shipIndicator</code> is set to <code>04</code>, prefill this with the payer's <code>city</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f zipCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If the <code>shipIndicator</code> is set to <code>04</code>, prefill this with the payer's <code>zipCode</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f countryCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If the <code>shipIndicator</code> is set to <code>04</code>, prefill this with the payer's <code>countryCode</code>.</div></div>
          </details>
        </div>
      </details>

    </div>
  </details>
</div>
