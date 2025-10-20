{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{%- capture documentation_section -%}{%- include utils/documentation-section.md -%}{%- endcapture -%}
{% assign operations_url = '/technical-reference/operations' | prepend: features_url %}
{% assign transaction = include.transaction | default: "capture" %}
{% if transaction == "cancel" %}
    {% assign plural = "cancellations" %}
{% else %}
    {% assign plural = transaction | append: "s" %}
{% endif %}

The `{{ transaction }}` resource contains information about the
`{{ transaction }}` transaction made against a {{ api_resource }} payment. You can
return a specific `{{ transaction }}` transaction by performing a `GET` request
towards the specific transaction's `id`.

## Transaction List Response

{% if documentation_section contains "checkout-v2" or "checkout-v3" or "payment-menu-v2" %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "paymentorder": "/psp/paymentorders/{{ page.payment_id }}",
    "{{ plural }}": { {% if api_resource == "invoice" %}
        "receiptReference": "AH12355", {% endif %}
        "id": "/psp/paymentorders/{{ page.payment_id }}/currentpayment",
        "{{ transaction }}List": [{
            "id": "/psp/paymentorders/{{ page.payment_id }}/currentpayment/{{ page.transaction_id }}",{% if api_resource == "swish" %}
            "swishPaymentReference": "8D0A30A7804E40479F88FFBA26111F04",
            "swishStatus": "PAID",{% endif %}{% if transaction == "authorization" %}
            "consumer": {
                    "id": "/psp/paymentorders/{{ page.payment_id }}/consumer"
                },
                "legalAddress": {
                    "id": "/psp/paymentorders/{{ page.payment_id }}/legaladdress"
                },
                "billingAddress": {
                    "id": "/psp/paymentorders/{{ page.payment_id }}/billingaddress"
                },{% endif %}
            "transaction": {
                "id": "/psp/paymentorders/{{ page.payment_id }}/currentpayment/{{ page.transaction_id }}",
                "created": "2016-09-14T01:01:01.01Z",
                "updated": "2016-09-14T01:01:01.03Z",
                "type": "{{ transaction | capitalize }}",
                "state": "Completed",
                "number": 1234567890,
                "amount": 1000,
                "vatAmount": 250,
                "description": "Test transaction",
                "payeeReference": "AH123456",
                "isOperational": false,
                "operations": [{% if transaction == "authorization" %}
                       {
                            "method": "POST",
                            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_id }}/authorizations",
                            "rel": "create-authorization",
                            "contentType": "application/json"
                        },
                        {
                            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_id }}",
                            "rel": "edit-authorization",
                            "method": "PATCH"
                        }
                {% endif %}]
            }
        }]
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
    "{{ plural }}": { {% if api_resource == "invoice" %}
        "receiptReference": "AH12355", {% endif %}
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/{{ plural }}",
        "{{ transaction }}List": [{
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/{{ plural }}/{{ page.transaction_id }}",{% if api_resource == "swish" %}
            "swishPaymentReference": "8D0A30A7804E40479F88FFBA26111F04",
            "swishStatus": "PAID",{% endif %}{% if transaction == "authorization" %}
            "consumer": {
                    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/consumer"
                },
                "legalAddress": {
                    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/legaladdress"
                },
                "billingAddress": {
                    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/billingaddress"
                },{% endif %}
            "transaction": {
                "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
                "created": "2016-09-14T01:01:01.01Z",
                "updated": "2016-09-14T01:01:01.03Z",
                "type": "{{ transaction | capitalize }}",
                "state": "Completed",
                "number": 1234567890,
                "amount": 1000,
                "vatAmount": 250,
                "description": "Test transaction",
                "payeeReference": "AH123456",
                "isOperational": false,
                "operations": [{% if transaction == "authorization" %}
                       {
                            "method": "POST",
                            "href": "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations",
                            "rel": "create-authorization",
                            "contentType": "application/json"
                        },
                        {
                            "href": "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
                            "rel": "edit-authorization",
                            "method": "PATCH"
                        }
                {% endif %}]
            }
        }]
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% endif %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Top-level link to payment/paymentOrder (conditional) -->
  {% if documentation_section contains "checkout" or "payment-menu" %}
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    {% capture id_md_checkout %}{% include fields/id.md %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ id_md_checkout | markdownify }}</div></div>
  </details>
  {% else %}
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    {% capture id_md_payment %}{% include fields/id.md sub_resource=plural %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ id_md_payment | markdownify }}</div></div>
  </details>
  {% endif %}

  <!-- {{ plural }} object (root sibling) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">`{{ plural }}`<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The current <code>{{ plural }}</code> resource.</div></div>

    <div class="api-children">
      <!-- id (child of {{ plural }}) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        {% capture id_md_plural %}{% include fields/id.md resource=plural %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ id_md_plural | markdownify }}</div></div>
      </details>

      <!-- {{ transaction }}List (array) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f {{ transaction }}List %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The array of {{ transaction }} transaction objects.</div></div>

        <div class="api-children">
          <!-- array item object -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f {{ transaction }}List[] %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>object</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The {{ transaction }} transaction object described in the <code>{{ transaction }}</code> resource below.</div></div>

            <div class="api-children">
              <!-- transaction.id -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                {% capture id_md_txn %}{% include fields/id.md resource="transaction" %}{% endcapture %}
                <div class="desc"><div class="indent-3">{{ id_md_txn | markdownify }}</div></div>
              </details>

              <!-- created -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f created, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The ISO-8601 date and time of when the transaction was created.</div></div>
              </details>

              <!-- updated -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f updated, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">The ISO-8601 date and time of when the transaction was updated.</div></div>
              </details>

              <!-- type -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                <div class="desc"><div class="indent-3">Indicates the transaction type.</div></div>
              </details>

              <!-- state -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f state, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                {% capture state_md %}{% include fields/state.md %}{% endcapture %}
                <div class="desc"><div class="indent-3">{{ state_md | markdownify }}</div></div>
              </details>

              <!-- number -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>integer</code></span>
                </summary>
                {% capture number_md %}{% include fields/number.md %}{% endcapture %}
                <div class="desc"><div class="indent-3">{{ number_md | markdownify }}</div></div>
              </details>

              <!-- amount -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>integer</code></span>
                </summary>
                {% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
                <div class="desc"><div class="indent-3">{{ amount_md | markdownify }}</div></div>
              </details>

              <!-- vatAmount -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>integer</code></span>
                </summary>
                {% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
                <div class="desc"><div class="indent-3">{{ vat_amount_md | markdownify }}</div></div>
              </details>

              <!-- description -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                {% capture description_md %}{% include fields/description.md %}{% endcapture %}
                <div class="desc"><div class="indent-3">{{ description_md | markdownify }}</div></div>
              </details>

              <!-- payeeReference -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string(30)</code></span>
                </summary>
                {% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}
                <div class="desc"><div class="indent-3">{{ payee_reference_md | markdownify }}</div></div>
              </details>

              <!-- receiptReference (only for invoice) -->
              {% if api_resource == "invoice" %}
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f receiptReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>string</code></span>
                </summary>
                {% capture receipt_reference_md %}{% include fields/receipt-reference.md %}{% endcapture %}
                <div class="desc"><div class="indent-3">{{ receipt_reference_md | markdownify }}</div></div>
              </details>
              {% endif %}

              <!-- isOperational -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f isOperational, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>bool</code></span>
                </summary>
                <div class="desc"><div class="indent-3"><code>true</code> if the transaction is operational; otherwise <code>false</code>.</div></div>
              </details>

              <!-- operations -->
              <details class="api-item" data-level="3">
                <summary>
                  <span class="field">{% f operations, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                  <span class="type"><code>array</code></span>
                </summary>
                {% capture operations_md %}{% include fields/operations.md resource="transaction" %}{% endcapture %}
                <div class="desc"><div class="indent-3">{{ operations_md | markdownify }}</div></div>
              </details>
            </div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>
