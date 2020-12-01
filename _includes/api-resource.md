{%- capture docsec -%}{%- include documentation-section.md -%}{%- endcapture -%}
{%- capture api_resource -%}
    {%- case docsec -%}
    {%- when "payment-instruments" -%}
        creditcard
    {%- when "card" -%}
        creditcard
    {%- when "mobile-pay" -%}
        mobilepay
    {%- when "checkout" -%}
        paymentorders
    {%- when "payment-menu" -%}
        paymentorders
    {%- else -%}
        {{ docsec }}
    {%- endcase -%}
{%- endcapture -%}
{{ api_resource | strip_newlines | strip -}}
