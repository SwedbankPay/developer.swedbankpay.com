{%- capture documentation_section -%}{%- include utils/documentation-section.md -%}{%- endcapture -%}
{%- capture documentation_section_url -%}
    {%- unless documentation_section contains '/old-implementations/payment-menu-v2' or documentation_section contains '/old-implementations/checkout-v2' or documentation_section contains '/old-implementations/checkout-v3' -%}
        /old-implementations/payment-instruments-v1
    {%- endunless -%}

    /{{- documentation_section fallback=include.fallback -}}

    {{- include.href -}}
{%- endcapture -%}
{{- documentation_section_url -}}
