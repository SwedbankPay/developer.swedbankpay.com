{%- capture termsofserviceurl -%}
    The URI to the terms of service document the payer must accept in order to
    complete the payment. Note that this field is not required
    unless `generateReferenceToken` or `generateRecurrenceToken` is also submitted
    in the request. This is the Merchants, not the Swedbank Pay Terms of
    Service. **HTTPS is a requirement**.
{%- endcapture -%}
{{- termsofserviceurl | strip_newlines -}}

{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
