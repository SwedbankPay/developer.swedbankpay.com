---
title: PaymentOrderUrls
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentOrderUrls](index.html)/[PaymentOrderUrls](-payment-order-urls.html)



# PaymentOrderUrls



[androidJvm]\




@[JvmOverloads](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.jvm/-jvm-overloads/index.html)



fun [PaymentOrderUrls](-payment-order-urls.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), backendUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), callbackUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, termsOfServiceUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, identifier: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) = UUID.randomUUID().toString())



Creates a set of URLs suitable for use with a Merchant Backend server.



This constructor sets hostUrls to contain only backendUrl (this coincides with how com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration sets the backend URL as [ViewPaymentOrderInfo.webViewBaseUrl](../-view-payment-order-info/web-view-base-url.html), completeUrl and cancelUrl to static paths relative to backendUrl. The paymentUrl will be constructed using the backendUrl, the path defined for the Android Intent Callback URL in the Merchant Backend specification, the identifier argument (by default a random UUID), and the application package name.



Example:

<table>
    <tr><td>`hostUrls`</td>   <td>`["https://example.com/"]`</td></tr>
    <tr><td>`completeUrl`</td><td>`"https://example.com/complete"`</td></tr>
    <tr><td>`cancelUrl`</td>  <td>`"https://example.com/cancel"`</td></tr>
    <tr><td>`paymentUrl`</td> <td>`"https://example.com/sdk-callback/android-intent?package=com.example.app&id=1234"`</td></tr>
</table>

## Parameters


androidJvm

| | |
|---|---|
| context | an application [Context](https://developer.android.com/reference/kotlin/android/content/Context.html) |
| backendUrl | the URL of your Merchant Backend |
| callbackUrl | the callbackUrl to use, if any |
| termsOfServiceUrl | the termsOfServiceUrl to use, if any |
| identifier | an identifier for this payment order. Should be unique within your app. Defaults to a random UUID. |





[androidJvm]\
fun [PaymentOrderUrls](-payment-order-urls.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), hostUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), backendUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), callbackUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, termsOfServiceUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, identifier: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) = UUID.randomUUID().toString())



Creates a set of URLs suitable for use with a Merchant Backend server.



This version of the constructor allows you to set the URL used for hostUrls separately. This is not usually needed.



## Parameters


androidJvm

| | |
|---|---|
| context | an application [Context](https://developer.android.com/reference/kotlin/android/content/Context.html) |
| hostUrl | the URL to place in hostUrls |
| backendUrl | the URL of your Merchant Backend |
| callbackUrl | the callbackUrl to use, if any |
| termsOfServiceUrl | the termsOfServiceUrl to use, if any |
| identifier | an identifier for this payment order. Should be unique within your app. Defaults to a random UUID. |





[androidJvm]\
fun [PaymentOrderUrls](-payment-order-urls.html)(hostUrls: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;, completeUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), cancelUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, paymentUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, callbackUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, termsOfServiceUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null)




