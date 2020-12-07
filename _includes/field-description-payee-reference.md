{%- capture documentation_section -%}{%- include documentation-section.md fallback="card" -%}{%- endcapture -%}
{%- assign describe_receipt = include.describe_receipt | default: false -%}
{%- capture documentation_section -%}{%- include documentation-section.md -%}{%- endcapture -%}
{% if documentation_section == nil or documentation_section == empty %}
    {% assign payee_reference_url = "/introduction#payee-reference" %}
{% else %}
    {%- capture payee_reference_url -%}
    {%- if documentation_section == "checkout" or documentation_section == "payment-menu" -%}
            /{{ documentation_section }}/features/technical-reference/payee-reference
        {%- else -%}
            /payment-instruments/{{ documentation_section }}/features/technical-reference/payee-reference
        {%- endif -%}
    {%- endcapture -%}
{%- endif -%}
{%- capture payee_reference -%}
    A unique reference from the merchant system. It is set per operation to
    ensure an exactly-once delivery of a transactional operation. See
    [`payeeReference`]({{ payee_reference_url }}) for details.

    {% if describe_receipt %}
        In Invoice Payments `payeeReference` is used as an invoice/receipt
        number, if the `receiptReference` is not defined.
    {% endif %}
{%- endcapture -%}
{{- payee_reference | newline_to_br | strip_newlines | split: '<br />' | join: ' ' | strip -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
