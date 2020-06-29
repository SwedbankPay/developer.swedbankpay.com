{% assign api_resource = include.api_resource  | default: "api-resource-not-set" %}
{% assign api_operation = include.api_operation %}
{% assign api_contentType = include.api_contentType | default: "application/javascript" %}
{% assign api_href = include.api_href | default: "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}" %}

{% assign begins_with = api_operation | split: "-" | first %}

{% if begins_with == "view" or "redirect" %}
{% assign api_method = "GET" %}
{% else %}
{% assign api_method = "POST" %}
{% endif %}

{% capture code %}
{
    "method": "{{ api_method }}",
    "href": "{{ api_href }}",
    "rel": "{{ api_operation }}",
    "contentType": "{{ api_contentType }}"
},
{% endcapture %}
{{code}}
