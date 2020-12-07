{%- capture documentation_section -%}{%- include documentation-section.md -%}{%- endcapture -%}
{%- capture payee_info_url -%}
   {%- if documentation_section == "checkout" or documentation_section == "payment-menu" -%}
        /{{ documentation_section }}/features/technical-reference/payee-info
    {%- else -%}
        /payment-instruments/{{ documentation_section }}/features/technical-reference/payee-info
    {%- endif -%}
{%- endcapture -%}
{%- capture payee_info -%}
    The `payeeInfo` object, containing information about the payee (the recipient of the money).
    See [`payeeInfo`]({{ payee_info_url }}) for details.
{%- endcapture -%}
{{- payee_info | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
