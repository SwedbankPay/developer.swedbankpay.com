{% include alert.html type="informative" icon="info" body="If you hesitate which version to use, we recommend the version marked with *." %}

{: .h2 }

### Payment order v3.0

<div class="slab mb-5">
  <ul class="toc-list" role="navigation" aria-label="Article content">
    <li>
      <a href="#capture-v30">
        Capture
      </a>
      <ul>
        <li>
          <a href="#capture-request-v30">
            Capture Request
          </a>
        </li>
        <li>
          <a href="#capture-response-v30">
            Capture Response
          </a>
        </li>
        <li>
        <a href="#capture-sequence-diagram-v30">
            Capture Sequence Diagram
        </a>
        </li>
      </ul>
    </li>
    <li>
      <a href="#cancel-v30">
        Cancel
      </a>
      <ul>
        <li>
          <a href="#cancel-request-v30">
          Cancel Request
        </a>
        </li>
        <li>
          <a href="#cancel-response-v30">
          Cancel Response
          </a>
        </li>
        <li>
        <a href="#cancel-sequence-diagram-v30">
          Cancel Sequence Diagram
        </a>
        </li>
      </ul>
    </li>
    <li>
      <a href="#reversal-v30">
        Reversal
      </a>
      <ul>
        <li>
          <a href="#reversal-request-v30">
          Reversal Request
          </a>
        </li>
        <li>
          <a href="#reversal-response-v30">
          Reversal Response
          </a>
        </li>
      </ul>
    </li>
  </ul>
</div>

{% include alert-two-phase-payments.md %}

{% include alert.html type="informative" icon="info" header="When something goes
wrong" body="When something fails during a post-purchase operation, you will get
an error message in the response in the form of a problem `json`." %}

See examples of the `jsons` in the [problems section][problems].

{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

{: .h2 }

### Capture v3.0

Captures are only possible when a payment has a successful `Authorization`
transaction, naturally excluding one-phase payment methods like Swish and
Trustly. They will be marked as a `Sale` transaction. Two-phase payment methods
like card and Vipps however, require a `Capture` to be completed.

Please note that you have a maximum of 5 **consecutive** failed attempts at a
capture. The payment will be locked after the fifth, and you need to contact us
for further attempts.

In addition to full captures, it is possible to do partial captures of the
authorized amount. You can do more captures on the same payment later, up to the
total authorized amount. A useful tool for when you have to split orders into
several shipments.

First off, you must request the order information from the server to get the
request link. With this, you can request the capture with the amount to capture,
and get the status back.

To capture the authorized payment, we need to perform `capture` against the
accompanying `href` returned in the `operations` list. See the abbreviated
request and response below:

{: .text-right}
[Top of page](#payment-order-v30)

{: .h3 }

#### Capture Request v3.0

{% capture request_header %}POST /psp/paymentorders/{{ page.payment_order_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.0    // Version optional, can be set in `productName`{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "description": "Capturing the authorized payment",
        "amount": 1500,
        "vatAmount": 375,
        "payeeReference": "AB832",
        "receiptReference": "AB831",
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

{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}
{% capture receipt_reference_md %}{% include fields/receipt-reference.md %}{% endcapture %}
{% capture order_items_md %}{% include fields/order-items.md %}{% endcapture %}

<div class="api-compact" role="table" aria-label="Request">
  <div class="header" role="row">
    <div role="columnheader">Field</div>
    <div role="columnheader">Type</div>
    <div role="columnheader">Required</div>
  </div>

  <!-- Root: transaction (level 0) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f transaction, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The transaction object.</div></div>

    <div class="api-children">
      <!-- description -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f description, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The description of the capture transaction.</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f amount, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f vatAmount, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- payeeReference -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f payeeReference, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string(30)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payee_reference_md | markdownify }}</div></div>
      </details>

      <!-- receiptReference (optional) -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f receiptReference, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string(30)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ receipt_reference_md | markdownify }}</div></div>
      </details>

      <!-- orderItems -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f orderItems, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>array</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ order_items_md | markdownify }}</div></div>

        <!-- Children of orderItems (level 2) -->
        <div class="api-children">
          <!-- reference -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f reference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">A reference that identifies the order item.</div></div>
          </details>

          <!-- name -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f name, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the order item.</div></div>
          </details>

          <!-- type -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f type, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>enum</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2"><code>PRODUCT</code>, <code>SERVICE</code>, <code>SHIPPING_FEE</code>, <code>PAYMENT_FEE</code>, <code>DISCOUNT</code>, <code>VALUE_CODE</code> or <code>OTHER</code>. The type of the order item.</div></div>
          </details>

          <!-- class -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f class, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The classification of the order item. Can be used for assigning the order item to a specific product category, such as <code>MobilePhone</code>. Note that <code>class</code> cannot contain spaces and must follow the regex pattern <code>[\w-]*</code>. Swedbank Pay may use this field for statistics.</div></div>
          </details>

          <!-- itemUrl (optional) -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f itemUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to a page that can display the purchased item, product or similar.</div></div>
          </details>

          <!-- imageUrl (optional) -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f imageUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to an image of the order item.</div></div>
          </details>

          <!-- description (optional) -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f description, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the order item.</div></div>
          </details>

          <!-- discountDescription (optional) -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f discountDescription, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the possible discount.</div></div>
          </details>

          <!-- quantity -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f quantity, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>number</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The 4 decimal precision quantity of order items being purchased.</div></div>
          </details>

          <!-- quantityUnit -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f quantityUnit, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The unit of the quantity, such as <code>pcs</code>, <code>grams</code>, or similar. This is used for your own book keeping.</div></div>
          </details>

          <!-- unitPrice -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f unitPrice, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The price per unit of order item, including VAT.</div></div>
          </details>

          <!-- discountPrice (optional) -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f discountPrice, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If the order item is purchased at a discounted price. This field should contain that price, including VAT.</div></div>
          </details>

          <!-- vatPercent -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f vatPercent, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The percent value of the VAT multiplied by 100, so <code>25%</code> becomes <code>2500</code>.</div></div>
          </details>

          <!-- amount (per item) -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f amount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. <code>10000</code> equals <code>100.00 SEK</code> and <code>5000</code> equals <code>50.00 SEK</code>.</div></div>
          </details>

          <!-- vatAmount (per item) -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f vatAmount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
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

{: .text-right .mt-3}

[Top of page](#payment-order-v30)

{: .h3 }

#### Capture Response v3.0

If the capture request succeeds, this should be the response:

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.0
api-supported-versions: 3.0{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/creditcard/payments/{{ page.payment_id }}",
    "capture": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}/captures/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2020-06-22T10:56:56.2927632Z",
            "updated": "2020-06-22T10:56:56.4035291Z",
            "type": "Capture",
            "state": "Completed",
            "amount": 1500,
            "vatAmount": 375,
            "description": "Capturing the authorized payment",
            "payeeReference": "AB832",
            "receiptReference": "AB831"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture transaction_md %}{% include fields/transaction.md %}{% endcapture %}
{% capture state_md %}{% include fields/state.md %}{% endcapture %}
{% capture number_md %}{% include fields/number.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture description_md %}{% include fields/description.md %}{% endcapture %}
{% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}

<div class="api-compact" role="table" aria-label="Response">
  <div class="header" role="row">
    <div role="columnheader">Field</div>
    <div role="columnheader">Type</div>
  </div>

  <!-- Root: payment (level 0) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f payment, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The relative URL of the payment this capture transaction belongs to.</div></div>
  </details>

  <!-- Root: capture (level 0) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f capture, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The capture object, containing the information about the capture transaction.</div></div>

    <!-- Children of capture (level 1) -->
    <div class="api-children">
      <!-- capture.id -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f id, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The relative URL of the created capture transaction.</div></div>
      </details>

      <!-- capture.transaction -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f transaction, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ transaction_md | markdownify }}</div></div>

        <!-- Children of capture.transaction (level 2) -->
        <div class="api-children">
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f id, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The relative URL of the current <code>transaction</code> resource.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f created, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date and time of when the transaction was created.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f updated, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date and time of when the transaction was updated.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f type, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the transaction type.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f state, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ state_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f number, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ number_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f amount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ amount_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f vatAmount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ vat_amount_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f description, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ description_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f payeeReference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_reference_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f receiptReference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. It is used to supplement <code>payeeReference</code> as an additional receipt number.</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

{: .text-right .mt-3}
[Top of page](#payment-order-v30)

{: .h3 }

#### Capture Sequence Diagram v3.0

```mermaid
sequenceDiagram
    participant Merchant
    participant SwedbankPay as Swedbank Pay

    rect rgba(81,43,43,0.1)
        activate Merchant
        note left of Payer: Capture
        Merchant ->>+ SwedbankPay: rel:capture
        deactivate Merchant
        SwedbankPay -->>- Merchant: Capture status
        note right of Merchant: Capture here only if the purchased<br/>goods don't require shipping.<br/>If shipping is required, perform capture<br/>after the goods have shipped.<br>Should only be used for <br>payment methods that support <br>Authorizations.
    end
```

The purchase should now be complete. But what if the purchase is cancelled or

the payer wants to return goods? For these instances, we have `cancel` and
`reversal`.

{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}

{: .text-right}
[Top of page](#payment-order-v30)

{: .h2 }

### Cancel v3.0

The `cancellations` resource lists the cancellation transactions on a

specific payment.

{% if documentation_section contains "checkout-v3" %}

To cancel a previously created payment, you must perform the `cancel` operation
against the accompanying `href` returned in the `operations` list. You can only
cancel a payment - or part of a payment - which has not been captured yet. There
must be funds left that are only authorized. If you cancel before any capture
has been done, no captures can be performed later.

{% else %}

To cancel a previously created payment, you must perform the
`create-paymentorder-cancel` operation against the accompanying `href` returned
in the `operations` list. You can only cancel a payment - or part of a payment -
which has not been captured yet. If you cancel before any capture has been done,
no captures can be performed later.

{% endif %}

{: .text-right}
[Top of page](#payment-order-v30)

{: .h3 }

#### Cancel Request v3.0

{% capture request_header %}POST /psp/paymentorders/{{ page.payment_order_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.0     // Version optional, can be set in `productName`{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "description": "Test Cancellation",
        "payeeReference": "ABC123"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture payee_reference_md %}{% include fields/payee-reference.md %}{% endcapture %}

<div class="api-compact" role="table" aria-label="Request">
  <div class="header" role="row">
    <div role="columnheader">Field</div>
    <div role="columnheader">Type</div>
    <div role="columnheader">Required</div>
  </div>

  <!-- Root: transaction -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f transaction, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The transaction object.</div></div>

    <div class="api-children">
      <!-- description -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f description, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">A textual description of why the transaction is cancelled.</div></div>
      </details>

      <!-- payeeReference -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f payeeReference, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string(30)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payee_reference_md | markdownify }}</div></div>
      </details>
    </div>
  </details>
</div>

{: .text-right .mt-3}
[Top of page](#payment-order-v30)

{: .h3 }

#### Cancel Response v3.0

If the cancel request succeeds, the response should be similar to the
example below:

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.0
api-supported-versions: 3.0{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/creditcard/payments/{{ page.payment_id }}",
    "cancellation": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}/cancellations/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
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

{% capture transaction_md %}{% include fields/transaction.md %}{% endcapture %}
{% capture number_md %}{% include fields/number.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}

<div class="api-compact" role="table" aria-label="Response">
  <div class="header" role="row">
    <div role="columnheader">Field</div>
    <div role="columnheader">Type</div>
  </div>

  <!-- Root: payment (level 0) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f payment, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The relative URL of the payment this cancellation transaction belongs to.</div></div>
  </details>

  <!-- Root: cancellation (level 0) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f cancellation, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The cancellation object, containing information about the cancellation transaction.</div></div>

    <div class="api-children">
      <!-- cancellation.id (level 1) -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f id, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The relative URL of the cancellation transaction.</div></div>
      </details>

      <!-- cancellation.transaction (level 1) -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f transaction, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ transaction_md | markdownify }}</div></div>

        <!-- Children of cancellation.transaction (level 2) -->
        <div class="api-children">
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f id, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The relative URL of the current <code>transaction</code> resource.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f created, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date and time of when the transaction was created.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f updated, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date and time of when the transaction was updated.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f type, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the transaction type.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f state, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>Initialized</code>, <code>Completed</code> or <code>Failed</code>. Indicates the state of the transaction.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f number, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ number_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f amount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ amount_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f vatAmount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ vat_amount_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f description, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A human readable description of maximum 40 characters of the transaction.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f payeeReference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_reference_md | markdownify }}</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

{: .text-right .mt-3}
[Top of page](#payment-order-v30)

{: .h3 }

#### Cancel Sequence Diagram v3.0

Cancel can only be done on an authorized transaction. As a cancellation does not
have an amount associated with it, it will release the entire reserved amount.
If your intention is to make detailed handling, such as only capturing a partial
amount of the transaction, you must start with the capture of the desired amount
before performing a cancel for the remaining reserved funds.

```mermaid
sequenceDiagram
    participant SwedbankPay as Swedbank Pay


    Merchant->>SwedbankPay: POST < {{ include.api_resource }} cancellation>
    activate Merchant
    activate SwedbankPay
    SwedbankPay-->>Merchant: transaction resource
    deactivate SwedbankPay
    deactivate Merchant
```

{% capture techref_url %}{% include utils/documentation-section-url.md href='/features/technical-reference' %}{% endcapture %}

{% assign transactions_url = '/transactions' | prepend: techref_url %}
{% assign operations_url = '/operations' | prepend: techref_url %}

{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}

{: .text-right}
[Top of page](#payment-order-v30)

{: .h2 }

### Reversal v3.0

This transaction is used when a `Capture` or `Sale` payment needs to be
reversed.

Please note that you have a maximum of 5 **consecutive** failed attempts at a
reversal. The payment will be locked after this, and you need to contact us for
another attempt.

If we want to reverse a previously captured amount, we need to perform
`reversal` against the accompanying `href` returned in the
`operations` list.

{: .text-right}
[Top of page](#payment-order-v30)

{: .h3 }

#### Reversal Request v3.0

{% capture request_header %}POST /psp/paymentorders/{{ page.payment_order_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.0     // Version optional, can be set in `productName`{% endcapture %}

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

{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}
{% capture receipt_reference_md %}{% include fields/receipt-reference.md %}{% endcapture %}
{% capture order_items_md %}{% include fields/order-items.md %}{% endcapture %}

<div class="api-compact" role="table" aria-label="Request">
  <div class="header" role="row">
    <div role="columnheader">Field</div>
    <div role="columnheader">Type</div>
    <div role="columnheader">Required</div>
  </div>

  <!-- Root: transaction -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f transaction, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The transaction object.</div></div>

    <div class="api-children">
      <!-- amount -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f amount, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f vatAmount, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <!-- payeeReference -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f payeeReference, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string(30)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payee_reference_md | markdownify }}</div></div>
      </details>

      <!-- receiptReference (optional) -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f receiptReference, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string(30)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ receipt_reference_md | markdownify }}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f description, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">Textual description of why the transaction is reversed.</div></div>
      </details>

      <!-- orderItems -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f orderItems, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>array</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ order_items_md | markdownify }}</div></div>

        <div class="api-children">
          <!-- reference -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f reference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">A reference that identifies the order item.</div></div>
          </details>

          <!-- name -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f name, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the order item.</div></div>
          </details>

          <!-- type -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f type, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>enum</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2"><code>PRODUCT</code>, <code>SERVICE</code>, <code>SHIPPING_FEE</code>, <code>PAYMENT_FEE</code>, <code>DISCOUNT</code>, <code>VALUE_CODE</code> or <code>OTHER</code>. The type of the order item.</div></div>
          </details>

          <!-- class -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f class, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The classification of the order item. Can be used for assigning the order item to a specific product category, such as <code>MobilePhone</code>. Note that <code>class</code> cannot contain spaces and must follow the regex pattern <code>[\\w-]*</code>. Swedbank Pay may use this field for statistics.</div></div>
          </details>

          <!-- itemUrl (optional) -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f itemUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to a page that can display the purchased item, product or similar.</div></div>
          </details>

          <!-- imageUrl (optional) -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f imageUrl, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to an image of the order item.</div></div>
          </details>

          <!-- description (optional) -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f description, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the order item.</div></div>
          </details>

          <!-- discountDescription (optional) -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f discountDescription, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the possible discount.</div></div>
          </details>

          <!-- quantity -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f quantity, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>number</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The 4 decimal precision quantity of order items being purchased.</div></div>
          </details>

          <!-- quantityUnit -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f quantityUnit, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The unit of the quantity, such as <code>pcs</code>, <code>grams</code>, or similar. This is used for your own book keeping.</div></div>
          </details>

          <!-- unitPrice -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f unitPrice, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The price per unit of order item, including VAT.</div></div>
          </details>

          <!-- discountPrice (optional) -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f discountPrice, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If the order item is purchased at a discounted price. This field should contain that price, including VAT.</div></div>
          </details>

          <!-- vatPercent -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f vatPercent, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The percent value of the VAT multiplied by 100, so <code>25%</code> becomes <code>2500</code>.</div></div>
          </details>

          <!-- amount (per item) -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f amount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. <code>10000</code> equals <code>100.00 SEK</code> and <code>5000</code> equals <code>50.00 SEK</code>.</div></div>
          </details>

          <!-- vatAmount (per item) -->
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f vatAmount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
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

{: .text-right .mt-3}
[Top of page](#payment-order-v30)

{: .h3 }

#### Reversal Response v3.0

If the reversal request succeeds, the response should be similar to the example below:

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.0
api-supported-versions: 3.0{% endcapture %}

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

{% capture transaction_md %}{% include fields/transaction.md %}{% endcapture %}
{% capture state_md %}{% include fields/state.md %}{% endcapture %}
{% capture number_md %}{% include fields/number.md %}{% endcapture %}
{% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
{% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
{% capture payee_reference_md %}{% include fields/payee-reference.md describe_receipt=true %}{% endcapture %}
{% capture receipt_reference_md %}{% include fields/receipt-reference.md %}{% endcapture %}
{% capture operations_md %}{% include fields/operations.md %}{% endcapture %}

<div class="api-compact" role="table" aria-label="Response">
  <div class="header" role="row">
    <div role="columnheader">Field</div>
    <div role="columnheader">Type</div>
  </div>

  <!-- Root: payment (level 0) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f payment, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The relative URL of the payment this reversal transaction belongs to.</div></div>
  </details>

  <!-- Root: reversals (level 0) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f reversals, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The reversal object, containing information about the reversal transaction.</div></div>

    <div class="api-children">
      <!-- reversals.id (level 1) -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f id, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The relative URL of the reversal transaction.</div></div>
      </details>

      <!-- reversals.transaction (level 1) -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f transaction, 1 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ transaction_md | markdownify }}</div></div>

        <!-- Children of reversals.transaction (level 2) -->
        <div class="api-children">
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f id, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The relative URL of the current <code>transaction</code> resource.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f created, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date and time of when the transaction was created.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f updated, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The ISO-8601 date and time of when the transaction was updated.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f type, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the transaction type.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f state, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ state_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f number, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ number_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f amount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ amount_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f vatAmount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ vat_amount_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f description, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">A human readable description of maximum 40 characters of the transaction.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f payeeReference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ payee_reference_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f receiptReference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ receipt_reference_md | markdownify }}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f isOperational, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>boolean</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>true</code> if the transaction is operational; otherwise <code>false</code>.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f reconciliationNumber, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The number of the reconciliation batch file where the transaction can be found.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f operations, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>array</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{{ operations_md | markdownify }}</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

### Done With The Basics

You have reached the final step of the basic payment implementation and should
be able to validate that everything works as intended, or maybe it's time for
[acceptance tests][acceptance-test]?

Some of our payment methods require a few additional steps before they can
be activated and become available in your payment UI. Read more about them
and what you need to do by clicking the cards below.

There are other features and capabilities you can add to tailor the payment
requests in order to meet your business needs. See what else we can offer by
clicking **Additional Request Options**.

{% include card-list.html card_list=page.card_list col_class="col-lg-5" %}

{: .text-right .mt-3}
[Top of page](#payment-order-v30)

{% include iterator.html prev_href="/checkout-v3/get-started/validate-status"
                         prev_title="Back To Validate Status"
                         next_href="/checkout-v3/features/"
                         next_title="Additional Request Options" %}

[problems]: /checkout-v3/technical-reference/problems
[acceptance-test]: /checkout-v3/get-started/#get-ready-to-go-live
