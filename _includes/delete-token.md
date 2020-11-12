{% assign documentation_section = include.documentation_section %}
{% assign api_resource = include.api_resource %}
{% assign token_field_name = include.token_field_name %}
{% capture token_url %}
    /psp/{{ api_resource }}/
    {%- if api_resource == "paymentorders" -%}
        recurrenceTokens
    {%- else -%}
        payments/instrumentData
    {%- endif -%}
    /{{- page.payment_token -}}
{% endcapture %}
{% assign token_url=token_url | strip %}

## Delete Token

Payers should be able to delete payment tokens that are associated to
them. How to delete a `{{ token_field_name }}` is described in the example below.
Note that the value of `state` must be `Deleted` when deleting the token.
No other states are supported.

{:.code-view-header}
**Request**

```http
PATCH {{ token_url }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "state": "Deleted",
    "comment": "Comment on why the deletion is happening"{% if documentation_section == "card" %},
    "tokenType" : "{{ token_field_name }}"{% endif %}
}
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "instrumentData": {
        "id": "{{ token_url }}",
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
