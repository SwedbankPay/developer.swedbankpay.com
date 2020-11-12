{%- assign api_resource = include.api_resource -%}
{%- assign product = api_resource | capitalize -%}
{%- assign language_codes = "en-US, nb-NO, sv-SE" -%}

## Languages

​
{%- case api_resource -%}
    {%- when "paymentorders" -%}
        {%- assign product = "Checkout" -%}
        {%- assign language_codes = "en-US, nb-NO, sv-SE" -%}
    {%- when "creditcard" -%}
        {%- assign product = "Card" -%}
        {%- assign language_codes="da-DK, de-DE, ee-EE, en-US, es-ES, fi-FI, fr-FR, lt-LT, lv-LV, nb-NO, ru-RU, sv-SE" -%}
    {%- when "mobilepay" -%}
        {%- assign product = "MobilePay" -%}
        {%- assign language_codes="da-DK, en-US, fi-FI" -%}
{%- endcase -%}

{%- assign language_codes = language_codes | split: ',' -%}

{{ product }} supports the following languages:
{% for language_code in language_codes %}
{%- if forloop.last %}
 and {% comment %}Keep this to preserve the space after 'and'!{% endcomment %}
{%- elsif forloop.first -%}
{%- else -%}
, {% comment %}Keep this to preserve the space after the comma!{% endcomment %}
{%- endif -%}
{% include language-map.md language_code=language_code %} `{{ language_code | strip }}`
{%- endfor -%}.
