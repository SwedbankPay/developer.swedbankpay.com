## Android: Default UI

`PaymentFragment` is very plain; in normal use it will only contain a progress
indicator and/or a WebView. For error conditions that may be resolved by a
simple retry, however, it will, by default show a message and a pull-to-refresh
control. If desired, this UI can be disabled. In addition, is a completion
message and an error message available. Those are unlikely to be useful in
production, but can be enabled for development, if desired.

This feature is also controller by an argument. This argument is an integer
representing flag bits.

{:.code-view-header}
**Android**

```kotlin
val arguments = PaymentFragment.ArgumentsBuilder()
    .paymentOrder(paymentOrder)
    .setEnabledDefaultUI() // enable nothing
    .build()

val manualArguments = Bundle()
manualArguments.putInt(
    PaymentFragment.ARG_ENABLED_DEFAULT_UI,
    PaymentFragment.RETRY_PROMPT or PaymentFragment.ERROR_MESSAGE
)
```
