{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

{% if api_resource == "paymentorders" %}
  {% assign api_resource_title="payment order" %}
{% else %}
  {% assign api_resource_title="payment" %}
{% endif %}

## Metadata

Metadata can be used to store data associated to a {{ api_resource_title }}
that can be retrieved later by performing a `GET` on the
{{ api_resource_title }}.
Swedbank Pay does not use or process `metadata`, it is only stored on the
{{ api_resource_title }} so it can be retrieved later alongside the
{{ api_resource_title }}. An example where `metadata` might be useful is when
several internal systems are involved in the payment process, and the payment
creation is done in one system and post-purchases take place in another.
In order to transmit data between these two internal systems, the data can be
stored in `metadata` on the {{ api_resource_title }} so the internal systems do
not need to communicate with each other directly. The usage of `metadata` field
is shown in the abbreviated `Purchase` request below.

## Metadata Request

{% capture request_header %}POST /psp/{{ api_resource }}/{% unless api_resource == "paymentorders" %}payments/{% endunless %}{{ page.payment_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
  "payment": {
    "operation": "Purchase",
    "intent": {% if api_resource == "swish" or api_resource == "trustly" %} "Sale", {% else %} "Authorization", {% endif %}
    "currency": "SEK",
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
        "metadata": {
        "key1": "value1",
        "key2": 2,
        "key3": 3.1,
        "key4": false
    },
    "urls": {
      "hostUrls": ["https://example.com"],
      "completeUrl": "https://example.com/payment-completed"
    },
    "payeeInfo": {
      "payeeId": "{{ page.merchant_id }}",
      "payeeReference": "CD1234",
    },
    "payer": {
      "payerReference": "AB1234",
    },
    "prefillInfo": {
        "msisdn": "+4798765432"
    }
  }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{:.table .table-striped}
| Parameter            | Type                                                |
| :------------------- | :-------------------------------------------------- |
| `metadata`           | `string`, `boolean`, `integer`,`decimal`            |

## GET Request

{% if documentation_section contains "old-implementations/payment-instruments-v1" %}

{% capture request_header %}GET /psp/{{ api_resource }}/payments/7e6cdfc3-1276-44e9-9992-7cf4419750e1/ HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% else %}

{% capture request_header %}GET /psp/paymentorders/7e6cdfc3-1276-44e9-9992-7cf4419750e1/ HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% endif %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

## GET Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/{{ api_resource }}/{% unless api_resource == "paymentorders" %}payments/{% endunless %}{{ page.payment_id }}",
    "metadata": {
        "id": "/psp/{{ api_resource }}/{% unless api_resource == "paymentorders" %}payments/{% endunless %}{{ page.payment_id }}/metadata",
        "key1": "value1",
        "key2": 2,
        "key3": 3.1,
        "key4": false
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}
