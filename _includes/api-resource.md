{%- capture docsec -%}{%- include utils/documentation-section.md -%}{%- endcapture -%}
{%- capture api_resource -%}
    {%- case docsec -%}
    {%- when "old-implementations/payment-instruments-v1" -%}
        creditcard
    {%- when "card" -%}
        creditcard
    {%- when "mobile-pay" -%}
        mobilepay
    {%- when "old-implementations/checkout-v2" -%}
         paymentorders
    {%- when "checkout-v3" -%}
         paymentorders
    {%- when "old-implementations/enterprise" -%}
         paymentorders
    {%- when "checkout-v3/payments-only" -%}
         paymentorders
    {%- when "old-implementations/payment-menu-v2" -%}
        paymentorders
    {%- else -%}
        {{ docsec }}
    {%- endcase -%}
{%- endcapture -%}
{{ api_resource | strip_newlines | strip -}}
