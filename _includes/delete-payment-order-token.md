{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% assign token_field_name = include.token_field_name %}
{% capture token_url %}
    /psp/{{ api_resource }}/{{ token_field_name }}s/{{- page.payment_token -}}
{% endcapture %}
{% assign token_url=token_url | strip %}

## Delete {{ token_field_name }}

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
    "comment": "Comment on why the deletion is happening"
}
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{   
    "token": "{{ page.payment_token }}",{% if token_field_name == "recurrenceToken" %}
    "isDeleted": true
    {% else %}
    "instrument": "CreditCard",
    "instrumentDisplayName": "123456xxxxxx1111"
    "instrumentParameters": {
        "cardBrand": "Visa",
        "expiryDate": "MM/YYYY"
    }
    {% endif %}
}
```
