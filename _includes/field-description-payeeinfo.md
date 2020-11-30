{%- capture payee_info_url -%}
   {%- if include.documentation_section == "checkout" or include.documentation_section == "payment-menu" -%}
        /{{include.documentation_section}}/other-features#payeeinfo
    {%- else -%}
        /payment-instruments/{{include.documentation_section}}/other-features#payeeinfo
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
