### Update Payment Order

{% include alert.html type="warning" icon="warning" body="If a payment is
attempted, failed or currently being processed, you will not be able to
update the `orderItems` for the payment order. Should you need to update the
`orderItems`, you will have to `abort` the payment order and create a new order
with the updated `orderItems`." %}

The `UpdateOrder` operation is used when there is a change in the amount, vat
amount or there are added or removed order items in the payment order. This
feature is available in **Seamless View** only.

{% include alert.html type="informative" icon="info" body="If you implement
`UpdateOrder` you need to `refresh()` the Payment Menu frontend after you have
called the `UpdateOrder` API from the backend." %}

In case the shopping cart is changed in another browser tab, that should also
lead to an `UpdateOrder`. On `window.onfocus` in the tab that had Payment Menu
initialized, `refresh()` should be invoked so the correct amount is authorized.

If the page is refreshed by a full page reload, `refresh()` is not necessary.

The response given when changing a payment order is equivalent to a `GET`
request towards the `paymentorders` resource. Even though the fields are the
same, the `UpdateOrder` request will overwrite the fields that were sent in the
initial `Purchase` request.

{% capture request_header %}PATCH /psp/paymentorders/{{ page.payment_order_id }} HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "UpdateOrder",
        "amount": 1500,
        "vatAmount": 375,
        "orderItems": [
            {
                "reference": "P1",
                "name": "Product1",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "itemUrl": "https://example.com/shop/products/1234",
                "imageUrl": "https://example.com/products/product1.jpg",
                "description": "Product description",
                "discountDescription": "Volume discount",
                "quantity": 351.3514,
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
                "description": "Product description",
                "quantity": 9876.1531,
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

  <!-- paymentOrder (root) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The payment order object.</div></div>

    <div class="api-children">
      <!-- operation -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operation %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture operation_md %}{% include fields/operation.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ operation_md | markdownify }}</div></div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture amount_md_root %}{% include fields/amount.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ amount_md_root | markdownify }}</div></div>
      </details>

      <!-- vatAmount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture vat_amount_md_root %}{% include fields/vat-amount.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ vat_amount_md_root | markdownify }}</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc"><div class="indent-1">The description of the payment order.</div></div>
      </details>

      <!-- orderItems (array container) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f orderItems %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        {% capture order_items_md %}{% include fields/order-items.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ order_items_md | markdownify }}</div></div>

        <div class="api-children">
          <!-- reference -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f reference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">A reference that identifies the order item.</div></div>
          </details>

          <!-- name -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f name, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the order item.</div></div>
          </details>

          <!-- type -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>enum</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2"><code>PRODUCT</code>, <code>SERVICE</code>, <code>SHIPPING_FEE</code>, <code>PAYMENT_FEE</code>, <code>DISCOUNT</code>, <code>VALUE_CODE</code> or <code>OTHER</code>. The type of the order item.</div></div>
          </details>

          <!-- class -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f class, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The classification of the order item. Can be used for assigning the order item to a specific product category, such as <code>MobilePhone</code>. Note that <code>class</code> cannot contain spaces and must follow the regex pattern <code>[\w-]*</code>. Swedbank Pay may use this field for statistics.</div></div>
          </details>

          <!-- itemUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f itemUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to a page that can display the purchased item, product or similar.</div></div>
          </details>

          <!-- imageUrl -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f imageUrl, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The URL to an image of the order item.</div></div>
          </details>

          <!-- description (item) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the order item.</div></div>
          </details>

          <!-- discountDescription -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountDescription, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable description of the possible discount.</div></div>
          </details>

          <!-- quantity -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f quantity, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>number</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The 4 decimal precision quantity of order items being purchased.</div></div>
          </details>

          <!-- quantityUnit -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f quantityUnit, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The unit of the quantity, such as <code>pcs</code>, <code>grams</code>, or similar. This is used for your own book keeping.</div></div>
          </details>

          <!-- unitPrice -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f unitPrice, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The price per unit of order item, including VAT.</div></div>
          </details>

          <!-- discountPrice -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f discountPrice, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">If the order item is purchased at a discounted price. This field should contain that price, including VAT.</div></div>
          </details>

          <!-- vatPercent -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatPercent, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The percent value of the VAT multiplied by 100, so <code>25%</code> becomes <code>2500</code>.</div></div>
          </details>

          <!-- amount (item) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. <code>10000</code> equals <code>100.00 NOK</code> and <code>500</code>0 equals <code>50.00 NOK</code>.</div></div>
          </details>

          <!-- vatAmount (item) -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
              <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-2">The total amount of VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. <code>10000</code> equals <code>100.00 NOK</code> and <code>500</code>0 equals <code>50.00 NOK</code>.</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",
        "created": "2018-09-14T13:21:29.3182115Z",
        "updated": "2018-09-14T13:21:57.6627579Z",
        "operation": "Purchase",
        "state": "Ready",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 0,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls" : { "id": "/psp/paymentorders/{{ page.payment_order_id }}/urls" },
        "payeeInfo" : { "id": "/psp/paymentorders/{{ page.payment_order_id }}/payeeinfo" },
        "payers": { "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/payers"
        "orderItems" : { "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderItems" },
        "metadata": { "id": "/psp/paymentorders/{{ page.payment_order_id }}/metadata" },
        "payments": { "id": "/psp/paymentorders/{{ page.payment_order_id }}/payments" },
        "currentPayment": { "id": "/psp/paymentorders/{{ page.payment_order_id }}/currentpayment" }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.stage.payex.com/psp/paymentorders/7f27f445-cefe-4a48-d405-08d8143ed22b",
            "rel": "update-paymentorder-updateorder",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-expandinstrument",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/paymentmenu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
        }
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

  <!-- payment (root) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The <code>payment</code> object contains information about the specific payment.</div></div>

    <div class="api-children">
      <!-- id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        {% capture id_md %}{% include fields/id.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>

      <!-- number -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f number %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        {% capture number_payment_md %}{% include fields/number.md resource="payment" %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ number_payment_md | markdownify }}</div></div>
      </details>

      <!-- created -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a>{:target="_blank"} date and time when the payment was created.</div></div>
      </details>

      <!-- updated -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a>{:target="_blank"} date and time when the payment was updated.</div></div>
      </details>

      <!-- state -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f state %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Ready</code>, <code>Pending</code>, <code>Failed</code> or <code>Aborted</code>. Indicates the state of the payment, not the state of any transactions performed on the payment. To find the state of the payment's transactions (such as a successful authorization), see the <code>transactions</code> resource or the different specialized type-specific resources such as <code>authorizations</code> or <code>sales</code>.</div></div>
      </details>

      <!-- prices (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f prices %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The <code>prices</code> resource lists the prices related to a specific payment.</div></div>

        <div class="api-children">
          <!-- prices.id -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            {% capture prices_id_md %}{% include fields/id.md resource="prices" %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ prices_id_md | markdownify }}</div></div>
          </details>
        </div>
      </details>

      <!-- amount -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        {% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <!-- remaining amounts -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f remainingCaptureAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The available amount to capture.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f remainingCancelAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The available amount to cancel.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f remainingReversalAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The available amount to reverse.</div></div>
      </details>

      <!-- description -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(40)</code></span>
        </summary>
        {% capture description_md %}{% include fields/description.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <!-- userAgent -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f userAgent %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        {% capture user_agent_md %}{% include fields/user-agent.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ user_agent_md | markdownify }}</div></div>
      </details>

      <!-- language -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f language %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>enum(string)</code></span>
        </summary>
        {% capture language_md %}{% include fields/language.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ language_md | markdownify }}</div></div>
      </details>

      <!-- urls (link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f urls %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the urls resource where all URLs related to the payment can be retrieved.</div></div>
      </details>

      <!-- payeeInfo (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeInfo %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        {% capture payee_info_md %}{% include fields/payee-info.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ payee_info_md | markdownify }}</div></div>
      </details>

      <!-- payers (link) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payers %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The URL to the <code>payer</code> resource where the information about the payer can be retrieved.</div></div>
      </details>

      <!-- operations (array) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operations, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        {% capture operations_md %}{% include fields/operations.md resource="payment" %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ operations_md | markdownify }}</div></div>

        <div class="api-children">
          <!-- method -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f method, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The HTTP method to use when performing the operation.</div></div>
          </details>

          <!-- href -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f href, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The target URL to perform the operation against.</div></div>
          </details>

          <!-- rel -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f rel, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The name of the relation the operation has to the current resource.</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>
