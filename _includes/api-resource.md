{%- capture docsec -%}{%- include utils/documentation-section.md -%}{%- endcapture -%}
{%- capture api_resource -%}
    {%- case docsec -%}
    {%- when "payment-instruments" -%}
        creditcard
    {%- when "card" -%}
        creditcard
    {%- when "mobile-pay" -%}
        mobilepay
    {%- when "checkout-v2" -%}
         paymentorders
     {%- when "checkout-v3/enterprise" -%}
         paymentorders
     {%- when "checkout-v3/payments-only" -%}
         paymentorders
    {%- when "payment-menu" -%}
        paymentorders
    {%- else -%}
        {{ docsec }}
    {%- endcase -%}
{%- endcapture -%}
{{ api_resource | strip_newlines | strip -}}
