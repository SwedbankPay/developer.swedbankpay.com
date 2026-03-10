We are adding a subscribable callback method called `onPaymentButtonPressed`,
which controls if and when the payment button should delay exection.

If subscribed to, the payment button will – instead of executing the payment
directly – execute the callback method and add an event listener for the
expected “continue“ response to be generated. They delay will apply for all
payment methods running iframed within the payment UI.

If no response to continue is received within a set time limit, the payment
button will be reset and the payment UI will be opened for another attempt.

## Seamless View Functions

The [Seamless View function][swf] `resume` is crucial for the payment button
delay to work, as it allows you to resume the payment flow in cases where you
have subscribed to `onPaymentButtonPressed`. If you subscribe to this, you
_have_ to send the `resume` function to be able to finish the payment flow.

If you do not run the function with valid input before `2 minutes` has passed,
`resume` will be called automatically with the `confirmation` value of `false`.

{:.code-view-header}
**Resuming the payment with a onPaymentButtonPressed flow**

```javascript
payex.hostedView.checkout().resume({
    paymentOrderId: "string",
    confirmation: true
});
```

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrderId, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        The PaymentOrderId of the purchase you want to resume.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f confirmation, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        Boolean value that determines if the payment should continue or if you
        want to stop the payment flow due to validation issues or otherwise.
      </div>
    </div>
  </details>
</div>

## Callback Response

The callback response will contain the `paymentOrderId` currently loaded in the
iframe, and a `true` or `false` indicating if the processing should continue or
not.

A proper UI error message will to be provided from the validator if the
processing if stopped.

[swf]: /checkout-v3/technical-reference/seamless-view-functions/
