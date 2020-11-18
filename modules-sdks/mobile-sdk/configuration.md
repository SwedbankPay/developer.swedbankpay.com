---
title: Configuration
estimated_read: 4
description: |
  Configure the **Swedbank Pay Mobile SDK** to communicate with your backend.
menu_order: 700
---

{% capture disclaimer %}
The SDK is at an early stage of development
and is not supported as of yet by Swedbank Pay. It is provided as a
convenience to speed up your development, so please feel free to play around.
However, if you need support, please wait for a future, stable release.
{% endcapture %}

{% include alert.html type="warning" icon="warning" header="Unsupported"
body=disclaimer %}

While making a payment, the SDK will need to create a payment order, and possibly start a consumer identification session. These are ultimately done using the relevant Swedbank Pay APIs, but as those are protected by secrets you cannot securely embed in a mobile app, you will need our own server in the middle.

The SDK cannot communicate directly with your servers, so you must provide a Configuration that specifies how it does that. This page provides a basic overview of the Configuration on both iOS and Android. More details shall be discussed in the platform-specific chapters.

## iOS

The Configuration is a value that conforms to the `SwedbankPaySDKConfiguration` protocol. The procotol has two required methods:

```swift
    struct MyConfiguration : SwedbankPaySDKConfiguration {

        // This method is called when the SDK starts a consumer identification session.
        // You need to make a request to your own backend here, that backend must
        // make a POST /psp/consumers request to Swedbank Pay, finally you must propagate
        // the result of that request to the completion callback here.
        //
        // The consumer and userData arguments are the values set to your
        // SwedbankPaySDKController. Their precise meaning is up to you.
        func postConsumers(
            consumer: SwedbankPaySDK.Consumer?,
            userData: Any?,
            completion: @escaping (Result<SwedbankPaySDK.ViewConsumerIdentificationInfo, Error>) -> Void
        ) {
           // code
        }

        // This method is called when the SDK creates the payment order.
        // You need to make a request to your own backend here, that backend must
        // make a POST /psp/paymentorders request to Swedbank Pay, finally you must propagate
        // the result of that request to the completion callback here.
        //
        // The paymentOrder and userData arguments are the values set to your
        // SwedbankPaySDKController. Their precise meaning is up to you.
        //
        // If you are making a payment with consumer identification, then the
        // consumerProfileRef from the identification session will be provided
        // in the consumerProfileRef argument. Otherwise, consumerProfileRef will be nil.
        func postPaymentorders(
            paymentOrder: SwedbankPaySDK.PaymentOrder?,
            userData: Any?,
            consumerProfileRef: String?,
            completion: @escaping (Result<SwedbankPaySDK.ViewPaymentOrderInfo, Error>) -> Void

        ) {
           // code
        }
    }
```

## Android

The Configuration is a subclass of the abstract class [`Configuration`][dokka-config]. The class has two abstract methods. These methods are suspending (asynchronous) Kotlin methods; a compatibility class is provided if you need to implement your Configuration in Java instead.

```kotlin
    class MyConfiguration : Configuration() {

        // This method is called when the SDK starts a consumer identification session.
        // You need to make a request to your own backend here, that backend must
        // make a POST /psp/consumers request to Swedbank Pay, and finally you must
        // return a ViewConsumerIdentificationInfo object populated with the
        // results of that request.
        //
        // The context argument is an application context for resource access.
        // The consumer and userData arguments are the values set as arguments
        // to PaymentFragment. Their precise meaning is up to you.
        override suspend fun postConsumers(
            context: Context,
            consumer: Consumer?,
            userData: Any?
        ): ViewConsumerIdentificationInfo {
            // code
        }

        // This method is called when the SDK creates the payment order.
        // You need to make a request to your own backend here, that backend must
        // make a POST /psp/paymentorders request to Swedbank Pay, finally you must
        // return a ViewPaymentOrderInfo object populated with the
        // results of that request.
        //
        // The context argument is an application context for resource access.
        // The paymentOrder and userData arguments are the values set as arguments
        // to PaymentFragment. Their precise meaning is up to you.
        //
        // If you are making a payment with consumer identification, then the
        // consumerProfileRef from the identification session will be provided
        // in the consumerProfileRef argument. Otherwise, consumerProfileRef will be nil.
        override suspend fun postPaymentorders(
            context: Context,
            paymentOrder: PaymentOrder?,
            userData: Any?,
            consumerProfileRef: String?
        ): ViewPaymentOrderInfo {
            // code
        }
    }
```

## Backend

As the mobile application cannot talk directly to Swedbank Pay servers, you will need your own backend to make those requests on the behalf of your Configuration. You are free to design your backend as best suits you, but the next chapter will detail one possible implementation, which also has a bundled-in Configuration implementation available in the SDK.

One thing you should keep in mind while designing your backend is that the `paymentUrl` of your payment order needs special consideration in order to work correctly. This is a somewhat complicated issue, discussed in detail in each platform-specific chapter, but the gist of the issue is that the `paymentUrl` will, in some cases, be opened in the browser application, and at that point we must take some measures to return to your application to continue the payment. This can be accomplished by having `paymentUrl` return a redirect response; the details of that redirect will be discussed in the platform-specific pages. It is recommneded that `paymentUrl` be unique to each payment order that you create.

The next chapter will go over the Merchant Backend API. It will also explore in detail how `paymentUrl` is handled on a server implementing the Merchant Backend API. The SDK comes ready with a Configuration suitable for a server implementing the Merchant Backend API, which will be discussed in detail in the client platform specific chapters.

{% include iterator.html prev_href="./"
                         prev_title="Back: Introduction"
                         next_href="merchant-backend"
                         next_title="Next: Merchant Backend" %}

[swagger]: https://github.com/SwedbankPay/swedbank-pay-sdk-mobile-example-merchant/blob/master/documentation/swedbankpaysdk_openapi.yaml
[swagger-editor]: https://editor.swagger.io/?url=https://raw.githubusercontent.com/SwedbankPay/swedbank-pay-sdk-mobile-example-merchant/master/documentation/swedbankpaysdk_openapi.yaml
[payment-url]: /checkout/payment-menu#payment-url
[initiate-consumer-session]: /checkout/checkin#step-1-initiate-session-for-consumer-identification
[create-payment-order]: /checkout/payment-menu#step-3-create-payment-order
[android-intent-scheme]: https://developer.chrome.com/multidevice/android/intents
[ios-custom-scheme]: https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content/defining_a_custom_url_scheme_for_your_app
[ios-universal-links]: https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content
[ios-universal-links-routing]: https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content#3001753
[ios-aasa]: https://developer.apple.com/documentation/safariservices/supporting_associated_domains_in_your_app#3001215
[rfc-7807]: https://tools.ietf.org/html/rfc7807
[swedbankpay-problems]: /home/technical-information#problems
[dokka-config]: https://github.com/SwedbankPay/swedbank-pay-sdk-android/blob/dev/sdk/dokka_github/sdk/com.swedbankpay.mobilesdk/-configuration/index.md
