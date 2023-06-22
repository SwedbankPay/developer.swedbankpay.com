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
     {%- when "digital-payments/enterprise" -%}
         paymentorders
     {%- when "digital-payments/payments-only" -%}
         paymentorders
    {%- when "payment-menu" -%}
        paymentorders
    {%- else -%}
        {{ docsec }}
    {%- endcase -%}
{%- endcapture -%}
{{ api_resource | strip_newlines | strip -}}
