## Verify Payments

`Verify` payments are also supported by the SDK. This is particularly useful
e.g. when creating tokens to charge a card later.

{:.code-view-header}
**Android**

```kotlin
val paymentOrder = PaymentOrder(
    operation = Operation.VERIFY
    ...
)
```

{:.code-view-header}
**iOS**

```swift
paymentOrder.operation = .Verify
```
