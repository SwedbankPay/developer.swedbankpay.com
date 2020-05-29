{%- assign haystack = include.word -%}
{%- assign needle = 'y' -%}
{%- assign needle_size = needle | size -%}
{%- assign haystack_size = haystack | size -%}
{%- assign start_index = haystack_size | minus: needle_size -%}
{%- assign result = haystack | slice: start_index, needle_size -%}
{%- capture plural -%}
    {%- if result == needle -%}
        {%- assign stem = haystack | slice: 0, start_index -%}
        {{- stem -}}ies
    {%- else -%}
        {{- haystack -}}s
    {%- endif -%}
{%- endcapture -%}
{{- plural | strip -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
