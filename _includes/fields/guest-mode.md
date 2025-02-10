{%- capture text -%}
Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not.
When using the Enterprise implementation, this is triggered by not including a
`payerReference` or `nationalIdentifier` in the original payment order request.
{%- endcapture -%}
{%- comment -%}
The following chain of Liquid filters converts newlines to spaces and removes
extranous spaces.
{%- endcomment -%}
{{- text | newline_to_br | strip_newlines | split: '<br />' | join: ' ' | strip -}}
{%- comment -%}
The dashes in the Liquid code tags remove output space. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
