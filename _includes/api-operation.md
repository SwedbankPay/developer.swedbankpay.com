{%- assign api_resource = include.api_resource  | default: "UNKNOWN_RESOURCE" -%}
{%- assign operation = include.operation -%}
{%- assign content_type = include.content_type | default: "application/json" -%}
{%- assign href_tail = include.href_tail -%}
{%- capture href -%}
{{- page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}
{%- endcapture -%}
{%- if href_tail != nil && href_tail != empty -%}
    {%- assign href = href | append: '/' | append: href_tail -%}
{%- endif -%}
{%- assign operation_begins_with = operation | split: "-" | first -%}
{%- case operation_begins_with -%}
    {%- when "failed" or "aborted" or "paid" -%}
        {%- assign api_method = "GET" -%}
    {%- when "view" -%}
        {%- assign api_method = "GET" -%}
        {%- assign content_type = "application/javascript" -%}
    {%- when "redirect" -%}
        {%- assign api_method = "GET" -%}
        {%- assign content_type = "text/html" -%}
    {%- when "update" -%}
        {%- assign api_method = "PATCH" -%}
    {%- else -%}
        {%- assign api_method = "POST" -%}
{%- endcase -%}
{% capture code -%}
        {
            "method": "{{ api_method }}",
            "href": "{{ href }}",
            "rel": "{{ operation }}",
            "contentType": "{{ content_type }}"
        }
{%- endcapture -%}
{{- code -}}
{%- comment -%}
{%- endcomment -%}
