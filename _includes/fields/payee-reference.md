{%- capture documentation_section -%}{%- include utils/documentation-section.md fallback="card" -%}{%- endcapture -%}
{%- assign describe_receipt = include.describe_receipt | default: false -%}
{%- capture documentation_section -%}{%- include utils/documentation-section.md -%}{%- endcapture -%}
{% if documentation_section == "card" %}
  {% assign payee_reference_max_length = 50 %}
{% else %}
  {% assign payee_reference_max_length = 30 %}
{% endif %}
{%- capture payee_reference_url -%}
    {%- if documentation_section == nil or documentation_section == empty -%}
        {%- assign payee_reference_url = "/checkout-v3/get-started/fundamental-principles#payee-reference" -%}
    {%- else -%}
        {%- include utils/documentation-section-url.md href="/features/technical-reference/payee-reference" -%}
    {%- endif -%}
{%- endcapture -%}
{%- capture payee_reference -%}
    A unique reference from the merchant system. Set per operation to
    ensure an exactly-once delivery of a transactional operation. Length and
    content validation depends on whether the `transaction.number` or the
    `payeeReference` is sent to the acquirer. **If Swedbank Pay handles the**
    **settlement**, the `transaction.number` is sent to the acquirer and the
    `payeeReference` must be in the format of `A-Za-z0-9` and
    `string({{ payee_reference_max_length }})`. **If you handle the settlement**,
    Swedbank Pay will send the `payeeReference` and it will be limited to the
    format of `string(12)`. All characters **must be digits**.

    {% if describe_receipt %}
        In Invoice Payments `payeeReference` is used as an invoice/receipt
        number, if the `receiptReference` is not defined.
    {% endif %}
{%- endcapture -%}
{{- payee_reference | newline_to_br | strip_newlines | split: '<br />' | join: ' ' | strip -}}
{%- comment -%}
The dashes in the Liquid code tags remove output space. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
