{%- capture orderitems -%}
    The array of items being purchased with the order.
    Used to print on invoices if the payer chooses to pay with invoice, among
    other things. `orderItems` is required in all requests.
    In `capture` requests it should only contain the items to be captured from the order.
{%- endcapture -%}
{{- orderitems | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
