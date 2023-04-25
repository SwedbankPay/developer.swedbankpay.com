## One-Click Payments

It is really easy to improve the purchase experience by auto-filling the payment
details. In order to do this, SwedbankPay needs to identify your customer. If
the customer is identified and has approved storing the payment details, the
rest is handled automatically.

## One-Click Payments In Enterprise

Enterprise merchant can supply the email and phone of the customer to let
SwedbankPay match the customer internally and let the customer store card
information (if desired).

{:.code-view-header}
**iOS**

```swift
var paymentOrder = ...
payment.payer = .init(
    consumerProfileRef: nil,
    email: "leia.ahlstrom@payex.com",
    msisdn: "+46739000001",
    payerReference: unique-identifier
)

```

{:.code-view-header}
**Android**

```kotlin

val paymentOrder = PaymentOrder(
    ...
    payer = PaymentOrderPayer(
        email = "leia.ahlstrom@payex.com",
        msisdn = "+46739000001",
        payerReference = unique-identifier
    ),
    ...
)
```

Now the customer has the option to store card numbers or select one of the
previously stored cards. More info in [the documentation][enterprise-payer-ref].

## One-Click Payments In PaymentsOnly

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
        payerReference = unique-identifier
    )
    ...
)
```

{:.code-view-header}
**iOS**

```swift
paymentOrder.generatePaymentToken = true
paymentOrder.payer = PaymentOrderPayer(
    payerReference: unique-identifier
)
```

## Token Retrieval Checkout V3

Retrieve the token by expanding the "paid" property of a previous successful
payment. To see this in action, the example merchant backend has an endpoint
called "/expand" that takes a "resource" (in this case the paymentId), and an
array of properties to expand. You get a payment order back, and in the expanded
paid property there is a "tokens" array (if the customer agreed to let you store
the information). A good practice is to only do this on the backend and serve
the token as part of user's info, to have the token available at the next
purchase.

{:.code-view-header}
**iOS**

```swift
// ExpandResponse is a struct you define to match the response from your server, since you will want to adapt it to your needs.

let request = configuration.expandOperation(paymentId: paymentId, expand: [.paid], endpoint: "expand") { (result: Result<ExpandResponse, Error>) in

    if case .success(let success) = result, let token = success.paymentOrder.paid?.tokens.first?.token {

        // Now save the token for the next purchase.
        // Notice that the backend never needs to respond with the complete expanded PaymentOrder.
        // This is just an illustration of how expansion can work
    } else {

        //handle failure
    }
}

```

{:.code-view-header}
**Android**

```kotlin
// N.B! expandOperation is a suspending function, so this call must be done inside suspending code.
// ExpandedPaymentOrder is a data class you define to match the response from your server, since you will want to adapt it to your needs.

try {
    var result: ExpandedPaymentOrder = merchantConfiguration.expandOperation(
        context,
        paymentId,
        arrayOf("paid"),
        "expand",
        ExpandedPaymentOrder::class.java
    )

    return expandedOrder.paid?.tokens?.first()?.token

} catch (error: UnexpectedResponseException) {

    //handle error
}
```

Read more on [expanding properties here][expanding_properties].

## Token Retrieval In Checkout V2

If you are still using the older Checkout version 2, the SDK contains a utility
method to query a conforming Merchant Backend server for the payment tokens of a
particular `payerReference`. Of course, you should have proper authentication in
your implementation if you use this functionality, to prevent unauthorized
access to other users' tokens (the example implementation has the endpoint
disabled by default).

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

## Token Usage

Usage of tokens are the same in both V3 as in V2 and to use a payment token with
a Merchant Backend, create a payment order where you set the `paymentToken`
field of `PaymentOrder` and the `payerReference` field of `PaymentOrderPayer`:

{:.code-view-header}
**Android**

```kotlin
val paymentOrder = PaymentOrder(
    ...,
    payer = PaymentOrderPayer(
        payerReference = unique-identifier
    )
    paymentToken = retrieved-token
    ...
)
```

{:.code-view-header}
**iOS**

```swift
paymentOrder.payer = PaymentOrderPayer(
    payerReference: unique-identifier
)
paymentOrder.paymentToken = retrieved-token
```

Your backend implementation should have proper authentication to prevent misuse
of tokens. The example implementation will reject attempts to use
`paymentToken` by default.

## Disable Stored Payment Instrument Details

The Merchant Backend allows you to set
`PaymentOrder.disableStoredPaymentDetails` to use this feature as described
in the [Version2 Payment Menu Documentation][add-stored-details].

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

[add-stored-details]: /old-implementations/payment-menu-v2/features/optional/payer-aware-payment-menu#add-stored-payment-instrument-details
[enterprise-payer-ref]: https://developer.swedbankpay.com/checkout-v3/enterprise/features/optional/enterprise-payer-reference
[expanding_properties]: https://developer.swedbankpay.com/introduction#expansion
