{% assign api_resource = include.api_resource %}
{% assign documentation_section = include.documentation_section %}

## Metadata

Metadata should be used by the merchant who wants to store data on a payment
that they can get out later when they make a `GET` request on that payment. See the
abbreviated `GET` request below.
SwedbankPay does not use this in the system other than to store the data and give
it back to the merchant who needs them. An example of this is if the merchant has
several internal systems where the actual creation of a payment takes place in
one system but post-purchase takes place in another system.
The merchant may need to send more data between these systems if they do not talk
to each other internally. This can be done by using the `metadata` field as shown
in the abbreviated `Purchase` request below.

{:.code-header}
**Request**

```http
POST /psp/{{ api_resource }}/{% unless api_resource == "paymentorders" %}payments/{% endunless %}{{ page.payment_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
{
  "payment": {
    "operation": "Purchase",
    "intent": {% if api_resource == "swish" or api_resource == "trustly" %} "Sale", {% else %} "Authorization", {% endif %}
    "currency": "SEK",
    "description": "Test Purchase",
    "payerReference": "AB1234",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls": {
      "hostUrls": ["https://example.com"],
      "completeUrl": "https://example.com/payment-completed"
    },
    "payeeInfo": {
      "payeeId": "{{ page.merchant_id }}",
      "payeeReference": "CD1234",
    },
    "metadata": {
        "key1": "value1",
        "key2": 2,
        "key3": 3.1,
        "key4": false
    },
    "prefillInfo": {
        "msisdn": "+4798765432"
    }
  }
}
```

{:.table .table-striped}
| Parameter            | Type                                                |
| :------------------- | :-------------------------------------------------- |
| `metadata`           | `string`, `boolean`, `integer`,`decimal`            |

{:.code-header}
**Request**

```http
GET /psp/{{ api_resource }}/{% unless api_resource == "paymentorders" %}payments/{% endunless %}{{ page.payment_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json
{
  "payment": "/psp/{{ api_resource }}/{% unless api_resource == "paymentorders" %}payments/{% endunless %}{{ page.payment_id }}",
  "metadata": {
    "id": "/psp/{{ api_resource }}/{% unless api_resource == "paymentorders" %}payments/{% endunless %}{{ page.payment_id }}/metadata",
    "key1": "value1",
    "key2": 2,
    "key3": 3.1,
    "key4": false
 }
}
```
