## Unscheduled Purchase

{% include alert.html type="warning" icon="warning" body="Please note that this
feature is only available through Payment Order, and the service is asynchronous
which will require a compatible implementation. Using a similar implementation
to Credit Card Recur will therefore not work." %}

An `unscheduled purchase`, also called a Merchant Initiated Transaction (MIT),
is a payment which uses a `paymentToken` generated through a previous payment in
order to charge the same card at a later time. They are done by the merchant
without the user being present.

To use this, you need to make sure `directDebitEnabled` is `true` in the Trustly
contract. After that you need to have the field `generateUnscheduledToken` set
to `true` when creating an initial Purchase or Verify. Another important step is
to make sure the `email` field is set, as this is a required parameter. If the
`email` is missing, Trustly will not be available for selection from the
payments menu.

If you enable `callbackEnabled` and send a `callbackUrl`, you can expect to get
a callback when the payment is finised. The alternative is setting up polling to
poll for a state.

## Creating The Payment

*   You need to `POST` a [Purchase payment][trustly-paymentorder-create] / and
    generate an unscheduled token (for later use). As mentioned, the `email`
    parameter MUST be set for trustly to appear as an available option

*   You need to `POST` a [Verify payment][trustly-paymentorder-create] / and
    generate an unscheduled token (for later use). As mentioned, the `email`
    parameter MUST be set for trustly to appear as an available option

## Delete Unscheduled Token

You can delete a created unscheduled token. Please see technical reference for
details [here][trustly-remove-payment-token].

<!--lint disable final-definition -->

[trustly-remove-payment-token]: /old-implementations/payment-menu-v2/features/optional/delete-token
[trustly-paymentorder-create]: /old-implementations/payment-menu-v2/payment-order
