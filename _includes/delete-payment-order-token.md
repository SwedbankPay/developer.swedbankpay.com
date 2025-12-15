{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% assign token_field_name = include.token_field_name %}
{% capture token_url %}
    /psp/paymentorders/{{ token_field_name }}s/{{- page.payment_token -}}
{% endcapture %}
{% assign token_url=token_url | strip %}

## Delete {{ token_field_name }} Request

{% capture request_header %}PATCH {{ token_url }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% capture request_content %}{
    "state": "Deleted",
    "comment": "Comment on why the deletion is happening"
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

## Delete {{ token_field_name }} Response

{% unless token_field_name == "recurrenceToken" %}

The example shows a token connected to a card. The parameters and display name
will vary depending on the payment method.

{% endunless %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
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
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}
