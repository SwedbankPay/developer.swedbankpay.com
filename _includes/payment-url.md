{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include documentation-section.md %}{% endcapture %}
{% assign when = include.when | default: "selecting the payment instrument" %}
{% assign full_reference = include.full_reference | default: false %}

{% if api_resource == "paymentorders" %}
    {% assign entity = "Payment Order" %}
{% else %}
    {% assign entity = "Payment" %}
{% endif %}

## Payment Url

For our Seamless Views, the field called `paymentUrl` will be used when the
payer is redirected out of the Seamless View (the `iframe`). The payer is
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

{% include alert.html type="informative" icon="info" body=notice %}

With `paymentUrl` in place, the retry process becomes much more convenient for
both the integration and the payer.

{% if full_reference %}

`paymentUrl` is used by the Seamless View flow and **must** be used for
WebView-based app implementations. Some payment instruments only work when
owning the full browser page (no use of `<iframe>`), this will be solved by
doing a full browser (top frame) redirect out of the Seamless View. 3-D Secure
requires this, for example.

For mobile flows, some payment instruments work best when app-to-app switching
is enabled and handled automatically (Swish, Vipps etc). To solve this, it is
important that the third party app or site understand where to redirect the
payer back to after the flow on their end is completed.

The `paymentUrl` is the URL Swedbank Pay will provide to the third party for
handling the redirect back to your site or app. When receiving the payer back
on the `paymentUrl` either in an app or web page, it is important to restore the
Seamless View to let the payment finalize the flow. For in-app it is important
that you either implement the `onPaymentCompleted` event or let the Seamless
View redirect to the `completeUrl` before intercepting the WebView. If you
intercept the WebView when the payer's device is redirected to the `paymentUrl`
it can lead to issues. If you want to handle payment errors in your own code,
you should also subscribe to other events provided by the Seamless View
JavaScript and shut down the Seamless View if any of these events occur.

Events to subscribe to for full control over the payment flow are can be found
in {% if api_resource == "paymentorders" %}
[Payment Menu Events](/{{ documentation_section }}/other-features#payment-menu-events).
{% else %}
[Seamless View Events](/payment-instruments/{{ documentation_section }}/other-features#seamless-view-events).
{% endif %}

When implementing the Seamless View flow into a WebView in your mobile app, you
should use a [custom scheme][custom-scheme] or [Universal Link][universal-link]
in the `paymentUrl` for handling automatic switching between your app and the
payment app on the mobile device.

{% endif %}
[custom-scheme]: https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content/defining_a_custom_url_scheme_for_your_app
[universal-link]: https://developer.apple.com/ios/universal-links/
