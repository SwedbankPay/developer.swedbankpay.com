{%- capture api_resource -%}{%- include api-resource.md -%}{%- endcapture -%}
{%- capture language -%}
    {%- case api_resource -%}
        {% when "creditcard" %}
            Allowed locale code values: `sv-SE`, `nb-NO`, `da-DK`, `de-DE`, `ee-EE`, `en-US`, `es-ES`, `fr-FR`,
            `lv-LV`, `lt-LT`, `ru-RU` or `fi-FI`.
        {% when "mobilepay" %}
            Allowed locale code values: `da-DK`, `fi-FI` or `en-US`.
        {% when "paymentorders" %}
            Allowed locale code values: `sv-SE`, `nb-NO`, `da-DK`, `en-US` or `fi-FI`.
        {% else %}
            Allowed locale code values: `sv-SE`, `nb-NO` or `en-US`.
    {%- endcase -%}
{%- endcapture -%}

{{- language | strip_newlines | strip -}}
{%- comment -%}
The dashes in the Liquid code tags remove output space. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
