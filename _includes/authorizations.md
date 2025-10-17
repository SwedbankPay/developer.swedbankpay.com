{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

## List Authorizations

The `authorizations` resource will list the authorization transactions
made on a specific payment.

{% capture request_header %}GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% include transaction-list-response.md transaction="authorization" %}

## Create Authorization Transaction

To create an `authorization` transaction, perform the `create-authorization`
operation as returned in a previously created invoice payment.

{% include alert.html type="informative" icon="info" body="
Note: The legal address must be the registered address of the payer." %}

## Authorization Request

{% capture request_header %}POST /psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "activity": "FinancingConsumer"
    },
    "consumer": {
        "socialSecurityNumber": "socialSecurityNumber",
        "customerNumber": "123456",
        "name": "Olivia Nyhuus",
        "email": "olivia.nyhuus@swedbankpay.com",
        "msisdn": "+4798765432",
        "ip": "127.0.0.1"
    },
    "legalAddress": {
        "addressee": "Olivia Nyhuus",
        "streetAddress": "SaltnesToppen 43",
        "zipCode": "1642",
        "city": "Saltnes",
        "countryCode": "no"
    },
    "billingAddress": {
        "addressee": "Olivia Nyhuus",
        "coAddress": "Bernt Nyhuus",
        "streetAddress": "SaltnesToppen 43",
        "zipCode": "1642",
        "city": "Saltnes",
        "countryCode": "no"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

<div class="api-compact" aria-label="Authorization Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- LEVEL 0: transaction -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field"><code>transaction</code><span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req"></span>
    </summary>
    <div class="desc"><div class="indent-0">Transaction context.</div></div>

    <!-- LEVEL 1: transaction children -->
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field"><code>activity</code><span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1"><code>FinancingConsumer</code></div></div>
      </details>
    </div>
  </details>

  <!-- LEVEL 0: consumer -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field"><code>consumer</code><span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The payer object.</div></div>

    <!-- LEVEL 1: consumer children -->
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f socialSecurityNumber %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            The social security number (national identity number) of the payer.
            Format Sweden: <code>YYMMDD-NNNN</code>. Format Norway: <code>DDMMYYNNNNN</code>. Format Finland: <code>DDMMYYNNNNN</code>.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f customerNumber %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The customer number in the merchant system.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f email %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The e-mail address of the payer.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f msisdn %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">The mobile phone number of the payer. Format Sweden: <code>+46707777777</code>. Format Norway: <code>+4799999999</code>. Format Finland: <code>+358501234567</code>.</div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f ip %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The IP address of the payer.</div></div>
      </details>
    </div>
  </details>

  <!-- LEVEL 0: legalAddress -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field"><code>legalAddress</code><span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The legal address object containing information about the payer's legal address.</div></div>

    <!-- LEVEL 1: legalAddress children -->
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f addressee %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The full (first and last) name of the payer.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f coAddress %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The CO-address (if used)</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f streetAddress %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The street address of the payer. Maximum 50 characters long.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f zipCode %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The postal code (ZIP code) of the payer.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f city %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The city of the payer.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f countryCode %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1"><code>SE</code>, <code>NO</code>, or <code>FI</code>. The country code of the payer.</div></div>
      </details>
    </div>
  </details>

  <!-- LEVEL 0: billingAddress -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field"><code>billingAddress</code><span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The billing address object containing information about the payer's billing address.</div></div>

    <!-- LEVEL 1: billingAddress children -->
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f addressee %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The full (first and last) name of the payer.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f coAddress %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The CO-address (if used)</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f streetAddress %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The street address of the payer. Maximum 50 characters long.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f zipCode %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The postal number (ZIP code) of the payer.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f city %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The city of the payer.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f countryCode %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1"><code>SE</code>, <code>NO</code>, or <code>FI</code>.</div></div>
      </details>
    </div>
  </details>
</div>

## Authorization Response

The `authorization` resource will be returned, containing information about
the newly created authorization transaction.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "authorization": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id}}",
        "consumer": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/consumer"
        },
        "legalAddress": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/legaladdress"
        },
        "billingAddress": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/billingaddress"
        },
        "transaction": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id}}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Authorization",
            "state": "Initialized",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456",
            "isOperational": false,
            "operations": [
                {
                    "href": "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
                    "rel": "edit-authorization",
                    "method": "PATCH"
                }
            ]
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}
