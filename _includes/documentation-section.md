{%- assign sections = page.dir | split: '/' -%}
{%- assign section_count = sections | size -%}
{%- capture documentation_section -%}
    {%- if section_count > 2 -%}
        {{- sections[2] -}}
    {%- else -%}
        {{- sections[1] -}}
    {%- endif -%}
{%- endcapture -%}
{{- documentation_section | strip_newlines | strip  -}}
