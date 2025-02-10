{%- capture settlement_url -%}
    {%- include utils/documentation-section-url.md
        href='/features/balancing-the-books/settlement-reconciliation' -%}
{%- endcapture -%}
{%- capture split_url -%}
    {%- include utils/documentation-section-url.md
        href='/features/balancing-the-books/split-settlement' -%}
{%- endcapture -%}
{%- capture text -%}
The `subsite` field can be used to perform a split settlement on the payment.
The different `subsite` values must be resolved with Swedbank Pay reconciliation
before being used. If you send in an unknown `subsite` value, it will be ignored
and the payment will be settled using the merchant's default settlement account.
Must be in the format of `A-Za-z0-9`.
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
