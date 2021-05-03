---
title: Mobile SDK – Custom Backend
estimated_read: 20
description: |
  You can also build a fully custom backend for the **Swedbank Pay Mobile SDK**
menu_order: 1200
---

{% capture disclaimer %}
The SDK is at an early stage of development
and is not supported as of yet by Swedbank Pay. It is provided as a
convenience to speed up your development, so please feel free to play around.
However, if you need support, please wait for a future, stable release.
{% endcapture %}

{% include alert.html type="warning" icon="warning" header="Unsupported"
body=disclaimer %}

In this chapter we explore how to integrate the mobile SDK with a fully custom backend server. It is recommended that you first read through the previous chapters and gain an understanding of how the SDK works with a backend implementing the Merchant Backend API.

## Basic Backend Requirements

To support the SDK, your backend must be capable of at least [creating a payment order][create-payment-order]. If you wish to use consumer identification, it must also be able to [start an identification session][initiate-consumer-session]. In addition to these, your backend must serve the appropriate html documents at urls used for the [`paymentUrl`][payment-url]; the content of these html documents will be discussed below, but it is noteworthy that they are different for payments from Android applications and those from iOS applications. Further, the urls used for as `paymentUrl` on iOS must be [configured as universal links for your iOS application][ios-aasa].

## Android Configuration

To bind the SDK to your custom backend, you must create a subclass of `com.swedbankpay.mobilesdk.Configuration`. This must be a Kotlin class. If you cannot use Kotlin, you can use the compatibility class `com.swedbankpay.mobilesdk.ConfigurationCompat`.

Your subclass must provide implementations of `postConsumers` and `postPaymentorders`. These methods are named after the corresponding Swedbank Pay APIs they are intended to be forwarded to. If you do not intend to use consumer identification, you can have your `postConsumers` implementation throw an exception.

The methods will be called with the arguments you give to the `PaymentFragment`. Therefore, the meaning of `consumer`, `paymentOrder`, and `userData` is up to you. If the consumer was identified before creating the paymentOrder, the consumer reference will be passed in the `consumerProfileRef` argument of  `postPaymentorders`. The exact implementation of these methods is outside the scope of this document.

You must return a `ViewConsumerIdentificationInfo` and a `ViewPaymentOrderInfo` object respectively; please refer to their class documentation on how to populate them from your backend responses. Any exception you throw from these methods will in turn be reported from the `PaymentViewModel`. Whether a given exception is treated as a retryable condition is controlled by the `shouldRetryAfter<Operation>Exception` methods; by default they only consider `IllegalStateException` as fatal. Please refer to the `Configuration` documentation on all the features.

```kotlin
    class MyConfiguration : Configuration() {
        suspend fun postConsumers(
            context: Context,
            consumer: Consumer?,
            userData: Any?
        ): ViewConsumerIdentificationInfo {
            val viewConsumerIdentification = post("https://example.com/identify")
            return ViewConsumerIdentificationInfo(
                webViewBaseUrl = "https://example.com/",
                viewConsumerIdentification = viewConsumerIdentification
            )
        }

        suspend fun postPaymentorders(
            context: Context,
            paymentOrder: PaymentOrder?,
            userData: Any?,
            consumerProfileRef: String?
        ): ViewPaymentOrderInfo {
            val viewPaymentOrder = post("https://example.com/pay/android")
            return ViewPaymentOrderInfo(
                webViewBaseUrl = "https://example.com/",
                viewPaymentOrder = viewPaymentOrder,
                completeUrl = "https://example.com/complete",
                cancelUrl = "https://example.com/cancel",
                paymentUrl = "https://example.com/payment/android",
                termsOfServiceUrl = "https://example.com/tos"
            )
        }
    }
```

## iOS Configuration

On iOS you must conform to the `SwedbankPaySDKConfiguration` protocol. Just like on Android, you must provide implementations for the `postConsumers` and `postPaymentorders` methods. The `consumer`, `paymentOrder`, and `userData` arguments to those methods will be the values you initialize your `SwedbankPaySDKController` with, and their meaning is up to you. The `postPaymentorders` method will optionally receive a `consumerProfileRef` argument, if the consumer was identified before creating the payment order.

The methods are asynchronous, and the result is reported by calling the `completion` callback with the result. Successful results have payloads of `SwedbankPaySDK.ViewConsumerIdentificationInfo` and `SwedbankPaySDK.ViewPaymentOrderInfo`, respectively; please refer to the type documentation on how to populate those types. The error of any failure result you report will be propagated back to your app in the `paymentFailed(error:)` delegate method. You must call the `completion` callback exactly once, multiple calls are a programing error.

```swift
    struct MyConfiguration : SwedbankPaySDKConfiguration {
        func postConsumers(
            consumer: SwedbankPaySDK.Consumer?,
            userData: Any?,
            completion: @escaping (Result<SwedbankPaySDK.ViewConsumerIdentificationInfo, Error>) -> Void
        ) {
            post("https://example.com/identify") { result in
                do {
                    let viewConsumerIdentification = try result.get()
                    let info = ViewConsumerIdentificationInfo(
                        webViewBaseURL: "https://example.com/",
                        viewConsumerIdentification: viewConsumerIdentification
                    )
                    completion(.success(info))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }

        func postPaymentorders(
            paymentOrder: SwedbankPaySDK.PaymentOrder?,
            userData: Any?,
            consumerProfileRef: String?,
            completion: @escaping (Result<SwedbankPaySDK.ViewPaymentOrderInfo, Error>) -> Void
        ) {
            post("https://example.com/pay/ios") { result in
                do {
                    let viewPaymentorder = try result.get()
                    let info = ViewPaymentOrderInfo(
                        webViewBaseURL: "https://example.com/",
                        viewPaymentorder: viewPaymentorder,
                        completeUrl: "https://example.com/complete",
                        cancelUrl: "https://example.com/cancel",
                        paymentUrl: "https://example.com/payment/ios",
                        termsOfServiceUrl: "https://example.com/tos"
                    )
                    completion(.success(info))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
```

## Backend

The code examples allude to a run-of-the-mill https API, but you can of course handle the communication in any way you see fit. The important part is that your backend must then communicate with the Swedbank Pay API using your secret token, and perform the requested operation.

### POST consumers

The "POST consumers" operation is simple, you must make a request to `POST /psp/consumers` with a payload of your choosing, and you must get the `view-consumer-identification` link back to the SDK.

{:.code-view-header}
**SDK Request**
```http
POST /identify HTTP/1.1
Host: example.com
```

{:.code-view-header}
**Swedbank Pay Request**

```http
POST /psp/consumers HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "operation": "initiate-consumer-session",
    "language": "sv-SE",
    "shippingAddressRestrictedToCountryCodes" : ["NO", "SE", "DK"]
}
```

{:.code-view-header}
**Swedbank Pay Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "operations": [
        {
            "method": "GET",
            "rel": "view-consumer-identification",
            "href": "{{ page.front_end_url }}/consumers/core/scripts/client/px.consumer.client.js?token={{ page.payment_token }}",
            "contentType": "application/javascript"
        }
    ]
}
```

{:.code-view-header}
**SDK Response**
```http
HTTP/1.1 200 OK
Content-Type: text/plain

{{ page.front_end_url }}/consumers/core/scripts/client/px.consumer.client.js?token={{ page.payment_token }}
```

This is, of course, an over-simplified protocol for documentation purposes.

### POST paymentorders

The "POST paymentorders" is a bit more complicated, as it needs to tie in with `paymentUrl` handling. Also, the full set of payment order urls must be made available to the app. In this simple example we use static urls for all of those, but in a real application you will want to create at least some of them dynamically, and will therefore need to incorporate them to your protocol.

{:.code-view-header}
**SDK Request**
```http
POST /pay/android HTTP/1.1
Host: example.com
```

{:.code-view-header}
**Swedbank Pay Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "paymentorder": {
        "urls": {
            "hostUrls": ["https://example.com/"],
            "completeUrl": "https://example.com/complete",
            "cancelUrl": "https://example.com/cancel",
            "paymentUrl": "https://example.com/payment/android"
        }
    }
}
```

{:.code-view-header}
**Swedbank Pay Response**

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
    "operations": [
        {
            "href": "{{ page.front_end_url }}/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token={{ page.payment_token }}&culture=sv-SE",
            "rel": "view-paymentorder",
            "method": "GET",
            "contentType": "application/javascript"
        }
    ]
}
```

{:.code-view-header}
**SDK Response**
```http
HTTP/1.1 200 OK
Content-Type: text/plain

{{ page.front_end_url }}/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token={{ page.payment_token }}&culture=sv-SE
```

### Payment URL

As discussed in previous chapters, in some situations the `paymentUrl` of a payment will be opened in the browser. When this happens, we need a way of returning the flow to the mobile application. We need to take a slightly different approach depending on the client platform.

#### Android

The SDK has an Intent Filter for the `com.swedbankpay.mobilesdk.VIEW_PAYMENTORDER` action. When it receives this action, if the Intent uri is equal to the `paymentUrl` of an ongoing payment (as reported by `ViewPaymentOrderInfo`), it will reload the payment menu of that payment. Therefore, if the `paymentUrl` is opened in the browser, that page must start an activity with such an Intent. This can be done by navigating to an [intent scheme url][android-intent-scheme]. Note that the rules for following intent-scheme navigations can sometimes cause redirects to those url not to work. To work around this, the `paymentUrl` must serve a proper html page, which attempts to immediately redirect to the intent-scheme url, but also has a link the user can tap on.

Refer to the intent scheme url documentation on how to form one. You should always include the package name so that your intent is not mistakenly routed to the wrong app.

{:.code-view-header}
**Request**

```http
GET /payment/android HTTP/1.1
Host: example.com
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: text/html

<html>
    <head>
        <title>Swedbank Pay Payment</title>
        <meta http-equiv="refresh" content="0;url=intent://example.com/payment/android#Intent;scheme=https;action=com.swedbankpay.mobilesdk.VIEW_PAYMENTORDER;package=com.example.app;end;">
    </head>
    <body>
        <a href="intent://example.com/payment/android#Intent;scheme=https;action=com.swedbankpay.mobilesdk.VIEW_PAYMENTORDER;package=com.example.app;end;">Back to app</a>
    </body>
</html>
```

#### iOS

Switching apps on iOS is always done by opening a URL. urls. It is preferred to use a Universal Link URL. Your app and backend must be configured such that the `paymentUrl` used on iOS payments is registered as a universal link to your app. Then, on iOS 13.4 or later, in most cases when the `paymentUrl` is navigated to, it will be immediately given to your app to handle. However, Universal Links are not entirely reliable, in particular if you wish to support iOS earlier than 13.4, and we must still not get stuck if the `paymentUrl` is opened in the browser instead.

Now, the most straightforward way of escaping this situation is to define a custom url scheme for your app, and do something similar to the Android solution, involving that scheme. If you plan to support only iOS 13.4 and up, where the situation is rather unlikely to occur, this can be sufficient. Doing this on earlier versions is likely to end up suboptimal, though, as doing this will cause an unsightly confirmation dialog to be shown before the app is actually launched. As the situation where `paymentUrl` is opened in the browser is actually quite likely to occur on iOS earlier than 13.4, this means you are more or less subjecting all users on those systems to sub-par user experience.

To provide a workaround to the confirmation popup, we devise a system that allows the user to retrigger the navigation to `paymentUrl` in such a way as to maximize the likelyhood that the system will let the app handle it. As one of the criteria is that the navigation must be to a domain different to the current one, the `paymentUrl` itsef will always redirect to a page on a different domain. That page is then able to link back to the `paymentUrl` and have that navigation be routed to the app. You could host this "trampoline" page yourself, but Swedbank Pay has a generic one available for use. The trampoline page takes three arguments, `target`, which should be set to your `paymentUrl`, `language`, which supports all the Checkout languages, and `app`, you app name that will be shown on the page.

On iOS any URL the app is opened with is delivered to the `UIApplicationDelegate` by either the `application(_:continue:restorationHandler:)` method (for universal links) or `application(_:open:options:)`. To let the SDK respond appropriately, you need to call `SwedbankPaySDK.continue(userActivity:)` or `SwedbankPaySDK.open(url:)` from those methods, respectively.

{:.code-view-header}
**Request**

```http
GET /payment/ios HTTP/1.1
Host: example.com
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 301 Moved Permanently
Location: https://ecom.stage.payex.com/externalresourcehost/trampoline?target=https%3A%2F%2Fexample.com%2Fpayment%2Fios%3Ffallback%3Dtrue&language=en-US&app=Example%20App
```

The trampoline url will, in turn, serve an html page:

{:.code-view-header}
**Request**

```http
GET /externalresourcehost/trampoline?target=https%3A%2F%2Fexample.com%2Fpayment%2Fios%3Ffallback%3Dtrue&language=en-US&app=Example%20App HTTP/1.1
Host: ecom.stage.payex.com
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: text/html

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Swedbank Pay Redirect</title>
    <link rel="icon" type="image/png" href="/externalresourcehost/content/images/favicon.png">
    <link rel="stylesheet" href="/externalresourcehost/content/css/style.css">
</head>
<body>
    <div class="trampoline-container" onclick="redirect()">
    <img alt="Swedbank Pay Logo" src="/externalresourcehost/content/images/swedbank-pay-logo-vertical.png" />
    <span class="trampoline-text">
            <a>Back to Example App</a>
    </span>
</div>

<script>
    function redirect() { window.location.href = decodeURIComponent("https%3A%2F%2Fexample.com%2Fpayment%2Fios%3Ffallback%3Dtrue"); };
</script>

</body>
</html>
```

The page links back to `https://example.com/payment/ios?fallback=true`. Notice the additional parameter. This is, indeed, part of the `target` parameter, and under the control of your backend. The purpose of this is to allow for one final escape hatch, in case the universal link mechanism fails to work. If this url is yet again opened in the browser, the backend responds with a redirect to to a custom-scheme url. (This _should_ only happen if your universal links configuration is broken, or if iOS has somehow failed to load the [Apple App-Site Association file][ios-aasa].)

{:.code-view-header}
**Request**

```http
GET /payment/ios?fallback=true HTTP/1.1
Host: example.com
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 301 Moved Permanently
Location: com.example.app://example.com/payment/ios?fallback=true
```

From the app perspective, in our example, the url the app is opened with will be one these three: `https://example.com/payment/ios`, `https://example.com/payment/ios?fallback=true`, or `com.example.app://example.com/payment/ios?fallback=true`. When any of these is passed to the SDK from your `UIApplicationDelegate`, the SDK will then call into your Configuration to check if it matches the `paymentUrl` (`https://example.com/payment/ios` in this example). This can be customized, but by default it will allow the scheme to change and for additional query parameters to be added to the url, so this example would work with the default configuration.

#### Apple App-Site Association

As the iOS `paymentUrl` needs to be a universal link, the backend will also need an [Apple App-Site Association file][ios-aasa]. This must be served at `/.well-known/apple-app-site-association`, and it must associate any url used as a `paymentUrl` with the app.

{:.code-view-header}
**Request**

```http
GET /.well-known/apple-app-site-association HTTP/1.1
Host: example.com
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "applinks": {
        "apps": [],
        "details": [
            {
                "appID": "ABCDE12345.com.example.app",
                "paths": [ "/payment/ios" ],

                "appIDs": [ "ABCDE12345.com.example.app" ],
                "components": [
                    { "/": "/payment/ios" }
                ]
            }
        ]
    }
}
```

Note that the AASA file must be served over `https`, otherwise iOS will not load it. This example AASA file contains both old-style and new-style values for maximum compatibility. You may not need the old-style values in your implementation, depending on your situation.

## Updating a Payment Order

The SDK includes a facility for updating a payment order after is has been created. The Merchant Backend Configuration uses this to allow setting the instrument of an instrument mode payment, but your custom Configuration can use it for whatever purpose you need.

<!--lint disable no-duplicate-headings-->

### Android

First, implement `updatePaymentOrder` in your `Configuration` subclass. This method returns the same data type as `postPaymentorders`, and when it does, the `PaymentFragment` reloads the payment menu according to the new data. The `paymentOrder` and `userData` arguments are what you set for the `PaymentFragment`, the `viewPaymentOrderInfo` argument is the current `ViewPaymentOrderInfo` (as returned from a previous call to this method, or, if this is the first update, the original `postPaymentorders` call). The `updateInfo` argument will be the value you call `PaymentViewModel.updatePaymentOrder` with, its meaning is therefore defined by you.

```kotlin
    class MyConfiguration : Configuration() {
        override suspend fun updatePaymentOrder(
            context: Context,
            paymentOrder: PaymentOrder?,
            userData: Any?,
            viewPaymentOrderInfo: ViewPaymentOrderInfo,
            updateInfo: Any?
        ): ViewPaymentOrderInfo {
            val viewPaymentOrder = post("https://example.com/payment/android/frobnicate")
            return ViewPaymentOrderInfo(
                webViewBaseUrl = "https://example.com/",
                viewPaymentOrder = viewPaymentOrder,
                completeUrl = "https://example.com/complete",
                cancelUrl = "https://example.com/cancel",
                paymentUrl = "https://example.com/payment/android",
                termsOfServiceUrl = "https://example.com/tos"
            )
        }
    }
```

To trigger an update, call `updatePaymentOrder` on the `PaymentViewModel` of the active payment. The argument of that call will be passed to your `Configuration.updatePaymentOrder` as the `updateInfo` argument.

```kotlin
    activity.paymentViewModel.updatePaymentOrder("frob")
```
### iOS

Implement `updatePaymentOrder` in your configuration. Rather like the Android method, this method takes a callback of the same type as `postPaymentorders`, and when that callback is invoked with a `Success` result, the `SwedbankPaySDKController` reloads the payment menu according to the new data. Unlike `postPaymentorders`, this method must also return a request handle, which can be used to cancel the request if needed. If the request is cancelled, the `completion` callback should _not_ be called.

```swift
    struct MyConfiguration : SwedbankPaySDKConfiguration {
        func updatePaymentOrder(
            paymentOrder: SwedbankPaySDK.PaymentOrder?,
            userData: Any?,
            viewPaymentOrderInfo: SwedbankPaySDK.ViewPaymentOrderInfo,
            updateInfo: Any,
            completion: @escaping (Result<SwedbankPaySDK.ViewPaymentOrderInfo, Error>) -> Void
        ) -> SwedbankPaySDKRequest? {
            val request = post("https://example.com/payment/ios/frobnicate") { result in
                do {
                    let viewPaymentorder = try result.get()
                    let info = ViewPaymentOrderInfo(
                        webViewBaseURL: "https://example.com/",
                        viewPaymentorder: viewPaymentorder,
                        completeUrl: "https://example.com/complete",
                        cancelUrl: "https://example.com/cancel",
                        paymentUrl: "https://example.com/payment/ios",
                        termsOfServiceUrl: "https://example.com/tos"
                    )
                    completion(.success(info))
                } catch NetworkError.cancelled {
                    // no callback
                } catch {
                    completion(.failure(error))
                }
            }
            return request
        }
    }
```

To trigger an update, call `updatePaymentOrder` on the `SwedbankPaySDKController`. The argument will be passed to your configuration in the `updateInfo` argument.

```swift
    swedbankPayController.updatePaymentOrder(
        updateInfo: "frob"
    )
```

### Backend

The backend implementation makes any needed calls to Swedbank Pay, and returns whatever your implementation expects. It is recommended to always use the `view-paymentorder` link from the update response, in case the update has caused a change to that url.

{:.code-view-header}
**Request**
```http
POST /payment/android/frobnicate HTTP/1.1
Host: example.com
```

{:.code-view-header}
**Response**
```http
HTTP/1.1 200 OK
Content-Type: text/plain

{{ page.front_end_url }}/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token={{ page.payment_token }}&culture=sv-SE
```

## Errors

Any exception you throw from your Configuration will be made available in `PaymentViewModel.exception` or `SwedbankPaySDKDelegate.paymentFailed(error:)`. You are therefore fully in control of the model you wish to use to report errors. We recommend adopting the [Problem Details for HTTP APIs][rfc-7807] convention for reporting errors from your backend. At the moment of writing, the Android SDK also contains a [utility][dokka-problem] for parsing RFC 7807 messages to help with this.

## Other Features

### iOS Payment Menu Redirect Handling

In many cases the payment menu will need to navigate to a different web page as part of the payment process. Unfortunately, testing has shown that not all such pages are happy about being opened in a `WKWebView`. To mitigate this, the SDK contains a list of pages we know to work, and any others will be opened in Safari (or whatever browser the user has set as default in recent iOS). If you wish, you can customize this behaviour by overriding `decidePolicyForPaymentMenuRedirect` in your configuration. Note that you can also modify this behaviour by the `webRedirectBehavior` property of `SwedbankPaySDKController`.

```swift
    struct MyConfiguration : SwedbankPaySDKConfiguration {
        func decidePolicyForPaymentMenuRedirect(
            navigationAction: WKNavigationAction,
            completion: @escaping (SwedbankPaySDK.PaymentMenuRedirectPolicy) -> Void
        ) {
            // we like to live dangerously, allow everything
            completion(.openInWebView)
        }
    }
```

### iOS Payment URL Matching

The iOS `paymentUrl` universal-link/custom-scheme contraption makes it so that your app must be able to accept some variations in the urls. The default behaviour is to allow for a different scheme and additional query parameters. If these are not good for your app, you can override the `url(_:matchesPaymentUrl:)` method in your configuration. If you wish to simply specify the allowed custom scheme, you can conform to `SwedbankPaySDKConfigurationWithCallbackScheme` instead.

```swift
    struct MyConfiguration : SwedbankPaySDKConfiguration {
        func url(_ url: URL, matchesPaymentUrl paymentUrl: URL) -> Bool {
            // We trust univeral links enough
            // so we do not need the custom-scheme fallback
            return url == paymentUrl
        }
    }
```

```swift
    struct MyConfiguration : SwedbankPaySDKConfigurationWithCallbackScheme {
        let callbackScheme = "com.example.app"
    }
```

{% include iterator.html prev_href="ios"
                         prev_title="Back: iOS"
                         next_href="other-features"
                         next_title="Next: Other Features" %}

[initiate-consumer-session]: /checkout/v2/checkin#step-1-initiate-session-for-consumer-identification
[create-payment-order]: /checkout/v2/payment-menu#step-3-create-payment-order
[payment-url]: /checkout/v2/features/technical-reference/payment-url
[ios-aasa]: https://developer.apple.com/documentation/safariservices/supporting_associated_domains_in_your_app#3001215
[android-intent-scheme]: https://developer.chrome.com/multidevice/android/intents
[rfc-7807]: https://tools.ietf.org/html/rfc7807
[dokka-problem]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-problem/index.md
