{%- capture api_resource -%}{%- include api-resource.md -%}{%- endcapture -%}
{%- capture language -%}
    {%- case api_resource -%}
        {% when "creditcard" %}
            `sv-SE`, `nb-NO`, `da-DK`, `de-DE`, `ee-EE`, `en-US`, `es-ES`, `fr-FR`,
            `lv-LV`, `lt-LT`, `ru-RU` or `fi-FI`.
        {% when "mobilepay" %}
            `da-DK`, `fi-FI` or `en-US`.
        {% when "paymentorders" %}
            `sv-SE`, `nb-NO`, `da-DK`, `en-US` or `fi-FI`.
        {% else %}
            `sv-SE`, `nb-NO` or `en-US`.
    {%- endcase -%}
{%- endcapture -%}

{{- language | strip_newlines | strip -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
