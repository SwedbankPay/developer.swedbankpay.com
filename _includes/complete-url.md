{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}

{% if documentation_section contains "checkout-v3" %}

## CompleteUrl

This URL will be used by Swedbank Pay when a payment is `Completed` or `Failed`.
If your integration subscribes to the `onPaid` and possibly the `onFailed`
event, no redirect or use of the `completeUrl` will take place. But if you do
not have any event handler for the `onPaymentCompleted` event, the Swedbank Pay
JavaScript will perform an HTTP redirect in the top frame to the `completeUrl`.
You will still need to do a `GET` request on the payment resource to find the
final status (`Completed` or `Failed`).

{% else %}

## CompleteUrl

This URL will be used by Swedbank Pay when a payment is `Completed` or `Failed`.
If your integration subscribes to the `onPaymentCompleted` and possibly the
`onPaymentFailed` event, no redirect or use of the `completeUrl` will take
place. But if you do not have any event handler for the `onPaymentCompleted`
event, the Swedbank Pay JavaScript will perform an HTTP redirect in the top
frame to the `completeUrl`. You will still need to do a `GET` request on the
payment resource to find the final status (`Completed` or `Failed`).

{% endif %}
