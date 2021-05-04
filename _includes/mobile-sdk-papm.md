## Payer Aware Payment Menu

Using Payer Aware Payment Menu involves managing payment tokens yourself. If
you are using a Merchant Backend, you can have a payment order create payment
tokens by setting the `generatePaymentToken` and `payerReference` fields of
`PaymentOrder` and `PaymentOrderPayer`, respectively.

{:.code-view-header}
**Android**

```kotlin
val paymentOrder = PaymentOrder(
    ...,
    generatePaymentToken = true,
    payer = PaymentOrderPayer(
        payerReference = "user1234"
    )
    ...
)
```

{:.code-view-header}
**iOS**

```swift
paymentOrder.generatePaymentToken = true
paymentOrder.payer = PaymentOrderPayer(
    payerReference: "user1234"
)
```

### Token Retrieval

The SDK contains a utility method to query a conforming Merchant Backend server
for the payment tokens of a particular `payerReference`. Of course, you should
have proper authentication in your implementation if you use this
functionality, to prevent unauthorized access to other users' tokens (the
example implementation has the endpoint disabled by default).

The utility method allows you to add extra header to the request; these can
be useful for implementing authentication.

{:.code-view-header}
**Android**

```kotlin
// N.B! getPayerOwnedPaymentTokens is a suspending function,
// so this call must be done inside suspending code.
// If the backend responds with a Problem, the call will throw
// a RequestProblemException.
val response = MerchantBackend.getPayerOwnedPaymentTokens(
    context,
    configuration,
    payerReference,
    "ExampleHeader", "ExampleValue"
)
```

{:.code-view-header}
**iOS**

```swift
let request = SwedbankPaySDK.MerchantBackend.getPayerOwnedPaymentTokens(
    configuration: configuration,
    payerReference: payerReference,
    extraHeaders: [
        "ExampleHeader": "ExampleValue"
    ]
) { result in
    // Use result here.
    // Be prepared for any errors of the type
    // SwedbankPaySDK.MerchantBackendError.
}
// If you need to cancel the request before it is complete, call
// request.cancel()
```

### Token Use

To use a payment token with a Merchant Backend, create a payment order where
you set the `paymentToken` field of `PaymentOrder` and the `payerReference`
field of `PaymentOrderPayer`:

{:.code-view-header}
**Android**

```kotlin
val paymentOrder = PaymentOrder(
    ...,
    payer = PaymentOrderPayer(
        payerReference = "user1234"
    )
    paymentToken = "token"
    ...
)
```

{:.code-view-header}
**iOS**

```swift
paymentOrder.payer = PaymentOrderPayer(
    payerReference: "user1234"
)
paymentOrder.paymentToken = "token"
```

Your backend implementation should have proper authentication to prevent misuse
of tokens. The example implementation will reject attempts to use
`paymentToken` by default.

#### Add Stored Payment Instrument Details

The Merchant Backend allows you to set
`PaymentOrder.disableStoredPaymentDetails` to use this feature as described
in the [Payment Menu Documentation][add-stored-details].

As mentioned there, it is important that you have obtained consent from the
user for storing payment details beforehand, if you use this feature.

{:.code-view-header}
**Android**

```kotlin
val paymentOrder = PaymentOrder(
    ...,
    disableStoredPaymentDetails = true
    ...
)
```

{:.code-view-header}
**iOS**

```swift
paymentOrder.disableStoredPaymentDetails = true
```

[add-stored-details]: /payment-menu/features/optional/payer-aware-payment-menu#add-stored-payment-instrument-details
