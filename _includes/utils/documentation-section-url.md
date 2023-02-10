{%- capture documentation_section -%}{%- include utils/documentation-section.md -%}{%- endcapture -%}
{%- capture documentation_section_url -%}
    {%- unless documentation_section contains 'payment-menu' or documentation_section contains 'checkout' -%}
        /payment-instruments
    {%- endunless -%}

    /{{- documentation_section fallback=include.fallback -}}

    {{- include.href -}}
{%- endcapture -%}
{{- documentation_section_url -}}
