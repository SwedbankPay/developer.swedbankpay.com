{%- assign resource=include.resource | default: 'payment order' -%}
{%- capture url -%}
    {%- include utils/documentation-section-url.md
        href='/features/technical-reference/complete-url' -%}
{%- endcapture -%}
{%- capture text -%}
The URL that Swedbank Pay will redirect back to when the payer has completed
their interactions with the payment. This does not indicate a successful
payment, only that it has reached a final (complete) state. A `GET` request
needs to be performed on the {{ resource }} to inspect it further. See
[`completeUrl`]({{ url }}) for details.
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
