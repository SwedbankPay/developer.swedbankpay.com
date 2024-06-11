{%- assign resource = include.resource | default: "payment" -%}
{%- assign sub_resource = include.sub_resource | default: empty -%}
{%- if sub_resource != empty -%}
    {%- capture sub_resource_text -%}
        this `{{ sub_resource }}` belongs to
    {%- endcapture -%}
{%- endif -%}
{%- capture text -%}
    The relative URL and unique identifier of the
    `{{ resource }}` resource {{ sub_resource_text }}.
    Please read about [URL Usage](/checkout-v3/get-started/fundamental-principles#url-usage)
    to understand how this and other URLs should be used in your solution.
{%- endcapture -%}
{%- comment -%}
The following chain of Liquid filters converts newlines to spaces and removes
extranous spaces.
{%- endcomment -%}
{{- text | newline_to_br | strip_newlines | split: '<br />' | join: ' ' | strip -}}
{%- comment -%}
The dashes in the Liquid code tags remove output space. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
