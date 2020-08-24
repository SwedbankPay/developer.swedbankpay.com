{% assign api_resource = include.api_resource %}
{% assign documentation_section = include.documentation_section %}

## Metadata

Metadata should be used by the merchant who wants to store data on a payment
that they can get out later when they make a `GET` request on that payment.
So SwedbankPay does not use this in the system other than to store them and give
back to the merchant who needs them. An example of this is if the merchant has
several internal systems. Where the actual creation of a payment takes place in
one system but post-purchase takes place in another system.
Then they may need to send more data between these systems if they do not talk
to each other internally. This can be done by using the `metadata` field.

{:.code-header}
**Request**

```http
POST /psp/{{ api_resource }}/payments/{{ page.payment_id }}/ HTTP/1.1
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
| Parameter            | Description                                                |
| :------------------- | :--------------------------------------------------------- |
| `metadata` | `authorizations`, `captures`, `cancellations`,`reversals` |


GET FOR METADATA

{:.code-header}
**Request**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/ HTTP/1.1
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
  "payment": "/psp/vipps/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
  "metadata": {
 "id": "/psp/vipps/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/metadata",
    "key1": "value1",
    "key2": 2,
    "key3": 3.1,
    "key4": false
 }
}
```
