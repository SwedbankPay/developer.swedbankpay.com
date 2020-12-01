{%- capture documentation_section -%}{%- include documentation-section.md -%}{%- endcapture -%}
{%- capture api_resource -%}
    {%- case documentation_section -%}
    {%- when empty -%}
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
