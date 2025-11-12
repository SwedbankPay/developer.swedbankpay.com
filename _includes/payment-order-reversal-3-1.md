{% capture techref_url %}{% include utils/documentation-section-url.md href='/features/technical-reference' %}{% endcapture %}
{% assign transactions_url = '/transactions' | prepend: techref_url %}
{% assign operations_url = '/operations' | prepend: techref_url %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}

{% if documentation_section contains "checkout-v3" %}

## Reversal v3.1

This transaction is used when a `Capture` or `Sale` payment needs to be
reversed.

Please note that you have a maximum of 5 **consecutive** failed attempts at a
reversal. The payment will be locked after this, and you need to contact us for
another attempt.

If the full amount of a sale transaction or a captured transaction is reversed,
The transaction will now have status `Reversed` instead of `Paid`.

## Create Reversal Transaction

If we want to reverse a previously captured amount, we need to perform
`reversal` against the accompanying `href` returned in the
`operations` list.

{% else %}

If we want to reverse a previously captured amount, we need to perform
`create-paymentorder-reversal` against the accompanying `href` returned in the
`operations` list.

{% endif %}

## Reversal Request v3.1

{% capture request_header %}POST /psp/paymentorders/{{ page.payment_order_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.1{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "description": "Reversal of captured transaction",
        "amount": 1500,
        "vatAmount": 375,
        "payeeReference": "ABC123"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- transaction (root) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f transaction %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The transaction object.</div></div>

    <div class="api-children">
      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- payeeReference -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(30)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ payee_reference_md | markdownify }}</div></div>
      </details>

      <!-- receiptReference (optional) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f receiptReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(30)</code></span>
        </summary>
        {% capture receipt_reference_md %}{% include fields/receipt-reference.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ receipt_reference_md | markdownify }}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Textual description of why the transaction is reversed.</div></div>
      </details>

      <!-- orderItems (array of complex objects) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture order_items_md %}{% include fields/order-items.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ order_items_md | markdownify }}</div></div>

        <div class="api-children">
          <!-- per-item fields (level 2) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f reference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">A reference that identifies the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>enum</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2"><code>PRODUCT</code>, <code>SERVICE</code>, <code>SHIPPING_FEE</code>, <code>PAYMENT_FEE</code>, <code>DISCOUNT</code>, <code>VALUE_CODE</code> or <code>OTHER</code>. The type of the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f class, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The classification of the order item. Can be used for assigning the order item to a specific product category, such as <code>MobilePhone</code>. Note that <code>class</code> cannot contain spaces and must follow the regex pattern <code>[\w-]*</code>. Swedbank Pay may use this field for statistics.</div></div>
          </details>

          <!-- Optional per-item fields -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f itemUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to a page that can display the purchased item, product or similar.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f imageUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to an image of the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the order item.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountDescription, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the possible discount.</div></div>
          </details>

          <!-- Required numeric per-item fields -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f quantity, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>number</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The 4 decimal precision quantity of order items being purchased.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f quantityUnit, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The unit of the quantity, such as <code>pcs</code>, <code>grams</code>, or similar. This is used for your own book keeping.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f unitPrice, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The price per unit of order item, including VAT.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountPrice, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If the order item is purchased at a discounted price. This field should contain that price, including VAT.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatPercent, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The percent value of the VAT multiplied by 100, so <code>25%</code> becomes <code>2500</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. <code>10000</code> equals <code>100.00 SEK</code> and <code>5000</code> equals <code>50.00 SEK</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The total amount of VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. <code>10000</code> equals <code>100.00 SEK</code> and <code>5000</code> equals <code>50.00 SEK</code>.</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

## Reversal Response v3.1

If the reversal request succeeds, the response should be similar to the example below:

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.1
api-supported-versions: 3.1{% endcapture %}

{% capture response_content %}{
  "paymentOrder": {
    "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d",
    "created": "2020-03-03T07:19:27.5636519Z",
    "updated": "2020-03-03T07:21:00.5605905Z",
    "operation": "Purchase",
    "status": "Reversed",
    "currency": "SEK",
    "amount": 1500,
    "vatAmount": 375,
    "remainingCaptureAmount": 0, // Only present after a partial reversal
    "remainingReversalAmount": 0, // Only present after a partial reversal
    "description": "Test Purchase",
    "initiatingSystemUserAgent": "<should be set by the system calling POST:/psp/paymentorders>",
    "language": "sv-SE",
    "availableInstruments": [ "CreditCard", "Invoice-PayExFinancingSe", "Invoice-PayMonthlyInvoiceSe", "Swish", "CreditAccount", "Trustly" ],
    "implementation": "PaymentsOnly",
    "integration": "HostedView|Redirect",
    "instrumentMode": true,
    "guestMode": true,
    "orderItems": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/orderitems"
    },
    "urls": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/urls"
    },
    "payeeInfo": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payeeInfo"
    },
    "payer": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payers"
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
    "postPurchaseFailedAttempts": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/postpurchasefailedattempts"
    },
    "metadata": {
      "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/metadata"
    }
  },
  "operations": [
  ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- paymentOrder -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The relative URL of the payment order this capture transaction belongs to.</div></div>
  </details>

  <!-- id -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The relative URL of the created capture transaction.</div></div>
  </details>

  <!-- created -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f created %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>date(string)</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The ISO 8601 date and time of when the transaction was created. Written in the format YYYY-MM-DDTHH:MM:SSZ, where Z indicates UTC.</div></div>
  </details>

  <!-- updated -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f updated %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>date(string)</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The ISO 8601 date and time of when the transaction was updated. Written in the format YYYY-MM-DDTHH:MM:SSZ, where Z indicates UTC.</div></div>
  </details>

  <!-- operation -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f operation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    {% capture operation_md %}{% include fields/operation.md %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ operation_md | markdownify }}</div></div>
  </details>

  <!-- status -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f status %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    {% capture status_md %}{% include fields/status.md %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ status_md | markdownify }}</div></div>
  </details>

  <!-- currency -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f currency %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>enum(string)</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The currency of the payment order in the ISO 4217 format (e.g. <code>DKK</code>, <code>EUR</code>, <code>NOK</code> or <code>SEK</code>). Some payment methods are only available with selected currencies.</div></div>
  </details>

  <!-- amount -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>integer</code></span>
    </summary>
    {% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ amount_md | markdownify }}</div></div>
  </details>

  <!-- vatAmount -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f vatAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>integer</code></span>
    </summary>
    {% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ vat_amount_md | markdownify }}</div></div>
  </details>

  <!-- remainingCaptureAmount -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f remainingCaptureAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>integer</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The remaining authorized amount that is still possible to capture. Only present after a partial reversal.</div></div>
  </details>

  <!-- remainingCancellationAmount -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f remainingCancellationAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>integer</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The remaining authorized amount that is still possible to cancel. Only present after a partial reversal.</div></div>
  </details>

  <!-- remainingReversalAmount -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f remainingReversalAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>integer</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The remaining captured amount that is still available for reversal. This field will not appear in the initial response if the payment method used was Swish. It will first appear if and when you do a GET on the payment.</div></div>
  </details>

  <!-- description -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    {% capture description_md %}{% include fields/description.md %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ description_md | markdownify }}</div></div>
  </details>

  <!-- initiatingSystemUserAgent -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f initiatingSystemUserAgent %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    {% capture isua_md %}{% include fields/initiating-system-user-agent.md %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ isua_md | markdownify }}</div></div>
  </details>

  <!-- language -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f language %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>enum(string)</code></span>
    </summary>
    {% capture language_md %}{% include fields/language.md %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ language_md | markdownify }}</div></div>
  </details>

  <!-- availableInstruments -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f availableInstruments %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">A list of payment methods available for this payment.</div></div>
  </details>

  <!-- implementation -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f implementation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The merchant's Online Payments implementation type. <code>Enterprise</code> or <code>PaymentsOnly</code>. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.</div></div>
  </details>

  <!-- integration -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f integration %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The merchant's Online Payments integration type. <code>HostedView</code> (Seamless View) or <code>Redirect</code>. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.</div></div>
  </details>

  <!-- instrumentMode -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f instrumentMode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>bool</code></span>
    </summary>
    <div class="desc"><div class="indent-0">Set to <code>true</code> or <code>false</code>. Indicates if the payment is initialized with only one payment method available.</div></div>
  </details>

  <!-- guestMode -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f guestMode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>bool</code></span>
    </summary>
    <div class="desc"><div class="indent-0">Set to <code>true</code> or <code>false</code>. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a <code>payerReference</code> in the original <code>paymentOrder</code> request.</div></div>
  </details>

  <!-- id resources -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f orderItems %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>id</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URL to the <code>orderItems</code> resource where information about the order items can be retrieved.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f urls %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>id</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URL to the <code>urls</code> resource where all URLs related to the payment order can be retrieved.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payeeInfo %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>id</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URL to the <code>payeeInfo</code> resource where information related to the payee can be retrieved.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payer %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>id</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URL to the <code>payer</code> resource where information about the payer can be retrieved.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f history %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>id</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URL to the <code>history</code> resource where information about the payment's history can be retrieved.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f failed %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>id</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URL to the <code>failed</code> resource where information about the failed transactions can be retrieved.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f aborted %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>id</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URL to the <code>aborted</code> resource where information about the aborted transactions can be retrieved.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paid %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>id</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URL to the <code>paid</code> resource where information about the paid transactions can be retrieved.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f cancelled %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>id</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URL to the <code>cancelled</code> resource where information about the cancelled transactions can be retrieved.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f financialTransactions %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>id</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URL to the <code>financialTransactions</code> resource where information about the financial transactions can be retrieved.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f failedAttempts %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>id</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URL to the <code>failedAttempts</code> resource where information about the failed attempts can be retrieved.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f postPurchaseFailedAttempts %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>id</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URL to the <code>postPurchaseFailedAttempts</code> resource where information about the failed capture, cancel or reversal attempts can be retrieved.</div></div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f metadata %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>id</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The URL to the <code>metadata</code> resource where information about the metadata can be retrieved.</div></div>
  </details>

  <!-- operations -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f operations %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>array</code></span>
    </summary>
    {% capture operations_md %}{% include fields/operations.md %}{% endcapture %}
    <div class="desc"><div class="indent-0">{{ operations_md | markdownify }}</div></div>
  </details>
</div>
