{% assign type = include.type | default: 'Module' %}
{% assign type_lower = type | downcase %}
{% assign use_language = include.use_language | default: false %}
{% assign active_repositories = site.github.public_repositories | where: 'archived', false %}

{% capture type_plural %}
    {% assign needle='y' %}
    {% assign haystack=type %}
    {% assign needle_size = needle | size %}
    {% assign haystack_size = haystack | size %}
    {% assign start_index = haystack_size | minus: needle_size %}
    {% assign result = haystack | slice: start_index, needle_size %}
    {% if result == needle %}
        {% assign stem = haystack | slice: 0, start_index %}
        {{ stem }}ies
    {% else %}
        {{ type }}s
    {% endif %}
{% endcapture %}

{% capture disclaimer %}
These {{ type_plural | strip }} are at an early stage of development and are not
supported as of yet by Swedbank Pay. They are provided as a convenience to speed
up your development, so please feel free to play around. However, if you need
support, please wait for a future, stable release.
{% endcapture %}

{% include alert.html type="warning" icon="warning" header="Unsupported"
body=disclaimer %}

{:.table .table-striped}
| Platform | {{ type }} | Repository |
| :------: | :--------- | :--------- |
{%- for repository in active_repositories -%}
  {%- if repository.topics contains type_lower %}
    {%- assign title = repository.description | remove: '(Beta)' | strip | replace: 'Payments', '**Payments**' | replace: 'Checkout', '**Checkout**' %}
    {%- assign name = repository.name | replace: 'swedbank-pay-', '…' %}
|   {%- if use_language -%}
        {% include logo.md platform=repository.language %}
    {%- else -%}
        {%- for topic in repository.topics -%}{%- include logo.md platform=topic -%}{%- endfor -%}
    {%- endif -%}
|   {% if repository.homepage != empty -%}[{{ title }}]({{ repository.homepage }})
    {%- else -%} {{ title }}
    {%- endif -%} | [`{{ name }}`]({{ repository.html_url }})
  {%- endif -%}
{%- endfor %}
