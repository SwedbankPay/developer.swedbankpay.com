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

{:.table .table-striped}
| Field                     | Type                 | Description                                                                                                                                                                                                                                                                       |
| :------------------------ | :------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}                 | `string`             | {% include fields/id.md sub_resource="payeeInfo" %}                                                                                                                                                                                                                    |
| {% f id %}              | `string`             | {% include fields/id.md resource="payeeInfo" %}                                                                                                                                                                                                                        |
| {% f payeeId %}         | `string`             | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay                                                                                                                                                                                              |
| {% f payeeReference %}  | `string(30)` | {% include fields/payee-reference.md %}                                                                                                                                                                                    |
| {% f payeeName %}       | `string`             | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                           |
| {% f productCategory %} | `string(50)`             | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process. You therefore need to ensure that the value given here is valid in the settlement. |
| {% f orderReference %}  | `string(50)`         | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                           |

{% include payee-reference.md %}
