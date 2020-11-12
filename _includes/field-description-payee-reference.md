{%- assign documentation_section = include.documentation_section -%}
{%- assign describe_receipt = include.describe_receipt | default: false -%}
{%- capture payee_reference_url -%}
   {%- if documentation_section == "checkout" or documentation_section == "payment-menu" -%}
        /{{ documentation_section }}/other-features#payee-reference
    {%- else -%}
        /payment-instruments/{{ documentation_section }}/other-features#payee-reference
    {%- endif -%}
{%- endcapture -%}
{%- capture payee_reference -%}
    A unique reference from the merchant system. It is set per operation to
    ensure an exactly-once delivery of a transactional operation. See
    [`payeeReference`]({{ payee_reference_url }}) for details.

    {%- if describe_receipt -%}
        In Invoice Payments `payeeReference` is used as an invoice/receipt
        number, if the `receiptReference` is not defined.
    {%- endif -%}
{%- endcapture -%}
{{- payee_reference | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
