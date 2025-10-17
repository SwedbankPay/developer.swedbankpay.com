## Order Items

The `orderItems` field of the `paymentOrder` is an array containing information
about the items being purchased. **It is mandatory for v3.0 and older**
**implementations, but voluntary for payment order v3.1**, so feel free to
remove it from your requests if you want. If you offer invoice as a payment
option, the field is still recommended as it are used for the product details on
the customer's invoice. If they are not present, `orderItems` will be generated
by using the `description` and `amount` fields from the `paymentOrder`.

{% capture request_content %}"orderItems": [
    {
        "reference": "P1",
        "name": "Product1",
        "type": "PRODUCT",
        "class": "ProductGroup1",
        "itemUrl": "https://example.com/products/123",
        "imageUrl": "https://example.com/product123.jpg",
        "description": "Product 1 description",
        "discountDescription": "Volume discount",
        "quantity": 5,
        "quantityUnit": "pcs",
        "unitPrice": 300,
        "discountPrice": 0,
        "vatPercent": 2500,
        "amount": 1500,
        "vatAmount": 375
    }
]{% endcapture %}

{% include code-example.html
    title='Request Excerpt'
    header=request_header
    json= request_content
    %}

<!-- Captures for markdown-includes -->
{%- capture order_items_md -%}{% include fields/order-items.md %}{%- endcapture -%}
{%- capture amount_md -%}{% include fields/amount.md %}{%- endcapture -%}
{%- capture vat_amount_md -%}{% include fields/vat-amount.md %}{%- endcapture -%}

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- Level 0 (all nodes CLOSED by default) -->
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
          <span class="field">{% f reference %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">A reference that identifies the order item.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f name %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The name of the order item.</div></div>
      </details>

      <!-- type (enum) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f type %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>enum</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1"><code>PRODUCT</code>, <code>SERVICE</code>, <code>SHIPPING_FEE</code>, <code>DISCOUNT</code>, <code>VALUE_CODE</code>, or <code>OTHER</code>. The type of the order item.</div></div>
      </details>

      <!-- class -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f class %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The classification of the order item. Can be used for assigning the order item to a specific product category, such as <code>MobilePhone</code>. Note that <code>class</code> cannot contain spaces and must follow the regex pattern <code>[\w-]*</code>. Swedbank Pay may use this field for statistics.</div></div>
      </details>

      <!-- itemUrl (optional) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f itemUrl %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to a page that can display the purchased item, such as a product page</div></div>
      </details>

      <!-- imageUrl (optional) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f imageUrl %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to an image of the order item.</div></div>
      </details>

      <!-- description (optional) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The human readable description of the order item.</div></div>
      </details>

      <!-- discountDescription (optional) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f discountDescription %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The human readable description of the possible discount.</div></div>
      </details>

      <!-- quantity -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f quantity %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>number</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The 4 decimal precision quantity of order items being purchased.</div></div>
      </details>

      <!-- quantityUnit -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f quantityUnit %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The unit of the quantity, such as <code>pcs</code>, <code>grams</code>, or similar.</div></div>
      </details>

      <!-- unitPrice -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f unitPrice %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The price per unit of order item, including VAT.</div></div>
      </details>

      <!-- discountPrice (optional) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f discountPrice %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">If the order item is purchased at a discounted price. This field should contain that price, including VAT.</div></div>
      </details>

      <!-- vatPercent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatPercent %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The percent value of the VAT multiplied by 100, so <code>25%</code> becomes <code>2500</code>.</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add small"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>
    </div>
  </details>
</div>
