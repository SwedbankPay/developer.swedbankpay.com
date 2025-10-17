{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% capture techref_url %}{% include utils/documentation-section-url.md %}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{%- capture url -%}
    {%- include utils/documentation-section-url.md
        href='/technical-reference/resource-sub-models' -%}
{%- endcapture -%}

The `status` field indicates the payment order's current status. `Initialized`
is returned when the payment is created and still ongoing.

The request example above has this status. `Paid` is returned when the payer has
completed the payment successfully.

`Failed` is returned when a payment has failed. You will find an error message
in the failed section.

`Cancelled` is returned when an authorized amount has been **fully** cancelled.

`Reversed` is returned when the full amount of a sale transaction or a captured
transaction has been reversed. The transaction will now have status `Reversed`
instead of `Paid`.

It will contain fields from both the cancelled description and paid section.
`Aborted` is returned when the merchant has aborted the payment or if the payer
cancelled the payment in the redirect integration (on the redirect page).

## Aborted

A payment order response with the status `Aborted`.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
    "paymentOrder": {
      "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd",
      "created": "2022-01-24T10:54:05.6243371Z",
      "updated": "2022-01-24T10:54:19.2679591Z",
      "operation": "Purchase",
      "status": "Aborted",
      "currency": "SEK",
      "amount": 32000,
      "vatAmount": 0,
      "description": "Abort test",
      "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
      "language": "sv-SE",
      "availableInstruments": [
          "CreditCard",
          "Invoice-PayExFinancingSe",
          "Invoice-PayMonthlyInvoiceSe",
          "Swish",
          "CreditAccount",
          "Trustly"
      ], {% if documentation_section contains "old-implementations/enterprise" %}
      "implementation": "Enterprise", {% endif %} {% if documentation_section contains "checkout-v3/payments-only" %}
      "implementation": "PaymentsOnly", {% endif %} {% if include.integration_mode=="seamless-view" %}
      "integration": "HostedView", {% endif %} {% if include.integration_mode=="redirect" %}
      "integration": "Redirect", {% endif %}
      "instrumentMode": false,
      "guestMode": false,
      "orderItems": {
          "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/orderitems"
      },
      "urls": {
          "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/urls"
      },
      "payeeInfo": {
          "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/payeeinfo"
      },
      "payer": {
          "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/payers"
      },
      "history": {
          "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/history"
      },
      "failed": {
          "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/failed"
      },
      "aborted": {
          "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/aborted"
      },
      "paid": {
          "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/paid"
      },
      "cancelled": {
          "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/cancelled"
      },
      "financialTransactions": {
          "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/financialtransactions"
      },
      "failedAttempts": {
          "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/failedattempts"
      },
      "metadata": {
          "id": "/psp/paymentorders/2c3f7a3e-65ca-4493-ac93-08d9dcb313fd/metadata"
      }
    },
    "operations": [ {% if include.integration_mode=="redirect" %}
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "redirect-checkout",
            "contentType": "text/html"
        }{% endif %} {% if include.integration_mode=="seamless-view" %}
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "view-checkout",
            "contentType": "application/javascript"
        }{% endif %}
    ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

Response fields not covered in the [`Initialized`]({{ techref_url }}/technical-reference/status-models#initialized) redirect or seamless view
responses:

<!-- Capture for markdown include -->
{%- capture operations_md -%}{% include fields/operations.md %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Single field, closed by default -->
  <details class="api-item" data-level="1">
    <summary>
      <span class="field">{% f operations %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>array</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        {{ operations_md | markdownify }}
        As this is an aborted payment, the available operations are <code>redirect-checkout</code> or <code>view-checkout</code>, depending on the integration.
        <a href="{{ features_url }}/technical-reference/operations">See Operations for details</a>.
      </div>
    </div>
  </details>
</div>

## Cancelled

The `cancel` response is not yet converted to the new standard.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/paymentorders/payments/{{ page.payment_id }}",
    "cancellation": {
        "id": "/psp/paymentorders/payments/{{ page.payment_id }}/cancellations/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/paymentorders/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2022-01-31T09:49:13.7567756Z",
            "updated": "2022-01-31T09:49:14.7374165Z",
            "type": "Cancellation",
            "state": "Completed",
            "number": 71100732065,
            "amount": 1500,
            "vatAmount": 375,
            "description": "Test Cancellation",
            "payeeReference": "AB123"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

<!-- Captures for markdown-includes -->
{%- capture txn_md -%}{% include fields/transaction.md %}{%- endcapture -%}
{%- capture number_md -%}{% include fields/number.md %}{%- endcapture -%}
{%- capture amount_md -%}{% include fields/amount.md %}{%- endcapture -%}
{%- capture vat_amount_md -%}{% include fields/vat-amount.md %}{%- endcapture -%}
{%- capture payee_ref_md -%}{% include fields/payee-reference.md describe_receipt=true %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0 (original order, all nodes CLOSED by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The relative URL of the payment this cancellation transaction belongs to.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f cancellation, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The cancellation object, containing information about the cancellation transaction.</div></div>

    <!-- Level 1/2: children of cancellation (exact original order) -->
    <div class="api-children">
      <!-- level 1 -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The relative URL of the cancellation transaction.</div></div>
      </details>

      <!-- level 1: transaction (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f transaction %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ txn_md | markdownify }}</div></div>

        <!-- Level 2: children of transaction (exact original order) -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The relative URL of the current <code>transaction</code> resource.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f created, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date and time of when the transaction was created.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f updated, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date and time of when the transaction was updated.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the transaction type.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f state, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>Initialized</code>, <code>Completed</code> or <code>Failed</code>. Indicates the state of the transaction.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ number_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ amount_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ vat_amount_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A human readable description of maximum 40 characters of the transaction.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_ref_md | markdownify }}</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

## Failed

The failed response is not yet converted to the new standard.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/paymentorders/payments/{{ page.payment_id }}",
    "failed": {
        "id": "/psp/paymentorders/bc2832a7-0e0f-45f2-57d6-08d9ea4cff66/failed",
        "problem": {
            "type": "acquirerinsufficientfunds",
            "title": "Operation failed",
            "status": 403,
            "detail": "Unable to complete Recurrence transaction, look at problem node!",
            "problems": [
                {
                    "name": "ExternalResponse",
                    "description": "REJECTED_BY_ACQUIRER_INSUFFICIENT_FUNDS-insufficient funds, response-code: 61"
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

{%- capture id_md -%}{% include fields/id.md resource="paymentorder" %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0, all nodes CLOSED by default (original order) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f failed, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The failed object.</div></div>

    <!-- Children of failed -->
    <div class="api-children">
      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      <!-- problem -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f problem %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The problem object.</div></div>

        <!-- Children of problem -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The type of problem that occurred.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f title, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The title of the problem that occurred.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f status, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The HTTP status code that the problem was served with.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f detail, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A detailed, human readable description of the error.</div></div>
          </details>

          <!-- problems array -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f problems, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>array</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The array of problem detail objects.</div></div>

            <div class="api-children">
              <!-- level 3 items so they toggle with 'problems' -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The name of the field, header, object, entity or likewise that was erroneous.</div></div>
              </details>

              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
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

## Initialized

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
    "paymentOrder": {
        "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b",
        "created": "2022-01-07T07:58:26.1300282Z",
        "updated": "2022-01-07T08:17:44.6839034Z",
        "operation": "Purchase",
        "status": "Initialized",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [
            "CreditCard",
            "Invoice-PayExFinancingSe",
            "Invoice-PayMonthlyInvoiceSe",
            "Swish",
            "CreditAccount",
            "Trustly"
        ],{% if documentation_section contains "old-implementations/enterprise" %}
        "implementation": "Enterprise", {% endif %} {% if documentation_section contains "checkout-v3/payments-only" %}
        "implementation": "PaymentsOnly", {% endif %} {% if include.integration_mode=="seamless-view" %}
        "integration": "HostedView", {% endif %} {% if include.integration_mode=="redirect" %}
        "integration": "Redirect", {% endif %}
        "instrumentMode": false,
        "guestMode": false,
        "payer": {
          "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payers"
        },
        "orderItems": {
          "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderitems"
        },
        "history": {
          "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/history"
        },
        "failed": {
          "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/failed"
        },
        "aborted": {
          "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/aborted"
        },
        "paid": {
          "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/paid"
        },
        "cancelled": {
          "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/cancelled"
        },
        "financialTransactions": {
          "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/financialtransactions"
        },
        "failedAttempts": {
          "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/failedattempts"
        },
        "metadata": {
          "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/metadata"
        }
    },
    "operations": [ {% if include.integration_mode=="redirect" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "redirect-checkout",
          "contentType": "text/html"
        }{% endif %} {% if include.integration_mode=="seamless-view" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "view-checkout",
          "contentType": "application/javascript"
        },{% endif %}
        {
          "href": "https://api.payex.com/psp/paymentorders/222a50ca-b268-4b32-16fa-08d6d3b73224",
          "rel":"update-order",
          "method":"PATCH",
          "contentType":"application/json"
        },
        {
          "href": "https://api.payex.com/psp/paymentorders/222a50ca-b268-4b32-16fa-08d6d3b73224",
          "rel": "abort",
          "method": "PATCH",
          "contentType": "application/json"
        }{% if documentation_section contains "checkout-v3" %},
        {
          "href": "https://api.payex.com/psp/paymentorders/{{ page.payment_order_id }}",
          "rel": "abort-paymentattempt",
          "method": "PATCH",
          "contentType": "application/json"
        }{% endif %}
    ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{%- capture id_md -%}{% include fields/id.md resource="paymentorder" %}{%- endcapture -%}
{%- capture operation_md -%}{% include fields/operation.md %}{%- endcapture -%}
{%- capture amount_md -%}{% include fields/amount.md %}{%- endcapture -%}
{%- capture vat_amount_md -%}{% include fields/vat-amount.md %}{%- endcapture -%}
{%- capture description_md -%}{% include fields/description.md %}{%- endcapture -%}
{%- capture isu_md -%}{% include fields/initiating-system-user-agent.md %}{%- endcapture -%}
{%- capture language_md -%}{% include fields/language.md %}{%- endcapture -%}
{%- capture operations_md -%}{% include fields/operations.md %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0 (all nodes CLOSED by default; original order) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <!-- Children of paymentOrder -->
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO-8601 date of when the payment order was created.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO-8601 date of when the payment order was updated.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f status %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">
          Indicates the payment order's current status. <code>Initialized</code> is returned when the payment is created and still ongoing. The request example above has this status.
          <code>Paid</code> is returned when the payer has completed the payment successfully. See the
          <a href="{{ features_url }}/technical-reference/status-models#paid"><code>Paid</code> section for further information</a>.
          <code>Failed</code> is returned when a payment has failed. You will find an error message in the failed section.
          <a href="{{ features_url }}/technical-reference/status-models#failed">Further information here</a>.
          <code>Cancelled</code> is returned when an authorized amount has been fully cancelled.
          See the <a href="{{ features_url }}/technical-reference/status-models#cancelled"><code>Cancel</code> feature section for further information</a>.
          It will contain fields from both the cancelled description and paid section.
          <code>Aborted</code> is returned when the merchant has aborted the payment or if the payer cancelled the payment in the redirect integration (on the redirect page).
          See the <a href="{{ features_url }}/technical-reference/status-models#aborted"><code>Abort</code> feature section for further information</a>.
        </div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f currency %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The currency of the payment order.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f initiatingSystemUserAgent %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ isu_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f availableInstruments %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of payment methods available for this payment.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f implementation %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">
          The merchant's Online Payments implementation type. <code>Enterprise</code> or <code>PaymentsOnly</code>. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.
        </div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f integration %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">
          The merchant's Online Payments integration type. <code>HostedView</code> (Seamless View) or <code>Redirect</code>. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the integration types might be subject to name changes. If this should happen, updated information will be available in this table.
        </div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrumentMode %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Indicates if the payment is initialized with only one payment method available.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f guestMode %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">
          Set to <code>true</code> or <code>false</code>. Indicates if the payer chose to pay as a guest or not. When using the Enterprise implementation, this is triggered by not including a <code>payerReference</code> or <code>nationalIdentifier</code> in the original payment order request.
        </div></div>
      </details>

      <!-- Links to sub-resources -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payer %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#payer"><code>payer</code> resource</a> where information about the payer can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>orderItems</code> resource where information about the order items can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f history %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#history"><code>history</code> resource</a> where information about the payment's history can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failed %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#failed"><code>failed</code> resource</a> where information about the failed transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f aborted %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#aborted"><code>aborted</code> resource</a> where information about the aborted transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paid %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#paid"><code>paid</code> resource</a> where information about the paid transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f cancelled %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#cancelled"><code>cancelled</code> resource</a> where information about the cancelled transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f financialTransactions %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#financialtransactions"><code>financialTransactions</code> resource</a> where information about the financial transactions can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failedAttempts %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <a href="{{ features_url }}/technical-reference/resource-sub-models#failedattempts"><code>failedAttempts</code> resource</a> where information about the failed attempts can be retrieved.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f metadata %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>id</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>metadata</code> resource where information about the metadata can be retrieved.</div></div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f operations,0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>array</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        {{ operations_md | markdownify }}
        As this is an initialized payment, the available operations are <code>abort</code>, <code>update-order</code> and <code>redirect-checkout</code> or <code>view-checkout</code>, depending on the integration.
        <a href="{{ features_url }}/technical-reference/operations">See Operations for details</a>.
      </div>
    </div>
  </details>
</div>

## Paid

The payment order response with status `paid`, and the `paid` resource expanded.
Please note that the main code example is of a card payment. We have included
`paid` resources of the remaining payment methods below the main code example.
Resource examples where details are empty indicate that no details are
available.

The wallets Apple Pay and Vipps do not return `maskedPan`. Please note that
while MobilePay does return this field, the value present is actually a
`networkToken`, which **represents** the PAN, but is not a PAN in itself.

### Card `Paid` Resource

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
    "paymentOrder": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b",
    "paid": {
        "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/paid",
        "instrument": "CreditCard",
        "number": 99101548603,
        "payeeReference": "1641542301",
        "amount": 1500,
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
    }
}{% endcapture %}

{% include code-example.html
    title='Card Response'
    header=response_header
    json= response_content
    %}

### Apple Pay `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

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
          "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
          "externalNonPaymentToken": "1234567890",
          "cardBrand": "Visa",
          "cardType": "Credit",
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
    title='Apple Pay Response'
    header=response_header
    json= response_content
    %}

### Click to Pay `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

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

### Google Pay&trade; `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

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

### MobilePay `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

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
            "maskedPan": "492500******0004",
            "maskedDPan": "************0004",
            "expiryDate": "12/2022",
            "issuerAuthorizationApprovalCode": "018117",
            "acquirerTransactionType": "MOBILEPAY",
            "acquirerStan": "53889",
            "acquirerTerminalId": "42",
            "acquirerTransactionTime": "2022-09-05T09:54:05Z"
            "bin": "489537"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='MobilePay Response'
    header=response_header
    json= response_content
    %}

### Vipps `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{:.code-view-header}
**Vipps Response**

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
    "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "paid": {
        "id": "/psp/paymentorders/a463b145-3278-4aa0-c4db-08da8f1813a2/paid",
        "instrument": "Vipps",
        "number": 99463794,
        "payeeReference": "1662366424",
        "amount": 1500,
        "transactionType": "Authorization",
        "amount": 1500,
        "submittedAmount": 1500,
        "feeAmount": 0,
        "discountAmount": 0,
        "paymentTokenGenerated": false,
        "details": {
            "nonPaymentToken": "12345678-1234-1234-1234-1234567890AB",
            "externalNonPaymentToken": "1234567890"
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

### Swish `paid` Resource

Please note that this is an abbreviated example. See the main `paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

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

Please note that this is an abbreviated example. See the main `Paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

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

Please note that this is an abbreviated example. See the main `Paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

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

Please note that this is an abbreviated example. See the main `Paid` example for
more context.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

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

Response fields not covered in the [`Initialized`]({{ techref_url }}/technical-reference/status-models#initialized) redirect or seamless view responses:

{%- capture id_md -%}{% include fields/id.md resource="paymentorder" %}{%- endcapture -%}
{%- capture number_md -%}{% include fields/number.md %}{%- endcapture -%}
{%- capture payee_ref_md -%}{% include fields/payee-reference.md %}{%- endcapture -%}
{%- capture amount_md -%}{% include fields/amount.md %}{%- endcapture -%}
{%- capture operations_md -%}{% include fields/operations.md %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0 (original order, all nodes CLOSED by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The relative URL of the payment this cancellation transaction belongs to.</div></div>
  </details>

  <!-- paid (parent object) level 0 -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paid, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The paid object.</div></div>

    <div class="api-children">
      <!-- id (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      <!-- instrument (level 1) with level-2 children -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrument %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The payment method used in the fulfillment of the payment. Do not use this field for code validation purposes. To determine if a <code>capture</code> is needed, we recommend using <code>operations</code> or the <code>transactionType</code> field.</div></div>

        <div class="api-children">
          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ number_md | markdownify }}</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_ref_md | markdownify }}</div></div>
          </details>

          <!-- level 2 -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f transactionType, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">This will either be set to <code>Authorization</code> or <code>Sale</code>. Can be used to understand if there is a need for doing a capture on this payment order. Swedbank Pay recommends using the different operations to figure out if a capture is needed.</div></div>
          </details>
        </div>
      </details>

      <!-- amount (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- submittedAmount (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f submittedAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">This field will display the initial payment order amount, not including any discounts or fees specific to a payment method. The final payment order amount will be displayed in the <code>amount</code> field.</div></div>
      </details>

      <!-- feeAmount (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f feeAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">If the payment method used had a unique fee, it will be displayed in this field.</div></div>
      </details>

      <!-- discountAmount (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f discountAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">If the payment method used had a unique discount, it will be displayed in this field.</div></div>
      </details>

      <!-- paymentTokenGenerated (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f paymentTokenGenerated %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Set to <code>true</code> or <code>false</code>. Used to show if a payment token has been generated or not. Will be set to <code>true</code> if the checkbox enabled by <code>EnablePaymentDetailsConsentCheckbox</code> has been checked by the payer during a payment, otherwise <code>false</code>.</div></div>
      </details>

      <!-- details (object) with level-2 children -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f details %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Details connected to the payment.</div></div>

        <div class="api-children">
          <!-- level 2 children of details -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f nonPaymentToken, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The result of our own card tokenization. Activated in POS for the merchant or merchant group.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f externalNonPaymentToken, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, transactions will be populated with the <code>paymentAccountReference</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f paymentAccountReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The result of an external tokenization. The value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, the <code>paymentAccountReference</code> will also populate the externalNonPaymentToken field.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f cardType, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>Credit Card</code> or <code>Debit Card</code>. Indicates the type of card used for the authorization.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f maskedPan, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The masked PAN number of the card.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f maskedDPan, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A masked version of a network token representing the card. It will only appear if the chosen payment method is tokenized and the card used is tokenized by Visa or MasterCard.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f expiryDate, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The month and year of when the card expires.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f issuerAuthorizationApprovalCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payment reference code provided by the issuer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f acquirerTransactionType, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>3DSECURE</code> or <code>STANDARD</code>. Indicates the transaction type of the acquirer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f acquirerStan, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The System Trace Audit Number assigned by the acquirer to uniquely identify the transaction.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f acquirerTerminalId, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ID of the acquirer terminal.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f acquirerTransactionTime, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date and time of the acquirer transaction.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f transactionInitiator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The party which initiated the transaction. <code>MERCHANT</code> or <code>CARDHOLDER</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f bin, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The first six digits of the maskedPan.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f msisdn, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The msisdn used in the purchase. Only available when paid with Swish.</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

### Paid Examples With Connected Tokens

If there e.g. is a recurrence or an unscheduled (below) token connected to the
payment, it will appear like this.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
    "paid": {
        "id": "/psp/paymentorders/91c3ca0d-3710-40f0-0f78-08d9d133750b/paid",
        "instrument": "CreditCard",
        "number": 99101548605,
        "payeeReference": "1641543637",
        "amount": 1500,
        "tokens": [
            {
                "type": "recurrence",
                "token": "48806524-6422-4db7-9fbd-c8b81611132f",
                "name": "492500******0004",
                "expiryDate": "02/2023"
            }
        ],
        "details": {}
    }
}{% endcapture %}

{% include code-example.html
    title='Recurrence Token Response'
    header=response_header
    json= response_content
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x{% endcapture %}

{% capture response_content %}{
    "paid": {
        "id": "/psp/paymentorders/9f786139-3537-4a8b-0f79-08d9d133750b/paid",
        "instrument": "CreditCard",
        "number": 99101548607,
        "payeeReference": "1641543818",
        "amount": 1500,
        "tokens": [
            {
                "type": "Unscheduled",
                "token": "6d495aac-cb2b-4d94-a5f1-577baa143f2c",
                "name": "492500******0004",
                "expiryDate": "02/2023"
            }
        ],
        "details": {}
    }
}{% endcapture %}

{% include code-example.html
    title='Unscheduled Token Response'
    header=response_header
    json= response_content
    %}

Response fields not covered in the [`Initialized`]({{ techref_url }}/technical-reference/status-models#initialized) redirect or seamless view
responses:

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 1 (all nodes CLOSED by default; original order) -->
  <details class="api-item" data-level="1">
    <summary>
      <span class="field">{% f tokens %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>array</code></span>
    </summary>
    <div class="desc"><div class="indent-1">A list of tokens connected to the payment.</div></div>

    <div class="api-children">
      <!-- Level 2 children of tokens -->
      <details class="api-item" data-level="2">
        <summary>
          <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">{% f payment, 0 %}, <code>recurrence</code>, <code>transactionOnFile</code> or <code>unscheduled</code>. The different types of available tokens.</div></div>
      </details>

      <details class="api-item" data-level="2">
        <summary>
          <span class="field">{% f token, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The token <code>guid</code>.</div></div>
      </details>

      <details class="api-item" data-level="2">
        <summary>
          <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The name of the token. In the example, a masked version of a card number.</div></div>
      </details>

      <details class="api-item" data-level="2">
        <summary>
          <span class="field">{% f expiryDate, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The expiry date of the token.</div></div>
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

  <!-- Level 0, all nodes CLOSED by default (original order) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f reversed, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The reversed object.</div></div>

    <!-- Children of reversed (exact original order) -->
    <div class="api-children">
      <!-- id (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      <!-- instrument (level 1) + its level-2 children -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrument %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">
          The payment method used in the fulfillment of the payment. Do not use this field for code validation purposes.
          To determine if a <code>capture</code> is needed, we recommend using <code>operations</code> or the <code>transactionType</code> field.
        </div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ number_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_ref_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f orderReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string(50)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The order reference should reflect the order reference found in the merchant's systems.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f transactionType, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">
              This will either be set to <code>Authorization</code> or <code>Sale</code>. Can be used to understand if there is a need for doing a <code>capture</code> on this payment order.
              Swedbank Pay recommends using the different <code>operations</code> to figure out if a <code>capture</code> is needed.
            </div></div>
          </details>
        </div>
      </details>

      <!-- amount (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- submittedAmount (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f submittedAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">
          This field will display the initial payment order amount, not including any method specific discounts or fees.
          The final payment order amount will be displayed in the <code>amount</code> field.
        </div></div>
      </details>

      <!-- feeAmount (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f feeAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">If the payment method used had a unique fee, it will be displayed in this field.</div></div>
      </details>

      <!-- discountAmount (level 1) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f discountAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">If the payment method used had a unique discount, it will be displayed in this field.</div></div>
      </details>

      <!-- tokens (array) level 1 + its children -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f tokens %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of tokens connected to the payment.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% f payment, 0 %}, <code>recurrence</code>, <code>transactionOnFile</code> or <code>unscheduled</code>. The different types of available tokens.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f token, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The token <code>guid</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the token. In the example, a masked version of a card number.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f expiryDate, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The expiry date of the token.</div></div>
          </details>
        </div>
      </details>

      <!-- details (object) level 1 + its children -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f details %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Details connected to the payment.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f nonPaymentToken, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The result of our own card tokenization. Activated in POS for the merchant or merchant group.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f externalNonPaymentToken, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">
              The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc.
              For Mass Transit merchants, transactions will be populated with the <code>paymentAccountReference</code>.
            </div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f paymentAccountReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">
              The result of an external tokenization. The value will vary depending on card types, acquirers, customers, etc.
              For Mass Transit merchants, the <code>paymentAccountReference</code> will also populate the externalNonPaymentToken field.
            </div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f cardType, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>Credit Card</code> or <code>Debit Card</code>. Indicates the type of card used for the authorization.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f maskedPan, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The masked PAN number of the card.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f maskedDPan, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">
              A masked version of a network token representing the card. It will only appear if the chosen payment method is tokenized and the card used is tokenized by Visa or MasterCard.
            </div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f expiryDate, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The month and year of when the card expires.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f issuerAuthorizationApprovalCode, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Payment reference code provided by the issuer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f acquirerTransactionType, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>3DSECURE</code> or <code>STANDARD</code>. Indicates the transaction type of the acquirer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f acquirerStan, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The System Trace Audit Number assigned by the acquirer to uniquely identify the transaction.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f acquirerTerminalId, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ID of the acquirer terminal.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f acquirerTransactionTime, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date and time of the acquirer transaction.</div></div>
          </details>

          <!-- corrected spelling -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f transactionInitiator, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The party which initiated the transaction. <code>MERCHANT</code> or <code>CARDHOLDER</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f bin, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The first six digits of the maskedPan.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f msisdn, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The msisdn used in the purchase. Only available when paid with Swish.</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>
