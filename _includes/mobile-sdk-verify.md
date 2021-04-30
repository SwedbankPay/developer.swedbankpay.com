## Verify Payments

`Verify` payments are also supported by the SDK

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
