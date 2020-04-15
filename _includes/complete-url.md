## CompleteUrl

This URL will be used by Swedbank Pay when a payment is `Completed` or `Failed`.
If your integration subscribes to the `onPaymentCompleted` and possibly the
`onPaymentFailed` event, no redirect or use of the `completeUrl` will take
place. But if you do not have any event handler for the `onPaymentCompleted`
event, the Swedbank Pay JavaScript will perform an HTTP redirect in the top
frame to the `completeUrl`. You will still need to do a `GET` request on the
payment resource to find the final status (`Completed` or `Failed`).
