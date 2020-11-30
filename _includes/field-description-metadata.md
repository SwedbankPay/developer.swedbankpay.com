{%- capture metadata_url -%}
   {%- if include.documentation_section == "checkout" or include.documentation_section == "payment-menu" -%}
        /{{include.documentation_section}}/other-features#metadata
    {%- else -%}
        /payment-instruments/{{include.documentation_section}}/other-features#metadata
    {%- endif -%}
{%- endcapture -%}
{%- capture metadata -%}
    The keys and values that should be associated with the payment. Can be
    additional identifiers and data you want to associate with the payment.
    Read more about this in the [`metadata`]({{ metadata_url }}) section.
{%- endcapture -%}
{{- payee_reference | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
