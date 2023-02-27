{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{%
endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}

## Restrict Payments To An Age Limit

Swedbank Pay provides the possibility to restrict payments to an Age Limit from
payment instruments which support this. This can be used when you want to make
sure you only accept payments from individuals over a certain age. You are
currently only able to restrict Swish payments to an Age Limit, but we will add
support for more payment instruments going forward. No changes are required at
your (the merchant’s) end to be able to offer more instruments at a later time.

The way you use this feature is by adding the field `restrictedToAgeLimit` in
your payment order request and setting it to the age limit you wish to restrict
your payments to. This will leave out all instruments which do not support this
feature. For instance, set `restrictedToAgeLimit` to 20 if you only want to
accept payments from individuals over the age 20. Instruments supporting the
feature will reject payments that do not match the restriction.

## Restrict Payments To An Age Limit Request

You need to add an `int` field called `restrictedToAgeLimit` in your payment
order request and set it to your desired age limit, i.e. 20.

Below is a shortened example of a payment order request. Apart from the
new field, the payment request is similar to a standard payment order request.
For an example of a payment order request, {% if documentation_section contains
"checkout-v3/enterprise" %} [click
here.](/checkout-v3/enterprise/redirect#payment-order-request) {% endif %} {% if
documentation_section contains "checkout-v3/payments-only" %} [click
here.](/checkout-v3/payments-only/redirect#payment-order-request) {% endif %} {%
if documentation_section contains "checkout-v3/business" %} [click here.]
(/checkout-v3/business/redirect#payment-order-request) {% endif %}

The response will be similar to a standard payment order response, which is also
documented on the page linked above.

{:.code-view-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "paymentorder": {
        "restrictedToAgeLimit": 20,
    }
}
```

{:.table .table-striped}
| Required         | Field     | Type         | Description   |
| :--------------: | :-------- | :----------- | :------------ |
| {% icon check %} | `paymentorder`                         | `object`  | The payment order object.                                                 |
|                  | {% f restrictedToAgeLimit %}        | `int`    | Used for setting the age you want to restrict the payment to.              |
