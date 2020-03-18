{% assign when = include.when | default: "selecting the payment instrument" %}
{% assign payment_order = include.payment_order | default: false %}

{% if payment_order %}
    {% assign entity = "Payment Order" %}
{% else %}
    {% assign entity = "Payment" %}
{% endif %}

For our Seamless Views, the field called `paymentUrl` will be used when the
consumer is redirected out of the Seamless View (the `iframe`). The consumer is
redirected out of frame when {{ when }}.

The URL should represent the page of where the {{ entity }} Seamless View was
hosted originally, such as the checkout page, shopping cart page, or similar.
Basically, `paymentUrl` should be set to the same URL as that of the page where
the JavaScript for the Seamless View was added to in order to initiate the
payment process.

{% capture notice %}
Please note that the `paymentUrl` must be able to invoke the same JavaScript URL
from the same {{ entity }} as the one that initiated the payment process
originally, so it should include some sort of state identifier in the URL. The
state identifier is the ID of the order, shopping cart or similar that has the
URL of the Payment stored.
{% endcapture %}

{% include alert.html type="neutral" icon="info" body=notice %}

With `paymentUrl` in place, the retry process becomes much more convenient for
both the integration and the payer.
