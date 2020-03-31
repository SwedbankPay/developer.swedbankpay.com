{% assign when = include.when | default: "selecting the payment instrument" %}
{% assign payment_order = include.payment_order | default: false %}
{% assign full_reference = include.full_reference | default: false %}

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

{% if full_reference %}

## PaymentUrl

This parameter is used by the seamless view flow (must be used for App webview
design).
Some payment instruments only works when
owning the full browser page (no iframes), this will be solved by redirecting
out of the seamless view (3-D secure etc). For mobile flows some payment
instruments works best when App2App switching is enabled and handled
automatically (Swish, Vipps etc). To solve this it is important that the third
party app or site understand where to redirect the consumer back to after the
flow on their end is completed. The paymentUrl is where you provide Swedbank Pay
with an endpoint that we will provide to the third party for handling this
redirect back to your site/App. When receiving the consumer back on the
paymentUrl either in an App or on the web page it is important to restore
the seamless view to let the payment finalize the flow.
For InApp it is important that you either implement the OnPaymentCompleted
event or let the seamless view redirect to the completeUrl before intercepting
the web view. If you intercept the web view when the consumer device is
redirected to the paymentUrl can lead to issues. If you want to handle payment
errors in your own code you should also subscribe to other events provided by
the seamless view javascript and shut down the seamless view if any of this
events occurs. Events to subscribe to for full control over the payment flow:

• OnError: will trigger any time a system error occur from the javascript
• OnPaymentFailed: will call registrered endpoint if provided. If not
subscribed to will redirect to conpleteUrl
• OnPaymentCanceled: will be called if the payment is aborted by the consumer
or triggered by you with the Abort command on the payment
• OnPaymentTransactionFailed: this will trigger if one payment attempt failed.
Standard functionality are to let the consumer be able to retry the payment from
the payment page.

When implementing the seamless view flow into a web view in your mobile app
you should send in a custom scheme in the paymentUrl for handling automatic
switching between your app and the payment app on the mobile device.

{% endif %}
