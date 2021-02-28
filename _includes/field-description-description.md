{%- capture documentation_section -%}{%- include documentation-section.md fallback="card" -%}{%- endcapture -%}
{%- assign description_url = documentation_section | prepend: "/" | append: "/features/technical-reference/description" -%}
{%- unless documentation_section contains "checkout" or documentation_section == "payment-menu" -%}
    {%- assign description_url = description_url | prepend: "/payment-instruments" -%}
{%- endunless -%}
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
