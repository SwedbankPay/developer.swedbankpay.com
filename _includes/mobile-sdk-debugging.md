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
    PaymentFragment.ARG_DEBUG_INTENT_URLS,
    true
)
```

### iOS

As explained in the [iOS documentation][ios-payment-url], the iOS SDK will
sometimes need to open navigations out of the payment menu in Safari rather
than the WKWebView. The SDK attempts to detect WKWebView incompatibilty, but
the logic might miss some cases. If you encounter a payment flow that does not
work correctly in the WKWebView, you can make all navigations go to Safari to
check if the flow is incompatible with WKWebView. 

{:.code-view-header}
**iOS**

```swift
swedbankPaySDKController.webRedirectBehavior = .AlwaysUseBrowser
```

If you discover a payment process that works with `.AlwaysUseBrowser` but fails
with `.Default`, please file an [issue][ios-issues].

[ios-issues]: https://github.com/SwedbankPay/swedbank-pay-sdk-ios/issues
[ios-payment-url]: /modules-sdks/mobile-sdk/ios#payment-url-and-external-applications
