{%- capture documentation_section -%}{%- include utils/documentation-section.md -%}{%- endcapture -%}
{% assign features_url = documentation_section | prepend: '/' | append: '/features' %}
{%- capture logo_description -%}
    {%- if documentation_section contains "payment-menu" or documentation_section contains "checkout" -%}
    With permission and activation on your contract (if you are using Seamless
    View), sending in a `logoUrl` will replace the Swedbank Pay logo with the
    logo sent in. If you do not send in a `logoUrl`, then no logo and no text is
    shown. Without permission or activation on your contract, sending in a
    `logoUrl` has no effect. The logo must be a picture with maximum 50px height
    and 400px width. Requires HTTPS. Read more about this in
    {% if documentation_section contains "checkout-v3" %} [Custom Logo]({{ features_url }}/customize-ui/custom-logo) {% else %} [Custom Logo]({{ features_url }}/optional/custom-logo) {% endif %}.
    {%- else -%}
    The URL that will be used for showing the customer logo. It must be a
    picture with maximum 50px height and 400px width. HTTPS is required.
     {%- endif -%}
{%- endcapture -%}
{{- logo_description | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output space. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
