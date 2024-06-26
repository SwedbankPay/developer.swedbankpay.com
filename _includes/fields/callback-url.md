{%- assign resource=include.resource | default: 'payment order' -%}
{%- capture url -%}
        {%- if features_url contains "checkout-v3" -%}
        {%- include utils/documentation-section-url.md
        href='/features/payment-operations/callback' -%}
    {%- else -%}
    {%- include utils/documentation-section-url.md
        href='/features/core/callback' -%}
    {%- endif -%}
{%- endcapture -%}
{%- capture text -%}
The URL that Swedbank Pay will perform an HTTP `POST` against every time a
transaction is created on the {{ resource }}. See [callback]({{ url }}) for
details.
{%- endcapture -%}
{%- comment -%}
The following chain of Liquid filters converts newlines to spaces and removes
extranous spaces.
{%- endcomment -%}
{{- text | newline_to_br | strip_newlines | split: '<br />' | join: ' ' | strip -}}
{%- comment -%} The dashes in the Liquid code tags remove output space.
More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
