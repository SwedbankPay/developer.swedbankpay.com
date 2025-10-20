## Authentication

An example request and response of a gift card authentication.

## Request

{:.code-view-header}
**Request**

```http
POST /api/payments/payment-account/{paymentAccountId}/payment/authorize HTTP/1.1
Authorization: Bearer <AccessToken>
Hmac: HMAC authentication filter
Content-Type: application/json

{
    "accountIdentifier": {
        "accountId": 123456789,
        "accountKey": 7013360000000001000,
        "cvc": 123,
        "encryptedPin": "000",
        "expiryDate": "12/20",
        "securityCode": 123,
        "track2": "7013360000000000000=2012125123"
    },
    "additionalData": "string",
    "amount": 10000,
    "currency": "NOK",
    "description": "string",
    "merchant": {
        "merchantName": "Test Merchant 101",
        "terminalId": 12345
    },
    "paymentOrderRef": "UUID",
    "paymentTransactionRef": "UUID",
    "repeat": true,
    "stan": 123456
}
```

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- Level 0 (all nodes CLOSED by default; original order retained) -->
  <!-- accountIdentifier (object, REQUIRED) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f accountIdentifier, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0"></div></div>

    <div class="api-children">
      <!-- Level 1 children of accountIdentifier -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f accountId %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Swedbank Pay internal id for card/account.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f accountKey %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Primary Account Number (PAN) for card/account. This is mandatory if ‘track2’ is not present.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cvc %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Card Verification Code.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f encryptedPin %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">If ‘000’ is set on authorization request, encrypted PIN block will be returned here.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f expiryDate %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Expiry date on card (only applicable for PaymentInstrumentType ‘creditcard’) where expiry date is printed on card. Format MM/YY</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f securityCode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Card Security Code.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f track2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Track 2 excluding start and end sentinel.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f additionalData %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Optional additional data stored on transaction.</div></div>
      </details>
    </div>
  </details>

  <!-- amount (REQUIRED) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f amount, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>integer</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">Total amount of Payment (in cents), ie. 100Kr -> 10000.</div></div>
  </details>

  <!-- currency (REQUIRED) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f currency, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">Currency for Payment.</div></div>
  </details>

  <!-- description -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f description, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
      <span class="req"></span>
    </summary>
    <div class="desc"><div class="indent-0">Payment description.</div></div>
  </details>

  <!-- merchant (object, REQUIRED) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f merchant, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0"></div></div>

    <div class="api-children">
      <!-- merchantName (REQUIRED) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f merchantName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Name of merchant where payment was performed</div></div>
      </details>

      <!-- terminalId -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f terminalId %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Used to identify terminal.</div></div>
      </details>
    </div>
  </details>

  <!-- paymentOrderRef (REQUIRED) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrderRef, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">Unique ID to bind 2-phase transactions.</div></div>
  </details>

  <!-- paymentTransactionRef (REQUIRED) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentTransactionRef, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">Unique ID for each payment.</div></div>
  </details>

  <!-- repeat -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f repeat, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>boolean</code></span>
      <span class="req"></span>
    </summary>
    <div class="desc"><div class="indent-0">Notifies this is a repeat message.</div></div>
  </details>

  <!-- stan -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f stan, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
      <span class="req"></span>
    </summary>
    <div class="desc"><div class="indent-0">Systems trace audit number.</div></div>
  </details>
</div>

## Response

{:.code-view-header}
**Response:**

```json
{
    "_links": [
        {
            "deprecation": "string",
            "href": "string",
            "hreflang": "string",
            "media": "string",
            "rel": "string",
            "templated": true,
            "title": "string",
            "type": "string"
        }
    ],
    "accountIdentifier": {
        "accountId": 123456789,
        "accountKey": 7013360000000001000,
        "cvc": 123,
        "encryptedPin": "000",
        "expiryDate": "12/20",
        "securityCode": 123,
        "track2": "7013360000000000000=2012125123"
    },
    "allowedProductIds": [
        "string"
    ],
    "amount": 0,
    "created": "2020-05-12T07:02:36.719Z",
    "currency": "string",
    "description": "string",
    "issuer": {
        "acquirerId": "string",
        "acquirerName": "string",
        "issuerId": "string",
        "issuerName": "string",
        "settlementProvided": true
    },
    "merchant": {
        "merchantName": "Test Merchant 101",
        "terminalId": 12345
    },
    "operation": "string",
    "paymentId": "string",
    "paymentOrderRef": "string",
    "paymentTransactionRef": "string",
    "remainingCancelAmount": 0,
    "remainingCaptureAmount": 0,
    "remainingReversalAmount": 0,
    "state": "OK",
    "transmissionTime": "2020-05-12T07:02:36.719Z",
    "updated": "2020-05-12T07:02:36.719Z"
}
```

{:.table .table-striped}
| Field   | Type   | Description                                                              |
| :------ | :----- | :----------------------------------------------------------------------- |
| `state` | `enum` | `OK`, `FAILED`, `REVERSED` or `DUPLICATE`. The state of the transaction. |
