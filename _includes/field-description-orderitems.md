{%- capture orderitems -%} The array of items being purchased with the order.
    Note that authorization orderItems will not be printed on invoices, so lines
    meant for print must be added in the Capture request. The authorization
    `orderItems` will, however, be used in the Admin system when captures or
    reversals are performed, and might be shown other places later. It is
    required to use this field to be able to send Capture `orderItems`.
    `Capture` requests should only contain items meant to be captured from the
    order.
    {%- endcapture -%} {{- orderitems | strip_newlines-}}
    {%- comment -%} The dashes in the Liquid code tags remove output space.
More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
