{%- capture documentation_section -%}{%- include documentation-section.md -%}{%- endcapture -%}
{%- capture documentation_section_url -%}
    {%- if documentation_section != 'payment-menu' and documentation_section != 'checkout' -%}
        /payment-instruments
    {%- endif -%}

    /{{- documentation_section -}}

    {{- include.href -}}
{%- endcapture -%}
{{- documentation_section_url -}}
