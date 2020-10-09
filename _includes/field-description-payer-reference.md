{%- assign documentation_section = include.documentation_section -%}
{%- capture payer_aware_payment_menu_url -%}
   {%- if documentation_section == "payment-menu" -%}
        /{{ documentation_section }}/other-features#payer-aware-payment-menu
    {%- endif -%}
{%- endcapture -%}
{%- capture payer_reference -%}
    {%- if documentation_section == "payment-menu" -%}
        The reference to the payer from the merchant system, like e-mail address, 
        mobile number, customer number etc. Also used in [Payer Aware Payment Menu]({{payer_aware_payment_menu_url}}). 
    {%- else -%}
        The reference to the payer from the merchant system, like e-mail address, 
        mobile number, customer number etc.
    {%- endif -%}
{%- endcapture -%}
{{- payer_reference | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}

   
