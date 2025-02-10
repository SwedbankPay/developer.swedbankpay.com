{%- assign numbered_resource=include.resource | default: 'transaction' -%}
{%- capture text -%}
The {{ numbered_resource }} `number`, useful when there's need to reference the
{{ numbered_resource }} in human communication. Not usable for programmatic
identification of the {{ numbered_resource }}, where `id` should be used
instead.
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
