{%- assign sections = page.dir | split: "/" -%}
{%- assign section_count = sections | size -%}
{% assign section_index = 1 %}
{%- if section_count > 2 -%}
    {% assign section_index = 2 %}
{%- endif -%}
{%- assign current_section = sections[section_index] | strip_newlines | strip -%}
{%- if include.fallback == empty -%}
    {% assign documentation_section = current_section %}
{%- else -%}
    {% comment %}
    If 'fallback' is provided, weird documentation sections (such as 'home',
    'payment-instruments', etc.) will be discarded and 'fallback' will be used
    instead.
    {% endcomment %}
    {%- capture known_sections %}
        checkout, payment-menu, gift-cards, card, invoice, mobile-pay, swish,
        trustly, vipps
    {%- endcapture -%}
    {%- assign known_sections = known_sections | strip_newlines | split: "," -%}
    {%- for known_section in known_sections -%}
        {%- assign known_section = known_section | strip_newlines | strip -%}
        {%- if known_section == current_section -%}
            {%- assign documentation_section = current_section -%}
        {%- endif -%}
    {%- endfor -%}
    {%- if documentation_section == undefined or documentation_section == nil or documentation_section == empty -%}
        {%- assign documentation_section = include.fallback -%}
    {%- endif -%}
{%- endif -%}
{{- documentation_section -}}
