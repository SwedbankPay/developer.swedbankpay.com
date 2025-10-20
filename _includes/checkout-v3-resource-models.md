{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}

## Aborted

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/aborted HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "aborted": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/aborted",
    "abortReason": "Payment aborted by payer"
  }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

<!-- Captures for markdown-includes -->
{%- capture id_md -%}{% include fields/id.md resource="paymentorder" %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0 (original order, all nodes CLOSED by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f aborted, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The abort object.</div></div>

    <!-- Level 1: children of aborted (exact original order) -->
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f abortReason %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Why the payment was aborted.</div></div>
      </details>
    </div>
  </details>
</div>

## Cancelled

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/cancelled HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "cancelled": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/paid",
    "cancelReason": "<should be the description from the merchant when doing cancel on the authorisation payment>",
    "instrument": "Creditcard",
    "number": 1234567890,
    "payeeReference": "CD123",
    "orderReference": "AB1234",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "tokens": [
      {
        "type": "payment",
        "token": "12345678-1234-1234-1234-1234567890AB",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "recurrence",
        "token": "87654321-4321-4321-4321-BA0987654321",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      }
    ],
    "details": {
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture id_paymentorder_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture number_md %}{% include fields/number.md %}{% endcapture %}
{% capture payee_ref_md %}{% include fields/payee-reference.md %}{% endcapture %}

<div class="api-compact" aria-label="Payment Order – Cancelled (No Required)">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- LEVEL 0: paymentOrder -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
  </details>

  <!-- LEVEL 0: cancelled -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f cancelled, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The cancel object.</div></div>

    <div class="api-children">
      <!-- LEVEL 1 fields under cancelled -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_paymentorder_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cancelReason %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Why the payment was cancelled.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrument %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            The payment method used in the fulfillment of the payment. Do not use this field for code validation purposes.
            To determine if a <code>capture</code> is needed, we recommend using <code>operations</code> or the <code>transactionType</code> field.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f number, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ number_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeReference, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(30)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payee_ref_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderReference, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(50)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The order reference should reflect the order reference found in the merchant's systems.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f transactionType, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            This will either be set to <code>Authorization</code> or <code>Sale</code>. Can be used to understand if a capture is needed.
            Swedbank Pay recommends using the different operations to figure out if a capture is needed.
          </div>
        </div>
      </details>

      <!-- Amount-related (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f submittedAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            This field will display the initial payment order amount, not including any discounts or fees specific to a payment method.
            The final payment order amount will be displayed in the <code>amount</code> field.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f feeAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">If the payment method used had a unique fee, it will be displayed in this field.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f discountAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">If the payment method used had a unique discount, it will be displayed in this field.</div></div>
      </details>

      <!-- tokens (level 1) + children (level 2) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f tokens %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of tokens connected to the payment.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                {% f payment, 0 %}, <code>recurrence</code>, <code>transactionOnFile</code> or <code>unscheduled</code>. The different types of available tokens.
              </div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f token, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The token <code>guid</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the token. In the example, a masked version of a card number.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f expiryDate, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The expiry date of the token.</div></div>
          </details>
        </div>
      </details>

      <!-- details (level 1) + children (level 2) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f details %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Details connected to the payment.</div></div>

        <div class="api-children">
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
            <div class="desc">
              <div class="indent-2">
                The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc.
                For Mass Transit merchants, transactions redeemed by Visa will be populated with PAR. For Mastercard and Amex, it will be our own token.
              </div>
            </div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

## Failed

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/failed HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "failed": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/failed",
    "problem": {
      "type": "https://api.payex.com/psp/errordetail/creditcard/acquirererror",
      "title": "Operation failed",
      "status": 403,
      "detail": "Unable to complete Authorization transaction, look at problem node!",
      "problems": [
        {
          "name": "ExternalResponse",
          "description": "REJECTED_BY_ACQUIRER-unknown error, response-code: 51"
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

{% capture id_paymentorder_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- LEVEL 0: paymentOrder -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
  </details>

  <!-- LEVEL 0: failed -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f failed, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The failed object.</div></div>

    <div class="api-children">
      <!-- LEVEL 1 under failed -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_paymentorder_md | markdownify }}</div></div>
      </details>
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f problem %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The problem object.</div></div>

        <!-- LEVEL 2 under problem -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The type of problem that occurred.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f title, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The title of the problem that occurred.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f status, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The HTTP status code that the problem was served with.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f detail, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A detailed, human readable description of the error.</div></div>
          </details>

          <!-- problems array (each item holds name & description) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f problems, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>array</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The array of problem detail objects.</div></div>

            <!-- Item fields inside problems[] -->
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f name,3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The name of the field, header, object, entity or likewise that was erroneous.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f description,3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The human readable description of what was wrong with the field, header, object, entity or likewise identified by <code>name</code>.</div></div>
              </details>
            </div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

## FailedAttempts

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/failedattempts HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "failedAttempts": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/failedattempts"
    "failedAttemptList": [
      {
        "created": "2020-03-03T07:21:01.1893466Z",
        "instrument": "CreditCard",
        "number": 123456,
        "status": "Aborted",
        "problem": {
          "type": "https://api.payex.com/psp/errordetail/creditcard/3dsecureusercanceled",
          "title": "Operation failed",
          "status": 403,
          "detail": "Unable to complete VerifyAuthentication transaction, look at problem node!",
          "problems": [
            {
              "name": "ExternalResponse",
              "description": "UserCancelled-CANCELED"
            }
          ]
        }
      },
            {
        "created": "2020-03-03T07:21:01.1893466Z",
        "instrument": "Vipps",
        "number": 123457,
        "status": "Failed",
        "operationalFee": false,
        "problem": {
          "type": "https://api.payex.com/psp/errordetail/vipps/vippsdeclined",
          "title": "Operation failed",
          "status": 403,
          "detail": "Unable to complete Vipps transaction. failedReason: VippsPaymentCancel,ErrorDescription: Received status USER_CANCEL from Vipps",
          "problems": []
        }
      },
      {
        "created": "2020-03-03T07:22:21.1893466Z",
        "instrument": "CreditCard",
        "number": 123458,
        "status": "Failed",
        "problem": {
          "type": "https://api.payex.com/psp/errordetail/creditcard/3dsecureacquirergatewayerror",
          "title": "Operation failed",
          "status": 502,
          "detail": "Unable to complete VerifyAuthentication transaction, look at problem node!",
          "problems": [
            {
              "name": "ExternalResponse",
              "description": "ARCOT_MERCHANT_PLUGIN_ERROR-merchant plugin error [98]: This is a triggered error message."
            }
          ]
        }
      }
    ]
  }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture id_paymentorder_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture number_paymentorder_md %}{% include fields/number.md resource="paymentorder" %}{% endcapture %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- LEVEL 0: paymentOrder -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
  </details>

  <!-- LEVEL 0: failedAttempts -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f failedAttempts, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The failed attempt object.</div></div>

    <!-- LEVEL 1 under failedAttempts -->
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_paymentorder_md | markdownify }}</div></div>
      </details>
      <!-- failedAttemptList -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failedAttemptList %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The array of failed attempts.</div></div>

        <!-- LEVEL 2: items inside failedAttemptList -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f created, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date of when the payment order was created.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f instrument, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payment method used in the failed payment.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ number_paymentorder_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f status, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The status of the payment attempt. <code>Failed</code> or <code>Aborted</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f operationalFee, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Vipps-specific flag. <code>true</code> if an operational fee for receiving card information from Vipps has been generated; otherwise <code>false</code>.</div></div>
          </details>

          <!-- problem object under failedAttempts -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f problem,2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The problem object.</div></div>

            <!-- LEVEL 3: fields inside problem -->
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f type, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The type of problem that occurred.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f title, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The title of the problem that occurred.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f status, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>integer</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The HTTP status code that the problem was served with.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f detail, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">A detailed, human readable description of the error.</div></div>
              </details>

              <!-- problems array (each item holds name & description) -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f problems, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>array</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The array of problem detail objects.</div></div>

                <!-- (Conceptual) item structure of problems[] -->
                <div class="api-children">
                  <details class="api-item" data-level="4">
                    <summary>
                      <span class="field">{% f name,4 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                      <span class="type"><code>string</code></span>
                    </summary>
                    <div class="desc"><div class="indent-4">The name of the field, header, object, entity or likewise that was erroneous.</div></div>
                  </details>

                  <details class="api-item" data-level="4">
                    <summary>
                      <span class="field">{% f description,4 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                      <span class="type"><code>string</code></span>
                    </summary>
                    <div class="desc"><div class="indent-4">The human readable description of what was wrong with the field, header, object, entity or likewise identified by <code>name</code>.</div></div>
                  </details>
                </div>
              </details>
            </div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

## FailedPostPurchaseAttempts

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/failedpostpurchaseattempts HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Accept: application/json;version=3.x{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "postPurchaseFailedAttempts": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/postpurchasefailedattempts",
    "postpurchaseFailedAttemptList": [
      {
        "created": "2020-03-03T07:21:01.1893466Z",
        "status": "Failed",
        "type": "Capture",
        "number": 12345678,
        "problem": {
          "type": "https://api.payex.com/psp/errordetail/creditcard/badrequest",
          "title": "Operation failed",
          "status": 400,
          "detail": "Unable to complete CreateCapture operation, look at problem node!",
          "problems": [
            {
              "name":"Entitynotfound",
              "description":"Capture with identifier f1c8c67b-88cb-407c-98fb-08db6f56295e could not be found"
            },
            {
              "name":"Component",
              "description":"pospay-ecommerce-financial-service"
            },
            {
              "name":"Method",
              "description":"N/A"
            }
          ]
        }
      }
    ]
  }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture id_paymentorder_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- LEVEL 0: paymentOrder -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
  </details>

  <!-- LEVEL 0: postpurchasefailedAttempts -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f postpurchasefailedAttempts, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The failed attempt object.</div></div>

    <div class="api-children">
      <!-- LEVEL 1: id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_paymentorder_md | markdownify }}</div></div>
      </details>

      <!-- LEVEL 1: postpurchaseFailedAttemptList -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f postpurchaseFailedAttemptList %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The array of failed attempts.</div></div>

        <!-- LEVEL 2: items inside postpurchaseFailedAttemptList -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f created, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date of when the payment order was created.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f status, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The status of the payment attempt. <code>Failed</code> or <code>Aborted</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The type of post-purchase transaction.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The attempt number of the post-purchase operation.</div></div>
          </details>

          <!-- LEVEL 2: problem object (moved under list items) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f problem, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The problem object.</div></div>

            <!-- LEVEL 3: fields inside problem -->
            <div class="api-children">
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f type, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The type of problem that occurred.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f title, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The title of the problem that occurred.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f status, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>integer</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The HTTP status code that the problem was served with.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f detail, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">A detailed, human readable description of the error.</div></div>
              </details>

              <!-- LEVEL 3: problems[] -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f problems, 3 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>array</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The array of problem detail objects.</div></div>

                <!-- LEVEL 4: items inside problems[] -->
                <div class="api-children">
                  <details class="api-item" data-level="4">
                    <summary>
                      <span class="field">{% f name %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                      <span class="type"><code>string</code></span>
                    </summary>
                    <div class="desc"><div class="indent-4">The name of the field, header, object, entity or likewise that was erroneous.</div></div>
                  </details>

                  <details class="api-item" data-level="4">
                    <summary>
                      <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                      <span class="type"><code>string</code></span>
                    </summary>
                    <div class="desc"><div class="indent-4">The human readable description of what was wrong with the field, header, object, entity or likewise identified by <code>name</code>.</div></div>
                  </details>
                </div>
              </details>
            </div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

## FinancialTransactions

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/financialtransactions HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "financialTransactions" {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/financialtransactions",
    "financialTransactionsList": [
      {
        "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/financialtransactions/7e6cdfc3-1276-44e9-9992-7cf4419750e1",
        "created": "2020-03-04T01:01:01.01Z",
        "updated": "2020-03-04T01:01:01.03Z",
        "type": "Capture",
        "number": 123459,
        "amount": 1000,
        "vatAmount": 250,
        "description": "Test transaction1",
        "payeeReference": "AH123456",
        "receiptReference": "OL1234"
        "orderItems": {
          "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/financialtransactions/7e6cdfc3-1276-44e9-9992-7cf4419750e1/orderitems"
        }
      },
      {
        "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/financialtransactions/<transactionId>",
        "created": "2020-03-05T01:01:01.01Z",
        "updated": "2020-03-05T01:01:01.03Z",
        "type": "Capture",
        "number": 123460,
        "amount": 500,
        "vatAmount": 125,
        "description": "Test transaction2",
        "payeeReference": "AH234567",
        "receiptReference": "OL5678"
        "orderItems": {
          "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/financialtransactions/7e6cdfc3-1276-44e9-9992-7cf4419750e1/orderitems"
        }
      },
      {
        "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/financialtransactions/<transactionId>",
        "created": "2020-04-02T01:01:01.01Z",
        "updated": "2020-04-02T01:01:01.03Z",
        "type": "Reversal",
        "number": 123461,
        "amount": 1000,
        "vatAmount": 250,
        "description": "Test transaction3",
        "payeeReference": "AH345678",
        "receiptReference": "OL1357"
        "orderItems": {
          "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/financialtransactions/7e6cdfc3-1276-44e9-9992-7cf4419750e1/orderitems"
        }
      }
    ]
  }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture id_paymentorder_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}
{% capture number_paymentorder_md %}{% include fields/number.md resource="paymentorder" %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture payee_ref_md %}{% include fields/payee-reference.md %}{% endcapture %}
{% capture receipt_ref_md %}{% include fields/receipt-reference.md %}{% endcapture %}
{% capture order_items_md %}{% include fields/order-items.md %}{% endcapture %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- LEVEL 0: paymentOrder -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
  </details>

  <!-- LEVEL 0: financialTransactions -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f financialTransactions, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The financial transactions object.</div></div>

    <div class="api-children">
      <!-- LEVEL 1: id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_paymentorder_md | markdownify }}</div></div>
      </details>

      <!-- LEVEL 1: financialTransactionsList -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f financialTransactionsList %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The array of financial transactions.</div></div>

        <!-- LEVEL 2: item fields -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The id of the financial transaction.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f created, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date of when the payment order was created.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f updated, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date of when the payment order was updated.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The type of transaction. <code>Capture</code>, <code>Authorization</code>, <code>Cancellation</code>, <code>Reversal</code>, <code>Sale</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ number_paymentorder_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ amount_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ vat_amount_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The description of the payment order.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_ref_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f receiptReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ receipt_ref_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f orderItems %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>array</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ order_items_md | markdownify }}</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

## History

We advise you to not build logic around the content of these fields. They are
mainly for information purposes, and might be subject to name changes. If these
should occur, updates will be available in the list below.

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/history HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "history": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/history",
    "historyList": [
      {
        "created": "2020-03-04T01:00:00.00Z",
        "name": "PaymentCreated",
        "initiatedBy" "Merchant"
      },
      {
        "created": "2020-03-04T01:01:00.00Z",
        "name": "PaymentLoaded",
        "initiatedBy" "System"
      },
      {
        "created": "2020-03-04T01:00:15.00Z",
        "name": "CheckinInitiated",
        "initiatedBy" "System"
      },
      {
        "created": "2020-03-04T01:00:16.00Z",
        "name": "PayerDetailsRetrieved",
        "initiatedBy" "System"
      },
      {
        "created": "2020-03-04T01:00:20.00Z",
        "name": "PayerCheckedIn",
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T01:01:01.01Z",
        "name": "PaymentInstrumentSelected",
        "instrument": "CreditCard",
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T01:03:01.01Z",
        "name": "PaymentAttemptStarted",
        "instrument": "CreditCard",
        "number": 123456,
        "prefill": true,
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T01:03:01.01Z",
        "name": "PaymentAttemptAborted",
        "number": 123456,
        "instrument": "CreditCard",
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentInstrumentSelected",
        "instrument": "Vipps",
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T03:01:01.01Z",
        "name": "PaymentInstrumentSelected",
        "instrument": "CreditCard",
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentAttemptStarted",
        "instrument": "CreditCard",
        "number": 123457,
        "prefill": true,
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentAttemptFailed",
        "instrument": "CreditCard",
        "number": 123457,
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentAttemptStarted",
        "instrument": "CreditCard",
        "number": 123458,
        "prefill": true,
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentPaid",
        "instrument": "CreditCard"
        "number": 123458,
        "initiatedBy" "Consumer"
      },
      {
        "created": "2020-03-05T02:01:01.01Z",
        "name": "PaymentPartiallyCaptured",
        "instrument": "CreditCard"
        "number": 123459,
        "initiatedBy" "Merchant"
      },
      {
        "created": "2020-03-06T02:01:01.01Z",
        "name": "PaymentPartiallyCaptured",
        "instrument": "CreditCard"
        "number": 123460,
        "initiatedBy" "Merchant"
      },
      {
        "created": "2020-03-07T02:01:01.01Z",
        "name": "PaymentPartiallyReversed",
        "instrument": "CreditCard"
        "number": 123461,
        "initiatedBy" "Merchant"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentCapturedFailed",
        "instrument": "CreditCard",
        "number": 123462,
        "initiatedBy" "Merchant"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentPartiallyCapturedFailed",
        "instrument": "CreditCard",
        "number": 123463,
        "initiatedBy" "Merchant"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentReversedFailed",
        "instrument": "CreditCard",
        "number": 123464,
        "initiatedBy" "Merchant"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentPartiallyReversedFailed",
        "instrument": "CreditCard",
        "number": 123465,
        "initiatedBy" "Merchant"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentCancelledFailed",
        "instrument": "CreditCard",
        "number": 123466,
        "initiatedBy" "Merchant"
      },
      {
        "created": "2020-03-04T02:01:01.01Z",
        "name": "PaymentPartiallyCancelledFailed",
        "instrument": "CreditCard",
        "number": 123467,
        "initiatedBy" "Merchant"
      }
    ]
  }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture id_paymentorder_md %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- LEVEL 0: paymentOrder -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
  </details>

  <!-- LEVEL 0: history -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f history, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The history object.</div></div>

    <div class="api-children">
      <!-- LEVEL 1: id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_paymentorder_md | markdownify }}</div></div>
      </details>

      <!-- LEVEL 1: historyList -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f historyList %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The array of history objects.</div></div>

        <!-- LEVEL 2: fields inside each historyList item -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f created %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date of when the history event was created.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f name %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Name of the history event. See dictionary below for information.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f instrument %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The payment method used when the event occurred.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payment number associated with the event.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f prefill %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates if payment info was prefilled or not.</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

{% capture table %}
<div class="api-compact" aria-label="History Events (A–Ö)">
  <div class="header">
    <div>History Event Name</div>
    <div>Description</div>
  </div>

  <!-- Level 0, all nodes CLOSED by default & sorted alphabetically -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f CheckinInitiated, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will be set when checkin is started, if checkin is activated for the merchant. The merchant must be configured with ProductPackage=Checkout</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PayerCheckedIn, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will be set when checkin is completed. The merchant must be configured with ProductPackage=Checkout</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PayerDetailsRetrieved, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will be set if a consumer profile is found. The merchant must be configured with ProductPackage=Checkout</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentAttemptAborted, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur if the payer aborts the payment attempt. Both the number and instrument parameters will be available on this event.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentAttemptFailed, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur if the payment failed. Both the number and instrument parameters will be available on this event.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentAttemptStarted, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur when the payer presses the first button in the payment process (either "pay" or "next" if the payment has multiple steps). The instrument parameter will contain the payment method for this attempt. The prefill will be true if the payment page was prefilled with payment information. The transaction number for this payment will be available in the number field.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentCancelled, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur when the merchant has cancelled the full authorization amount. Both the number and instrument parameters will be available on this event.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentCancelledFailed, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur when the merchant has tried - but failed - to do a <strong>full</strong> cancel of the authorization amount. The number (nullable) of this event will point to a number in the <code>financialTransaction</code> node for easy linking.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentCaptured, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur when the merchant has captured the full authorization amount. Both the number and instrument parameters will be available on this event. The number of this event will point to a number in the <code>financialTransaction</code> field for easy linking.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentCapturedFailed, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur when the merchant has tried - but failed - to do a <strong>full</strong> capture of the authorization amount. The number (nullable) of this event will point to a number in the <code>financialTransaction</code> node for easy linking.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentCreated, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">This event will occur as soon as the merchant initiates the payment order.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentInstrumentSelected, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur each time the payer expands a payment method in the payment UI. The payment method selected will be set in the instrument parameter.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentInstrumentSet, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">If the <code>PaymentOrder</code> is initiated in Instrument Mode, the first occurrence will be set to the value from the merchant´s POST statement. Following values will be set for each time the merchant to a PATCH to change the payment method used for that payment. The payment method set will be in the instrument parameter.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentLoaded, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will be set the first time the payer loads the payment window. If this event hasn't occurred, the payment window hasn't been loaded.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentPaid, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur if the payment succeeds. Both the number and instrument parameters will be available on this event.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentPartiallyCancelled, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur when the merchant has cancelled part of the authorization amount. Both the number and instrument parameters will be available on this event.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentPartiallyCancelledFailed, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur when the merchant has tried - but failed - to cancel the remaining (uncaptured) parts of authorizated amount. The number (nullable) of this event will point to a number in the <code>financialTransaction</code> node for easy linking.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentPartiallyCaptured, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur when the merchant has done a partial capture of authorization amount. Both the number and instrument parameters will be available on this event. The number of this event will point to a number in the <code>financialTransaction</code> field for easy linking.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentPartiallyCapturedFailed, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur when the merchant has tried - but failed - to do a <strong>partial</strong> capture of the authorization amount. The number (nullable) of this event will point to a number in the <code>financialTransaction</code> node for easy linking.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentPartiallyReversed, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur when the merchant reverses a part of the authorization amount. Both the number and instrument parameters will be available on this event. The number of this event will point to a number in the <code>financialTransaction</code> field for easy linking.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentPartiallyReversedFailed, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur when the merchant has tried - but failed - to do a partial reversal of the captured authorization amount. The number parameter might be available on this event. If present, it will point to a number in the <code>financialTransaction</code> field for easy linking.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentReversed, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur when the merchant reverses the full authorization amount. Both the number and instrument parameters will be available on this event. The number of this event will point to a number in the <code>financialTransaction</code> field for easy linking.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f PaymentReversedFailed, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    </summary>
    <div class="desc"><div class="indent-0">Will occur when the merchant has tried - but failed - to do a reversal of the <strong>fully</strong> captured authorization amount. The number parameter might be available on this event. If present, it will point to a number in the <code>financialTransaction</code> field for easy linking.</div></div>
  </details>
</div>
{% endcapture %}
{% include accordion-table.html content=table header_text="History Event Dictionary" %}

## Paid

The payment order response with `status` equal to `Paid`, and the `paid`
resource expanded. Please note that the main code example is of a card payment.

We have included `paid` resources of the remaining payment methods below the
main code example. Resource examples where details are empty indicate that no
details are available.

The wallets Apple Pay and Vipps do not return `maskedPan`. Please note that
while MobilePay does return this field, the value present is actually a
`networkToken`, which **represents** the PAN, but is not a PAN in itself.

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

### Card `Paid` Resource

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "paid": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/paid",
    "instrument": "Creditcard",
    "number": 1234567890,
    "payeeReference": "CD123",
    "orderReference": "AB1234",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "paymentTokenGenerated": false,
    "tokens": [
      {
        "type": "payment",
        "token": "12345678-1234-1234-1234-1234567890AB",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "recurrence",
        "token": "87654321-4321-4321-4321-BA0987654321",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "unscheduled",
        "token": "87654321-4321-4321-4321-BA0987654321",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "transactionsOnFile",
        "token": "87654321-4321-4321-4321-BA0987654321",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      }
    ],
    "details": {
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
      "paymentAccountReference": "43f6b6d2cbd30c36627ec02247259",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004", // Same format as maskedDpan for enrolled network tokenization cards
      "maskedDPan": "***********1234",
      "expiryDate": "12/2022",
      "issuerAuthorizationApprovalCode": "L00302",
      "acquirerTransactionType": "STANDARD",
      "acquirerStan": "302",
      "acquirerTerminalId": "70101301389",
      "acquirerTransactionTime": "2022-06-15T14:12:55.029Z",
      "transactionInitiator": "CARDHOLDER",
      "bin": "492500"
    }
  }{% endcapture %}

  {% include code-example.html
    title='Card Response'
    header=response_header
    json= response_content
    %}

### Apple Pay `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "paid": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/paid",
    "instrument": "ApplePay",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "paymentTokenGenerated": false,
    "details": {
        "cardBrand": "Visa",
        "cardType": "Credit",
        "maskedDPan": "492500******0004",
        "expiryDate": "12/2023",
        "issuerAuthorizationApprovalCode": "L00392",
        "acquirerTransactionType": "WALLET",
        "acquirerStan": "392",
        "acquirerTerminalId": "80100001190",
        "acquirerTransactionTime": "2022-09-05T06:45:40.322Z",
        "transactionInitiator": "CARDHOLDER",
        "bin": "492500"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Apple Pay Response'
    header=response_header
    json= response_content
    %}

### Click to Pay `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "paid": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/paid",
    "instrument": "ClickToPay",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "amount": 1500,
    "paymentTokenGenerated": false,
    "details": {
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "maskedDPan": "492500******0004",
      "expiryDate": "12/0023",
      "issuerAuthorizationApprovalCode": "L00392",
      "acquirerTransactionType": "WALLET",
      "acquirerStan": "392",
      "acquirerTerminalId": "80100001190",
      "acquirerTransactionTime": "2022-09-05T06:45:40.322Z",
      "transactionInitiator": "CARDHOLDER"
      "bin": "489537"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Click to Pay Response'
    header=response_header
    json= response_content
    %}

### Google Pay&trade; `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "paid": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/paid",
    "instrument": "GooglePay",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "amount": 1500,
    "paymentTokenGenerated": false,
    "details": {
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "maskedDPan": "492500******0004",
      "expiryDate": "12/0023",
      "issuerAuthorizationApprovalCode": "L00392",
      "acquirerTransactionType": "WALLET",
      "acquirerStan": "392",
      "acquirerTerminalId": "80100001190",
      "acquirerTransactionTime": "2022-09-05T06:45:40.322Z",
      "transactionInitiator": "CARDHOLDER"
      "bin": "489537"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Google Pay&trade; Response'
    header=response_header
    json= response_content
    %}

### MobilePay `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "paid": {
    "id": "/psp/paymentorders/efdcbf77-9a62-426b-a3b1-08da8caf7918/paid",
    "instrument": "MobilePay",
    "number": 75100106637,
    "payeeReference": "1662364327",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "paymentTokenGenerated": false,
    "details": {
        "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
        "externalNonPaymentToken": "1234567890",
        "cardBrand": "Visa",
        "maskedDPan": "492500******0004",
        "expiryDate": "12/2022",
        "issuerAuthorizationApprovalCode": "018117",
        "acquirerTransactionType": "MOBILEPAY",
        "acquirerStan": "53889",
        "acquirerTerminalId": "42",
        "acquirerTransactionTime": "2022-09-05T09:54:05Z",
        "bin": "489537"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='MobilePay Response'
    header=response_header
    json= response_content
    %}

### Vipps `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "paid": {
    "id": "/psp/paymentorders/a463b145-3278-4aa0-c4db-08da8f1813a2/paid",
    "instrument": "Vipps",
    "number": 99463794,
    "payeeReference": "1662366424",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "paymentTokenGenerated": false,
    "details": {
        "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
        "externalNonPaymentToken": "1234567890",
        "cardBrand": "Visa",
        "maskedDPan": "************0004",
        "acquirerTransactionType": "WALLET",
        "acquirerTerminalId": "99488282",
        "acquirerTransactionTime": "2022-09-05T09:54:05Z",
        "transactionInitiator": "CARDHOLDER",
        "bin": "489537"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Vipps Response'
    header=response_header
    json= response_content
    %}

### Swish `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "paid": {
    "id": "/psp/paymentorders/b0410cd0-61df-4548-a3ad-08da8caf7918/paid",
    "instrument": "Swish",
    "number": 74100413405,
    "payeeReference": "1662360831",
    "transactionType": "Sale",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "paymentTokenGenerated": false,
    "details": {
      "misidn": "+46739000001"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Swish Response'
    header=response_header
    json= response_content
    %}

### Invoice `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"paid": {
    "id": "/psp/paymentorders/05a356df-05e2-49e6-8858-08da8cb4d651/paid",
    "instrument": "Invoice",
    "number": 71100775379,
    "payeeReference": "1662360980",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "paymentTokenGenerated": false,
    "details": {}
  }
}{% endcapture %}

{% include code-example.html
    title='Invoice Response'
    header=response_header
    json= response_content
    %}

### Installment Account `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"paid": {
    "id": "/psp/paymentorders/39eef759-a619-4c91-885b-08da8cb4d651/paid",
    "instrument": "CreditAccount",
    "number": 77100038000,
    "payeeReference": "1662361777",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "paymentTokenGenerated": false,
    "details": {}
  }
}{% endcapture %}

{% include code-example.html
    title='Installment Account Response'
    header=response_header
    json= response_content
    %}

### Trustly `Paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"paid": {
    "id": "/psp/paymentorders/bf660901-93d0-4245-4e6b-08da8f165366/paid",
    "instrument": "Trustly",
    "number": 79100113652,
    "payeeReference": "1662373401",
    "orderReference": "orderReference",
    "transactionType": "Sale",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "paymentTokenGenerated": false,
    "details": {
      "trustlyOrderId": 123456789
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Trustly Response'
    header=response_header
    json= response_content
    %}

<!-- Captures for markdown-includes -->
{%- capture id_md -%}{% include fields/id.md resource="paymentorder" %}{%- endcapture -%}
{%- capture number_md -%}{% include fields/number.md resource="paymentorder" %}{%- endcapture -%}
{%- capture payee_ref_md -%}{% include fields/payee-reference.md %}{%- endcapture -%}
{%- capture amount_md -%}{% include fields/amount.md %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0 (original order, all nodes CLOSED by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paid, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The paid object.</div></div>

    <!-- Level 1/2: children of paid (exact original order) -->
    <div class="api-children">
      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      <!-- level 1 PARENT: instrument -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrument %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The payment method used in the fulfillment of the payment. Do not use this field for code validation purposes. To determine if a <code>capture</code> is needed, we recommend using <code>operations</code> or the <code>transactionType</code> field.</div></div>

        <!-- level 2 CHILDREN of instrument (moved under instrument so they toggle correctly) -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ number_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_ref_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f orderReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The order reference should reflect the order reference found in the merchant's systems.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f transactionType, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">This will either be set to <code>Authorization</code> or <code>Sale</code>. Can be used to understand if there is a need for doing a <code>capture</code> on this payment order. Swedbank Pay recommends using the different <code>operations</code> to figure out if a <code>capture</code> is needed.</div></div>
          </details>
        </div>
      </details>

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f submittedAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">This field will display the initial payment order amount, not including any discounts or fees specific to a payment method. The final payment order amount will be displayed in the <code>amount</code> field.</div></div>
      </details>

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f feeAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">If the payment method used had a unique fee, it will be displayed in this field.</div></div>
      </details>

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f discountAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">If the payment method used had a unique discount, it will be displayed in this field.</div></div>
      </details>

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paymentTokenGenerated %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Used to show if a payment token has been generated or not. Will be set to <code>true</code> if the checkbox enabled by <code>EnablePaymentDetailsConsentCheckbox</code> has been checked by the payer during a payment, otherwise <code>false</code>.</div></div>
      </details>

      <!-- level 1: tokens (array) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f tokens %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of tokens connected to the payment.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% f payment, 0 %}, <code>recurrence</code>, <code>transactionOnFile</code> or <code>unscheduled</code>. The different types of available tokens.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f token, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The token <code>guid</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the token. In the example, a masked version of a card number.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f expiryDate, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The expiry date of the token.</div></div>
          </details>
        </div>
      </details>

      <!-- level 1: details (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f details %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Details connected to the payment.</div></div>

        <div class="api-children">
          <!-- (rest of your level-2 fields under details unchanged) -->
          <!-- ... -->
        </div>
      </details>
    </div>
  </details>
</div>

## Payer

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "payer": {
    "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payers",
    "reference": "reference to payer"
    "name": "Azra Oliveira",
    "email": "azra@swedbankpay.com",
    "msisdn": "+46722345678",  {% unless documentation_section contains "checkout-v3/payments-only" %}
    "gender": "male",
    "birthYear": "1980", {% endunless %}
    "hashedFields": {
      "emailHash": "968e23eda8818f8647d15775c939b3bc32ba592e",
      "msisdnHash": "a23ec9d5b9def87cae2769cfffb0b8a0487a5afd"  {% unless documentation_section contains "checkout-v3/payments-only" %},
      "socialSecurityNumberHash": "50288c11d79c1ba0671e6426ffddbb4954347ba4" {% endunless %}
    },
    "shippingAddress": {
      "addressee": "firstName + lastName",
      "coAddress": "coAddress",
      "streetAddress": "streetAddress",
      "zipCode": "zipCode",
      "city": "city",
      "countryCode": "countryCode"
    },
    "device": {
      "detectionAccuracy": 48,
      "ipAddress": "127.0.0.1",
      "userAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36 Edg/97.0.1072.62",
      "deviceType": "Desktop",
      "hardwareFamily": "Emulator",
      "hardwareName": "Desktop|Emulator",
      "hardwareVendor": "Unknown",
      "platformName": "Windows",
      "platformVendor": "Microsoft",
      "platformVersion": "10.0",
      "browserName": "Edge (Chromium) for Windows",
      "browserVendor": "Microsoft",
      "browserVersion": "95.0",
      "browserJavaEnabled": false
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

<!-- Captures for markdown-includes -->
{%- capture id_md -%}{% include fields/id.md resource="paymentorder" %}{%- endcapture -%}
{%- capture ua_md -%}{% include fields/user-agent.md %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0 (original order, all nodes CLOSED by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payer, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payer object.</div></div>

    <!-- Level 1/2: children of payer (exact original order; device moved out one level) -->
    <div class="api-children">
      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f reference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The reference to the payer. In checkout, this will be the <code>consumerReference</code>.</div></div>
      </details>

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f name %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The name of the payer.</div></div>
      </details>

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f email %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The email address of the payer.</div></div>
      </details>

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f msisdn %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The msisdn of the payer.</div></div>
      </details>

      {% unless documentation_section contains "checkout-v3/payments-only" %}
      <!-- level 1 (guarded) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f gender %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The gender of the payer.</div></div>
      </details>

      <!-- level 1 (guarded) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f birthYear %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The birth year of the payer.</div></div>
      </details>
      {% endunless %}

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f hashedFields %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>hashedFields</code> object, containing hashed versions of the payer's email, msisdn and if present, Social Security Number.</div></div>

        <div class="api-children">
          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f emailHash %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A hashed version of the payer's email.</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f msisdnHash %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A hashed version of the payer's email.</div></div>
          </details>

          {% unless documentation_section contains "checkout-v3/payments-only" %}
          <!-- level 2 (guarded) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f socialSecurityNumberHash %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A hashed version of the payer's social security number.</div></div>
          </details>
          {% endunless %}
        </div>
      </details>

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f shippingAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The shipping address object related to the <code>payer</code>.</div></div>

        <!-- Level 2: children of shippingAddress (exact original order) -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f addressee, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">First and last name of the addressee – the receiver of the shipped goods.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f coAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payer's c/o address, if applicable.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f streetAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payer's street address. Maximum 50 characters long.</div></div>
          </details>

          <!-- coAddress repeated as in original -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f coAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payer's c/o address, if applicable.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f zipCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payer's zip code.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f city, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payer's city of residence.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f countryCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Country code for country of residence, e.g. <code>SE</code>, <code>NO</code>, or <code>FI</code>.</div></div>
          </details>
        </div>
      </details>

      <!-- level 1: device (tag UPDATED to level-1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f device %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The device detection object.</div></div>

        <div class="api-children">
          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f detectionAccuracy, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the accuracy of the device detection on a scale from 0 to 100.</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f ipAddress, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The IP address of the payer's device.</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f userAgent, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ ua_md | markdownify }}</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f deviceType, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The type of device used by the payer.</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f hardwareFamily, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The type of hardware used by the payer.</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f hardwareName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the payer's hardware.</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f hardwareVendor, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The vendor of the payer's hardware.</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f platformName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Name of the operating system used on the payer's device.</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f platformVendor, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Vendor of the operating system used on the payer's device.</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f platformVersion, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Version of the operating system used on the payer's device.</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f browserName, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Name of the browser used on the payer's device.</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f browserVendor, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Vendor of the browser used on the payer's device.</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f browserVersion, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Version of the browser used on the payer's device.</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f browserJavaEnabled, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>bool</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates if the browser has Java enabled. Either <code>true</code> or <code>false</code>.</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

## Reversed

The payment order response with `status` equal to `Reversed`, and the `reversed`
resource expanded. Please note that the main code example is of a card reversal.

Apart from the id and number fields, the output will be inherited from the
corresponding `Paid` transaction. As several `Reversed` transactions can exist
on a single payment, the number and payerReference will be from the latest
`Reversed`.

We have included `reversal` resources of the remaining payment methods below the
main code example. Resource examples where details are empty indicate that no
details are available.

The wallets Apple Pay and Vipps do not return `maskedPan`. Please note that
while MobilePay does return this field, the value present is actually a
`networkToken`, which **represents** the PAN, but is not a PAN in itself.

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/reversed HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

### Card `Reversed` Resource

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "reversed": {
    "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/reversed",
    "instrument": "Creditcard",
    "number": 1234567890,
    "payeeReference": "CD123",
    "orderReference": "AB1234",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "tokens": [
      {
        "type": "payment",
        "token": "12345678-1234-1234-1234-1234567890AB",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "recurrence",
        "token": "87654321-4321-4321-4321-BA0987654321",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "unscheduled",
        "token": "87654321-4321-4321-4321-BA0987654321",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      },
      {
        "type": "transactionsOnFile",
        "token": "87654321-4321-4321-4321-BA0987654321",
        "name": "4925xxxxxx000004",
        "expiryDate" : "mm/yyyy"
      }
    ],
    "details": {
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
      "paymentAccountReference": "43f6b6d2cbd30c36627ec02247259",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "maskedDPan": "************0004",
      "expiryDate": "12/2022",
      "issuerAuthorizationApprovalCode": "L00302",
      "acquirerTransactionType": "STANDARD",
      "acquirerStan": "302",
      "acquirerTerminalId": "70101301389",
      "acquirerTransactionTime": "2022-06-15T14:12:55.029Z",
      "transactionInitiator": "CARDHOLDER",
      "bin": "492500"
    }
  }{% endcapture %}

{% include code-example.html
    title='Card Response'
    header=response_header
    json= response_content
    %}

### Apple Pay `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "reversed": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/reversed",
    "instrument": "ApplePay",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
        "cardBrand": "Visa",
        "cardType": "Credit",
        "maskedDPan": "************0004",
        "expiryDate": "12/2023",
        "issuerAuthorizationApprovalCode": "L00392",
        "acquirerTransactionType": "WALLET",
        "acquirerStan": "392",
        "acquirerTerminalId": "80100001190",
        "acquirerTransactionTime": "2022-09-05T06:45:40.322Z",
        "transactionInitiator": "CARDHOLDER",
        "bin": "492500"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Apple Pay Response'
    header=response_header
    json= response_content
    %}

### Click to Pay `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "reversed": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/reversed",
    "instrument": "ClickToPay",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "amount": 1500,
    "details": {
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "maskedDPan": "************0004",
      "expiryDate": "12/0023",
      "issuerAuthorizationApprovalCode": "L00392",
      "acquirerTransactionType": "WALLET",
      "acquirerStan": "392",
      "acquirerTerminalId": "80100001190",
      "acquirerTransactionTime": "2022-09-05T06:45:40.322Z",
      "transactionInitiator": "CARDHOLDER"
      "bin": "489537"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Click to Pay Response'
    header=response_header
    json= response_content
    %}

### Google Pay&trade; `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "reversed": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/reversed",
    "instrument": "GooglePay",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "amount": 1500,
    "details": {
      "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
      "externalNonPaymentToken": "1234567890",
      "cardBrand": "Visa",
      "cardType": "Credit",
      "maskedPan": "492500******0004",
      "maskedDPan": "************0004",
      "expiryDate": "12/0023",
      "issuerAuthorizationApprovalCode": "L00392",
      "acquirerTransactionType": "WALLET",
      "acquirerStan": "392",
      "acquirerTerminalId": "80100001190",
      "acquirerTransactionTime": "2022-09-05T06:45:40.322Z",
      "transactionInitiator": "CARDHOLDER"
      "bin": "489537"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Google Pay&trade; Response'
    header=response_header
    json= response_content
    %}

### MobilePay `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "reversed": {
    "id": "/psp/paymentorders/efdcbf77-9a62-426b-a3b1-08da8caf7918/reversed",
    "instrument": "MobilePay",
    "number": 75100106637,
    "payeeReference": "1662364327",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
        "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
        "externalNonPaymentToken": "1234567890",
        "cardBrand": "Visa",
        "maskedDPan": "************0004",
        "expiryDate": "12/2022",
        "issuerAuthorizationApprovalCode": "018117",
        "acquirerTransactionType": "MOBILEPAY",
        "acquirerStan": "53889",
        "acquirerTerminalId": "42",
        "acquirerTransactionTime": "2022-09-05T09:54:05Z",
        "bin": "489537"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='MobilePay Response'
    header=response_header
    json= response_content
    %}

### Vipps `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "reversed": {
    "id": "/psp/paymentorders/a463b145-3278-4aa0-c4db-08da8f1813a2/reversed",
    "instrument": "Vipps",
    "number": 99463794,
    "payeeReference": "1662366424",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
        "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
        "externalNonPaymentToken": "1234567890",
        "cardBrand": "Visa",
        "maskedDPan": "************0004",
        "acquirerTransactionType": "WALLET",
        "acquirerTerminalId": "99488282",
        "acquirerTransactionTime": "2022-09-05T09:54:05Z",
        "transactionInitiator": "CARDHOLDER",
        "bin": "489537"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Vipps Response'
    header=response_header
    json= response_content
    %}

### Swish `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "reversed": {
    "id": "/psp/paymentorders/b0410cd0-61df-4548-a3ad-08da8caf7918/reversed",
    "instrument": "Swish",
    "number": 74100413405,
    "payeeReference": "1662360831",
    "transactionType": "Sale",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
      "misidn": "+46739000001"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Swish Response'
    header=response_header
    json= response_content
    %}

### Invoice `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"reversed": {
    "id": "/psp/paymentorders/05a356df-05e2-49e6-8858-08da8cb4d651/reversed",
    "instrument": "Invoice",
    "number": 71100775379,
    "payeeReference": "1662360980",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {}
  }
}{% endcapture %}

{% include code-example.html
    title='Invoice Response'
    header=response_header
    json= response_content
    %}

### Installment Account `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"reversed": {
    "id": "/psp/paymentorders/39eef759-a619-4c91-885b-08da8cb4d651/reversed",
    "instrument": "CreditAccount",
    "number": 77100038000,
    "payeeReference": "1662361777",
    "transactionType": "Authorization",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {}
  }
}{% endcapture %}

{% include code-example.html
    title='Installment Account Response'
    header=response_header
    json= response_content
    %}

### Trustly `Reversed` Resource

Please note that this is an abbreviated example. See the main `Reversed` example
for more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
"reversed": {
    "id": "/psp/paymentorders/bf660901-93d0-4245-4e6b-08da8f165366/reversed",
    "instrument": "Trustly",
    "number": 79100113652,
    "payeeReference": "1662373401",
    "orderReference": "orderReference",
    "transactionType": "Sale",
    "amount": 1500,
    "submittedAmount": 1500,
    "feeAmount": 0,
    "discountAmount": 0,
    "details": {
      "trustlyOrderId": 123456789
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Trustly Response'
    header=response_header
    json= response_content
    %}


<!-- Captures for markdown-includes -->
{%- capture id_md -%}{% include fields/id.md resource="paymentorder" %}{%- endcapture -%}
{%- capture number_md -%}{% include fields/number.md resource="paymentorder" %}{%- endcapture -%}
{%- capture payee_ref_md -%}{% include fields/payee-reference.md %}{%- endcapture -%}
{%- capture amount_md -%}{% include fields/amount.md %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0 (original order, all nodes CLOSED by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f reversed, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The reversed object.</div></div>

    <!-- Level 1/2: children of reversed (exact original order) -->
    <div class="api-children">
      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      <!-- level 1 PARENT: instrument -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrument %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The payment method used in the fulfillment of the payment. Do not use this field for code validation purposes. To determine if a <code>capture</code> is needed, we recommend using <code>operations</code> or the <code>transactionType</code> field.</div></div>

        <!-- level 2 CHILDREN of instrument (moved under instrument so they toggle correctly) -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ number_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_ref_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f orderReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(50)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The order reference should reflect the order reference found in the merchant's systems.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f transactionType, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">This will either be set to <code>Authorization</code> or <code>Sale</code>. Can be used to understand if there is a need for doing a <code>capture</code> on this payment order. Swedbank Pay recommends using the different <code>operations</code> to figure out if a <code>capture</code> is needed.</div></div>
          </details>
        </div>
      </details>

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f submittedAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">This field will display the initial payment order amount, not including any method specific discounts or fees. The final payment order amount will be displayed in the <code>amount</code> field.</div></div>
      </details>

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f feeAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">If the payment method used had a unique fee, it will be displayed in this field.</div></div>
      </details>

      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f discountAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">If the payment method used had a unique discount, it will be displayed in this field.</div></div>
      </details>

      <!-- level 1: tokens (array) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f tokens %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of tokens connected to the payment.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% f payment, 0 %}, <code>recurrence</code>, <code>transactionOnFile</code> or <code>unscheduled</code>. The different types of available tokens.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f token, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The token <code>guid</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the token. In the example, a masked version of a card number.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f expiryDate, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The expiry date of the token.</div></div>
          </details>
        </div>
      </details>

      <!-- level 1: details (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f details %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Details connected to the payment.</div></div>

        <div class="api-children">
          <!-- (rest of level-2 fields under details unchanged) -->
          <!-- ... -->
        </div>
      </details>
    </div>
  </details>
</div>
