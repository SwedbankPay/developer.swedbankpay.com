{%- assign payment_instrument = include.payment_instrument -%}
{%- if payment_instrument == "mobilepay"-%}
    {%- assign payment_instrument ="mobile-pay" -%}
{%- endif -%}
{%- if payment_instrument == "paymentorders"-%}
    {%- assign payment_instrument ="checkout" -%}
{%- endif -%}
{%- assign description_url=payment_instrument | prepend: "/" | append: "/other-features#description" -%}
{%- if payment_instrument != "checkout"-%}
    {%- assign description_url=description_url | prepend:  "/payments" -%}
{%- endif -%}
{%- capture description -%}
    A 40 character length textual [description]({{ description_url }}) of the purchase.
{%- endcapture -%}
{{- description | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

https://shopify.github.io/liquid/basics/whitespace/

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
