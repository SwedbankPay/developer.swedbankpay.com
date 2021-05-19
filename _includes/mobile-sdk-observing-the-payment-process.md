## Observing the Payment Process

Your application can observe the state of the payment and react accordingly.
At a minimum, your application must remove the SDK UI from view when the
payment is finished.

### Android

On Android, observe the `state` or `richState` of `PaymentViewModel`.
The `PaymentViewModel` of a `PaymentFragment` is stored in its parent
`Activity`. If you really need to have multiple `PaymentFragment`s in
a single `Activity`, you need to assign each a different key for their
`PaymentViewModel`s
(use `PaymentFragment.ArgumentsBuilder.viewModelProviderKey`).

{:.code-view-header}
**Android**

```kotlin
val paymentViewModel = ViewModelProvider(activity)[PaymentViewModel::class.java]
// or use the activity.paymentViewModel convenience property

paymentViewModel.richState.observe(owner) { richState ->
    // handle new state here
}
```

The process state is available at `richState.state`, which has the following
cases:

*   `PaymentViewModel.State.IDLE`: Not active
*   `PaymentViewModel.State.IN_PROGRESS`: Active; waiting for either network response or user interaction
*   `PaymentViewModel.State.UPDATING_PAYMENT_ORDER`: Updating the payment order (because you called `updatePaymentOrder`)
*   `PaymentViewModel.State.COMPLETE`: Complete; you should hide the `PaymentFragment` and check the payment status from your application servers
*   `PaymentViewModel.State.CANCELED`: Canceled by the user; you should hide the `PaymentFragment`.
*   `PaymentViewModel.State.RETRYABLE_ERROR`: Payment could not proceed, but the error is not fatal. See below for options here.
*   `PaymentViewModel.State.FAILURE`: Payment has failed. You should hide the `PaymentFragment`.

In the retryable error and failure states, the error that caused the failure is
available at `richState.exception`. The exception is of any type thrown by
your Configuration. If the failure state was instead reached because Swedbank
Pay reported a [Terminal Failure][terminal-failure], that will be available at
`richState.terminalFailure`.

When the `PaymentFragment` is showing the payment menu of the payment order,
the corresponding `ViewPaymentOrderInfo` is available at
`richState.viewPaymentOrderInfo`. This is the value that your Configuration
returned to the SDK; if you are using Instrument Mode with the Merchant Backend
Configuration, you may be interested in the `instrument` and
`availableInstruments` fields to determine whether to show your instrument
selection UI.

#### Retryable Errors

In the retryable error state, the `PaymentFragment` will, by default, show
an error message with instructions to retry. You may disable this by setting
the desired default UI flags
(`PaymentFragment.ArgumentsBuilder.setEnabledDefaultUI`). If you do wish to
provide your own UI for this state, you can call
`paymentViewModel.retryPreviousAction()` to insruct the `PaymentFragment` to
retry. A message describing the problem is available at
`richState.retryableErrorMessage`.

#### Overriding Terms of Service Link

By default, when the user taps on the Terms of Service link in the Payment
Menu, a new Activity will be started, which will display the linked web page.
However, you may wish to provide a native Terms of Service UI instead. To do
this, set a listener for the event by calling
`paymentViewModel.setOnTermsOfServiceClickListener`.

{:.code-view-header}
**Android**

```kotlin
paymentViewModel.setOnTermsOfServiceClickListener(lifecycleOwner) { paymentFragment, url ->
    // show ToS UI
    // return true to disable the default behaviour
    // (alternatively, return false to continue with the default behaviour)
}
```

### iOS

On iOS, set a delegate to the `SwedbankPaySDKController`. The delegate methods
will be called on state changes.

{:.code-view-header}
**iOS**

```swift
swedbankPaySDKController.delegate = self

// ...

extension MyClass : SwedbankPaySDKDelegate {
    func paymentOrderDidShow(info: SwedbankPaySDK.ViewPaymentOrderInfo) {
        // A payment order is now shown;
        // info is the ViewPaymentOrderInfo value from your Configuration
    }

    func paymentOrderDidHide() {
        // No payment order is now shown
    }
    func updatePaymentOrderFailed(
        updateInfo: Any,
        error: Error
    ) {
        // An update failed; error is the error from your Configuration
    }

    func paymentComplete() {
        // Payment is complete; you should hide the SwedbankPaySDKController
    }
    func paymentCanceled() {
        // Payment canceled by user; you should hide the SwedbankPaySDKController
    }

    func paymentFailed(error: Error) {
        // Payment failed. The error is either from your Configuration,
        // or a SwedbankPaySDKController.WebContentError
    }

    func overrideTermsOfServiceTapped(url: URL) -> Bool {
        // Show custom Terms of Service UI, if needed.
        // Return true to disable the default behaviour,
        // false to allow SwedbankPaySDKController to show
        // the default ToS UI.
    }
}
```

Any errors are ones thrown by your Configuration, or, in the case of
`paymentFailed`, `SwedbankPaySDKController.WebContentError`.
`SwedbankPaySDKController.WebContentError` has two cases:

* .ScriptLoadingFailure(scriptUrl: URL?): The script failed to load. No error message is available; this is a limitation of WKWebView
* .ScriptError(SwedbankPaySDK.TerminalFailure?): The script made an `onError` callback. The payload is the [Terminal Failure][terminal-failure] reported by Swedbank Pay.

When using the Merchant Backend Configuration, other errors will be of the type
`SwedbankPaySDK.MerchantBackendError`.

[terminal-failure]: /checkout/v2/features/technical-reference/payment-menu-events#onerror
