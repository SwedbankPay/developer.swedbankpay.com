## GET Single Payer Token

A GET request used when you need to retrieve a single token.

## GET Single Payer Token Request

{% capture request_header %}GET /online/payer/payees/<payeeId>/tokens/<tokenId> HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% include code-example.html
    title='GET Single Payer Token Request'
    header=request_header
    %}

## GET Single Payer Token Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
   "token": {
     "id" : "<resourceId>",
     "payerReference" : "<payerReference>",
     "token": "<Guid>",
     "tokenType": "Unscheduled",
     "instrument": "Trustly",
     "instrumentDisplayName" : "Custom value, or default depending on instrument",
     "correlationsId": "e2f06785-805d-4605-bf40-426a725d313d",
     "state": "Active",
     "instrumentParameters": {
       ...
    }
  },
  "operations": [
    {
       "method": "GET",
       "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/tokens/<token>-<tokenType>",
       "rel": "get-token",
       "contentType": "application/json"
    },
    {
       "method": "PATCH",
       "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/tokens/<token>-<tokenType>/displaynames",
       "rel": "update-displayname",
       "contentType": "application/json"
     },
     {
        "method": "PATCH",
        "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/tokens/<token>-<tokenType>/archives",
        "rel": "archive-token",
        "contentType": "application/json"
     }
   ]
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
        The reason why the token was archived.
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

### Instrument Parameters - CreditCard

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
          <div class="desc"><>
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

### Instrument Parameters - Trustly

{% capture response_content %}{
   "token": {
      "instrumentParameters": {
         "AccountId": "156",
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
            <span class="field">{% f AccountId %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
          </summary>
          <div class="desc">
            <div class="indent-2">Account identifier provided by Trustly.</div>
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

## GET All Payer Tokens Request

{% capture request_header %}GET /online/payer/payees/{{payeeId}}/payers/{{payerReference}}/tokens HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% include code-example.html
    title='GET All Payer Tokens Request'
    header=request_header
    %}

## Get All Payer Tokens Response

{% capture response_content %}{
{
  "tokens": {
    "id": "/online/payer/payees/<payeeid>/payers/<payerReference>/tokens",
    "payerReference": "{payerReference}",
    "migratedFromConsumerProfile": true
    "tokenlist": [
      {
         "id" : "<resourceId>",
         "payerReference" : "<payerReference>",
         "token": "<Guid>",
         "tokenType": "TransactionOnFile",
         "instrument": "Trustly",
         "instrumentDisplayName" : "Custom value, or default depending on instrument",
         "correlationsId": "e2f06785-805d-4605-bf40-426a725d313d",
         "state": "Archived",
         "archivedBy": "TOKEN_ISSUER",
         "archiveReason": "Comment with reason for archive",
         "instrumentParameters": {
           ...
         }
        "operations": [...]
      },
      {
         "id" : "<resourceId>",
         "payerReference" : "<payerReference>",
         "token": "<Guid>",
         "tokenType": "Unscheduled",
         "instrument": "CreditCard|Trustly|CarPay",
         "instrumentDisplayName" : "Custom value, or default depending on instrument",
         "correlationsId": "e2f06785-805d-4605-bf40-426a725d313d",
         "state": "Active",
         "instrumentParameters": {
           ...
         }
        "operations": [...]
      },
      {
         "id" : "<resourceId>",
         "payerReference" : "<payerReference>",
         "token": "<Guid>",
         "tokenType": "Payment",
         "instrument": "CreditCard",
         "instrumentDisplayName" : "Custom value, or default depending on instrument",
         "correlationsId": "e2f06785-805d-4605-bf40-426a725d313d",
         "state": "Archived",
         "archivedBy": "PAYEE",
         "archiveReason": "Comment with reason for archive",
         "instrumentParameters": {
           ...
         }
        "operations": [...]
      }
    ]
  },
  "operations": [
    {
      "method": "GET",
      "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/payers/<payerReference>/tokens",
      "rel": "get-payer-tokens",
      "contentType": "application/json"
    },
    {
      "method": "PATCH",
      "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/payers/<payerReference>/archives",
      "rel": "archive-payer-tokens",
      "contentType": "application/json"
    }
  ]
}
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

## GET Archived Payer Tokens Request

{% capture request_header %}GET /online/payer/payees/<payeeId>/payers/<payerReference>/archives HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% include code-example.html
    title='GET Archived Tokens Request'
    header=request_header
    %}

## GET Archived Payer Tokens Response

{% capture response_content %}{
{
  "tokens": {
    "id": "/online/payer/payees/<payeeid>/payers/<payerReference>/tokens",
    "payerReference": "{payerReference}",
    "migratedFromConsumerProfile": false
    "tokenlist": [
      {
         "id" : "<resourceId>",
         "payerReference" : "<payerReference>",
         "token": "<Guid>",
         "tokenType": "Payment",
         "instrument": "CreditCard",
         "instrumentDisplayName" : "Custom value, or default depending on instrument",
         "correlationsId": "e2f06785-805d-4605-bf40-426a725d313d",
         "state": "Archived",
         "archivedBy": "PAYEE",
         "archiveReason": "Comment with reason for archive",
         "instrumentParameters": {
           ...
         }
        "operations": [...]
      },
      {
         "id" : "<resourceId>",
         "payerReference" : "<payerReference>",
         "token": "<Guid>",
         "tokenType": "Unscheduled",
         "instrument": "Trustly",
         "instrumentDisplayName" : "Custom value, or default depending on instrument",
         "correlationsId": "e2f06785-805d-4605-bf40-426a725d313d",
         "state": "Archived",
         "archivedBy": "SWEDBANK_PAY",
         "archiveReason": "Comment with reason for archive",
         "instrumentParameters": {
           ...
         }
        "operations": [...]
      },
      {
         "id" : "<resourceId>",
         "payerReference" : "<payerReference>",
         "token": "<Guid>",
         "tokenType": "Recurrence",
         "instrument": "CreditCard",
         "instrumentDisplayName" : "Custom value, or default depending on instrument",
         "correlationsId": "e2f06785-805d-4605-bf40-426a725d313d",
         "state": "Archived",
         "archivedBy": "TOKEN_ISSUER",
         "archiveReason": "Comment with reason for archive",
         "instrumentParameters": {
           ...
         }
        "operations": [...]
      }
    ]
  },
  "operations": [
    {
      "method": "GET",
      "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/payers/<payerReference>/tokens",
      "rel": "get-payer-tokens",
      "contentType": "application/json"
    },
    {
      "method": "PATCH",
      "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/payers/<payerReference>/archives",
      "rel": "archive-payer-tokens",
      "contentType": "application/json"
    }
  ]
}
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

## PATCH Update Display Name Request

{% capture request_header %}PATCH /online/payer/payees/<payeeId>/tokens/<tokenId>/displaynames HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% capture request_content %}{
"displayName" : "Example"
}{% endcapture %}

{% include code-example.html
    title='PATCH Update Display Name Request'
    header=request_header
    json= request_content
    %}

  <!-- LEVEL 0 -->
    <div class="api-children">
      <details class="api-item" data-level="0">
        <summary>
          <span class="field">{% f displayName %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-0">The new display name.</div></div>
      </details>

  </div>
</details>
</div>

## PATCH Update Display Name Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
   "token": {
     "id" : "<resourceId>",
     "payerReference" : "<payerReference>",
     "token": "<Guid>",
     "tokenType": "Unscheduled",
     "instrument": "Trustly",
     "instrumentDisplayName" : "Custom value, or default depending on instrument",
     "correlationsId": "e2f06785-805d-4605-bf40-426a725d313d",
     "state": "Active",
     "instrumentParameters": {
       ...
    }
  },
  "operations": [
    {
       "method": "GET",
       "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/tokens/<token>-<tokenType>",
       "rel": "get-token",
       "contentType": "application/json"
    },
    {
       "method": "PATCH",
       "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/tokens/<token>-<tokenType>/displaynames",
       "rel": "update-displayname",
       "contentType": "application/json"
     },
     {
        "method": "PATCH",
        "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/tokens/<token>-<tokenType>/archives",
        "rel": "archive-token",
        "contentType": "application/json"
     }
   ]
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

## PATCH Archive Single Payer Token Request

{% capture request_header %}PATCH /online/payer/payees/<payeeId>/tokens/<tokenId>/archives HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% capture request_content %}{
  "reason" : "description",
  "updatedBy": "PAYEE"
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
    <div class="api-children">
      <details class="api-item" data-level="0">
        <summary>
          <span class="field">{% f reason %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-0">An explanation for why the tokens are being archived.</div></div>
      </details>

      <details class="api-item" data-level="0">
        <summary>
          <span class="field">{% f updatedBy %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-0">Indicates who archived the token: <code>PAYEE</code>, <code>SWEDBANK_PAY</code> or <code>TOKEN_ISSUER</code>.</div></div>
      </details>

  </div>
</details>
</div>

## PATCH Archive Single Payer Token Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
   "token": {
     "id" : "<resourceId>",
     "payerReference" : "<payerReference>",
     "token": "<Guid>",
     "tokenType": "Unscheduled",
     "instrument": "Trustly",
     "instrumentDisplayName" : "Custom value, or default depending on instrument",
     "correlationsId": "e2f06785-805d-4605-bf40-426a725d313d",
     "state": "Archived",
     "archivedBy": "PAYEE",
     "archiveReason": "Comment with reason for archive",
     "instrumentParameters": {
       ...
    }
  },
  "operations": [
    {
       "method": "GET",
       "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/tokens/<token>-<tokenType>",
       "rel": "get-token",
       "contentType": "application/json"
    },
    {
       "method": "PATCH",
       "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/tokens/<token>-<tokenType>/displaynames",
       "rel": "update-displayname",
       "contentType": "application/json"
     },
     {
        "method": "PATCH",
        "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/tokens/<token>-<tokenType>/archives",
        "rel": "archive-token",
        "contentType": "application/json"
     }
   ]
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

## PATCH Archive All Payer Tokens Request

{% capture request_header %}PATCH /online/payer/payees/<payeeId>/payers/<payerReference>/archives HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% capture request_content %}{
  "reason" : "description",
  "updatedBy": "SWEDBANK_PAY"
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
    <div class="api-children">
      <details class="api-item" data-level="0">
        <summary>
          <span class="field">{% f reason %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-0">An explanation for why the tokens are being archived.</div></div>
      </details>

      <details class="api-item" data-level="0">
        <summary>
          <span class="field">{% f updatedBy %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-0">Indicates who archived the tokens: <code>PAYEE</code>, <code>SWEDBANK_PAY</code> or <code>TOKEN_ISSUER</code>.</div></div>
      </details>

  </div>
</details>
</div>

## PATCH Archive All Payer Tokens Response

{% capture response_content %}{
{
  "tokens": {
    "id": "/online/payer/payees/<payeeid>/payers/<payerReference>/tokens",
    "payerReference": "{payerReference}",
    "migratedFromConsumerProfile": false
    "tokenlist": [
      {
         "id" : "<resourceId>",
         "payerReference" : "<payerReference>",
         "token": "<Guid>",
         "tokenType": "Payment",
         "instrument": "CreditCard",
         "instrumentDisplayName" : "Custom value, or default depending on instrument",
         "correlationsId": "e2f06785-805d-4605-bf40-426a725d313d",
         "state": "Archived",
         "archivedBy": "PAYEE",
         "archiveReason": "Comment with reason for archive",
         "instrumentParameters": {
           ...
         }
        "operations": [...]
      },
      {
         "id" : "<resourceId>",
         "payerReference" : "<payerReference>",
         "token": "<Guid>",
         "tokenType": "Unscheduled",
         "instrument": "Trustly",
         "instrumentDisplayName" : "Custom value, or default depending on instrument",
         "correlationsId": "e2f06785-805d-4605-bf40-426a725d313d",
         "state": "Archived",
         "archivedBy": "SWEDBANK_PAY",
         "archiveReason": "Comment with reason for archive",
         "instrumentParameters": {
           ...
         }
        "operations": [...]
      },
      {
         "id" : "<resourceId>",
         "payerReference" : "<payerReference>",
         "token": "<Guid>",
         "tokenType": "Recurrence",
         "instrument": "CreditCard",
         "instrumentDisplayName" : "Custom value, or default depending on instrument",
         "correlationsId": "e2f06785-805d-4605-bf40-426a725d313d",
         "state": "Archived",
         "archivedBy": "TOKEN_ISSUER",
         "archiveReason": "Comment with reason for archive",
         "instrumentParameters": {
           ...
         }
        "operations": [...]
      }
    ]
  },
  "operations": [
    {
      "method": "GET",
      "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/payers/<payerReference>/tokens",
      "rel": "get-payer-tokens",
      "contentType": "application/json"
    },
    {
      "method": "PATCH",
      "href": "https://api.<environment>.swedbankpay.com/online/payer/payees/<guid>/payers/<payerReference>/archives",
      "rel": "archive-payer-tokens",
      "contentType": "application/json"
    }
  ]
}
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
