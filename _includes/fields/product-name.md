{%- capture field -%}
Indicates a Checkout v3 compliant client. Required to enable Checkout v3
functionality and operations.
{%- endcapture -%}
{{- field | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output space. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
