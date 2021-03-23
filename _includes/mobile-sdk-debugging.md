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
working, but, of course, this list can be neither complete nor correct for all
time. If you encounter a payment flow that opens in the WKWebView (i.e. does not
open in Safari), but does not work correctly, you can make all navigations
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

[ios-issues]: https://github.com/SwedbankPay/swedbank-pay-sdk-ios/issues
[ios-payment-url]: /modules-sdks/mobile-sdk/ios#payment-url-and-external-applications
