{%- capture documentation_section -%}{%- include utils/documentation-section.md -%}{%- endcapture -%}
{%- capture metadata_url -%}
   {%- if documentation_section contains "checkout" or documentation_section contains "payment-menu" -%}
        /{{documentation_section}}/features/technical-reference/metadata
    {%- else -%}
        /old-implementations/payment-instruments-v1/{{documentation_section}}/features/technical-reference/metadata
    {%- endif -%}
{%- endcapture -%}
{%- capture metadata -%}
    The keys and values that should be associated with the payment. Can be
    additional identifiers and data you want to associate with the payment.
    Read more about this in the [`metadata`]({{ metadata_url }}) section.
{%- endcapture -%}
{{- payee_reference | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output space. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
