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

<div class="api-compact" aria-label="Authorization Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- LEVEL 0: transaction -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field"><code>transaction</code><i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The transaction object.</div></div>

    <!-- LEVEL 1: children of transaction -->
    <div class="api-children">

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cardNumber %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">Primary Account Number (PAN) of the card, printed on the face of the card.</div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cardExpiryMonth %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">Expiry month of the card, printed on the face of the card.</div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cardExpiryYear %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">Expiry year of the card, printed on the face of the card.</div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cardVerificationCode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc">
          <div class="indent-1">Card verification code (CVC/CVV/CVC2), usually printed on the back of the card.</div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cardholderName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
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

<div class="api-compact" aria-label="Authorization Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- LEVEL 0: payment -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment object.</div></div>
  </details>

  <!-- LEVEL 0: authorization -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f authorization, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The authorization object.</div></div>

    <!-- LEVEL 1: children of authorization -->
    <div class="api-children">

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f direct %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The type of the authorization.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cardBrand %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Visa</code>, <code>MC</code>, etc. The brand of the card.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cardType %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Credit Card</code> or <code>Debit Card</code>. Indicates the type of card used for the authorization.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f issuingBank %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The name of the bank that issued the card used for the authorization.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paymentToken %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The payment token created for the card used in the authorization.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f maskedPan %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The masked PAN number of the card.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f expiryDate %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The month and year of when the card expires.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f panToken %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The token representing the specific PAN of the card.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f panEnrolled %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"></div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f acquirerTransactionTime %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a>{:target="_blank"} date and time of the acquirer transaction.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/id.md resource="itemDescriptions" %}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f nonPaymentToken %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The result of our own card tokenization. Activated in POS for the merchant or merchant group.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f externalNonPaymentToken %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
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
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f transaction %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/transaction.md %}</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/id.md resource="transaction" %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f created, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>date(string)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a>{:target="_blank"} date and time when the transaction was created.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f updated, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>date(string)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a>{:target="_blank"} date and time when the transaction was updated.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the transaction type.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f state, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>Initialized</code>, <code>Completed</code> or <code>Failed</code>. Indicates the state of the transaction.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/number.md %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                Amount is entered in the lowest monetary unit of the selected currency.
                E.g. <code>10000</code> = 100.00 NOK, <code>5000</code> = 50.00 SEK.
              </div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                If the amount given includes VAT, this may be displayed for the user on the payment page (redirect only).
                Set to <code>0</code> (zero) if this is not relevant.
              </div>
            </div>
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
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/payee-reference.md %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f failedReason, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable explanation of why the payment failed.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f isOperational, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>true</code> if the transaction is operational; otherwise <code>false</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f operations, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>array</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/operations.md resource="transaction" %}</div></div>
          </details>
        </div>
      </details>

    </div>
  </details>
</div>
