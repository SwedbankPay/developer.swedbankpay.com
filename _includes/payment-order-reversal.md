{% capture techref_url %}{% include utils/documentation-section-url.md href='/features/technical-reference' %}{% endcapture %}
{% assign transactions_url = '/transactions' | prepend: techref_url %}
{% assign operations_url = '/operations' | prepend: techref_url %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}

{% if documentation_section contains "checkout-v3" %}

## Reversal

This transaction is used when a `Capture` or `Sale` payment needs to be
reversed.

Please note that you have a maximum of 5 **consecutive** failed attempts at a
reversal. The payment will be locked after this, and you need to contact us for
another attempt.

## Create Reversal Transaction

If we want to reverse a previously captured amount, we need to perform
`reversal` against the accompanying `href` returned in the
`operations` list.

{% else %}

If we want to reverse a previously captured amount, we need to perform
`create-paymentorder-reversal` against the accompanying `href` returned in the
`operations` list.

{% endif %}

## Reversal Request

{% capture request_header %}POST /psp/paymentorders/{{ page.payment_order_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.0/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "description": "Reversal of captured transaction",
        "amount": 1500,
        "vatAmount": 375,
        "payeeReference": "ABC123",
        "receiptReference": "ABC122",
        "orderItems": [
            {
                "reference": "P1",
                "name": "Product1",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "itemUrl": "https://example.com/products/123",
                "imageUrl": "https://example.com/product123.jpg",
                "description": "Product 1 description",
                "discountDescription": "Volume discount",
                "quantity": 4,
                "quantityUnit": "pcs",
                "unitPrice": 300,
                "discountPrice": 200,
                "vatPercent": 2500,
                "amount": 1000,
                "vatAmount": 250
            },
            {
                "reference": "P2",
                "name": "Product2",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "description": "Product 2 description",
                "quantity": 1,
                "quantityUnit": "pcs",
                "unitPrice": 500,
                "vatPercent": 2500,
                "amount": 500,
                "vatAmount": 125
            }
        ]
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
      <span class="field">{% f transaction %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The transaction object.</div></div>

    <div class="api-children">
      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- payeeReference -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string(30)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ payee_reference_md | markdownify }}</div></div>
      </details>

      <!-- receiptReference (optional) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f receiptReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string(30)</code></span>
        </summary>
        {% capture receipt_reference_md %}{% include fields/receipt-reference.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ receipt_reference_md | markdownify }}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Textual description of why the transaction is reversed.</div></div>
      </details>

      <!-- orderItems (array of complex objects) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>array</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture order_items_md %}{% include fields/order-items.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ order_items_md | markdownify }}</div></div>

        <div class="api-children">
          <!-- reference -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f reference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">A reference that identifies the order item.</div></div>
          </details>

          <!-- name -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the order item.</div></div>
          </details>

          <!-- type -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>enum</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2"><code>PRODUCT</code>, <code>SERVICE</code>, <code>SHIPPING_FEE</code>, <code>PAYMENT_FEE</code>, <code>DISCOUNT</code>, <code>VALUE_CODE</code> or <code>OTHER</code>. The type of the order item.</div></div>
          </details>

          <!-- class -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f class, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The classification of the order item. Can be used for assigning the order item to a specific product category, such as <code>MobilePhone</code>. Note that <code>class</code> cannot contain spaces and must follow the regex pattern <code>[\w-]*</code>. Swedbank Pay may use this field for statistics.</div></div>
          </details>

          <!-- itemUrl (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f itemUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to a page that can display the purchased item, product or similar.</div></div>
          </details>

          <!-- imageUrl (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f imageUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to an image of the order item.</div></div>
          </details>

          <!-- description (per-item, optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the order item.</div></div>
          </details>

          <!-- discountDescription (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountDescription, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the possible discount.</div></div>
          </details>

          <!-- quantity -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f quantity, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>number</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The 4 decimal precision quantity of order items being purchased.</div></div>
          </details>

          <!-- quantityUnit -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f quantityUnit, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The unit of the quantity, such as <code>pcs</code>, <code>grams</code>, or similar. This is used for your own book keeping.</div></div>
          </details>

          <!-- unitPrice -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f unitPrice, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The price per unit of order item, including VAT.</div></div>
          </details>

          <!-- discountPrice (optional) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountPrice, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If the order item is purchased at a discounted price. This field should contain that price, including VAT.</div></div>
          </details>

          <!-- vatPercent -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatPercent, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The percent value of the VAT multiplied by 100, so <code>25%</code> becomes <code>2500</code>.</div></div>
          </details>

          <!-- amount -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. <code>10000</code> equals <code>100.00 SEK</code> and <code>5000</code> equals <code>50.00 SEK</code>.</div></div>
          </details>

          <!-- vatAmount -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
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

## Reversal Response

If the reversal request succeeds, the response should be similar to the example below:

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.0/2.0
api-supported-versions: 3.0/2.0{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/creditcard/payments/{{ page.payment_order_id }}",
    "reversal": {
        "id": "/psp/creditcard/payments/{{ page.payment_order_id }}/reversals/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/pcreditcard/payments/{{ page.payment_order_id }}/transactions/{{ page.transaction_id }}",
            "created": "2022-01-26T14:00:03.4725904Z",
            "updated": "2022-01-26T14:00:04.3851302Z",
            "type": "Reversal",
            "state": "Completed",
            "number": 71100730898,
            "amount": 1500,
            "vatAmount": 375,
            "description": "Reversing the capture amount",
            "payeeReference": "ABC123",
            "receiptReference": "ABC122"
            "isOperational": false,
            "reconciliationNumber": 738180,
            "operations": []
        }
    }
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

  <!-- payment (root) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The relative URL of the payment this reversal transaction belongs to.</div></div>
  </details>

  <!-- reversals (root) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f reversals, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The reversal object, containing information about the reversal transaction.</div></div>

    <div class="api-children">
      <!-- id (child of reversals) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The relative URL of the reversal transaction.</div></div>
      </details>

      <!-- transaction (child of reversals) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f transaction %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        {% capture transaction_md %}{% include fields/transaction.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ transaction_md | markdownify }}</div></div>

        <div class="api-children">
          <!-- transaction.id -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The relative URL of the current <code>transaction</code> resource.</div></div>
          </details>

          <!-- transaction.created -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f created, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date and time of when the transaction was created.</div></div>
          </details>

          <!-- transaction.updated -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f updated, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date and time of when the transaction was updated.</div></div>
          </details>

          <!-- transaction.type -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the transaction type.</div></div>
          </details>

          <!-- transaction.state -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f state, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            {% capture state_md %}{% include fields/state.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ state_md | markdownify }}</div></div>
          </details>

          <!-- transaction.number -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            {% capture number_md %}{% include fields/number.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ number_md | markdownify }}</div></div>
          </details>

          <!-- transaction.amount -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            {% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ amount_md | markdownify }}</div></div>
          </details>

          <!-- transaction.vatAmount -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            {% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ vat_amount_md | markdownify }}</div></div>
          </details>

          <!-- transaction.description -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A human readable description of maximum 40 characters of the transaction.</div></div>
          </details>

          <!-- transaction.payeeReference -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            {% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ payee_reference_md | markdownify }}</div></div>
          </details>

          <!-- transaction.receiptReference (note: no ", 2" in source; placed as level 2 under transaction per context) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f receiptReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            {% capture receipt_reference_md %}{% include fields/receipt-reference.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ receipt_reference_md | markdownify }}</div></div>
          </details>

          <!-- transaction.isOperational -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f isOperational, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>boolean</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>true</code>  if the transaction is operational; otherwise  <code>false</code>.</div></div>
          </details>

          <!-- transaction.reconciliationNumber -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f reconciliationNumber, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The number of the reconciliation batch file where the transaction can be found.</div></div>
          </details>

          <!-- transaction.operations -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f operations, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
              <span class="type"><code>array</code></span>
            </summary>
            {% capture operations_md %}{% include fields/operations.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ operations_md | markdownify }}</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>
