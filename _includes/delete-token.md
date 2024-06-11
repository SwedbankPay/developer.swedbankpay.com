{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
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

## Delete {{ token_field_name }}

Payers should be able to delete payment tokens that are associated to them. How
to delete a `{{ token_field_name }}` is described in the example below. Note
that the value of `state` must be `Deleted` when deleting the token. No other
states are supported.

## Delete Token Request

{% capture request_header %}PATCH {{ token_url }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "state": "Deleted",
    "comment": "Comment on why the deletion is happening"{% if documentation_section == "card" %},
    "tokenType" : "{{ token_field_name }}"{% endif %}
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

## Delete Token Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{   {% if documentation_section contains "payment-menu" %}
    "token": "{{ page.payment_token }}",
    "isDeleted": true
    {% else %}
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
    {% endif %}
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}
