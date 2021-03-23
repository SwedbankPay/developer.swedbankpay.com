{%- capture documentation_section -%}{%- include documentation-section.md -%}{%- endcapture -%}
{%- capture metadata_url -%}
   {%- if documentation_section contains "checkout" or documentation_section == "payment-menu" -%}
        /{{documentation_section}}/features/technical-reference/metadata
    {%- else -%}
        /payment-instruments/{{documentation_section}}/features/technical-reference/metadata
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
