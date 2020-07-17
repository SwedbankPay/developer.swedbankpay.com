{%- assign documentation_section = include.documentation_section -%}
{%- assign description_url = documentation_section | prepend: "/" | append: "/other-features#description" -%}
{%- if documentation_section != "checkout" and documentation_section != "payment-menu" -%}
    {%- assign description_url = description_url | prepend: "/payments" -%}
{%- endif -%}
{%- capture description -%}
    A 40 character length textual [description]({{ description_url }}) of the purchase.
{%- endcapture -%}
{{- description | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
