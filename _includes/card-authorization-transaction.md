{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

## Card Authorization Transaction

The `authorization` resource contains information about an authorization
transaction made towards a payment. To create a new `authorization` transaction,
perform a `POST` towards the URL obtained from the `payment.authorization.id`
from the `payment` resource below. The example is abbreviated for brevity.

## GET Authorization Request

{% capture request_header %}GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

## GET Authorization Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
        "authorizations": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

## Authorization Request

{% capture request_header %}POST /psp/creditcard/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "cardNumber": "4925000000000004",
        "cardExpiryMonth": "12",
        "cardExpiryYear": "22",
        "cardVerificationCode": "749",
        "cardholderName": "Olivia Nyhuus",
        "chosenCoBrand": "Visa"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

<div class="api-compact" role="table" aria-label="Authorization Request">
  <div class="header" role="row">
    <div role="columnheader">Field</div>
    <div role="columnheader">Type</div>
    <div role="columnheader">Required</div>
  </div>

  <!-- LEVEL 0: transaction -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader"><code>transaction</code><span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The transaction object.</div></div>

    <!-- LEVEL 1: children of transaction -->
    <div class="api-children">

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f cardNumber %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">Primary Account Number (PAN) of the card, printed on the face of the card.</div>
        </div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f cardExpiryMonth %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">Expiry month of the card, printed on the face of the card.</div>
        </div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f cardExpiryYear %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">Expiry year of the card, printed on the face of the card.</div>
        </div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f cardVerificationCode %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc">
          <div class="indent-1">Card verification code (CVC/CVV/CVC2), usually printed on the back of the card.</div>
        </div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f cardholderName %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc">
          <div class="indent-1">Name of the cardholder, usually printed on the face of the card.</div>
        </div>
      </details>

    </div>
  </details>
</div>

## Authorization Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/creditcard/payments/{{ page.payment_id }}",
    "authorization": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id }}",
        "paymentToken": "{{ page.payment_token }}",
        "recurrenceToken": "{{ page.payment_id }}",
        "maskedPan": "123456xxxxxx1234",
        "expiryDate": "mm/yyyy",
        "panToken": "{{ page.transaction_id }}",
        "cardBrand": "Visa",
        "cardType": "Credit",
        "issuingBank": "UTL MAESTRO",
        "countryCode": "999",
        "acquirerTransactionType": "3DSECURE",
        "issuerAuthorizationApprovalCode": "397136",
        "acquirerStan": "39736",
        "acquirerTerminalId": "39",
        "acquirerTransactionTime": "2017-08-29T13:42:18Z",
        "authenticationStatus": "Y",
        "nonPaymentToken": "",
        "externalNonPaymentToken": "",
        "transaction": {
            "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Authorization",
            "state": "Initialized",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456",
            "failedReason": "ExternalResponseError",
            "failedActivityName": "Authorize",
            "failedErrorCode": "REJECTED_BY_ACQUIRER",
            "failedErrorDescription": "General decline, response-code: 05",
            "isOperational": "TRUE",
            "activities": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}/activities" },
            "operations": [
                {
                    "href": "https://api.payex.com/psp/creditcard/payments/{{ page.payment_id }}",
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

<div class="api-compact" role="table" aria-label="Authorization Response">
  <div class="header" role="row">
    <div role="columnheader">Field</div>
    <div role="columnheader">Type</div>
  </div>

  <!-- LEVEL 0: payment -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f payment, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment object.</div></div>
  </details>

  <!-- LEVEL 0: authorization -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f authorization, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The authorization object.</div></div>

    <!-- LEVEL 1: children of authorization -->
    <div class="api-children">

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f direct %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The type of the authorization.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f cardBrand %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Visa</code>, <code>MC</code>, etc. The brand of the card.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f cardType %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Credit Card</code> or <code>Debit Card</code>. Indicates the type of card used for the authorization.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f issuingBank %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The name of the bank that issued the card used for the authorization.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f paymentToken %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The payment token created for the card used in the authorization.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f maskedPan %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The masked PAN number of the card.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f expiryDate %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The month and year of when the card expires.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f panToken %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The token representing the specific PAN of the card.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f panEnrolled %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"></div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f acquirerTransactionTime %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO-8601 date and time of the acquirer transaction.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f id %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/id.md resource="itemDescriptions" %}</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f nonPaymentToken %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The result of our own card tokenization. Activated in POS for the merchant or merchant group.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f externalNonPaymentToken %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc.
            For Mass Transit merchants, transactions redeemed by Visa will be populated with PAR. For Mastercard and Amex, it will be our own token.
          </div>
        </div>
      </details>

      <!-- transaction (LEVEL 1) + LEVEL 2 children -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f transaction %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/transaction.md %}</div></div>

        <div class="api-children">
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f id, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/id.md resource="transaction" %}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f created, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date and time of when the transaction was created.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f updated, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date and time of when the transaction was updated.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f type, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the transaction type.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f state, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>Initialized</code>, <code>Completed</code> or <code>Failed</code>. Indicates the state of the transaction.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f number, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/number.md %}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f amount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                Amount is entered in the lowest monetary unit of the selected currency.
                E.g. <code>10000</code> = 100.00 NOK, <code>5000</code> = 50.00 SEK.
              </div>
            </div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f vatAmount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                If the amount given includes VAT, this may be displayed for the user on the payment page (redirect only).
                Set to <code>0</code> (zero) if this is not relevant.
              </div>
            </div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f description, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/description.md %}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f payeeReference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/payee-reference.md %}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f failedReason, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable explanation of why the payment failed.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f isOperational, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>true</code> if the transaction is operational; otherwise <code>false</code>.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f operations, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>array</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/operations.md resource="transaction" %}</div></div>
          </details>
        </div>
      </details>

    </div>
  </details>
</div>
