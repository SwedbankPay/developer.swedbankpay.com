{%- capture termsofserviceurl -%}
    The URI to the terms of service document which the payer must accept in
    order to complete the payment. **HTTPS is a requirement**.
{%- endcapture -%}
{{- termsofserviceurl | strip_newlines -}}

{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
