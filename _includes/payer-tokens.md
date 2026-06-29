
## Mapping payerOwnedTokens vs. Payer API

**What is `payerOwnedTokens`?**

`payerOwnedTokens` was a `PaymentOrder` API endpoint (v2.0/v3.0/v3.1) used to
retrieve and update tokens asssociated to a specific `payerReference`. This
endpoint will be removed in v3.2 and replaced by the Payer API.

**What is Payer API?**

Payer API is the new, authoritative service used to retrieve, update and manage tokens for a payer.

{:.table .table-striped}

| Old (`PaymentOrder` API)    | New (Payer API)  | Description    |
| :------ | :------ | :------ |
| `GET /payerOwnedtokens/<payerReference>`      | `GET /online/payers/<payerReference>`    | Retrieves active tokens for a payer          |
| `PATCH /payerOwnedtokens/<payerReference>`    | `PATCH /online/payers/<payerReference>/archives`  | Archives all tokens for a payer         |
| `GET /paymenttokens/<token>`            | `GET /online/payers/tokens/<token-tokenType>`    | Retrieves a single token                        |
| `PATCH /paymenttokens/<token>`          | `PATCH /online/payers/tokens/<token>-<tokenType>/archives`  | Archives or updates token             |
|         | `PATCH /online/payers/tokens/<token>-<tokenType>/displaynames` | New API witch updates the token's display name           |

### Code Examples

Examples of old versus new API requests. Full request and response examples
below.

#### GET All Payer Tokens

{% capture request_header %}GET /psp/paymentorders/payerownedtokens/<payerReference> HTTP/1.1
Host: api.externalintegration.swedbankpay.com
Authorization: Bearer <token>{% endcapture %}

{% include code-example.html
    title='Old (PaymentOrder API) GET All Tokens Request'
    header=request_header
    %}

{% capture request_header %}GET /online/payers/<payerReference> HTTP/1.1
Host: api.externalintegration.swedbankpay.com
Authorization: Bearer <token>{% endcapture %}

{% include code-example.html
    title='New (Payer API) GET All Tokens Request'
    header=request_header
    %}

#### Archive All Tokens

{% capture request_header %}PATCH /psp/paymentorders/payerownedtokens/<payerReference> HTTP/1.1
Host: api.externalintegration.swedbankpay.com
Authorization: Bearer <token>{% endcapture %}

{% include code-example.html
    title='Old (PaymentOrder API) Archive All Tokens Request'
    header=request_header
    %}

{% capture request_header %}PATCH /online/payers/<payerReference>/archives HTTP/1.1
Host: api.externalintegration.swedbankpay.com
Authorization: Bearer <token>{% endcapture %}

{% include code-example.html
    title='New (Payer API) Archive All Tokens Request'
    header=request_header
    %}

#### GET Single Token

{% capture request_header %}GET /psp/paymentorders/paymenttokens/<token> HTTP/1.1
Host: api.externalintegration.swedbankpay.com
Authorization: Bearer <token>{% endcapture %}

{% include code-example.html
    title='Old (PaymentOrder API) GET Single Token Request'
    header=request_header
    %}

{% capture request_header %}GET /online/payers/tokens/<token>-<tokenType> HTTP/1.1
Host: api.externalintegration.swedbankpay.com
Authorization: Bearer <token>{% endcapture %}

{% include code-example.html
    title='New (Payer API) GET Single Token Request'
    header=request_header
    %}

### Important Differences

*   Payer API gives you a more structured and long-term token handling.

*   All new integrations must use the Payer API, not `payerOwnedTokens`.

*   Token types and status (Active/Archived) are the same, but the Payer API has
more detailed fields and better support for the token lifecycle.

## New (Payer) APIs

All Payer APIs with requests and responses.

## GET Single Payer Token

A GET request used when you need to retrieve a single token.

### GET Single Payer Token Request

{% capture request_header %}GET /online/payers/tokens/<token>-<tokenType> HTTP/1.1
Host: api.externalintegration.swedbankpay.com
Authorization: Bearer <AccessToken>{% endcapture %}

{% include code-example.html
    title='GET Single Payer Token Request'
    header=request_header
    %}

### GET Single Payer Token Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "id": "/online/payers/tokens/<token>-<tokenType>",
    "payerReference": "<payerReference>",
    "migratedFromConsumerProfile": false,
    "token": {
        "operations": [
            {
                "href": "https://api.externalintegration.swedbankpay.com/online/payers/tokens/<token>-<tokenType>",
                "rel": "get-token",
                "method": "GET",
                "contentType": "application/json"
            }
        ],
        "id": "/online/payers/tokens/<token>-<tokenType>",
        "payerReference": "<payerReference>",
        "token": "<token>",
        "tokenType": "Payment",
        "instrument": "Trustly",
        "displayName": "*****232",
        "correlationId": "895e495f71a0b8e9f8085024f2947704a18ada29bc7ef78b59302c414fb6c190c295c088bd1a8707db5f507dd0e8349405414eee393f98538e00b1f7360f0d52",
        "state": "Archived",
        "archivedBy": "PAYEE",
        "archiveReason": "string",
        "networkTokenized": false,
        "instrumentParameters": {
            "maskedAccountNumber": "*****232",
            "accountId": "6224691047"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='GET Single Payer Token Response'
    header=response_header
    json= response_content
    %}

{% capture id_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" aria-label="GET Single Payer Token Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>
  <!-- LEVEL 0: id -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f id, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>string</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">The token ID.</div>
  </div>
</details>

  <!-- LEVEL 0: payerReference -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f payerReference, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>object</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">The reference used to recognize the payer in the absence of SSN and/or a secure login.</div>
  </div>
</details>

    <!-- LEVEL 0: migratedFromConsumerProfile -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f migratedFromConsumerProfile, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>bool</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0"><code>True</code> or <code>false</code>, indicates if the token was migrated from a consumer profile or not.</div>
  </div>
</details>

<!-- LEVEL 0: token -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f token, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>object</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">The token object.</div>
  </div>

  <!-- LEVEL 1: children of token -->
  <div class="api-children">

      <details class="api-item" data-level="1">
  <summary>
    <span class="field">{% f operations %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>array</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">{{ operations_md | markdownify }}</div>
  </div>
</details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">The token ID.</div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f payerReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The reference used to recognize the payer in the absence of SSN and/or a secure login.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f token %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">The token <code>guid</code>.</div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f tokenType %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The available token types: <code>Payment</code>, <code>Recurrence</code>,
        <code>TransactionOnFile</code> or <code>Unscheduled</code>.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f instrument %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        Available payment methods which support tokens: <code>CreditCard</code> or <code>Trustly</code>.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f instrumentDisplayName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The displayed payment method name. Either a custom value or the default instrument name.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f correlationsId %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        A unique ID (guid) used in the system. Makes it easier to trace cards, accounts etc. connected to the token.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f state %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The state of the token. Can either be <code>Active</code> or <code>Archived</code>.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f archivedBy %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        Present if the token state is <code>Archived</code> and indicates who archived it.
        Can either be <code>PAYEE</code>, <code>SWEDBANK_PAY</code> or <code>TOKEN_ISSUER</code>.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f archiveReason %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
       Present if the token state is <code>Archived</code> and indicates the reason why the token was archived.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f instrumentParameters %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>object</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        A list of additional information connected to the token. The content may differ depending on the payment method.
      </div></div>
    </details>

<!-- LEVEL 0: operations -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>array</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">{{ operations_md | markdownify }}</div>
  </div>
</details>
</div>
</details>
</div>
{% capture response_content %}{
   "token": {
      "instrumentParameters": {
         "cardBrand": "Visa",
         "expiryDate" : "12/2028",
         "expiryPan": "12/2028",
         "issuerName": "Name of issuer if present",
         "lastFourPan": "0004",
         "bin": "492500",
         "cardHolderType": "Consumer",
         "cardType": "Debit",
         "countryCode": "752",
         "lastFourDPan": "1234",
         "expiryDPan": "02/2029"
      }
   }
}{% endcapture %}

{% include code-example.html
    title='Instrument Parameters - CreditCard'
    header=response_header
    json= response_content
    %}

{% capture id_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" aria-label="Instrument Parameters - CreditCard">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>
<!-- LEVEL 0: token -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f token, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>object</code></span>
  </summary>

  <div class="desc">
    <div class="indent-0">The token object.</div>
  </div>

  <!-- LEVEL 1: children of token -->
  <div class="api-children">

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f instrumentParameters %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>object</code></span>
      </summary>

      <div class="desc">
        <div class="indent-1">
          A list of additional information connected to the token.
        </div>
      </div>

      <!-- LEVEL 2: fields inside instrumentParameters object -->
      <div class="api-children">

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f cardBrand %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc">
            <div class="indent-2"><code>Visa</code>, <code>MC</code>, etc. The brand of the card.</div>
          </div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f expiryDate %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc">
            <div class="indent-2">The month and year when the card expires.</div>
          </div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f expiryPan %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc">
            <div class="indent-2">Expiry date of the card's PAN.</div>
          </div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f issuerName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc">
            <div class="indent-2">Expiry date of the card's PAN.</div>
          </div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f lastFourPan %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc">
            <div class="indent-2">The last four digits of the card's PAN.</div>
          </div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f bin %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc">
            <div class="indent-2">The first six digits of the card's PAN.</div>
          </div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f cardHolderType %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc">
            <div class="indent-2">Indicates if the card holder is <code>Corporate</code> or a <code>Consumer</code>.</div>
          </div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f cardType %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc">
            <div class="indent-2">Indicates if the card is a <code>Debit</code> or <code>Credit</code> card.</div>
          </div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f countryCode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc">
            <div class="indent-2">Expiry date of the card's PAN.</div>
          </div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f lastFourDPan %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc">
            <div class="indent-2">The last four digits of the card's DPAN (network token).</div>
          </div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f expiryDPan %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc">
            <div class="indent-2">The expiry of the card's DPAN (network token).</div>
          </div>
        </details>

      </div>
    </details>

  </div>
</details>
</div>

### Instrument Parameters - Trustly

{% capture response_content %}{
   "token": {
      "instrumentParameters": {
         "accountId": "156",
         "maskedAccountNumber": "***5678"
      },
   }
}{% endcapture %}

{% include code-example.html
    title='Instrument Parameters - Trustly'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Instrument Parameters - Trustly">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>
<!-- LEVEL 0: token -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f token, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>object</code></span>
  </summary>

  <div class="desc">
    <div class="indent-0">The token object.</div>
  </div>

  <!-- LEVEL 1: children of token -->
  <div class="api-children">

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f instrumentParameters %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>object</code></span>
      </summary>

      <div class="desc">
        <div class="indent-1">
          A list of additional information connected to the token.
        </div>
      </div>

      <!-- LEVEL 2: fields inside instrumentParameters object -->
      <div class="api-children">

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f accountId %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc">
            <div class="indent-2">Account identifier provided by Trustly.</div>
          </div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f maskedAccountNumber %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc">
            <div class="indent-2">The payer's masked bank account number.</div>
          </div>
        </details>

      </div>
    </details>

  </div>
</details>
</div>

## GET All Payer Tokens

A GET request used to retrieve all payer tokens linked to a payee using the
payer's `payerReference`.

### GET All Payer Tokens Request

{% capture request_header %}GET /online/payers/<payerReference> HTTP/1.1
Host: api.externalintegration.swedbankpay.com
Authorization: Bearer <AccessToken>{% endcapture %}

{% include code-example.html
    title='GET All Payer Tokens Request'
    header=request_header
    %}

### Get All Payer Tokens Response

{% capture response_content %}{
    "tokens": {
        "id": "/online/payers/<payerReference>",
        "payerReference": "<payerReference>",
        "migratedFromConsumerProfile": false,
        "tokenList": [
            {
                "operations": [
                    {
                        "href": "https://api.externalintegration.swedbankpay.com/online/payers/tokens/<token>-<tokenType>",
                        "rel": "get-token",
                        "method": "GET",
                        "contentType": "application/json"
                    },
                    {
                        "href": "https://api.externalintegration.swedbankpay.com/online/payers/tokens/<token>-<tokenType>/archives",
                        "rel": "archive-token",
                        "method": "PATCH",
                        "contentType": "application/json"
                    },
                    {
                        "href": "https://api.externalintegration.swedbankpay.com/online/payers/tokens/<token>-<tokenType>/displaynames",
                        "rel": "update-displayname",
                        "method": "PATCH",
                        "contentType": "application/json"
                    }
                ],
                "id": "/online/payers/tokens/<token>-<tokenType>e",
                "payerReference": "<payerReference>",
                "token": "<token>",
                "tokenType": "Recurrence",
                "instrument": "CreditCard",
                "displayName": "0416",
                "correlationId": "8e7752b2-016f-4b9f-ac39-2844907d8f9c",
                "state": "Active",
                "networkTokenized": false,
                "instrumentParameters": {
                    "cardBrand": "Visa",
                    "expiryPan": "12/2055",
                    "issuerName": "Utl. Visa",
                    "bin": "476173",
                    "cardholderType": "Unknown",
                    "cardType": "Credit",
                    "countryCode": "999",
                    "lastFourPan": "0416"
                }
            }
        ]
    },
    "operations": [
        {
            "href": "https://api.externalintegration.swedbankpay.com/online/payers/<payerReference>",
            "rel": "get-payer-tokens",
            "method": "GET",
            "contentType": "application/json"
        },
        {
            "href": "https://api.externalintegration.swedbankpay.com/online/payers/<payerReference>/archives",
            "rel": "archive-payer-tokens",
            "method": "PATCH",
            "contentType": "application/json"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='GET All Payer Tokens Response'
    header=response_header
    json= response_content
    %}

{% capture id_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" aria-label="GET All Payer Tokens Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>
<!-- LEVEL 0: tokens -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f tokens, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>object</code></span>
  </summary>

  <div class="desc">
    <div class="indent-0">The token object.</div>
  </div>

  <!-- LEVEL 1: children of tokens -->
  <div class="api-children">

<details class="api-item" data-level="1">
  <summary>
    <span class="field">{% f operations %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>array</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">{{ operations_md | markdownify }}</div>
  </div>
</details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc">
        <div class="indent-1">{{ id_md | markdownify }}</div>
      </div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f payerReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc">
        <div class="indent-1">
          The reference used to recognize the payer in the absence of SSN and/or a secure login.
        </div>
      </div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f migratedFromConsumerProfile %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>bool</code></span>
      </summary>
      <div class="desc">
        <div class="indent-1">
          Indicates if the token was migrated from Swedbank Pay's old consumer profile solution.
          Set to <code>true</code> or <code>false</code>.
        </div>
      </div>
    </details>

    <!-- LEVEL 1: tokenlist array -->
    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f tokenlist %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>array</code></span>
      </summary>
      <div class="desc">
        <div class="indent-1">The array of token objects.</div>
      </div>

      <!-- LEVEL 2: fields inside each tokenlist item -->
      <div class="api-children">

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">The token ID.</div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f payerReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The reference used to recognize the payer in the absence of SSN and/or a secure login.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f token %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">The token <code>guid</code>.</div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f tokenType %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The available token types:
            <code>Payment</code>, <code>Recurrence</code>,
            <code>TransactionOnFile</code> or <code>Unscheduled</code>.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f instrument %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            Available payment methods which support tokens:
            <code>CreditCard</code> or <code>Trustly</code>.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f instrumentDisplayName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The displayed payment method name.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f correlationsId %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            A unique ID (guid) used in the system.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f state %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The state of the token. Can either be
            <code>Active</code> or <code>Archived</code>.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f archivedBy %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            Present if the token state is <code>Archived</code> and indicates who archived it:
            <code>PAYEE</code>, <code>SWEDBANK_PAY</code> or <code>TOKEN_ISSUER</code>.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f archiveReason %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The reason why the token was archived.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f instrumentParameters %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>object</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            A list of additional information connected to the token.
          </div></div>
        </details>

      </div>
    </details>

  </div>
</details>

<!-- LEVEL 0: operations -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>array</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">{{ operations_md | markdownify }}</div>
  </div>
</details>
</div>

## GET Archived Payer Tokens

A GET request used to retrieve all archived tokens by a payee using the payer's
`payerReference`.

### GET Archived Payer Tokens Request

{% capture request_header %}GET /online/payers/<payerReference>/archives HTTP/1.1
Host: api.externalintegration.swedbankpay.com
Authorization: Bearer <AccessToken>{% endcapture %}

{% include code-example.html
    title='GET Archived Tokens Request'
    header=request_header
    %}

### GET Archived Payer Tokens Response

{% capture response_content %}{
    "tokens": {
        "id": "/<payerReference>/archives",
        "payerReference": "<payerReference>",
        "migratedFromConsumerProfile": false,
        "tokenList": [
            {
                "operations": [
                    {
                        "href": "https://api.externalintegration.swedbankpay.com/online/payers/tokens/<token>-<tokenType>",
                        "rel": "get-token",
                        "method": "GET",
                        "contentType": "application/json"
                    }
                ],
                "id": "/online/payers/tokens/<token>-<tokenType>",
                "payerReference": "<payerReference>",
                "token": "<token>",
                "tokenType": "Payment",
                "instrument": "CreditCard",
                "displayName": "updated name",
                "correlationId": "8e7752b2-016f-4b9f-ac39-2844907d8f9c",
                "state": "Archived",
                "archivedBy": "PAYEE",
                "archiveReason": "string",
                "networkTokenized": false,
                "instrumentParameters": {
                    "cardBrand": "Visa",
                    "expiryPan": "12/2055",
                    "issuerName": "Utl. Visa",
                    "bin": "476173",
                    "cardholderType": "Unknown",
                    "cardType": "Credit",
                    "countryCode": "999",
                    "lastFourPan": "0416"
                }
            }
        ]
    },
    "operations": [
        {
            "href": "https://api.externalintegration.swedbankpay.com/online/payers/<payerReference>/archives",
            "rel": "get-archived-payer-tokens",
            "method": "GET",
            "contentType": "application/json"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='GET Archived Payer Tokens Response'
    header=response_header
    json= response_content
    %}

{% capture id_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" aria-label="GET Archived Payer Tokens Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>
<!-- LEVEL 0: tokens -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f tokens, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>object</code></span>
  </summary>

  <div class="desc">
    <div class="indent-0">The token object.</div>
  </div>

  <!-- LEVEL 1: children of tokens -->
  <div class="api-children">

  <details class="api-item" data-level="1">
  <summary>
    <span class="field">{% f operations %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>array</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">{{ operations_md | markdownify }}</div>
  </div>
</details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc">
        <div class="indent-1">{{ id_md | markdownify }}</div>
      </div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f payerReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc">
        <div class="indent-1">
          The reference used to recognize the payer in the absence of SSN and/or a secure login.
        </div>
      </div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f migratedFromConsumerProfile %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>bool</code></span>
      </summary>
      <div class="desc">
        <div class="indent-1">
          Indicates if the token was migrated from Swedbank Pay's old consumer profile solution.
          Set to <code>true</code> or <code>false</code>.
        </div>
      </div>
    </details>

    <!-- LEVEL 1: tokenlist array -->
    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f tokenlist %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>array</code></span>
      </summary>

      <div class="desc">
        <div class="indent-1">The array of token objects.</div>
      </div>

      <!-- LEVEL 2: fields inside each tokenlist item -->
      <div class="api-children">

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">The token ID.</div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f payerReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The reference used to recognize the payer in the absence of SSN and/or a secure login.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f token %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">The token <code>guid</code>.</div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f tokenType %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The available token types:
            <code>Payment</code>, <code>Recurrence</code>,
            <code>TransactionOnFile</code> or <code>Unscheduled</code>.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f instrument %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            Available payment methods which support tokens:
            <code>CreditCard</code> or <code>Trustly</code>.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f instrumentDisplayName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The displayed payment method name.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f correlationsId %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            A unique ID (guid) used in the system.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f state %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The state of the token. Can either be
            <code>Active</code> or <code>Archived</code>.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f archivedBy %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            Present if the token state is <code>Archived</code> and indicates who archived it:
            <code>PAYEE</code>, <code>SWEDBANK_PAY</code> or <code>TOKEN_ISSUER</code>.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f archiveReason %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The reason why the token was archived.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f instrumentParameters %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>object</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            A list of additional information connected to the token.
            The content may differ depending on the payment method.
          </div></div>
        </details>

      </div>
    </details>

  </div>
</details>

<!-- LEVEL 0: operations -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>array</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">{{ operations_md | markdownify }}</div>
  </div>
</details>
</div>

## PATCH Update Display Name

A PATCH request used to update a payer token's display name.

### PATCH Update Display Name Request

{% capture request_header %}PATCH /online/payers/tokens/<token>-<tokenType>/displaynames HTTP/1.1
Host: api.externalintegration.swedbankpay.com
Authorization: Bearer <AccessToken>{% endcapture %}

{% capture request_content %}{
"displayName" : "New display name"
}{% endcapture %}

{% include code-example.html
    title='PATCH Update Display Name Request'
    header=request_header
    json= request_content
    %}

<div class="api-compact" aria-label="PATCH Update Display Name Request">

  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- LEVEL 0 -->
      <details class="api-item" data-level="0">
        <summary>
          <span class="field">{% f displayName, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-0">The new display name.</div></div>
      </details>

  </div>

### PATCH Update Display Name Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "id": "/tokens/bc898d02-2423-4e02-822c-8dfb136f2ca6-OneClick/displaynames",
    "payerReference": "<payerReference>",
    "migratedFromConsumerProfile": false,
    "token": {
        "operations": [
            {
                "href": "https://api.externalintegration.swedbankpay.com/online/payers/tokens/<token>-<tokenType>",
                "rel": "get-token",
                "method": "GET",
                "contentType": "application/json"
            },
            {
                "href": "https://api.externalintegration.swedbankpay.com/online/payers/tokens/<token>-<tokenType>/archives",
                "rel": "archive-token",
                "method": "PATCH",
                "contentType": "application/json"
            },
            {
                "href": "https://api.externalintegration.swedbankpay.com/online/payers/tokens/<token>-<tokenType>/displaynames",
                "rel": "update-displayname",
                "method": "PATCH",
                "contentType": "application/json"
            }
        ],
        "id": "/online/payers/tokens/<token>-<tokenType>",
        "payerReference": "<payerReference>",
        "token": "<token>",
        "tokenType": "Payment",
        "instrument": "CreditCard",
        "displayName": "New display name",
        "correlationId": "8e7752b2-016f-4b9f-ac39-2844907d8f9c",
        "state": "Active",
        "networkTokenized": false,
        "instrumentParameters": {
            "cardBrand": "Visa",
            "expiryPan": "12/2055",
            "issuerName": "Utl. Visa",
            "bin": "476173",
            "cardholderType": "Unknown",
            "cardType": "Credit",
            "countryCode": "999",
            "lastFourPan": "0416"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='PATCH Update Display Name Response'
    header=response_header
    json= response_content
    %}

{% capture id_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" aria-label="PATCH Update Display Name Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>
  <!-- LEVEL 0: id -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f id, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>object</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">The token ID.</div>
  </div>
</details>

  <!-- LEVEL 0: payerReference -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f payerReference, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>object</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">The reference used to recognize the payer in the absence of SSN and/or a secure login..</div>
  </div>
</details>

    <!-- LEVEL 0: migratedFromConsumerProfile -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f migratedFromConsumerProfile, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>bool</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0"><code>True</code> or <code>false</code>, indicating if the token was migrated from a consumer profile or not.</div>
  </div>
</details>

<!-- LEVEL 0: token -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f token, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>object</code></span>
  </summary>

  <div class="desc">
    <div class="indent-0">The token object.</div>
  </div>

  <!-- LEVEL 1: children of token -->
  <div class="api-children">

<details class="api-item" data-level="1">
  <summary>
    <span class="field">{% f operations %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>array</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">{{ operations_md | markdownify }}</div>
  </div>
</details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">The token ID.</div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f payerReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The reference used to recognize the payer in the absence of SSN and/or a secure login.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f token %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">The token <code>guid</code>.</div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f tokenType %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The available token types:
        <code>Payment</code>, <code>Recurrence</code>,
        <code>TransactionOnFile</code> or <code>Unscheduled</code>.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f instrument %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        Available payment methods which support tokens:
        <code>CreditCard</code> or <code>Trustly</code>.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f instrumentDisplayName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The displayed payment method name. Either a custom value or the default instrument name.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f correlationsId %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        A unique ID (guid) used in the system.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f state %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The state of the token. Can either be <code>Active</code> or <code>Archived</code>.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f archivedBy %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        Present if the token state is <code>Archived</code> and indicates who archived it:
        <code>PAYEE</code>, <code>SWEDBANK_PAY</code> or <code>TOKEN_ISSUER</code>.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f archiveReason %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The reason why the token was archived.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f instrumentParameters %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>object</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        A list of additional information connected to the token.
        The content may differ depending on the payment method.
      </div></div>
    </details>

  </div>
</details>

<!-- LEVEL 0: operations -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>array</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">{{ operations_md | markdownify }}</div>
  </div>
</details>
</div>

## PATCH Archive Single Payer Token

A PATCH request used to archive a single, specific payer token.

### PATCH Archive Single Payer Token Request

{% capture request_header %}PATCH /online/payers/tokens/<token>-<tokenType>/archives HTTP/1.1
Host: api.externalintegration.swedbankpay.com
Authorization: Bearer <AccessToken>{% endcapture %}

{% capture request_content %}{
  "reason" : "description",
  "updatedBy": "Payee"
}{% endcapture %}

{% include code-example.html
    title='PATCH Archive Single Payer Token Request'
    header=request_header
    json= request_content
    %}

  <div class="api-compact" aria-label="Payment Order Request">

  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- LEVEL 0 -->
      <details class="api-item" data-level="0">
        <summary>
          <span class="field">{% f reason, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-0">An explanation of why the token is being archived.</div></div>
      </details>

      <details class="api-item" data-level="0">
        <summary>
          <span class="field">{% f updatedBy, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-0">Indicates who archived the token: <code>PAYEE</code>, <code>CONSUMER</code>, <code>ONLINE</code> or <code>TOKENISSUER</code>.</div></div>
      </details>

  </div>

### PATCH Archive Single Payer Token Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "id": "/tokens/<token>-<tokenType>/archives",
    "payerReference": "<payerReference>",
    "migratedFromConsumerProfile": false,
    "token": {
        "operations": [
            {
                "href": "https://api.externalintegration.swedbankpay.com/online/payers/tokens/<token>-<tokenType>",
                "rel": "get-token",
                "method": "GET",
                "contentType": "application/json"
            }
        ],
        "id": "/online/payers/tokens/<token>-<tokenType>",
        "payerReference": "<payerReference>",
        "token": "<token>",
        "tokenType": "Payment",
        "instrument": "CreditCard",
        "displayName": "updated name",
        "correlationId": "8e7752b2-016f-4b9f-ac39-2844907d8f9c",
        "state": "Archived",
        "archivedBy": "PAYEE",
        "archiveReason": "string",
        "networkTokenized": false,
        "instrumentParameters": {
            "cardBrand": "Visa",
            "expiryPan": "12/2055",
            "issuerName": "Utl. Visa",
            "bin": "476173",
            "cardholderType": "Unknown",
            "cardType": "Credit",
            "countryCode": "999",
            "lastFourPan": "0416"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='PATCH Archive Single Payer Token Response'
    header=response_header
    json= response_content
    %}

{% capture id_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" aria-label="PATCH Archive Single Payer Token Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>
  <!-- LEVEL 0: id -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f token, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>object</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">The token object.</div>
  </div>
</details>

  <!-- LEVEL 0: payerReference -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f payerReference, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>object</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">The reference used to recognize the payer in the absence of SSN and/or a secure login..</div>
  </div>
</details>

    <!-- LEVEL 0: migratedFromConsumerProfile -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f migratedFromConsumerProfile, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>bool</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0"><code>True</code> or <code>false</code>, indicating if the token was migrated from a consumer profile or not.</div>
  </div>
</details>

<!-- LEVEL 0: token -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f token, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>object</code></span>
  </summary>

  <div class="desc">
    <div class="indent-0">The token object.</div>
  </div>

  <!-- LEVEL 1: children of token -->
  <div class="api-children">

<details class="api-item" data-level="1">
  <summary>
    <span class="field">{% f operations %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>array</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">{{ operations_md | markdownify }}</div>
  </div>
</details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">The token ID.</div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f payerReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The reference used to recognize the payer in the absence of SSN and/or a secure login.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f token %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The token <code>guid</code>.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f tokenType %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The available token types:
        <code>Payment</code>, <code>Recurrence</code>,
        <code>TransactionOnFile</code> or <code>Unscheduled</code>.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f instrument %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        Available payment methods which support tokens:
        <code>CreditCard</code> or <code>Trustly</code>.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f instrumentDisplayName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The displayed payment method name. Either a custom value or the default instrument name.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f correlationsId %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        A unique ID (guid) used in the system.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f state %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The state of the token. Can either be
        <code>Active</code> or <code>Archived</code>.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f archivedBy %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        Present if the token state is <code>Archived</code> and indicates who archived it:
        <code>PAYEE</code>, <code>SWEDBANK_PAY</code> or <code>TOKEN_ISSUER</code>.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f archiveReason %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        The reason why the token was archived.
      </div></div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f instrumentParameters %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>object</code></span>
      </summary>
      <div class="desc"><div class="indent-1">
        A list of additional information connected to the token.
        The content may differ depending on the payment method.
      </div></div>
    </details>

  </div>
</details>

<!-- LEVEL 0: operations -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>array</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">{{ operations_md | markdownify }}</div>
  </div>
</details>
</div>

## PATCH Archive All Payer Tokens

A PATCH request used to archive all tokens linked to a specific
`payerReference`.

### PATCH Archive All Payer Tokens Request

{% capture request_header %}PATCH /online/payers/<payerReference>/archives HTTP/1.1
Host: api.externalintegration.swedbankpay.com
Authorization: Bearer <AccessToken>{% endcapture %}

{% capture request_content %}{
  "reason" : "description",
  "updatedBy": "Payee"
}{% endcapture %}

{% include code-example.html
    title='PATCH Archive All Payer Tokens Request'
    header=request_header
    json= request_content
    %}

<div class="api-compact" aria-label="PATCH Archive All Payer Tokens Request">

  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- LEVEL 0 -->
      <details class="api-item" data-level="0">
        <summary>
          <span class="field">{% f reason, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-0">An explanation of why the tokens are being archived.</div></div>
      </details>

      <details class="api-item" data-level="0">
        <summary>
          <span class="field">{% f updatedBy, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-0">Indicates who archived the tokens: <code>PAYEE</code>, <code>CONSUMER</code>, <code>ONLINE</code> or <code>TOKENISSUER</code>.</div></div>
      </details>

  </div>

### PATCH Archive All Payer Tokens Response

{% capture response_content %}{
    "tokens": {
        "id": "/online/payers/<payerReference>/archives",
        "payerReference": "<payerReference>",
        "migratedFromConsumerProfile": false,
        "tokenList": [
            {
                "operations": [
                    {
                        "href": "https://api.externalintegration.swedbankpay.com/online/payers/tokens/<token>-<tokentType>",
                        "rel": "get-token",
                        "method": "GET",
                        "contentType": "application/json"
                    }
                ],
                "id": "/online/payers/tokens/<token>-<tokentType>",
                "payerReference": "<payerReference>",
                "token": "<token>",
                "tokenType": "Payment",
                "instrument": "CreditCard",
                "displayName": "3406",
                "correlationId": "b5c14a0d-e098-4a49-9019-abcd181176c5",
                "state": "Archived",
                "archivedBy": "PAYEE",
                "archiveReason": "string",
                "networkTokenized": false,
                "instrumentParameters": {
                    "cardBrand": "MasterCard",
                    "expiryPan": "12/2055",
                    "bin": "522661",
                    "cardholderType": "Consumer",
                    "cardType": "Credit",
                    "countryCode": "752",
                    "lastFourPan": "3406"
                }
            },
            {
                "operations": [
                    {
                        "href": "https://api.externalintegration.swedbankpay.com/online/payers/tokens/<token>-<tokentType>",
                        "rel": "get-token",
                        "method": "GET",
                        "contentType": "application/json"
                    }
                ],
                "id": "/online/payers/tokens/<token>-<tokenType>",
                "payerReference": "<payerReference>",
                "token": "<token>",
                "tokenType": "Recurrence",
                "instrument": "CreditCard",
                "displayName": "3406",
                "correlationId": "b5c14a0d-e098-4a49-9019-abcd181176c5",
                "state": "Archived",
                "archivedBy": "PAYEE",
                "archiveReason": "string",
                "networkTokenized": false,
                "instrumentParameters": {
                    "cardBrand": "MasterCard",
                    "expiryPan": "12/2055",
                    "bin": "522661",
                    "cardholderType": "Consumer",
                    "cardType": "Credit",
                    "countryCode": "752",
                    "lastFourPan": "3406"
                }
            }
        ]
    },
    "operations": [
        {
            "href": "https://api.externalintegration.swedbankpay.com/online/payers/<payerReference>/archives",
            "rel": "get-archived-payer-tokens",
            "method": "GET",
            "contentType": "application/json"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='PATCH Archive All Payer Tokens Response'
    header=response_header
    json= response_content
    %}

{% capture id_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" aria-label="PATCH Archive All Payer Tokens Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>
<!-- LEVEL 0: token -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f token, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>object</code></span>
  </summary>

  <div class="desc">
    <div class="indent-0">The token object.</div>
  </div>

  <!-- LEVEL 1: children of token -->
  <div class="api-children">

<details class="api-item" data-level="1">
  <summary>
    <span class="field">{% f operations %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>array</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">{{ operations_md | markdownify }}</div>
  </div>
</details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc">
        <div class="indent-1">{{ id_md | markdownify }}</div>
      </div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f payerReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc">
        <div class="indent-1">
          The reference used to recognize the payer in the absence of SSN and/or a secure login.
        </div>
      </div>
    </details>

    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f migratedFromConsumerProfile %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>bool</code></span>
      </summary>
      <div class="desc">
        <div class="indent-1">
          Indicates if the token was migrated from Swedbank Pay's old consumer profile solution.
          Set to <code>true</code> or <code>false</code>.
        </div>
      </div>
    </details>

    <!-- LEVEL 1: tokenlist -->
    <details class="api-item" data-level="1">
      <summary>
        <span class="field">{% f tokenlist %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>array</code></span>
      </summary>

      <div class="desc">
        <div class="indent-1">The array of token objects.</div>
      </div>

      <!-- LEVEL 2: fields inside each tokenlist item -->
      <div class="api-children">

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">The token ID.</div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f payerReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The reference used to recognize the payer in the absence of SSN and/or a secure login.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f token %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The token <code>guid</code>.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f tokenType %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            Available token types:
            <code>Payment</code>, <code>Recurrence</code>,
            <code>TransactionOnFile</code> or <code>Unscheduled</code>.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f instrument %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            Available payment methods which support tokens:
            <code>CreditCard</code> or <code>Trustly</code>.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f instrumentDisplayName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The displayed payment method name.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f correlationsId %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            A unique ID (guid) used in the system.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f state %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The state of the token:
            <code>Active</code> or <code>Archived</code>.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f archivedBy %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            Indicates who archived the token:
            <code>PAYEE</code>, <code>SWEDBANK_PAY</code> or <code>TOKEN_ISSUER</code>.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f archiveReason %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            The reason why the token was archived.
          </div></div>
        </details>

        <details class="api-item" data-level="2">
          <summary>
            <span class="field">{% f instrumentParameters %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>object</code></span>
          </summary>
          <div class="desc"><div class="indent-2">
            Additional information connected to the token.
          </div></div>
        </details>

      </div>
    </details>

  </div>
</details>

<!-- LEVEL 0: operations -->
<details class="api-item" data-level="0">
  <summary>
    <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    <span class="type"><code>array</code></span>
  </summary>
  <div class="desc">
    <div class="indent-0">{{ operations_md | markdownify }}</div>
  </div>
</details>
</div>
