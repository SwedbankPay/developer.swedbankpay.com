---
title: PaymentOrderUrls
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentOrderUrls](index.html)



# PaymentOrderUrls



[androidJvm]\
data class [PaymentOrderUrls](index.html)(hostUrls: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;, completeUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), cancelUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, paymentUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, callbackUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, termsOfServiceUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

A set of URLs relevant to a payment order.



The Mobile SDK places some requirements on these URLs,  different to the web-page case. See individual properties for discussion.



## Constructors


| | |
|---|---|
| [PaymentOrderUrls](-payment-order-urls.html) | [androidJvm]<br>@[JvmOverloads](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.jvm/-jvm-overloads/index.html)<br>fun [PaymentOrderUrls](-payment-order-urls.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), backendUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), callbackUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, termsOfServiceUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, identifier: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) = UUID.randomUUID().toString())<br>Creates a set of URLs suitable for use with a Merchant Backend server. |
| [PaymentOrderUrls](-payment-order-urls.html) | [androidJvm]<br>fun [PaymentOrderUrls](-payment-order-urls.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), hostUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), backendUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), callbackUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, termsOfServiceUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, identifier: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) = UUID.randomUUID().toString())<br>Creates a set of URLs suitable for use with a Merchant Backend server. |
| [PaymentOrderUrls](-payment-order-urls.html) | [androidJvm]<br>fun [PaymentOrderUrls](-payment-order-urls.html)(hostUrls: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;, completeUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), cancelUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, paymentUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, callbackUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, termsOfServiceUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null) |


## Types


| Name | Summary |
|---|---|
| [Builder](-builder/index.html) | [androidJvm]<br>class [Builder](-builder/index.html) |
| [Companion](-companion/index.html) | [androidJvm]<br>object [Companion](-companion/index.html) |


## Functions


| Name | Summary |
|---|---|
| [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [callbackUrl](callback-url.html) | [androidJvm]<br>@SerializedName(value = "callbackUrl")<br>val [callbackUrl](callback-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>A URL on your server that receives status callbacks related to the payment. |
| [cancelUrl](cancel-url.html) | [androidJvm]<br>@SerializedName(value = "cancelUrl")<br>val [cancelUrl](cancel-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>The URL that the payment menu will redirect to when the payment is canceled. |
| [completeUrl](complete-url.html) | [androidJvm]<br>@SerializedName(value = "completeUrl")<br>val [completeUrl](complete-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>The URL that the payment menu will redirect to when the payment is complete. |
| [hostUrls](host-urls.html) | [androidJvm]<br>@SerializedName(value = "hostUrls")<br>val [hostUrls](host-urls.html): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;<br>Array of URLs that are valid for embedding this payment order. |
| [paymentUrl](payment-url.html) | [androidJvm]<br>@SerializedName(value = "paymentUrl")<br>val [paymentUrl](payment-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>A URL that will be navigated to when the payment menu needs to be reloaded. |
| [termsOfServiceUrl](terms-of-service-url.html) | [androidJvm]<br>@SerializedName(value = "termsOfServiceUrl")<br>val [termsOfServiceUrl](terms-of-service-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>A URL to your Terms of Service. |

