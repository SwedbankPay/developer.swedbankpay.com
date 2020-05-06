{%- assign payment_instrument = include.payment_instrument -%}
{%- assign payment_instrument_title = payment_instrument -%}
​
{%- capture languages -%}
Swedish `sv-SE`, English (UK) `ee-EE` and Norwegian `nb-NO`.
{%- endcapture -%}
​
{%- case payment_instrument -%}
{%- when "creditcard" -%}
{%- assign payment_instrument_title = "Card" -%}
{%- capture languages -%}
Swedish `sv-SE`, Norwegian `nb-NO`, Danish `da-DK`, Deutch `de-DE`,
English (UK) `ee-EE`, English (US) `en-US`, Spanish `es-ES`, French `fr-FR`,
Latvian `lv-LV`, Lithuanian `lt-LT`, Russian `ru-RU` and Finnish `fi-FI`.
{%- endcapture -%}

{%- when "mobilepay" -%}
{%- assign payment_instrument_title = "MobilePay" -%}
{%- capture languages -%}
Swedish `sv-SE`, English (UK)`ee-EE`, Norwegian `nb-NO`, Danish `da-DK` and
Finnish `fi-FI`.
{%- endcapture -%}
{%- endcase -%}
​
{{ payment_intrument_title }} supports the folowing languages:
{{ languages | strip_newlines}}.
