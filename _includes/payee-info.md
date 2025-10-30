{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

{% assign length = 50 %}
{% case api_resource %}
    {% when "paymentorders" %}
        {% assign length = 30 %}
    {% when "swish" %}
        {% assign length = 35 %}
    {% when "vipps" %}
        {% assign length = 30 %}
{% endcase %}

## PayeeInfo

The `payeeinfo` resource contains information about the payee (i.e. a merchant,
a corporation etc) related to a specific payment.

## GET Request

{% if documentation_section contains "payment-menu" or documentation_section contains "checkout" %}

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_id }}/payeeInfo HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% else %}

{% capture request_header %}GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/payeeInfo HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% endif %}

## GET Response

{% if documentation_section contains "payment-menu" or documentation_section contains "checkout" %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentorder": "/psp/paymentorders/{{ page.payment_id }}",
    "payeeInfo": {
        "id": "/psp/paymentorders/{{ page.payment_id }}/payeeInfo",
        "payeeId": "{{ page.merchant_id }}",
        "payeeReference": "EN1234",
        "payeeName": "TestMerchant1",
        "productCategory": "EF1234",
        "orderReference": "or-123456"
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
    "payeeInfo": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/payeeInfo",
        "payeeId": "{{ page.merchant_id }}",
        "payeeReference": "EN1234",
        "payeeName": "TestMerchant1",
        "productCategory": "EF1234",
        "orderReference": "or-123456"
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
  <details class="api-item" data-level="0">
    <summary>
    {% if documentation_section contains "payment-menu" or documentation_section contains "checkout" %}
      <span class="field">{% f paymentorder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      {% else %}
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
    {% endif %}
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
           {% if documentation_section contains "payment-menu" or documentation_section contains "checkout" %}
                {% capture inc %}{% include fields/id.md resource="paymentorder" sub_resource="payeeInfo" %}{% endcapture %}{{ inc | markdownify }}
            {% else %}
                {% capture inc %}{% include fields/id.md resource="payment" sub_resource="payeeInfo" %}{% endcapture %}{{ inc | markdownify }}
            {% endif %}
      </div>
    </div>
  </details>
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payeeInfo, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">The payeeInfo resource.</div>
    </div>
    
    <div class="api-children">
        <details class="api-item" data-level="1">
            <summary>
                <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-1">{% capture inc %}{% include fields/id.md resource="payeeInfo" %}{% endcapture %}{{ inc | markdownify }}</div></div>
        </details>
        <details class="api-item" data-level="1">
            <summary>
                <span class="field">{% f payeeId, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-1">This is the unique id that identifies this payee (like merchant) set by Swedbank Pay</div></div>
        </details>
        <details class="api-item" data-level="1">
            <summary>
                <span class="field">{% f payeeReference, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-1">{% capture inc %}{% include fields/payee-reference.md %}{% endcapture %}{{ inc | markdownify }}</div></div>
        </details>
        <details class="api-item" data-level="1">
            <summary>
                <span class="field">{% f payeeName, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-1">The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.</div></div>
        </details>
        <details class="api-item" data-level="1">
            <summary>
                <span class="field">{% f productCategory, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                <span class="type"><code>string(50)</code></span>
            </summary>
            <div class="desc"><div class="indent-1">A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process. You therefore need to ensure that the value given here is valid in the settlement.</div></div>
        </details>
        <details class="api-item" data-level="1">
            <summary>
                <span class="field">{% f orderReference, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                <span class="type"><code>string(50)</code></span>
            </summary>
            <div class="desc"><div class="indent-1">The order reference should reflect the order reference found in the merchant's systems.</div></div>
        </details>
    </div>
  </details>
</div>

{% include payee-reference.md %}
