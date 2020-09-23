{%- capture text -%}
Indicates the state of the transaction, usually `initialized`, `completed` or
`failed`. If a partial {{ transaction }} has been done and further transactions
are possible, the state will be `awaitingActivity`.
{%- endcapture -%}
{{- text | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
