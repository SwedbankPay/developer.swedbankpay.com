## Instrument Mode

In "Instrument Mode" the Payment Menu will display only one specific payment
instrument instead of all configured on your merchant account. Please refer to
the [Payment Menu documentation][instrument-mode] for more information on when
you should use this feature.

To use Instrment Mode with a Merchant Backend, set the `instrument` field
of your payment order to a non-null value.

On Android, `instrument` is a String, but some common instruments are available
int the `PaymentInstruments` class:

{:.code-view-header}
**Android**

```kotlin
val paymentOrder = PaymentOrder(
    ...,
    instrument = PaymentInstruments.CREDIT_CARD,
    ...
)

val otherPaymentOrder = paymentOrder.copy(
    instrument = "SomeInstrument"
)
```

On iOS, `instrument` is an struct that wraps a String, and provides common
instruments as static constants:

{:.code-view-header}
**iOS**

```swift
paymentOrder.instrument = .creditCard
paymentOrder.instrument = Instrument(rawValue: "SomeInstrument")
```

### Changing the Instrument

If a payment order is created in instrument mode, the Merchant Backend
Configuration will populate the `instrument` and `availableInstruments`
fields of the `ViewPaymentOrderInfo`. This is also recommended to do if using
instrument mode with a custom Configuration. This way, the containing
application can observe the payment process and determine if it is in
instrument mode, and display additional UI accordingly.

{:.code-view-header}
**Android**

```kotlin
// paymentViewModel is a property of FragmentActivity
// lifecycleOwner should usually be viewLifecycleOwner if we are in a Fragment
paymentViewModel.richState.observe(this) { richState ->
    if (richState?.viewPaymentOrderInfo?.instrument != null) {
        // show instrument mode UI
    }
}
```

{:.code-view-header}
**iOS**

```swift
// paymentOrderDidShow is a part of the protocol SwedbankPaySDKDelegate
func paymentOrderDidShow(info: SwedbankPaySDK.ViewPaymentOrderInfo) {
    if info.instrument != nil {
        // show instrument mode UI
    }
}
```

To change the instrument of an ongoing payment order, call the
`updatePaymentOrder` method. Its argument is passed to your Configuration,
which must know how to interpret it. If using the Merchant Backend
Configuration, the argument should be the new instrument to set.

Your Configuration should report the valid instruments for the ongoing payment
order in the `ViewPaymentOrderInfo.availableInstruments` property. Your UI can
observe this property to show only valid options to the user. The Merchant
Backend Configuration populates this field when.

{:.code-view-header}
**Android**

```kotlin
// On Android, updatePaymentOrder is part of PaymentViewModel
paymentViewModel.updatePaymentOrder(PaymentInstruments.INVOICE)
```

{:.code-view-header}
**iOS**

```swift
// On iOS, updatePaymentOrder is part of SwedbankPaySDKController
swedbankPaySDKController.updatePaymentOrder(SwedbankPaySDK.Instrument.invoice)
```

You should, of course, then observe when the update completes, and update your
UI accordingly.

{:.code-view-header}
**Android**

```kotlin
paymentViewModel.state.observe(this) {
    when (it) {
        UPDATING_PAYMENT_ORDER -> showUpdatingUI()
        else -> hideUpdatingUI()
    }
}
```

{:.code-view-header}
**iOS**

```swift
showUpdatingUI()
swedbankPaySDKController.updatePaymentOrder(SwedbankPaySDK.Instrument.invoice)

// ... elsewhere ...

// paymentOrderDidShow is a part of the protocol SwedbankPaySDKDelegate
func paymentOrderDidShow(info: SwedbankPaySDK.ViewPaymentOrderInfo) {
    // ...code...
    hideUpdatingUI()
}

func updatePaymentOrderFailed(updateInfo: Any, error: Error) {
    hideUpdatingUI()
}
```

[instrument-mode]: /payment-menu/features/optional/instrument-mode
