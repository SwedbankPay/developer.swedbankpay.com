## Purchase

An example request and response of a gift card purchase.

## Request

{:.code-view-header}
**Request**

```http
POST /api/payments/payment-account/{paymentAccountId}/payment/purchase HTTP/1.1
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
    "products": [
        {
            "amount": 1337,
            "description": "1x banana",
            "productId": "001",
            "quantity": 13.37,
            "unitOfMeasure": "L",
            "vatAmount": 337,
            "vatRate": 25
        }
    ],
    "repeat": true,
    "stan": 123456
}
```

<div class="api-compact" role="table" aria-label="Request">
  <div class="header" role="row">
    <div role="columnheader">Field</div>
    <div role="columnheader">Type</div>
    <div role="columnheader">Required</div>
  </div>

  <!-- Level 0 (all nodes CLOSED by default; original order retained) -->

  <!-- accountIdentifier (object, REQUIRED) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f accountIdentifier, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0"></div></div>

    <div class="api-children">
      <!-- Level 1 children of accountIdentifier -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f accountId %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Swedbank Pay internal id for card/account.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f accountKey %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Primary Account Number (PAN) for card/account. This is mandatory if ‘track2’ is not present.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f cvc %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Card Verification Code.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f encryptedPin %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">If ‘000’ is set on authorization request, encrypted PIN block will be returned here.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f expiryDate %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Expiry date on card (only applicable for PaymentInstrumentType ‘creditcard’) where expiry date is printed on card. Format MM/YY</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f securityCode %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Card Security Code.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f track2 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Track 2 excluding start and end sentinel.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f additionalData %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Optional additional data stored on transaction.</div></div>
      </details>
    </div>
  </details>

  <!-- amount (REQUIRED) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f amount, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>integer</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">Total amount of Payment (in cents), ie. 100Kr -> 10000.</div></div>
  </details>

  <!-- currency (REQUIRED) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f currency, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>string</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">Currency for Payment.</div></div>
  </details>

  <!-- description -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f description, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>string</code></span>
      <span class="req"></span>
    </summary>
    <div class="desc"><div class="indent-0">Payment description.</div></div>
  </details>

  <!-- merchant (object, REQUIRED) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f merchant, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0"></div></div>

    <div class="api-children">
      <!-- merchantName (REQUIRED) -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f merchantName %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Name of merchant where payment was performed</div></div>
      </details>

      <!-- terminalId -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f terminalId %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Used to identify terminal.</div></div>
      </details>
    </div>
  </details>

  <!-- paymentOrderRef (REQUIRED) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f paymentOrderRef, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>string</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">Unique ID to bind 2-phase transactions.</div></div>
  </details>

  <!-- paymentTransactionRef (REQUIRED) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f paymentTransactionRef, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>string</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">Unique ID for each payment.</div></div>
  </details>

  <!-- products (array, OPTIONAL) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f products, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>array</code></span>
      <span class="req"></span>
    </summary>
    <div class="desc"><div class="indent-0"></div></div>

    <div class="api-children">
      <!-- Level 1 children of products -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f amount %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Monetary value of purchased product (in cents).</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f description %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Optional product description.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f productId %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">A product identifier provided by Swedbank Pay.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f quantity %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>number</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Number of product units sold (both integer and decimal numbers supported).</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f unitOfMeasure %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Type of measurement, L=Liter, U=Unit, G=Grams. This may refer to the number of packs, number of bottles etc., O=present (denotes no measurement). Enum: [L, U, G, O].</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f vatAmount %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Monetary value of vat-amount for purchased product (in cents).</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f vatRate %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>number</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Vat-rate for purchased product (both integer and decimal numbers supported).</div></div>
      </details>
    </div>
  </details>

  <!-- repeat -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f repeat, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>boolean</code></span>
      <span class="req"></span>
    </summary>
    <div class="desc"><div class="indent-0">Notifies this is a repeat message.</div></div>
  </details>

  <!-- stan -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f stan, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>string</code></span>
      <span class="req"></span>
    </summary>
    <div class="desc"><div class="indent-0">Systems trace audit number.</div></div>
  </details>
</div>

## Response

{:.code-view-header}
**Response**

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
    "created": "2020-05-11T08:20:13.829Z",
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
    "transmissionTime": "2020-05-11T08:20:13.829Z",
    "updated": "2020-05-11T08:20:13.829Z"
}
```

{:.table .table-striped}
| Field   | Type   | Description                                                              |
| :------ | :----- | :----------------------------------------------------------------------- |
| `state` | `enum` | `OK`, `FAILED`, `REVERSED` or `DUPLICATE`. The state of the transaction. |
