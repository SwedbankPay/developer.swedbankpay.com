{%- assign documentation_section = include.documentation_section -%}
{%- assign documentation_section_title = documentation_section | capitalize -%}
{%- assign language_codes = "en-US, nb-NO, sv-SE" -%}

## Languages

​
{%- case documentation_section -%}
    {%- when "card" -%}
        {%- assign documentation_section_title = "Card" -%}
        {%- assign language_codes="da-DK, de-DE, ee-EE, en-US, es-ES, fi-FI, fr-FR, lt-LT, lv-LV, nb-NO, ru-RU, sv-SE" -%}
    {%- when "mobile-pay" -%}
        {%- assign documentation_section_title = "MobilePay" -%}
        {%- assign language_codes="da-DK, en-US, fi-FI, nb-NO, sv-SE" -%}
{%- endcase -%}

{%- assign language_codes = language_codes | split: ',' -%}

{{ documentation_section_title }} supports the following languages:
{% for language_code in language_codes %}
{%- if forloop.last %}
 and {% comment %}Keep this to preserve the space after 'and'!{% endcomment %}
{%- elsif forloop.first -%}
{%- else -%}
, {% comment %}Keep this to preserve the space after the comma!{% endcomment %}
{%- endif -%}
{% include language-map.md language_code=language_code %} `{{ language_code | strip }}`
{%- endfor -%}.
