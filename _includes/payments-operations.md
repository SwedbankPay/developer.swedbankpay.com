{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}

## Operation `paid-payment`

The `paid-payment` operation confirms that the transaction has been successful
and that the payment is completed.

A `paid-payment` operation looks like this:

{% capture response_content %}{
   "href": "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}/paid",
   "rel": "paid-payment",
   "method": "GET",
   "contentType": "application/json"
}{% endcapture %}

{% include code-example.html
    title='`paid-payment` operation'
    header=response_header
    json= response_content
    %}

To inspect the paid payment, you need to perform an HTTP `GET` request
towards the operation's `href` field. An example of the request and
response is given below.

{% capture request_header %}GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% if documentation_section == "card" %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "paid": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/paid",
        "number": 1234567890,
        "transaction": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ site.transaction_id }}",
            "number": 1234567891
        },
        "payeeReference": "CD123",
        "orderReference": "AB1234",
        "amount": 1500,
        "tokens": [
            {
                "type": "payment",
                "token": "{{ page.payment_token }}",
                "name": "4925xxxxxx000004",
                "expiryDate": "mm/yyyy"
            },
            {
                "type": "recurrence",
                "token": "{{ page.payment_token }}",
                "name": "4925xxxxxx000004",
                "expiryDate": "mm/yyyy"
            },
            {
                "type": "transactionsOnFile",
                "token": "{{ page.payment_token }}",
                "name": "4925xxxxxx000004",
                "expiryDate": "mm/yyyy"
            }
        ],
        "details": {
            "cardBrand": "Visa",
            "MaskedPan": "4925xxxxxx000004",
            "cardType": "Credit",
            "issuingBank": "UTL MAESTRO",
            "countryCode": "999",
            "acquirerTransactionType": "3DSECURE",
            "issuerAuthorizationApprovalCode": "397136",
            "acquirerStan": "39736",
            "acquirerTerminalId": "39",
            "acquirerTransactionTime": "2017-08-29T13:42:18Z",
            "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
            "externalNonPaymentToken": "1234567890",
            "transactionInitiator": "MERCHANT"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% else %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "paid": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/paid",
        "number": 1234567890,
        "transaction": {
            "id": "/psp{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ site.transaction_id }}",
            "number": 1234567891
        },
        "payeeReference": "CD123",
        "orderReference": "AB1234",
        "amount": 1500
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% endif %}

{% capture payment_txn_link_md %}{% include fields/id.md sub_resource="transaction" %}{% endcapture %}
{% capture transaction_md %}{% include fields/transaction.md %}{% endcapture %}
{% capture id_txn_md %}{% include fields/id.md resource="transaction" %}{% endcapture %}
{% capture number_md %}{% include fields/number.md %}{% endcapture %}
{% capture payee_reference_md %}{% include fields/payee-reference.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Root: payment (level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">{{ payment_txn_link_md | markdownify }}</div></div>

    <div class="api-children">
      <!-- transaction (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f transaction, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ transaction_md | markdownify }}</div></div>

        <!-- Children of transaction (level 2) -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ id_txn_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ number_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f cardBrand, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>Visa</code>, <code>MC</code>, etc. The brand of the card.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f maskedPan, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The masked PAN number of the card.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f cardType, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>Credit Card</code> or <code>Debit Card</code>. Indicates the type of card used for the authorization.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f issuingBank, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the bank that issued the card used for the authorization.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f countryCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The country the card is issued in.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f acquirerTransactionType, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>3DSECURE</code> or <code>SSL</code>. Indicates the transaction type of the acquirer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f acquirerStan, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The System Trace Audit Number assigned by the acquirer to uniquely identify the transaction.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f acquirerTerminalId, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ID of the acquirer terminal.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f acquirerTransactionTime, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>date(string)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a> date and time of the acquirer transaction.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f nonPaymentToken, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The result of our own card tokenization. Activated in POS for the merchant or merchant group.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f externalNonPaymentToken, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, transactions redeemed by Visa will be populated with PAR. For Mastercard and Amex, it will be our own token.</div></div>
          </details>
        </div>
      </details>

      <!-- Siblings to transaction (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeReference, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(30)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payee_reference_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderReference, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(50)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The order reference, which should reflect the order reference found in the merchant's systems.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f tokens, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of generated tokens.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f details, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A human readable and descriptive text of the payment.</div></div>
      </details>

    </div>
  </details>
</div>

## Operation `failed-payment`

The `failed-payment` operation means that something went wrong during the
payment process. The transaction was not authorized, and no further transactions
can be created if the payment is in this state.

A `failed-payment` operation looks like this:

{% capture response_content %}{
   "href": "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}/failed",
   "rel": "failed-payment",
   "method": "GET",
   "contentType": "application/problem+json"
}{% endcapture %}

{% include code-example.html
    title='`failed-payment` operation'
    header=response_header
    json= response_content
    %}

To inspect why the payment failed, you need to perform an HTTP `GET` request
towards the operation's `href` field.

The problem message can be found in `details` field. Under `problems` you can
see which problem occurred, a `description` of the problem and the corresponding
error code.

An example of the request and response is given below.

{% capture request_header %}GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/failed HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "problem": {
        "type": "{{ page.api_url }}/psp/errordetail/{{ api_resource }}/acquirererror",
        "title": "Operation failed",
        "status": 403,
        "detail": {% if documentation_section == "trustly" %} "Unable to complete operation, error calling 3rd party", {% else %} "Unable to complete Authorization transaction, look at problem node!", {% endif %}
        "problems": [
            {
                "name": "ExternalResponse",
                "description": "REJECTED_BY_ACQUIRER-unknown error, response-code: 51"
            }
        ]
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

## Operation `aborted-payment`

The `aborted-payment` operation means that the merchant aborted the payment
before the payer fulfilled the payment process. You can see this under
`abortReason` in the response.

An `aborted-payment` operation looks like this:

{% capture response_content %}{
    "href": "{{ page.api_url }}/psp/creditcard/payments/<paymentId>/aborted",
    "rel": "aborted-payment",
    "method": "GET",
    "contentType": "application/json"
}{% endcapture %}

{% include code-example.html
    title='`aborted-payment` operation'
    header=response_header
    json= response_content
    %}

To inspect why the payment was aborted, you need to perform an HTTP `GET`
request towards the operation's `href` field. An example of the request and
response is given below.

{% capture request_header %}GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/aborted HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "aborted": {
        "abortReason": "Aborted by consumer"
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}
