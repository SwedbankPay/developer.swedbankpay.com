{%- assign payment_instrument = include.payment_instrument -%}
{%- assign payment_instrument_title = payment_instrument | capitalize -%}
{%- assign language_codes = "en-US, nb-NO, sv-SE" -%}
​​
{%- case payment_instrument -%}
    {%- when "creditcard" -%}
        {%- assign payment_instrument_title = "Card" -%}
        {%- assign language_codes="da-DK, de-DE, ee-EE, en-US, es-ES, fi-FI, fr-FR, lt-LT, lv-LV, nb-NO, ru-RU, sv-SE" -%}
    {%- when "mobilepay" -%}
        {%- assign payment_instrument_title = "MobilePay" -%}
        {%- assign language_codes="da-DK, en-UK, en-US, fi-FI, nb-NO, sv-SE" -%}
{%- endcase -%}

{%- assign language_codes = language_codes | split: ',' -%}

{{ payment_instrument_title }} supports the folowing languages:
{% for language_code in language_codes %}
{%- if forloop.last -%}
 and {% comment %}Keep this to preserve the space after 'and'!{% endcomment %}
{%- elsif forloop.first -%}
{%- else -%}
, {% comment %}Keep this to preserve the space after the comma!{% endcomment %}
{%- endif -%}
{% include language-map.md language_code=language_code %} `{{ language_code | strip }}`
{%- endfor -%}.
