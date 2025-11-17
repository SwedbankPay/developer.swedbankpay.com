{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{%- capture operations_href -%}
    {%- if documentation_section == nil or documentation_section == empty -%}
        /checkout-v3/get-started/fundamental-principles#operations
    {%- else -%}
        {%- include utils/documentation-section-url.md href='/technical-reference/operations' -%}
    {%- endif -%}
{%- endcapture -%}
{% assign transaction = include.transaction | default: "capture" %}
{% assign mcom = include.mcom | default: false %}

{% if transaction == "cancel" %}
    {% assign plural = "cancellations" %}
{% else %}
    {% assign plural = transaction | append: "s" %}
{% endif %}

The created `{{ transaction }}` resource contains information about the
`{{ transaction }}` transaction made against a `{{ api_resource }}` payment.

## Capture Response

{% if documentation_section contains "checkout" or "payment-menu" %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=<PaymentOrderVersion>
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentorder": "/psp/paymentorders/{{ page.payment_id }}",
    "{{ transaction }}": {
        "id": "/psp/paymentorders/{{ page.payment_id }}/currentpayment/{{ page.transaction_id }}",{% if api_resource == "creditcard" %}
        "paymentToken": "{{ page.payment_token }}",
        "maskedPan": "123456xxxxxx1234",
        "expireDate": "mm/yyyy",
        "panToken": "{{ page.transaction_id }}",
        "cardBrand": "Visa",
        "cardType": "Credit Card",
        "issuingBank": "UTL MAESTRO",
        "countryCode": "999",
        "acquirerTransactionType": "3DSECURE",
        "acquirerStan": "39736",
        "acquirerTerminalId": "39",
        "acquirerTransactionTime": "2017-08-29T13:42:18Z",
        "authenticationStatus": "Y",{% endif %}
        "itemDescriptions": {
            "id": "/psp/paymentorders/{{ page.payment_id }}/currentpayment/{{ page.transaction_id }}/itemDescriptions"
        },
        "transaction": {
            "id": "/psp/paymentorders/{{ page.payment_id }}/currentpayment/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "{{ transaction | capitalize }}",
            "state": {% if transaction == "transaction" %}"Failed"{% else %}"Completed"{% endif %},
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "ABC123", {% if api_resource == "invoice" %}
            "receiptReference": "ABC123", {% endif %}
            "isOperational": false,
            "problem": {
                "type": "https://api.payex.com/psp/errordetail/{{ api_resource }}/3DSECUREERROR",
                "title": "Error when complete authorization",
                "status": 400,
                "detail": "Unable to complete 3DSecure verification!",
                "problems": [
                ] {% unless transaction == "transaction" %}
            "operations": [{% if api_resource == "swish" and mcom == true %}
                {
                    "href": "swish://paymentrequest?token=LhXrK84MSpWU2RO09f8kUP-FHiBo-1pB",
                    "method": "GET",
                    "rel": "redirect-app-swish"
                },{% endif %}
                {
                    "href": "/psp/paymentorders/{{ page.payment_id }}/currentpayment/{{ page.transaction_id }}",
                    "rel": "edit-{{ transaction }}",
                    "method": "PATCH"
                }
            ]{% endunless %}
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
    "{{ transaction }}": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/{{ plural }}/{{ page.transaction_id }}",{% if api_resource == "creditcard" %}
        "paymentToken": "{{ page.payment_token }}",
        "maskedPan": "123456xxxxxx1234",
        "expireDate": "mm/yyyy",
        "panToken": "{{ page.transaction_id }}",
        "cardBrand": "Visa",
        "cardType": "Credit Card",
        "issuingBank": "UTL MAESTRO",
        "countryCode": "999",
        "acquirerTransactionType": "3DSECURE",
        "acquirerStan": "39736",
        "acquirerTerminalId": "39",
        "acquirerTransactionTime": "2017-08-29T13:42:18Z",
        "authenticationStatus": "Y",{% endif %}
        "itemDescriptions": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}/itemDescriptions"
        },
        "transaction": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "{{ transaction | capitalize }}",
            "state": {% if transaction == "transaction" %}"Failed"{% else %}"Completed"{% endif %},
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "ABC123", {% if api_resource == "invoice" %}
            "receiptReference": "ABC123", {% endif %}
            "isOperational": false,
            "problem": {
                "type": "https://api.payex.com/psp/errordetail/{{ api_resource }}/3DSECUREERROR",
                "title": "Error when complete authorization",
                "status": 400,
                "detail": "Unable to complete 3DSecure verification!",
                "problems": [
                ] {% unless transaction == "transaction" %}
            "operations": [{% if api_resource == "swish" and mcom == true %}
                {
                    "href": "swish://paymentrequest?token=LhXrK84MSpWU2RO09f8kUP-FHiBo-1pB",
                    "method": "GET",
                    "rel": "redirect-app-swish"
                },{% endif %}
                {
                    "href": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
                    "rel": "edit-{{ transaction }}",
                    "method": "PATCH"
                }
            ]{% endunless %}
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% endif %}

<!-- Captures for markdown-includes -->
{%- capture id_generic_md -%}{% include fields/id.md %}{%- endcapture -%}
{%- capture id_sub_plural_md -%}{% include fields/id.md sub_resource=plural %}{%- endcapture -%}
{%- capture id_auth_md -%}{% include fields/id.md resource="authorization" %}{%- endcapture -%}
{%- capture id_itemdesc_md -%}{% include fields/id.md resource="itemDescriptions" %}{%- endcapture -%}
{%- capture transaction_md -%}{% include fields/transaction.md %}{%- endcapture -%}
{%- capture id_tx_md -%}{% include fields/id.md resource="transaction" %}{%- endcapture -%}
{%- capture state_md -%}{% include fields/state.md %}{%- endcapture -%}
{%- capture number_md -%}{% include fields/number.md %}{%- endcapture -%}
{%- capture amount_md -%}{% include fields/amount.md %}{%- endcapture -%}
{%- capture vat_amount_md -%}{% include fields/vat-amount.md %}{%- endcapture -%}
{%- capture description_md -%}{% include fields/description.md %}{%- endcapture -%}
{%- capture payee_ref_receipt_md -%}{% include fields/payee-reference.md describe_receipt=true %}{%- endcapture -%}
{%- capture receipt_ref_md -%}{% include fields/receipt-reference.md %}{%- endcapture -%}
{%- capture operations_tx_md -%}{% include fields/operations.md resource="transaction" %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0 (original order; all nodes CLOSED by default) -->
  {% if documentation_section contains "checkout" or "payment-menu" %}
    <!-- paymentOrder (string) -->
    <details class="api-item" data-level="0">
      <summary>
        <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-0">{{ id_generic_md | markdownify }}</div></div>
    </details>
  {% else %}
    <!-- payment (string) -->
    <details class="api-item" data-level="0">
      <summary>
        <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>string</code></span>
      </summary>
      <div class="desc"><div class="indent-0">{{ id_sub_plural_md | markdownify }}</div></div>
    </details>

    <!-- {{ plural }} (object) -->
    <details class="api-item" data-level="0">
      <summary>
        <span class="field"><code>{{ plural }}</code><i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
        <span class="type"><code>object</code></span>
      </summary>
      <div class="desc"><div class="indent-0">The current <code>{{ plural }}</code> resource.</div></div>
    </details>
  {% endif %}

  <!-- authorization (object) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f authorization, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The authorization object.</div></div>

    <div class="api-children">
      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_auth_md | markdownify }}</div></div>
      </details>

      <!-- itemDescriptions (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f itemDescriptions %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The object representation of the <code>itemDescriptions</code> resource.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ id_itemdesc_md | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <!-- transaction (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f transaction %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ transaction_md | markdownify }}</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ id_tx_md | markdownify }}</div></div>
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
            <div class="desc"><div class="indent-2">{{ state_md | markdownify }}</div></div>
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
              <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ description_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_ref_receipt_md | markdownify }}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f receiptReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ receipt_ref_md | markdownify }}</div></div>
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
            <div class="desc"><div class="indent-2">{{ operations_tx_md | markdownify }}</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>
