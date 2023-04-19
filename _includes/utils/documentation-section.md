{%- capture sections -%}
    old-implementations/checkout-v2,
    checkout-v3/enterprise,
    checkout-v3/starter,
    checkout-v3/business,
    checkout-v3/payments-only,
    old-implementations/payment-menu-v2,
    gift-cards,
    old-implementations/payment-instruments-v1/card,
    old-implementations/payment-instruments-v1/invoice,
    old-implementations/payment-instruments-v1/mobile-pay,
    old-implementations/payment-instruments-v1/swish,
    old-implementations/payment-instruments-v1/trustly,
    old-implementations/payment-instruments-v1/vipps
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
