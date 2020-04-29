{% assign payment_instrument = include.payment_instrument %}
{%- if payment_instrument == "checkout" -%}
{%- capture description -%}
    A 40 character length textual [description](/{{ payment_instrument }}/other-features#description) of the purchase.
{%- endcapture -%}
{%- else -%}
{%- capture description -%}
    A 40 character length textual [description](/payments/{{ payment_instrument }}/other-features#description) of the purchase.
{%- endcapture -%}
{%- endif -%}
{{- description | strip_newlines -}}

{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

https://shopify.github.io/liquid/basics/whitespace/

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
