{%- assign resource = include.resource | default: "payment" -%}
{%- assign sub_resource = include.sub_resource | default: empty -%}
{%- if sub_resource != empty -%}
    {%- capture sub_resource_text -%}
        this `{{ sub_resource }}` belongs to
    {%- endcapture -%}
{%- endif -%}
{%- capture id_text -%}
    The relative URL and unique identifier of the
    `{{ resource }}` resource {{ sub_resource_text }}.
    Please read about [URL Usage](/introduction#url-usage) to
    understand how this and other URLs should be used in your solution.
{%- endcapture -%}
{{- id_text | strip_newlines -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
