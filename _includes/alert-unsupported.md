{% capture disclaimer %}
These {{ include.type }} are at an early stage of development and are not
supported as of yet by Swedbank Pay. They are provided as a convenience to speed
up your development, so please feel free to play around. However, if you need
support, please wait for a future, stable release.
{% endcapture %}

{% include alert.html type="warning" icon="warning" header="Unsupported"
body=disclaimer %}
