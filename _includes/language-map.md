{%- assign code = include.language_code | remove: " " | strip -%}
{%- capture language_name -%}
    {%- case code -%}
        {%- when "da-DK" -%}
            Danish
        {%- when "de-DE" -%}
            German
        {%- when "ee-EE" -%}
            Estonian
        {%- when "en-US" -%}
            English (US)
        {%- when "es-ES" -%}
            Spanish
        {%- when "fi-FI" -%}
            Finnish
        {%- when "fr-FR" -%}
            French
        {%- when "lt-LT" -%}
            Lithuanian
        {%- when "lv-LV" -%}
            Latvian
        {%- when "nb-NO" -%}
            Norwegian
        {%- when "ru-RU" -%}
            Russian
        {%- when "sv-SE" -%}
            Swedish
        {% else %}
            Unknown
    {%- endcase -%}
{%- endcapture -%}
{{- language_name -}}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
