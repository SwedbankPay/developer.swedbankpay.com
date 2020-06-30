{%- assign api_resource = include.api_resource  | default: "UNKNOWN_RESOURCE" -%}
{%- assign api_operation = include.api_operation -%}
{%- assign api_content_type = include.api_content_type | default: "application/javascript" -%}
{%- capture api_href -%}
{{- site.api_url }}/psp/{{ api_resource }}/payments/{{ site.payment_id -}}
{%- endcapture -%}
{%- assign operation_begins_with = api_operation | split: "-" | first -%}
{%- if operation_begins_with == "view" or operation_begins_with == "redirect" -%}
    {%- assign api_method = "GET" -%}
{%- else -%}
    {%- assign api_method = "POST" -%}
{%- endif -%}
{% capture code -%}
        {
            "method": "{{ api_method }}",
            "href": "{{ api_href }}",
            "rel": "{{ api_operation }}",
            "contentType": "{{ api_content_type }}"
        }
{%- endcapture -%}
{{- code -}}
{%- comment -%}
{%- endcomment -%}
