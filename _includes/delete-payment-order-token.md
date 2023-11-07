{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% assign token_field_name = include.token_field_name %}
{% capture token_url %}
    /psp/paymentorders/{{ token_field_name }}s/{{- page.payment_token -}}
{% endcapture %}
{% assign token_url=token_url | strip %}

## Delete {{ token_field_name }} Request

{:.code-view-header}
**Request**

```http
PATCH {{ token_url }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.1/3.0/2.0      // Version optional for 3.0 and 2.0

{
    "state": "Deleted",
    "comment": "Comment on why the deletion is happening"
}
```

## Delete {{ token_field_name }} Response

{% unless token_field_name == "recurrenceToken" %}

The example shows a token connected to a card. The instrument parameters and
display name will vary depending on the instrument.

{% endunless %}

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.1/3.0/2.0
api-supported-versions: 3.1/3.0/2.0

{
    {% if token_field_name == "paymentToken" %}
    "paymentToken": "{{ page.payment_token }}",
    {% else %}
    "token": "{{ page.payment_token }}",{% endif %} {% if token_field_name == "recurrenceToken" %}
    "isDeleted": true
    {% else %}
    "instrument": "CreditCard",
    "instrumentDisplayName": "123456xxxxxx1111"
    "correlationId": "e2f06785-805d-4605-bf40-426a725d313d",
    "instrumentParameters": {
        "cardBrand": "Visa",
        "expiryDate": "MM/YYYY"
    }
    {% endif %}
}
```
