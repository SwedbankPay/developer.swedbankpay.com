{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}

## Fees And Discounts

 If you want to add fees or discounts to your payment order, this can be done by
 include them as `orderItems` in your request. The feature is currently
 available for **Invoice**, **Installment Account** and **Monthly Payments**.

 Use positive amounts for fees and negative amounts for discounts. Remember
 that the sum of the `orderItems` must match the total payment order amount.

 Restricting the fee or discount to certain payment methods is also possible.
 Simply add the `restrictedToInstruments` field and which payment method the fee
 or discount applies to. This is currently available for invoice only.

 The example below shows a fee which only applies to Swedish invoices. Other
 options for some of the fields are in the table below.

## Fee Request

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "orderItems": [
        {
            "reference": "I1",
            "name": "InvoiceFee",
            "type": "PAYMENT_FEE",
            "class": "Fees",
            "description": "Fee for paying with Invoice",
            "quantity": 1,
            "quantityUnit": "pcs",
            "unitPrice": 1900,
            "vatPercent": 0,
            "amount": 1900,
            "vatAmount": 0,
            "restrictedToInstruments": [
                "Invoice-PayExFinancingSe"
            ]
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

<!-- Captures for markdown-includes -->
{%- capture order_items_md -%}{% include fields/order-items.md %}{%- endcapture -%}
{%- capture description_md -%}{% include fields/description.md %}{%- endcapture -%}
{%- capture amount_md -%}{% include fields/amount.md %}{%- endcapture -%}
{%- capture vat_amount_md -%}{% include fields/vat-amount.md %}{%- endcapture -%}

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- Level 0 (all nodes CLOSED by default; original order retained) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f orderItems, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
      <span class="type"><code>array</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">{{ order_items_md | markdownify }}</div></div>

    <div class="api-children">
      <!-- Level 1 children of orderItems -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f reference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">A reference that identifies the order item.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The name of the order item.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1"><code>PRODUCT</code>, <code>SERVICE</code>, <code>SHIPPING_FEE</code>, <code>PAYMENT_FEE</code>, <code>DISCOUNT</code>, <code>VALUE_CODE</code> or <code>OTHER</code>. The type of the order item. <code>PAYMENT_FEE</code> is the amount you are charged with when you are paying with invoice. The amount can be defined in the <code>amount</code> field below.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f class, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The classification of the order item. Can be used for assigning the order item to a specific product category, such as <code>MobilePhone</code>. Note that <code>class</code> cannot contain spaces and must follow the regex pattern <code>[\w-]*</code>. Swedbank Pay may use this field for statistics.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f itemUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to a page that can display the purchased item, product or similar.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f imageUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to an image of the order item.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f discountDescription, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Used for discounts only. The human readable description of the possible discount.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f quantity, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>number</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The 4 decimal precision quantity of order items being purchased.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f quantityUnit, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The unit of the quantity, such as <code>pcs</code>, <code>grams</code>, or similar. This is used for your own book keeping.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f unitPrice, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The price per unit of order item, including VAT.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f discountPrice, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Used for discounts only. If the order item is purchased at a discounted price. This field should contain that price, including VAT.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatPercent, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The percent value of the VAT multiplied by 100, so <code>25%</code> becomes <code>2500</code>.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f restrictedToInstruments %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>array</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">A list of the payment methods you wish to restrict the payment to. Currently <code>Invoice</code> only. <code>Invoice</code> supports the subtypes <code>PayExFinancingNo</code>, <code>PayExFinancingSe</code> and <code>PayMonthlyInvoiceSe</code>, separated by a dash, e.g.; <code>Invoice-PayExFinancingNo</code>. The fee or discount applies to all payment methods if a restriction is not included. Use of this field requires an agreement with Swedbank Pay.</div></div>
      </details>
    </div>
  </details>
</div>
