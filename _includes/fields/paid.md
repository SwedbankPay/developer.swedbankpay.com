{%- capture url -%}
    {%- include utils/documentation-section-url.md
        href='/features/technical-reference/resource-sub-models#paid' -%}
{%- endcapture -%}
{%- capture text -%}
The URL to the {% clink `paid` resource %}{{ url }}{% endclink %} where
information about the paid transactions, including any possibly created tokens,
can be retrieved.
{%- endcapture -%}
{{- text | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output space. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
