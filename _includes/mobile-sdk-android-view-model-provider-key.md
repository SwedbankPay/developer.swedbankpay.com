## Android: View Model Provider Key

On Android, you communicate with a `PaymentFragment` through a
`PaymentViewModel` that is stored in the `FragmentActivity` containing the
`PaymentFragment`. Normally this means that a single Activity can only contain
one `PaymentFragment`. This should not usually be a problem, but for advanced
use cases, you can manually set the storage key for the `PaymentViewModel`
of a given `PaymentFragment`, allowing for multiple instances to coexist in a
single Activity. Further use of multiple simultaneous `PaymentFragment`s is
beyond the scope of this document.

The key is set as an argument to the `PaymentFragment`. You can either use
the `PaymentFragment.ArgumentsBuilder` to build the argument bundle
(recommended), or you can manually set a value for the key
`PaymentFragment.ARG_VIEW_MODEL_PROVIDER_KEY`.

{:.code-view-header}
**Android**

```kotlin
val arguments = PaymentFragment.ArgumentsBuilder()
    .paymentOrder(paymentOrder)
    .viewModelProviderKey("PaymentViewModelOne")
    .build()

val manualArguments = Bundle()
manualArguments.putString(
    PaymentFragment.ARG_VIEW_MODEL_PROVIDER_KEY,
    "PaymentViewModelTwo"
)
```
