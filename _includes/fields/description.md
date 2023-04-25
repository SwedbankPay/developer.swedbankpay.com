{%- capture documentation_section -%}{%- include utils/documentation-section.md fallback="card" -%}{%- endcapture -%}
{%- assign description_url = documentation_section | prepend: "/" | append: "/features/technical-reference/description" -%}
{%- unless documentation_section contains "checkout" or documentation_section contains "payment-menu" -%}
    {%- assign description_url = description_url | prepend: "/old-implementations/payment-instruments-v1" -%}
{%- endunless -%}
{%- capture description -%}
    A 40 character length textual [description]({{ description_url }}) of the purchase.
{%- endcapture -%}
{{- description | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output space. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
