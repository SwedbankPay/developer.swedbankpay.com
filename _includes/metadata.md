{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}

## Metadata

Metadata can be used to store data associated to a payment that can be retrieved
later by performing a `GET`. Swedbank Pay does not use or process `metadata`, it
is only stored on the payment so it can be retrieved later. An example where
`metadata` might be useful is when several internal systems are involved in the
payment process, and the payment creation is done in one system and
post-purchases take place in another. In order to transmit data between these
two internal systems, the data can be stored in `metadata` on the payment so the
internal systems do not need to communicate with each other directly. The usage
of `metadata` field is shown in the abbreviated `Purchase` request below.

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

{% capture request_header %}POST /psp/{{ api_resource }}/{% unless api_resource == "paymentorders" %}payments/{% endunless %}{{ page.payment_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='GET Request'
    header=request_header
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
