{%- capture documentation_section -%}{%- include utils/documentation-section.md -%}{%- endcapture -%}
{%- assign api_resource = "Payment" -%}
{%- if documentation_section contains "checkout" or documentation_section contains "payment-menu" -%}
    {%- assign api_resource = "Payment Order" -%}
{%- endif -%}
{%- capture initiating_system_user_agent -%}
The [user agent](/introduction#user-agent) of the HTTP client making the
request, reflecting the value sent in the `User-Agent` header with the initial
`POST` request which created the {{ api_resource | strip }}.
{%- endcapture -%}
{%- comment -%}
The following chain of Liquid filters converts newlines to spaces and removes
extranous spaces.
{%- endcomment -%}
{{- initiating_system_user_agent | newline_to_br | strip_newlines | split: '<br />' | join: ' ' | strip -}}
{%- comment -%}
The dashes in the Liquid code tags remove output space. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
