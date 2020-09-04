{%- assign api_resource = include.api_resource -%}
{% case api_resource %}
{% when "creditcard" %}
{%- capture language -%}
`sv-SE`, `nb-NO`, `da-DK`, `de-DE`, `ee-EE`, `en-US`, `es-ES`, `fr-FR`, `lv-LV`,
`lt-LT`, `ru-RU` or `fi-FI`.
{%- endcapture -%}

{% when "mobilepay" %}
{%- capture language -%}
`da-DK`, `fi-FI` or `en-US`.
{%- endcapture -%}

{% else %}
{%- capture language -%}
`sv-SE`, `nb-NO` or `en-US`.
{%- endcapture -%}
{% endcase %}

{{- language | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
