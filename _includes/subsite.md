{% assign instrument = include.payment-instrument | default: false %}

{% if instrument=="card" %}
    {% assign payeeReferenceLength = "50" %}
{% elsif instrument=="credit-account" %}
    {% assign payeeReferenceLength = "50" %}
{% elsif instrument=="invoice" %}
    {% assign payeeReferenceLength = "50" %}
{% elsif instrument=="swish" %}
    {% assign payeeReferenceLength = "35" %}
{% elsif instrument=="vipps" %}
    {% assign payeeReferenceLength = "30" %}
{% elsif instrument=="mobilepay" %}
    {% assign payeeReferenceLength = "50" %}
{% elsif instrument=="checkout" %}
    {% assign payeeReferenceLength = "30" %}
{% else %}
    {% assign payeeReferenceLength = "30" %}
{% endif %}

## Subsite
