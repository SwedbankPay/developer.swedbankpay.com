## Purchase Payments

The `Purchase` operation is used in all common purchase scenarios.
It is the default in the SDK, so you usually do not need to specify it.

{:.code-view-header}
**Android**

```kotlin
val paymentOrder = PaymentOrder(
    operation = Operation.PURCHASE
    ...
)
```

{:.code-view-header}
**iOS**

```swift
paymentOrder.operation = .Purchase
```
