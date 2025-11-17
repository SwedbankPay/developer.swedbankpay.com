{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}

## Restrict Payments To An Age Limit

Swedbank Pay provides the possibility to restrict payments to an age limit with
payment methods which support this. This can be used when you want to make sure
you only accept payments from individuals over a certain age. You are currently
only able to restrict Swish payments to an Age Limit, but we will add support
for more payment methods going forward. No changes are required at your (the
merchant’s) end to be able to offer more payment methods at a later time.

The way you use this feature is by adding the field `restrictedToAgeLimit` in
your payment order request and setting it to the age limit you wish to restrict
your payments to. This will leave out all payment methods which do not support
this feature. For instance, set `restrictedToAgeLimit` to 20 if you only want to
accept payments from individuals over the age 20. Payment methods supporting the
feature will reject payments that do not meet the restriction.

## Restrict Payments To An Age Limit Request

You need to add an `int` field called `restrictedToAgeLimit` in your payment
order request and set it to your desired age limit, i.e. 20.

Below is a shortened example of a payment order request. Apart from the
new field, the payment request is similar to a standard payment order request.
For an example of a payment order request, {% if documentation_section contains
"old-implementations/enterprise" %} [click
here.](/old-implementations/enterprise/redirect#payment-order-request) {% endif %} {% if
documentation_section contains "checkout-v3/payments-only" %} [click
here.](/checkout-v3/get-started/payment-request) {% endif %}

The response will be similar to a standard payment order response, which is also
documented on the page linked above.

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=<PaymentOrderVersion>{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "restrictedToAgeLimit": 20,
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="required">{% icon check %}</span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The payment order object.
      </div>
    </div>

    <div class="api-children">
        <details class="api-item" data-level="1">
            <summary>
                <span class="field">{% f restrictedToAgeLimit %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                <span class="type"><code>int</code></span>
                <span class="required"></span>
            </summary>
            <div class="desc"><div class="indent-1">Used for setting the age you want to restrict the payment to.</div></div>
        </details>
    </div>
  </details>
</div>
