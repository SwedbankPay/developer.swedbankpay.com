---
title: PaymentOrderUrls -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PaymentOrderUrls](index)/[PaymentOrderUrls](-payment-order-urls)



# PaymentOrderUrls  
[androidJvm]  
Content  
@[JvmOverloads](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.jvm/-jvm-overloads/index.html)()  
  
fun [PaymentOrderUrls](-payment-order-urls)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), backendUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), callbackUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, termsOfServiceUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, identifier: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) = UUID.randomUUID().toString())  
More info  


Creates a set of URLs suitable for use with a Merchant Backend server.



This constructor sets hostUrls to contain only backendUrl (this coincides with how [MerchantBackendConfiguration](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-configuration/index) sets the backend URL as [ViewPaymentOrderInfo.webViewBaseUrl](../-view-payment-order-info/web-view-base-url), completeUrl and cancelUrl to static paths relative to backendUrl. The paymentUrl will be constructed using the backendUrl, the path defined for the Android Intent Callback URL in the Merchant Backend specification, the identifier argument (by default a random UUID), and the application package name.



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
| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a>context| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a><br><br>an application [Context](https://developer.android.com/reference/kotlin/android/content/Context.html)<br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a>backendUrl| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a><br><br>the URL of your Merchant Backend<br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a>callbackUrl| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a><br><br>the callbackUrl to use, if any<br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a>termsOfServiceUrl| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a><br><br>the termsOfServiceUrl to use, if any<br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a>identifier| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a><br><br>an identifier for this payment order. Should be unique within your app. Defaults to a random UUID.<br><br>|
  
  


[androidJvm]  
Content  
fun [PaymentOrderUrls](-payment-order-urls)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), hostUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), backendUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), callbackUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, termsOfServiceUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, identifier: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) = UUID.randomUUID().toString())  
More info  


Creates a set of URLs suitable for use with a Merchant Backend server.



This version of the constructor allows you to set the URL used for hostUrls separately. This is not usually needed.



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a>context| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a><br><br>an application [Context](https://developer.android.com/reference/kotlin/android/content/Context.html)<br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a>hostUrl| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a><br><br>the URL to place in hostUrls<br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a>backendUrl| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a><br><br>the URL of your Merchant Backend<br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a>callbackUrl| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a><br><br>the callbackUrl to use, if any<br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a>termsOfServiceUrl| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a><br><br>the termsOfServiceUrl to use, if any<br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a>identifier| <a name="com.swedbankpay.mobilesdk/PaymentOrderUrls/PaymentOrderUrls/#android.content.Context#kotlin.String#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String/PointingToDeclaration/"></a><br><br>an identifier for this payment order. Should be unique within your app. Defaults to a random UUID.<br><br>|
  
  


[androidJvm]  
Content  
fun [PaymentOrderUrls](-payment-order-urls)(hostUrls: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)<[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)>, completeUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), cancelUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, paymentUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, callbackUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, termsOfServiceUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null)  



