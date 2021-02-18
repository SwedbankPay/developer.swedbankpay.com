{%- capture sections %}
    checkout/2.0, checkout/3.0/basic, checkout/3.0/tailored, checkout/3.0/dsca,
    checkout/3.0/standard, payment-menu, gift-cards, card, invoice, mobile-pay,
    swish, trustly, vipps
{%- endcapture -%}
{%- assign sections = sections | strip_newlines | strip | split: "," -%}
{%- for s in sections -%}
    {%- assign section = s | strip_newlines | strip -%}
    {%- assign path_section = section | prepend: "/" | append: "/" -%}
    {%- if page.dir contains path_section -%}
        {%- assign documentation_section = section -%}
        {%- break -%}
    {%- endif -%}
{%- endfor -%}
{%- if documentation_section == undefined or documentation_section == nil or documentation_section == empty -%}
    {{- include.fallback -}}
{%- else -%}
    {{- documentation_section -}}
{%- endif -%}
