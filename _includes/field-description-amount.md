{%- assign currency = include.currency | default: "SEK" -%}
{% if currency == empty %}
{% assign currency = "SEK" %}
{% endif %}
{%- capture amount_text -%}
The amount (including VAT, if any) to charge the payer, entered in the lowest monetary unit of the selected currency. E.g.:&nbsp;
**`10000`** = `100.00` {{ currency }},&nbsp;
**`5000`** = `50.00` {{ currency }}.
{%- endcapture -%}
{{- amount_text | strip_newlines | replace: "&nbsp;", " " -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
