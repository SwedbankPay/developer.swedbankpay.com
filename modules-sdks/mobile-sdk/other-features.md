---
title: Other Features
estimated_read: 20
description: |
  The SDK supports more features than the basic ones needed for integration.
  This page explores those.
menu_order: 1300
---

{% capture disclaimer %}
The SDK is at an early stage of development
and is not supported as of yet by Swedbank Pay. It is provided as a
convenience to speed up your development, so please feel free to play around.
However, if you need support, please wait for a future, stable release.
{% endcapture %}

{% include alert.html type="warning" icon="warning" header="Unsupported"
body=disclaimer %}

## Payment Orders

The SDK works in terms of Payment Orders as used in [Checkout][checkout]
and [Payment Menu][payment-menu]. Therefore, all [features][checkout-features]
of payment orders are available in the SDK by using a suitable custom
configuration.

The rest of the page illustrates how to use certain Payment Order features
with the SDK-provided Merchant Backend Configuration. Detailed descriptions
of the features will not be repeated here; please refer to the
[Checkout documentation][checkout-features] instead.

### URLs

A Payment Order created for the SDK must have [`urls`][checkout-urls] the same
way a Payment Order to be used on a web page would. The SDK context places some
requirement on these urls.

{:.table .table-striped}
| Field               | SDK Requirements                                                                                                                                                |
| :------------------ | :------- | :--------------------------------------------------------------------------------------------------------------------------------------------------- |
| `hostUrls`          | Should match the value your Configuration returns in the `webViewBaseURL` of `ViewPaymentOrderInfo`.                                                            |
| `completeUrl`       | No special requirements. However, the SDK will intercept the navigation, so `completeUrl` will not actually be opened in the SDK Web View.                      |
| `termsOfServiceUrl` | No special requirements.                                                                                                                                        |
| `cancelUrl`         | No special requirements. However, the SDK will intercept the navigation, so `cancelUrl` will not actually be opened in the SDK Web View.                        |
| `paymentUrl`        | If opened in a browser, must eventually be delivered to the SDK, bringing the containing app to the foreground. See the Android and iOS specific documentation. |
| `callbackUrl`       | No special requirements. This is a server-to-server affair.                                                                                                     |

#### Merchant Backend Configuration

The SDK-provided Merchant Backend Configuration allows creating a set of `urls`
that fulfill the above when used with a backend implementing the Merchant
Backend API.

{:.code-view-header}
**Android**

```kotlin
// backendUrl is the the backendUrl of your MerchantBackendConfiguration
val urls = PaymentOrderUrls(
    context = context,
    backendUrl = backendUrl
    callbackUrl = callbackUrl,
    termsOfServiceUrl = termsOfServiceUrl
)
```

{:.code-view-header}
**iOS**

```kotlin
// On iOS, the `paymentUrl` has a nonnegligible chance of actually being shown in Safari,
// so we want to localize it. This is why we need the language parameter here.
let urls = SwedbankPaySDK.PaymentOrderUrls(
    configuration: configuration,
    language: language,
    callbackUrl: callbackUrl,
    termsOfServiceUrl: termsOfServiceUrl
)
```

### Order Items

You may want to populate the `orderItems` field of the `paymentOrder` for e.g.
printing invoices. The SDK offers facilities for working with `orderItems`,
allowing you to discover the fields of an Order Item in your IDE.

Please refer to the [Checkout documentation][checkout-orderitems] and/or the
class documentation for the meaning of the fields.

On Android, `OrderItem` is a data class, so its instances are immutable,
but you can easily create copies with modified fields.

{:.code-view-header}
**Android**

```kotlin
val orderItem = OrderItem(
    reference = "123abc",
    name = "Thing",
    // ItemType is a enum, allowing you to discover the options in your IDE
    type = ItemType.PRODUCT,
    `class` = "Things",
    // Optional Order Item fields are optional in the kotlin OrderItem class as well.
    // The optional fields default to null, so you do not need to specify them if
    // you do not use them.
    itemUrl = null,
    quantity = 1,
    quantityUnit = "pcs",
    unitPrice = 1000,
    vatPercent = 2500 // 25%,
    amount = 1000,
    vatAmount = 200
)

// OrderItem is immutable, but easy to create partially modified copies of
val otherItem = orderItem.copy(
    reference = "456def",
    name = "Other Thing"
)
```

On iOS `SwedbankPaySDK.OrderItem` is a struct, allowing you to store and modify
them like any other Swift values.

{:.code-view-header}
**iOS**

```swift
var orderItem = SwedbankPaySDK.OrderItem(
    reference: "123abc",
    name: "Thing",
    // SwedbankPaySDK.ItemType is a enum, allowing you to discover the options in your IDE
    type: .Product,
    class: "Things",
    quantity: 1,
    quantityUnit: "pcs",
    unitPrice: 1000,
    vatPercent: 2500 // 25%,
    amount: 1000,
    vatAmount: 200
)

// a SwedbankPaySDK.OrderItem var is mutable like any var
orderItem.reference = "456def"
orderItem.name = "Other Thing"
```

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

## Payer Aware Payment Menu

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

### Token Retrieval

The SDK contains a utility method to query a conforming Merchant Backend server
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

### Token Use

To use a payment token with a Merchant Backend, create a payment order where
you set the `paymentToken` field of `PaymentOrder` and the `payerReference`
field of `PaymentOrderPayer`:

{:.code-view-header}
**Android**

```kotlin
val paymentOrder = PaymentOrder(
    ...,
    payer = PaymentOrderPayer(
        payerReference = "user1234"
    )
    paymentToken = "token"
    ...
)
```

{:.code-view-header}
**iOS**

```swift
paymentOrder.payer = PaymentOrderPayer(
    payerReference: "user1234"
)
paymentOrder.paymentToken = "token"
```

Your backend implementation should have proper authentication to prevent misuse
of tokens. The example implementation will reject attempts to use
`paymentToken` by default.

#### Add Stored Payment Instrument Details

The Merchant Backend allows you to set
`PaymentOrder.disableStoredPaymentDetails` to use this feature as described
in the [Payment Menu Documentation][add-stored-details].

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

*    .ScriptLoadingFailure(scriptUrl: URL?): The script failed to load. No error message is available; this is a limitation of WKWebView
*    .ScriptError(SwedbankPaySDK.TerminalFailure?): The script made an `onError` callback. The payload is the [Terminal Failure][terminal-failure] reported by Swedbank Pay.

When using the Merchant Backend Configuration, other errors will be of the type
`SwedbankPaySDK.MerchantBackendError`.

## Problems

When using the Merchant Backend Configuration, most errors in the payment
process will result in [Problem][problems] responses from the backend.
The SDK contains utilities for processing these in your application.

On Android, if any operation fails due to a Problem, the resulting exception
will be of the type `RequestProblemException`, which allows access to the
`Problem` object. `Problem` is a JVM representation of the Problem JSON
response, allowing for easy access to standard fields. You are free to use
`Problem` as-is for modeling your own problem types. The Merchant Backend
Configuration further defines a subclass of `Problem`,
`MerchantBackendProblem`, which is a sealed class containg all the problem
types expected to occur with a Merchant Backend server. All problems reported
by the Merchant Backenc Configuration are of this type, allowing you to use
kotlin's powerful `when` expression to handle the different errors:

{:.code-view-header}
**Android**

```kotlin
when (problem) {
    is MerchantBackendProblem.Client.MobileSDK.Unauthorized ->
        handleUnauthorized()
    is MerchantBackendProblem.Client ->
        handleOtherClientError()
    is MerchantBackendProblem.Server.MobileSDK ->
        handleMerchantBackendError()
    is MerchantBackendProblem.Server.SwedbankPay.ConfigurationError ->
        handleConfigurationError()
    is MerchantBackendProblem.Server.SwedbankPay ->
        handleSwedbankPayError()
    else ->
        handleUnknownError()

}
```

On iOS, if any operation fails due to a Problem, the resultig error will be
`SwedbankPaySDK.MerchantBackendError.problem`, and it will have the problem
as an associated value, of type `SwedbankPaySDK.Problem`.
`SwedbankPaySDK.Problem` is a enum with a similar structure to the Android
`MerchantBackendProblem`, allowing for idiomatic error handling.

{:.code-view-header}
**iOS**

```swift
if case SwedbankPaySDK.MerchantBackendError.problem(let problem) = error {
    switch problem {
    case .client(.mobileSDK(.unauthorized)):
        handleUnauthorized()
    case .client:
        handleOtherClientError()
    case .server(.mobileSDK):
        handleMerchantBackendError()
    case .server(.swedbankPay):
        handleSwedbankPayError()
    default:
        handleUnknownError()
    }
}
```

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

## Debugging Features

To help with investigating problematic scenarios, the SDK has some debugging
features.

### Android

The SDK normally attempts to keep the payment flow inside a WebView as far as
possible. In case some payment instrument fails to work properly, it may be
helpful to see if it is related to the WebView. To allow this, you can set a
flag to immediately move the payment process to the browser app when it
navigates away from the payment menu. In particular, if some card issuer's flow
opens a third-party application, but the process fails to return to your app,
you should see if this option makes any difference.

Testing your application with this option enabled can also be useful in
ascertaining that your "Android Intent callback" endpoint is working properly.

{:.code-view-header}
**Android**

```kotlin
val arguments = PaymentFragment.ArgumentsBuilder()
    .paymentOrder(paymentOrder)
    .useBrowser(true)
    .build()

val manualArguments = Bundle()
manualArguments.putBoolean(
    PaymentFragment.ARG_USE_BROWSER,
    true
)
```

If a payment flow should open a third-party application, but this does not
happen as expected, you can set a flag to display error dialogs when web
content attempts to start an Activity, but it fails.

{:.code-view-header}
**Android**

```kotlin
val arguments = PaymentFragment.ArgumentsBuilder()
    .paymentOrder(paymentOrder)
    .debugIntentUris(true)
    .build()

val manualArguments = Bundle()
manualArguments.putBoolean(
    PaymentFragment.ARG_DEBUG_INTENT_URIS,
    true
)
```

### iOS

As explained in the [iOS documentation][ios-payment-url], the iOS SDK will,
in some cases, open navigations out of the payment menu in Safari rather than
the WKWebView. The SDK contains a list of redirects that we have tested to be
working, but, of course, this list can be neither complete not correct for all
time. If you enounter a payment flow that opens in the WKWebView (i.e. does not
open in Safari), but that does not work correctly, you can make all navigations
go to Safari to check if the flow has become incompatible with WKWebView. On
the other hand, if you encounter a payment flow that opens in Safari and wish
to investigate if it would work in the web view instead, you can make all
navigations open in the web view.

{:.code-view-header}
**iOS**

```swift
swedbankPaySDKController.webRedirectBehavior = .AlwaysUseWebView

swedbankPaySDKController.webRedirectBehavior = .AlwaysUseBrowser
```

If you have set `.AlwaysUseBrowser` and discovered a site that works with
WKWebView, you can set a `webNavigationLogger` to your
`SwedbankPaySDKController` and make note of the URL. Then, modify your
Configuration to allow that URL to be opened in the WKWebView. If using
the Merchant Backend Configuration, add a `additionalAllowedWebViewRedirects`
argument to your initializer. If using a custom Configuration, change your
`decidePolicyForPaymentMenuRedirect` implementation accordingly.

{:.code-view-header}
**iOS**

```swift
swedbankPaySDKController.webNavigationLogger = { url in
    print(url)
}
```

```swift
let configuration = SwedbankPaySDK.MerchantBackendConfiguration(
    backendUrl: backendUrl,
    additionalAllowedWebViewRedirects: [.Domain("example.com")]
)
```

After you have verified that a domain works with WKWebView, please file an
[issue][ios-issues] to have it added to the SDK's bundled list.

[checkout]: /checkout/
[payment-menu]: /payment-menu/
[checkout-features]: /checkout/other-features
[checkout-urls]: /checkout/other-features#urls
[checkout-orderitems]: /checkout/other-features#order-items
[instrument-mode]: /payment-menu/other-features#instrument-mode
[add-stored-details]: /payment-menu/other-features#add-stored-payment-instrument-details
[terminal-failure]: /checkout/other-features#onerror
[problems]: /payment-menu/other-features#problems
[3ds2]: /checkout/other-features#3-d-secure-2
[ios-payment-url]: /modules-sdks/mobile-sdk/ios#payment-url-and-external-applications
[ios-issues]: https://github.com/SwedbankPay/swedbank-pay-sdk-ios/issues


{% include iterator.html prev_href="custom-backend"
                         prev_title="Back: Custom Backend"
                         next_href="process-diagrams"
                         next_title="Next: Process Diagrams" %}
