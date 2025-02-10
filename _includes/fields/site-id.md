{%- capture url -%}
    {%- include utils/documentation-section-url.md
        href='/features/balancing-the-books/split-settlement' -%}
{%- endcapture -%}
{%- capture text -%}
`siteId` is used for split settlement transactions when you, as a merchant, need
to specify towards AMEX which sub-merchant the transaction belongs to. Must be
in the format of `A-Za-z0-9`.
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
