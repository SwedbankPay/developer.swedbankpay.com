Swedbank Pay's Online Payments API is built in a way that depends on that you,
as a merchant, is able to store the `paymentOrderId`. The `paymentOrderId` is a
URL which points to the specific instance of a payment order resource, but in
some cases it will be hard to use it as a payment reference.

To help you keep track of the transaction easier, we provide a unique
identification called `referenceCode` in all v3 implementations. The code can
then be printed and, for instance, used as a scannable barcode for future
tracking.

The `referenceCode` isn't available by default, but needs to be activated by us
to appear in your payment order responses.

## Reference Code Query

When enabled, the `referenceCode` will appear as a 16 digit code in the expanded
`paid` field when the payment is fully paid.

In addition to the regular `GET` method, you may obtain information about the
payment by doing a `QUERY` with the `referenceCode` in the JSON body as shown in
the below example.

Both `GET` and `QUERY` responses will look like the abbreviated `paid`
example below. The parts omitted from this example will look like the response
from a regular `GET` request.

## GET Request

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

## QUERY Request

{% capture request_header %}QUERY /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
  "referenceCode": 1717224235360011
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

## GET And QUERY Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentOrder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "paid": {
    "id": "/psp/paymentorders/1f8d409e-8d8c-4ba1-a3ab-08da8caf7918/paid",
    "instrument": "Creditcard",
    "number": 80100001190,
    "payeeReference": "1662360210",
    "amount": 1500,
    "referenceCode": "1717224235360011"
    "details": {}
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

  <!-- 1) paymentOrder (rot) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">The payment order object.</div>
    </div>
  </details>

  <!-- 2) paid (rot) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paid, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">The paid object.</div>
    </div>

    <div class="api-children" data-level="1">

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            {% capture inc %}{% include fields/id.md resource="paymentorder" %}{% endcapture %}{{ inc | markdownify }}
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f instrument, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">Payment method used in the cancelled payment.</div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f number, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            {% capture inc %}{% include fields/number.md %}{% endcapture %}{{ inc | markdownify }}
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeReference, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(30)</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            {% capture inc %}{% include fields/payee-reference.md %}{% endcapture %}{{ inc | markdownify }}
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f referenceCode, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">A 16 digit reference code which can be used for tracking payments.</div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            {% capture inc %}{% include fields/amount.md %}{% endcapture %}{{ inc | markdownify }}
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f details, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc">
          <div class="indent-1">Details connected to the payment.</div>
        </div>
      </details>
    </div>
  </details>
</div>
