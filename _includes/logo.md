{%- assign platform = include.platform | downcase -%}
{%- case platform -%}
    {%- when "c#" -%}
        {%- assign platform = "dotnet" -%}
    {%- when "kotlin" -%}
        {%- assign platform = "android" -%}
    {%- when "typescript" -%}
        {%- assign platform = "js" -%}
{%- endcase -%}
{%- assign file_name = platform | prepend: '/' | append: '.svg' -%}
{%- for file in site.static_files -%}
    {%- if file.path contains '/assets/img/logos/' and file.path contains file_name -%}
![{{ include.platform }}](/assets/img/logos/{{ platform }}.svg)
    {%- else -%}
<!-- {{ include.platform }} -->
    {%- endif -%}
{%- endfor -%}
{%- comment -%}
The dashes in the Liquid code tags remove output whitespace. More on that here:

<https://shopify.github.io/liquid/basics/whitespace/>

It's essential to have control over newlines in this file. If unintentional
newlines sneak into what's rendered by this include, it will break all tables
it is included in, so please beware.
{%- endcomment -%}
