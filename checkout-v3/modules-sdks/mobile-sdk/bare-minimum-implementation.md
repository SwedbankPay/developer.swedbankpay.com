---
title: Bare Minimum Implementation
permalink: /:path/bare-minimum-implementation/
description: |
  Bare minimum implementation of the **Swedbank Pay Mobile SDK**
menu_order: 800
---

In this chapter we provide the bare minimum implementation needed to present the
Swedbank Pay UI using the Mobile SDK. There are several important limitations
with this implementation that we're listing at the end of the chapter.

## Payment

To start off, you need a payment to present. If you already have a backend
implementation of the Swedbank Pay APIs, you can use that to initialize a
payment order. If you don't have a backend implementation, you can manually
create a payment order using Swagger or a similar tool.

For simplicity, we're specifying some simple placeholder values and URLs when
creating the payment order that you can use as well. There is no need for the
bare minimum implementation to provide URLs to actual working sites:

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.1

{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test App Purchase",
        "userAgent": "SDK-Test",
        "language": "sv-SE",
        "instrument": null,
        "urls": {
            "hostUrls": [ "https://example.com" ],
            "paymentUrl": "examplepayment://payment/",
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "termsOfServiceUrl": "https://example.com/tos",
            "callbackUrl": "https://api.example.com/payment-callback"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "orderReference": "or-123456"
        }
    }
}
```

After the payment order is created, you can fetch it to get the available
operations. The operation you're interested in for the sake of the bare minimum
implementation is the `view-checkout`.

```json
{
  "paymentOrder": { ... }
  "operations": [
    {
      "method": "GET",
      "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
      "rel": "view-checkout",
      "contentType": "application/javascript"
    },
    ...
  ]
}
```

The `href` from the operation is then used in the Android and iOS implementations below.

## Android

Integrate the SDK in your application by simply adding the dependency to the
`build.gradle` file:

```groovy
dependencies {
    implementation 'com.swedbankpay.mobilesdk:mobilesdk:{{ page.mobile_sdk_android_version }}'
}
```

Or in your `gradle.kts` file:

```kotlin
dependencies {
    implementation("com.swedbankpay.mobilesdk:mobilesdk:{{ page.mobile_sdk_android_version }}")
}
```

Depending on your app, you might also need to add
`androidx.appcompat:appcompat:1.6.1`

## Android Setup

If you would like the implementation to have basic return URL functionality
(that is, having the ability for external apps like Vipps and BankID to return
back to your app automatically after they are done) you need to make sure that
the payment URL will launch the app. A basic way to enable this is a custom URL
scheme (`examplepayment://`). To make the your app launch for such URLs in the
system, you need to add the following to your manifest file:

```xml
<activity android:name=".MainActivity">
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="examplepayment" android:host="path" />
    </intent-filter>
</activity>
```

## Android SDK Configuration

Next, you provide the configuration for the payment UI. We don't use consumer
identification for the bare minimum implementation, so that method is
implemented but does not return any data. The payment order returned have
URLs matching the payment order you created earlier. Provide the `view-checkout`
operation `href` in the `viewPaymentLink` parameter of `ViewPaymentOrderInfo`.

```kotlin
class TestConfiguration : Configuration() {

    // This method is required but not used
    override suspend fun postConsumers(
        context: Context,
        consumer: Consumer?,
        userData: Any?
    ): ViewConsumerIdentificationInfo {
        throw Exception()
    }

    override suspend fun postPaymentorders(
        context: Context,
        paymentOrder: PaymentOrder?,
        userData: Any?,
        consumerProfileRef: String?
    ): ViewPaymentOrderInfo {
        return ViewPaymentOrderInfo(
            viewPaymentLink = "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
            webViewBaseUrl = "https://example.com/",
            completeUrl = "https://example.com/complete",
            cancelUrl = "https://example.com/cancel",
            paymentUrl = "examplepayment://payment/",
            isV3 = true
        )
    }
}
```

## Android Present Payment

You are now ready to present the payment UI. First, you set our configuration as
the global `defaultConfiguration` for `PaymentFragment` in your app:

```kotlin
val configuration = TestConfiguration()
PaymentFragment.defaultConfiguration = configuration
```

After this, you simply create a `PaymentFragment` instance and present it in a
way that works in your application (in this example, we're accessing the
Appcompat `FragmentManager` via `supportFragmentManager`, meaning this code is
implemented in an `Activity` of the app):

```kotlin
val arguments = PaymentFragment.ArgumentsBuilder()
    .checkoutV3(true)
    .build()

val paymentFragment = PaymentFragment()
paymentFragment.arguments = arguments

val containerViewId = R.id.sdk_payment_fragment // Specify a container ID for the fragment
supportFragmentManager.beginTransaction()
    .add(containerViewId, paymentFragment)
    .commit()
```

You want to listen to some basic state updates from the payment UI and dismiss
the view when it's finished. You do this by accessing the `paymentViewModel`
that is available on all Activities. In the following example, we observe the
`state` variable in the same Activity as above, and remove the payment fragment
from the screen after the payment is finalized (again, this is done with
`supportFragmentManager`, you can modify this depending on how you presented the
fragment):

```kotlin
paymentViewModel.state.observe(this, Observer {
    if (it.isFinal == true) {
        supportFragmentManager.beginTransaction()
            .remove(paymentFragment)
            .commit()
    }
})
```

## iOS

Integrate the SDK in your application by either using Swift Package Manager or
CocoaPods.

### Swift Package Manager

The package repository URL for the SDK is
[`https://github.com/SwedbankPay/swedbank-pay-sdk-ios.git`][sdk-package-repo].
Add the `SwedbankPaySDK` library, there is no need to add the 
`SwedbankPaySDKMerchantBackend` library for the bare minimum implementation.

### CocoaPods

Add the dependency in your `Podfile`:

```ruby
pod 'SwedbankPaySDK', '~> {{ page.mobile_sdk_ios_version }}'
```

## iOS Setup

If you would like the implementation to have basic return URL functionality
(that is, having the ability for external apps like Vipps and BankID to return
back to your app automatically after they are done) you need to make sure that
the payment URL will launch the app. A basic way to enable this is a custom URL
scheme (`examplepayment://`).

The easiest way to add a URL scheme to your app is to select the project file,
go to the `Info` tab, scroll down to `URL Types`, and click the `+` button to
add a new scheme. Insert `examplepayment` to the `URL Schemes` field. You can
choose the URL `Identifier` freely, but remember that that it should be unique.
The `Role` for the url type should be `Editor`. Finally, to mark this url type
as the Swedbank Pay payment url scheme, open the `Additional url type
properties`, and add a property with the key
`com.swedbank.SwedbankPaySDK.callback`, type `Boolean`, and value `YES`.

![Payment url scheme added in project Info tab][custom-scheme-1]

You can also edit the `Info.plist` file directly, if you wish.

![Payment url scheme added in Info.plist editor][custom-scheme-2]

To forward the custom-scheme payment urls to the SDK, implement the
[`application(_:open:options:)`][uiappdelegate-openurl] method in your
application delegate, and call `SwedbankPaySDK.open(url: url)` to let the SDK
handle the url.

```swift
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return SwedbankPaySDK.open(url: url)
}
```

## iOS SDK Configuration

Next, you provide the configuration for the payment UI. We don't use consumer
identification for the bare minimum implementation, so that method is
implemented but does not return any data. The payment order returned have
URLs matching the payment order you created earlier. Provide the `view-checkout`
operation `href` in the `viewPaymentLink` parameter of `ViewPaymentOrderInfo`.

Provide the `view-checkout` operation `href` in the `viewPaymentLink` parameter
of `ViewPaymentOrderInfo`;

```swift
enum SwedbankPayConfigurationError: Error {
    case notImplemented
}

class TestConfiguration: SwedbankPaySDKConfiguration {

    // This delegate method is required but not used
    func postConsumers(consumer: SwedbankPaySDK.Consumer?,
                       userData: Any?,
                       completion: @escaping (Result<SwedbankPaySDK.ViewConsumerIdentificationInfo, Error>) -> Void) {
        completion(.failure(SwedbankPayConfigurationError.notImplemented))
    }
    
    func postPaymentorders(paymentOrder: SwedbankPaySDK.PaymentOrder?,
                           userData: Any?,
                           consumerProfileRef: String?,
                           options: SwedbankPaySDK.VersionOptions,
                           completion: @escaping (Result<SwedbankPaySDK.ViewPaymentOrderInfo, Error>) -> Void) {
        let info = SwedbankPaySDK.ViewPaymentOrderInfo(isV3: true,
                                                       webViewBaseURL: URL(string: "https://example.com/"),
                                                       viewPaymentLink: URL(string: "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959")!,
                                                       completeUrl: URL(string: "https://example.com/complete")!,
                                                       cancelUrl: URL(string: "https://example.com/cancel"),
                                                       paymentUrl: URL(string: "examplepayment://payment/"),
                                                       termsOfServiceUrl: URL(string: "https://example.com/tos"))
        completion(.success(info))
    }

}
```

## iOS Present Payment

You want to listen to some basic state updates from the payment UI and dismiss
the view when it's finished. You do this by implementing the
`SwedbankPaySDKDelegate` protocol. In the following example, we implement
the delegate protocol and the following three delegate methods in a view
controller. We will be presenting the payment view controller modally in the
implementation further down, so we can use `dismiss()` to close it:

```swift
func paymentComplete() {
    dismiss(animated: true)
    print("Payment Complete")
}

func paymentCanceled() {
    dismiss(animated: true)
    print("Payment Canceled")
}

func paymentFailed(error: Error) {
    dismiss(animated: true)
    print("Payment Failed")
}
```

You are now ready to present the payment UI. Simply create a
`SwedbankPaySDKController`, provide the configuration, assign the `delegate`
and present it in a way that works in your application (again, in the example
we're presenting the view modally in a separate View Controller):

```swift
let configuration = TestConfiguration()
let paymentController = SwedbankPaySDKController(configuration: configuration,
                                                 withCheckin: false,
                                                 consumer: nil,
                                                 paymentOrder: nil,
                                                 userData: nil)

paymentController.delegate = self

present(paymentController, animated: true)
```

## Limitations of the minimal implementation

While you can use the steps above to present a payment UI in your apps with very
little work, there are several limitations to the implementation that you should
consider before choosing how to implement the full payment in your apps.

### Dynamic configuration

For simplicity, we've hardcoded all URLs needed to initiliaze the configuration.
In an actual application, you instead need to fetch one ore more URLs from your
backend and supply it to the payment UI. The obvious URL that is required to be
dynamic is the payment order specific `viewPaymentLink`, but also URLs such as
`paymentUrl` should ideally be dynamic (depending on mobile platform and even
the payment order, more on this below).

### Cancelling payment

In this implementation, we haven't included a way for the user to cancel the
payment order. You could achieve this functionality by adding a cancel button
to your UI (for example providing a navigation bar with a close button for the
payment UI view controller/fragment), and cancelling the payment order via your
backend.

### Payment URL Handling

In this minimal implementation, we used custom URL scheme for the payment URL.
This causes several issues in a production environment:

* On iOS, using custom URL schemes instead of Universal Links comes with several
drawbacks, including prompting the user with an additional confirmation popup
as well as being unable to verify URL ownership to your specific app (other
apps can declare the same custom URL scheme outside of your control).
* On Android, the SDK expects the app to be launched by external apps using an
`intent:` scheme URL. This ties into the intent filter contained in the SDK,
that will bring the containing application to the foreground and reload the
payment menu. Because we're using the simpler custom URL scheme in this
implementation, the payment menu will not reload and this will result in some
payment instruments not behaving correctly.
* There are a few, albeit rare, scenarios where the user can end up launching
the Payment URL in the mobile browser on their phone. For URLs with custom
schemes that's handled nicely, but for universal URLs, it's more problematic.
This means that browsing to the payment URL ideally should return a view that
redirects the user to the app. We provide example on how to implement this in
the next chapter [Custom Backend][payemnt-url].

{% include iterator.html prev_href="/checkout-v3/modules-sdks/mobile-sdk/configuration"
                         prev_title="Back: Configuration"
                         next_href="/checkout-v3/modules-sdks/mobile-sdk/custom-backend"
                         next_title="Next: Custom Backend" %}

[sdk-package-repo]: https://github.com/SwedbankPay/swedbank-pay-sdk-ios.git
[custom-scheme-1]: /assets/img/mobile-sdk/ios-custom-scheme-1.png
[custom-scheme-2]: /assets/img/mobile-sdk/ios-custom-scheme-2.png
[uiappdelegate-openurl]: https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623112-application
[payemnt-url]: /checkout-v3/modules-sdks/mobile-sdk/custom-backend/#payment-url