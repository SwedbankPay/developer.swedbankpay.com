{% assign documentation_section = include.documentation_section %}
{% assign api_resource = include.api_resource %}
{% assign token_field_name = include.token_field_name %}

Payers should be able to delete payment tokens that are associated to
them. How to delete a `{{ token_field_name }}` is described in the example below.
Note that the value of `state` must be `Deleted` when deleting the token. 
No other states are supported.

{:.code-header}
**Request**

```http
PATCH /psp/{{ api_resource }}/{% unless api_resource == "paymentorders" %}payments/{% endunless %}{{ page.payment_id }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
{
  "state": "Deleted",
  "comment": "Comment on why the deletion is happening"{% if documentation_section == "card" %}
  "tokenType" : "{{ token_field_name }}"{% endif %}
}
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json
{
  "instrumentData": {
    "id": "/psp/{{ api_resource }}/{% unless api_resource == "paymentorders" %}payments/{% endunless %}instrumentdata/{{ page.payment_id }}",
    "paymentToken": "{{ page.payment_token }}",
    "payeeId": "{{ page.merchant_id }}",
    "isDeleted": true {% if documentation_section == "card" %}
    "isPayeeToken": false,
    "cardBrand": "Visa",
    "maskedPan": "123456xxxxxx1111",
    "expiryDate": "MM/YYYY",
    "tokenType" : "{{ token_field_name }}" {% endif %}
  }
}
```

