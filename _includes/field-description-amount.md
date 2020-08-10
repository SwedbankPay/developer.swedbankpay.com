{%- assign currency = include.currency | default: "SEK" -%}
{% if currency == empty %}
{% assign currency = "SEK" %}
{% endif %}
{%- capture amount_text -%}
The transaction amount (including VAT, if any) entered in the lowest monetary
unit of the selected currency. E.g.:
**`10000`** = `100.00` {{ currency }},
**`5000`** = `50.00` {{ currency }}.
{%- endcapture -%}
{%- comment -%}
First convert newlines to '<br />', strip all newlines, split into an array
on '<br />' as a separator, then join the array back into a string separated
by ' ' (a space) and then strip extraneous whitespace.
{%- endcomment -%}
{{- amount_text | newline_to_br | strip_newlines | split: '<br />' | join: ' ' | strip -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
