## Payment Tokens For Unscheduled Or Recurring Purchases

A common practice is to store a credit-card for later use, e.g. for
subscriptions, and charge every month. To make this safe & secure you let
SwedbankPay store the payment information and only keep a reference, a payment
token. This token can later be used to make purchases, and there are two types
of tokens that can be created. One for subscriptions, and one for later
unscheduled purchases. They are created the same way, by setting
generateUnscheduledToken = true or generateRecurrenceToken = true, in the
paymentOrder and then either making a purchase or verifying a purchase.

{:.code-view-header}
**iOS**

```swift
var paymentOrder = ... //create the paymentOrder as usual by calculating price, etc
paymentOrder.generateRecurrenceToken = true
paymentOrder.generateUnscheduledToken = true
```

{:.code-view-header}
**Android**

```kotlin

val paymentOrder = PaymentOrder(
    ...
    generateRecurrenceToken = true,
    generateUnscheduledToken = true,
    ...
)
```

When expanding the paid property of this verified or purchased payment, there is
an array with tokens one can save for later use. Read more on: [expanding
properties][expanding_properties]. Here is an abbreviated example of what is
received, typically only on the backend.

{:.code-view-header}
**JSON**

```http
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

Then, to make an unscheduled purchase you simply add the unscheduledToken, or
the recurrenceToken to the paymentOrder request. Obviously these purchases and
the expanding of tokens is only needed to be done on the backend.

More info on [unscheduled purchases][unscheduled].

More info on [recurring purchases][recur].

[expanding_properties]: https://developer.swedbankpay.com/checkout-v3/get-started/fundamental-principles#expansion
[unscheduled]: https://developer.swedbankpay.com/checkout-v3/features/optional/unscheduled
[recur]: https://developer.swedbankpay.com/checkout-v3/features/optional/recur
