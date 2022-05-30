## Payment tokens for unscheduled or recurring purchases

A common practice is to store a credit-card for later use, e.g. for subscriptions, and charge every month. To make this safe & secure you let SwedbankPay store the payment information and only keep a reference, a payment token. This token can later be used to make purchases, and there are two types of tokens that can be created. One for subscriptions, and one for later unscheduled purchases. They are created the same way, by setting generateUnscheduledToken = true or generateRecurrenceToken = true, in the paymentOrder and then either making a purchase or verifying a purchase. This is done the same way in PaymentsOnly as in the Enterprise implementation.

{:.code-view-header}
**iOS**

``` Swift

var paymentOrder = ... //create the paymentOrder as usual by calculating price, etc
paymentOrder.generateRecurrenceToken = true
paymentOrder.generateUnscheduledToken = true

```

{:.code-view-header}
**Android**

``` Kotlin

val paymentOrder = PaymentOrder(
    ...
    generateRecurrenceToken = true,
    generateUnscheduledToken = true,
    ...
)

```

When expanding the paid property of this verified or purchased payment, there is an array with tokens one can save for later use. See One-click Payments for details on expanding PaymentOrders. Here is an abbreviated example of what is received, typically only on the backend. 


``` JSON
{
    "paymentOrder": {
        ...
        "paid": {
            ...
            "tokens": [
                {
                    "type": "recurrence",
                    "token": "a7d7d780-98ba-4466-befe-e5428f716c30",
                    "name": "458109******3517",
                    "expiryDate": "12/2030"
                },
                {
                    "type": "unscheduled",
                    "token": "0c43b168-dcd5-45d1-b9c4-1fb8e273c799",
                    "name": "458109******3517",
                    "expiryDate": "12/2030"
                }
            ]
        }
    }
}
```

Then, to make an unscheduled purchase you simply add the unscheduledToken, or the recurrenceToken to the paymentOrder request. Obviously these purchases and the expanding of tokens is only needed to be done on the backend.

More info on [unscheduled purchases][unscheduled].

More info on [recurring purchases][recur].

## One-click Payments

It is really easy to improve the purchase experience by auto-filling the payment details. In order to do this, SwedbankPay needs to identify your customer. If the customer is identified and has approved storing the payment details, the rest is handled automatically.

## One-click Payments in Enterprise

Enterprise merchant can simply supply the email and phone of the customer to let SwedbankPay match the customer internally and let the customer store card information (if desired).

{:.code-view-header}
**iOS**

``` Swift
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

``` Kotlin

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

Now the customer has the option to store card numbers or select one of the previously stored cards. More info in [the documentation][enterprise-payer-ref].

## One-click Payments in PaymentsOnly

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


### Token Retrieval Checkout V3

Retrieve the token by expanding the "paid" property of a previous successful payment. To see this in action, the example merchant backend has an endpoint called "/expand" that takes a "resource" (in this case the paymentId), and an array of properties to expand. You get a payment order back, and in the expanded paid property there is a "tokens" array (if the customer agreed to let you store the information). A good practice is to only do this on the backend and serve the token as part of user's info, to have the token available at the next purchase.

{:.code-view-header}
**iOS**

```Swift

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

``` Kotlin
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

### Token Retrieval in V2

If you are still using the older Checkout version 2, the SDK contains a utility method to query a conforming Merchant Backend server
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

### Token Usage

Usage of tokens are the same in both V3 as in V2 and to use a payment token with a Merchant Backend, 
create a payment order where
you set the `paymentToken` field of `PaymentOrder` and the `payerReference`
field of `PaymentOrderPayer`:

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

#### Disable Stored Payment Instrument Details

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

[add-stored-details]: /payment-menu/features/optional/payer-aware-payment-menu#add-stored-payment-instrument-details
[enterprise-payer-ref]: https://developer.swedbankpay.com/checkout-v3/enterprise/features/optional/enterprise-payer-reference
[expanding_properties]: https://developer.swedbankpay.com/introduction#expansion
[unscheduled]: https://developer.swedbankpay.com/checkout-v3/payments-only/features/optional/unscheduled
[recur]: https://developer.swedbankpay.com/checkout-v3/payments-only/features/optional/recur
