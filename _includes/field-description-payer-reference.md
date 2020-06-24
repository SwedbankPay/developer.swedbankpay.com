{% assign documentation_section = include.documentation_section %}

{%- if documentation_section == "checkout" -%}
{%- assign documentation_url = documentation_section | prepend: "/" | append: "/other-features#merchant-identified-payer" -%}

{%- else -%}
{%- assign documentation_url = documentation_section | prepend: "/" | append: "/other-features#merchant-identified-payer" -%}
{%- endif -%}

{%- capture text -%}
The reference to the consumer from the merchant system, like mobile number,
customer number etc. Used in [Merchant Identified Payer]({{ documentation_url }}).
{%- endcapture-%}
{{- text | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
