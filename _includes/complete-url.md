## CompleteUrl

This URL will be used by Swedbank Pay when a payment is Completed or Failed. 
If your integration subscribes to the `OnPaymentCompleted` and possibly the 
`onPaymentFailed` event no redirect or use of the `completeUrl` will take place. 
But if you do not implement any method callback for the `OnPaymentCompleted` event
the Swedbank Pay javascript will redirect the top frame to the `completeUrl`. 
You will still need to call a `GET` on the payment 
resource to find the finale status (Completed or Failed).