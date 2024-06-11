{%- capture url -%}
    {%- include utils/documentation-section-url.md
        href='/features/technical-reference/payment-url' -%}
{%- endcapture -%}
{%- assign resource=include.resource | default: 'payment order' -%}
{%- capture text -%}
The {% clink `paymentUrl` %}{{ url }}{% endclink %} represents the URL that
Swedbank Pay will redirect back to when the view-operation needs to be loaded,
to inspect and act on the current status of the payment, such as when the payer
is redirected out of the Seamless View (the `<iframe>`) and sent back after
completing the payment. `paymentUrl` is only used in Seamless Views and should
point to the page of where the Payment Order Seamless View is hosted. If both
`cancelUrl` and `paymentUrl` is sent, the `paymentUrl` will used. Trustly will
only be available if the `paymentUrl` is provided while using Seamless View.
When using Redirect, Trustly will appear regardless.
{%- endcapture -%}
{%- comment -%}
The following chain of Liquid filters converts newlines to spaces and removes
extranous spaces.
{%- endcomment -%}
{{- text | newline_to_br | strip_newlines | split: '<br />' | join: ' ' | strip -}}
{%- comment -%} The dashes in the Liquid code tags remove output space.
More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
