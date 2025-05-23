---
title: Android
permalink: /:path/android/
description: |
  With a Merchant Backend in place, we can start developing a mobile application
  with Swedbank Pay payments.
  Let us begin with Android.
menu_order: 1000
---

This guide assumes that you are using the Merchant Backend Configuration and
your backend implements the Merchant Backend API. If you are using a custom
backend instead, the meaning of `PaymentFragment` arguments will be different,
as well as any errors reported, but the basic process is the same. The
differences will be highlighted in the chapter on custom backends.

## Installation

The Android component of the Swedbank Pay Mobile SDK is distributed through
Maven Central. It is split into two libraries in the
[`com.swedbankpay.mobilesdk`][maven-group]{:target="_blank"} group:

*   Core SDK: [`com.swedbankpay.mobilesdk:mobilesdk`][sdk-maven]{:target="_blank"}
*   Merchant Backend Utilities:
    [`com.swedbankpay.mobilesdk:mobilesdk-merchantbackend`][merchantbackend-maven]{:target="_blank"}

If you are not using the Merchant Backend API in your backend, you only need to
use the first one. Otherwise, you should add both libraries to your project to
get utilities for interfacing with your Merchant Backend server.

Most applications can integrate the SDK by simply adding the dependency in
the `build.gradle` file:

```groovy
dependencies {
    implementation 'com.swedbankpay.mobilesdk:mobilesdk:{{ page.mobile_sdk_android_version }}'
    implementation 'com.swedbankpay.mobilesdk:mobilesdk-merchantbackend:{{ page.mobile_sdk_android_version }}'
}
```

Or in your `gradle.kts` file:

```kotlin
dependencies {
    implementation("com.swedbankpay.mobilesdk:mobilesdk:{{ page.mobile_sdk_android_version }}")
    implementation("com.swedbankpay.mobilesdk:mobilesdk-merchantbackend:{{ page.mobile_sdk_android_version }}")
}
```

Please refer to Maven Central for the latest versions of the libraries.

## Custom URL Scheme

The [Payment Url][paymenturl] handling in the Android SDK uses a custom URL
scheme. You must therefore set this up using the template intent filter prepared
in the SDK, that uses a
[Gradle Manifest Placeholder][gradle-manifest-placeholders]. You do this by
specifying your custom URL scheme in you `build.gradle` file (in this example
we're preparing for a payment URL using `examplepayment://`):

```groovy
defaultConfig {
    manifestPlaceholders = [swedbankPaymentUrlScheme:"examplepayment"]
}
```

Or in your `gradle.kts` file:

```kotlin
defaultConfig {
    manifestPlaceholders["swedbankPaymentUrlScheme"] = "examplepayment"
}
```

## Usage

```mermaid
sequenceDiagram
    participant App
    participant SDK
    participant Merchant
    participant SwedbankPay as Swedbank Pay
    participant Ext as External App

    rect rgba(238, 112, 35, 0.05)
        note left of App: Configuration
        App ->> SDK: MerchantBackendConfiguration.Builder("https://example.com/swedbank-pay-mobile/").build()
        SDK -->> App: configuration
        App ->> SDK: PaymentFragment.defaultConfiguration = configuration
    end

    opt Unless Guest Payment
        App ->> SDK: Consumer(language = ..., shippingAddressRestrictedToCountryCodes = ...)
        SDK -->> App: consumer
    end

    rect rgba(138, 205, 195, 0.1)
        note left of App: Prepare Payment
        App ->> SDK: PaymentOrderUrls(context, "https://example.com/swedbank-pay-mobile/")
        SDK -->> App: paymentOrderUrls
        App ->> SDK: PaymentOrder(urls = paymentOrderUrls, ...)
        SDK -->> App: paymentOrder
    end

    App ->> SDK: activity.paymentViewModel.[rich]state.observe(...)
    App ->> SDK: PaymentFragment.ArgumentsBuilder().consumer(consumer).paymentOrder(paymentOrder).build()
    SDK -->> App: arguments
    App ->> SDK: PaymentFragment()
    SDK -->> App: paymentFragment
    App ->> SDK: paymentFragment.arguments = arguments
    App ->> App: Show paymentFragment

    rect rgba(138, 205, 195, 0.1)
        note left of App: Discover Endpoints
        SDK ->> Merchant: GET /swedbank-pay-mobile/
        Merchant -->> SDK: { "consumers": "/swedbank-pay-mobile/consumers", "paymentorders": "/swedbank-pay-mobile/paymentorders" }
    end

    opt Unless Guest Payment
        SDK ->> Merchant: POST /swedbank-pay-mobile/consumers
        Merchant ->> SwedbankPay: POST /psp/consumers
        SwedbankPay -->> Merchant: rel: view-consumer-identification
        Merchant -->> SDK: rel: view-consumer-identification
        SDK ->> SDK: Show html page with view-consumer-identification
        SwedbankPay ->> SDK: Consumer identification process
        SDK ->> SwedbankPay: Consumer identification process
        SwedbankPay ->> SDK: consumerProfileRef
        SDK ->> SDK: paymentOrder.payer = { consumerProfileRef }
    end

    rect rgba(138, 205, 195, 0.1)
        note left of App: Payment Menu
        SDK ->> Merchant: POST /swedbank-pay-mobile/paymentorders
        Merchant ->> SwedbankPay: POST /psp/paymentorders
        SwedbankPay -->> Merchant: rel: view-paymentorder
        Merchant -->> SDK: rel: view-paymentorder
        SDK ->> SDK: Show html page with view-paymentorder
        SwedbankPay ->> SDK: Payment process
        SDK ->> SwedbankPay: Payment process
        opt Redirect to Third-Party Page
            SDK ->> SDK: Show third-party page
            SDK ->> SDK: Intercept navigation to paymentUrl
            SDK ->> SDK: Reload html page with view-paymentorder
        end
        opt Launch External Application
            SDK ->> Ext: Start external application
            Ext ->> Merchant: Open paymentUrl
            Merchant ->> Ext: Redirect intent://<...>action=com.swedbankpay.mobilesdk.VIEW_PAYMENTORDER
            Ext ->> SDK: Start activity\naction=com.swedbankpay.mobilesdk.VIEW_PAYMENTORDER
            SDK ->> SDK: Reload html page with view-paymentorder
        end
        SDK ->> SDK: Intercept navigation to completeUrl
        SDK ->> SDK: paymentViewModel.state <- SUCCESS
        SDK ->> App: observer.onChanged(SUCCESS)
    end

    App ->> App: Remove paymentFragment
```

The public API of the Android SDK is in the package
[`com.swedbankpay.mobilesdk`][dokka-pkg]{:target="_blank"}. The main component
is [`PaymentFragment`][dokka-payfrag]{:target="_blank"}, a `Fragment` that
handles a single payment order. To use a `PaymentFragment`, it must have a
[`Configuration`][dokka-config]{:target="_blank"}. In most cases it is enough to
construct a single `Configuration` and set it as the
[default][dokka-payfrag-defconf]{:target="_blank"}. In more advanced cases you
will need to subclass `PaymentFragment` and override
[`getConfiguration`][dokka-payfrag-getconf]{:target="_blank"}.

For using a backend implementing the Merchant Backend API, the SDK also provides
utility classes in the package
[`com.swedbankpay.mobilesdk.merchantbackend`][dokka-pkg-merch]{:target="_blank"}.
The examples on this page make use of these, including the `Configuration`
implementation
[`MerchantBackendConfiguration`][dokka-merchconfig]{:target="_blank"}.

```kotlin
val backendUrl = "https://example.com/swedbank-pay-mobile/"

val configuration = MerchantBackendConfiguration.Builder(backendUrl)
    .build()
PaymentFragment.defaultConfiguration = configuration
```

To start a payment, you need a
[`PaymentOrder`][dokka-paymentorder]{:target="_blank"}, and, unless making a
guest payment, a [`Consumer`][dokka-consumer]{:target="_blank"}. Using a
`Consumer` makes future payments by the same payer easier.

The semantics of `Consumer` properties are the same as the fields of the
[`POST/psp/consumers`][checkin-consumer] request. There are default values for
the `operation` and `language` properties
(`ConsumerOperation.INITIATE_CONSUMER_SESSION` and `Language.ENGLISH`,
respectively).

```kotlin
val consumer = Consumer(
    language = Language.SWEDISH,
    shippingAddressRestrictedToCountryCodes = listOf("NO", "SE", "DK")
)
```

Similarly, the semantics of `PaymentOrder` properties are the same as the fields
of the [`POST /psp/paymentorders`][checkin-paymentorder] request. Sensible
default values are provided for many of the properties. The `urls` property has
no default per se, but there are
[convenience constructors][dokka-paymentorderurls-init]{:target="_blank"}
available for it, and it is recommended that you use them. Assuming you have the
Android Payment Url Helper endpoint set up with the specified static path
relative to your backend url (i.e. `sdk-callback/android-intent`), then using
the one of the `PaymentOrderUrls(context: Context, backendUrl: String)` variants
will set the `paymentUrl` correctly.

```kotlin
val paymentOrder = PaymentOrder(
    currency = Currency.getInstance("SEK"),
    amount = 1500L,
    vatAmount = 375L,
    description = "Test Purchase",
    language = Language.SWEDISH,
    urls = PaymentOrderUrls(context, backendUrl),
    payeeInfo = PayeeInfo(
        // ①
        payeeName = "Merchant1",
        productCategory = "A123",
        orderReference = "or-123456",
        subsite = "MySubsite"
    ),

    orderItems = listOf(
        OrderItem(
            reference = "P1",
            name = "Product1",
            type = ItemType.PRODUCT,
            `class` = "ProductGroup1",
            itemUrl = "https://example.com/products/123",
            imageUrl = "https://example.com/product123.jpg",
            description = "Product 1 description",
            discountDescription = "Volume discount",
            quantity = 4,
            quantityUnit = "pcs",
            unitPrice = 300L,
            discountPrice = 200L,
            vatPercent = 2500,
            amount = 1000L,
            vatAmount = 250L
        )
    )
)
```

*   ① payeeId and payeeReference are required fields, but default to the empty
    string. The assumption here is that your Merchant Backend will override the
    values set here. If your system works better with the Mobile Client setting
    them instead, they are available here also.

To start a payment, create a `PaymentFragment` and set its arguments according
to the payment. The
[`PaymentFragment.ArgumentsBuilder`][dokka-payfrag-argbuilder]{:target="_blank"}
class is provided to help with creating the argument bundle. In most cases you
only need to worry about the
[`paymentOrder`][dokka-payfrag-argbuilder-paymentorder]{:target="_blank"}
property. The payment process starts as soon as the `PaymentFragment` is
visible. Note that Digital Payments is currently opt-in, so that merchants can
upgrade without too much breaking changes and start using the new Digital
Payments when ready.

```kotlin
val arguments = PaymentFragment.ArgumentsBuilder()
    .checkoutV3(true)
    .paymentOrder(paymentOrder)
    .build()

val paymentFragment = PaymentFragment()
paymentFragment.arguments = arguments

// Now use FragmentManager to show paymentFragment.
// You can also make a navigation graph with PaymentFragment
// and do something like
// findNavController().navigate(R.id.showPaymentFragment, arguments)
```

Note that the SDK only supports customer-checkin for version 2, and provides
fallback for merchants in need of this. Then you need to supply a
[`consumer`][dokka-payfrag-argbuilder-consumer]{:target="_blank"} and the
Checkout v3 setting becomes irrelevant.

```kotlin
val arguments = PaymentFragment.ArgumentsBuilder()
    .consumer(consumer)
    .paymentOrder(paymentOrder)
    .build()

val paymentFragment = PaymentFragment()
paymentFragment.arguments = arguments

// Now handle the fragment the same way as previously.
```

To observe the payment process, use the
[`PaymentViewModel`][dokka-paymentvm]{:target="_blank"}
[of the containing `Activity`][dokka-activity-paymentvm]{:target="_blank"}.
When the
`PaymentViewModel` [signals][dokka-paymentvm-livestate]{:target="_blank"}
that the payment process has reached a
[final][dokka-paymentvm-state-isfinal]{:target="_blank"} state, you should
remove the `PaymentFragment` and inform the user of the
result.

```kotlin
paymentViewModel.state.observe(this, Observer {
    if (it.isFinal == true) {
        // Remove PaymentFragment
        // Check payment status from your backend
        // Notify user
    }
})
```

Note that checking the payment status after completion is outside the scope of
the Mobile SDK. Your backend should collect any information it needs to perform
this check when it services the request to the
[Payment Orders endpoint][backend-payment-orders] made by the `PaymentFragment`.

## Errors

If any errors happen in the payment, the `PaymentViewModel` will report a state
of either `FAILURE` or `RETRYABLE_ERROR`. If the error is retryable, the
`PaymentFragment` will show an error message and a retry control (this is
configurable), but you can also trigger a retry by calling retryPreviousAction
on the `PaymentViewModel`.

When the state is `FAILURE` or `RETRYABLE_ERROR`, and the error condition was
caused by an exception thrown from the `Configuration`, that exception is
available in
[`PaymentViewModel.richState.exception`][dokka-paymentvm-richstate-exception]{:target="_blank"}.
The exception will be of any type throw by your `Configuration`. When using
`MerchantBackendConfiguration`, this means it will be an `IOException` if there
was a problem communicating with the backend, and an `IllegalStateException` if
you have made a programming error (consult the exception message). A particular
`IOException` to check for is
[`RequestProblemException`][dokka-problem-exception]{:target="_blank"}, which
signals that the backend responded with a Problem message. Another one is
[`UnexpectedResponseException`][dokka-unexpected-exception]{:target="_blank"},
which signals that the SDK did not understand the backend response.

## Problems

If errors are encountered in the payment process, the Merchant Backend is
expected to respond with a [Problem Details for HTTP APIs (RFC 7807)][rfc-7807]
message. If a problem occurs, the application can receive it by observing the
[`richState`][dokka-paymentvm-liverichstate] of the `PaymentViewModel`. If a
problem has occurred, the [`exception`][dokka-paymentvm-richstate-exception]
property of the [`RichState`][dokka-paymentvm-richstate] will contain a
[`RequestProblemException`][dokka-problem-exception]. The problem is then
accessible as [`exception.problem`][dokka-problem-exception-problem]. The
Android SDK will parse any RFC 7807 problem, but it has specialized data types
for known problem types, namely the [Common Problems][swedbankpay-problems] and
the [Merchand Backend Problems][backend-problems].

Problems are presented as a [class hierarchy][dokka-problem]{:target="_blank"}
representing different problem categories. All problems parsed from RFC 7807
messages are classified as either
[`Client`][dokka-problem-client]{:target="_blank"} or
[`Server`][dokka-problem-server]{:target="_blank"} problems. A `Client` problem
is one caused by client behavior, and is to be fixed by changing the request
made to the server. Generally, a `Client` problem is a programming error, with
the possible exception of
[`Problem.Client.MobileSDK.Unauthorized`][dokka-problem-client-mobilesdk-unauthorized]{:target="_blank"}.
A `Server` problem is one caused by a malfunction or lack of service in the
server evironment. A `Server` problem is fixed by correcting the behavior of
the malfunctioning server, or simply trying again later.

Further, both `Client` and `Server` problems are categorized as `MobileSDK`,
`SwedbankPay`, or `Unknown`. `MobileSDK` problems are ones with
[Merchant Backend problem types][backend-problems], while `SwedbankPay` problems
have [Swedbank Pay API problem types][swedbankpay-problems]. `Unknown` problems
are of types that the SDK has no knowledge of. There is also the interface
[`SwedbankPayProblem`][dokka-swedbankpayproblem]{:target="_blank"}, which
encompasses both [`Client`][dokka-problem-client-swedbankpay]{:target="_blank"}
and [`Server`][dokka-problem-server-swedbankpay]{:target="_blank"} type
`SwedbankPay` problems.

```kotlin
paymentViewModel.richState.observe(this, Observer {
    if (it.state.isFinal == true) {
        val exeption = it.exception as? RequestProblemException
        if (exception != null) (
            when (val problem = exception.problem) {
                is MerchantBackendProblem.Client.MobileSDK.Unauthorized ->
                    Log.d(TAG, "Credentials invalidated: ${problem.message}")

                if MerchantBackendProblem.Client.MobileSDK ->
                    Log.d(TAG, "Other client error at Merchant Backend: ${problem.raw}")

                is MerchantBackendProblem.Client.SwedbankPay.InputError ->
                    Log.d(TAG, "Payment rejected by Swedbank Pay: ${problem.detail}; Fix: ${problem.action}")

                is MerchantBackendProblem.Client.Unknown ->
                    if (problem.type == "https://example.com/problems/special-problem") {
                        Log.d(TAG, "Special problem occurred: ${problem.detail}")
                    } else {
                        Log.d(TAG, "Unexpected problem: ${problem.raw}")
                    }

                is MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout ->
                    Log.d(TAG, "Swedbank Pay timeout: ${problem.message}")

                is MerchantBackendProblem.Server.SwedbankPay.SystemError ->
                    Log.d(TAG, "Generic server error at Swedbank Pay: ${problem.detail}")

                is SwedbankPayProblem ->
                    Log.d(TAG, "Other problem at Swedbank Pay: ${problem.detail}; Fix: ${problem.action}")

                else ->
                    Log.d(TAG, "Unexpected problem: ${problem.raw}")
            }
        }
    }
})
```

## Payment URL And External Applications

The payment process may involve navigating to third-party web pages, or even
launching external applications. To resume processing the payment in the payment
menu, each payment order must have a [Payment Url][paymenturl]. As mentioned
above, the SDK has convenience constructors to set up a payment url for you, and
as the SDK handles showing third-party web pages inside the `PaymentFragment`,
it automatically intercepts any navigation to the payment url, and reloads the
payment menu. This requires no additional setup.

If a third party application is launched, it will signal the return to the
payment menu by opening the payment url, using a standard `ACTION_VIEW`
`Intent`. The payment URL should use a custom URL scheme unique to the app. The
SDK has a template intent filter that uses a
[Gradle Manifest Placeholder][gradle-manifest-placeholders], so the SDK will
receive it, bringing the containing application to the foreground, and reloading
the payment menu.

{% include iterator.html prev_href="/checkout-v3/modules-sdks/mobile-sdk/custom-backend"
                         prev_title="Back: Custom Backend"
                         next_href="/checkout-v3/modules-sdks/mobile-sdk/ios"
                         next_title="Next: iOS" %}

[maven-group]: https://search.maven.org/search?q=g:com.swedbankpay.mobilesdk
[sdk-maven]: https://search.maven.org/artifact/com.swedbankpay.mobilesdk/mobilesdk
[merchantbackend-maven]: https://search.maven.org/artifact/com.swedbankpay.mobilesdk/mobilesdk-merchantbackend
[dokka-pkg]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/index.md
[dokka-pkg-merch]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk.merchantbackend/index.md
[dokka-payfrag]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-payment-fragment/index.md
[dokka-payfrag-argbuilder]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-payment-fragment/-arguments-builder/index.md
[dokka-payfrag-argbuilder-consumer]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-payment-fragment/-arguments-builder/consumer.md
[dokka-payfrag-argbuilder-paymentorder]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-payment-fragment/-arguments-builder/payment-order.md
[dokka-payfrag-defconf]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-payment-fragment/-companion/default-configuration.md
[dokka-payfrag-getconf]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-payment-fragment/get-configuration.md
[dokka-config]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-configuration/index.md
[dokka-merchconfig]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-configuration/index.md
[dokka-paymentvm]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-payment-view-model/index.md
[dokka-paymentvm-livestate]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-payment-view-model/state.md
[dokka-paymentvm-liverichstate]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-payment-view-model/rich-state.md
[dokka-paymentvm-state-isfinal]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-payment-view-model/-state/is-final.md
[dokka-paymentvm-richstate]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-payment-view-model/-rich-state/index.md
[dokka-paymentvm-richstate-exception]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-payment-view-model/-rich-state/exception.md
[dokka-consumer]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-consumer/index.md
[dokka-paymentorder]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-payment-order/index.md
[checkin-consumer]: /old-implementations/checkout-v2/checkin#step-1-initiate-session-for-consumer-identification
[checkin-paymentorder]: /old-implementations/checkout-v2/payment-menu#step-3-create-payment-order
[dokka-paymentorderurls-init]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-payment-order-urls/-payment-order-urls.md
[dokka-activity-paymentvm]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/payment-view-model.md
[backend-payment-orders]: /old-implementations/mobile-sdk/merchant-backend#payment-orders-endpoint
[dokka-problem-exception]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/
[dokka-problem-exception-problem]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/
[dokka-unexpected-exception]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/
[rfc-7807]: https://tools.ietf.org/html/rfc7807
[swedbankpay-problems]: /checkout-v3/features/technical-reference/problems
[backend-problems]: /old-implementations/mobile-sdk/merchant-backend#problems
[dokka-problem]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/index.md
[dokka-problem-client]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-client/index.md
[dokka-problem-client-swedbankpay]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-client/-swedbank-pay/index.md
[dokka-problem-client-mobilesdk-unauthorized]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-client/-mobile-s-d-k/-unauthorized/index.md
[dokka-problem-server]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/index.md
[dokka-problem-server-swedbankpay]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-swedbank-pay/index.md
[dokka-swedbankpayproblem]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk.merchantbackend/-swedbank-pay-problem/index.md
[paymenturl]: /checkout-v3/features/technical-reference/payment-url
[gradle-manifest-placeholders]: https://developer.android.com/build/manage-manifests#inject_build_variables_into_the_manifest
