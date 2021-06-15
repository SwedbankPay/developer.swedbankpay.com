---
title: ViewPaymentOrderInfo
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[ViewPaymentOrderInfo](index.html)



# ViewPaymentOrderInfo



[androidJvm]\
data class [ViewPaymentOrderInfo](index.html)(webViewBaseUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, viewPaymentOrder: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), completeUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), cancelUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, paymentUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, termsOfServiceUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, instrument: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, availableInstruments: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

Data required to show the payment menu.



If you provide a custom [Configuration](../-configuration/index.html), you must get the relevant data from your services and return a ViewPaymentOrderInfo object in your [Configuration.postPaymentorders](../-configuration/post-paymentorders.html) method.



## Constructors


| | |
|---|---|
| [ViewPaymentOrderInfo](-view-payment-order-info.html) | [androidJvm]<br>fun [ViewPaymentOrderInfo](-view-payment-order-info.html)(webViewBaseUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, viewPaymentOrder: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), completeUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), cancelUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, paymentUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, termsOfServiceUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, instrument: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, availableInstruments: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;? = null, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)? = null) |


## Functions


| Name | Summary |
|---|---|
| [describeContents](index.html#-1578325224%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [describeContents](index.html#-1578325224%2FFunctions%2F-1074806346)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [writeToParcel](index.html#-1754457655%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [writeToParcel](index.html#-1754457655%2FFunctions%2F-1074806346)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [availableInstruments](available-instruments.html) | [androidJvm]<br>val [availableInstruments](available-instruments.html): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;? = null<br>If the payment order is in instrument mode, all the valid instruments for it. |
| [cancelUrl](cancel-url.html) | [androidJvm]<br>val [cancelUrl](cancel-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>The cancelUrl of the payment order |
| [completeUrl](complete-url.html) | [androidJvm]<br>val [completeUrl](complete-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>The completeUrl of the payment order |
| [instrument](instrument.html) | [androidJvm]<br>val [instrument](instrument.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>If the payment order is in instrument mode, the current instrument. |
| [paymentUrl](payment-url.html) | [androidJvm]<br>val [paymentUrl](payment-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>The paymentUrl of the payment order |
| [termsOfServiceUrl](terms-of-service-url.html) | [androidJvm]<br>val [termsOfServiceUrl](terms-of-service-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>The termsOfServiceUrl of the payment order |
| [userData](user-data.html) | [androidJvm]<br>val [userData](user-data.html): [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)? = null<br>Any value you may need for your [Configuration](../-configuration/index.html). |
| [viewPaymentOrder](view-payment-order.html) | [androidJvm]<br>val [viewPaymentOrder](view-payment-order.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>The view-paymentorder link from Swedbank Pay. |
| [webViewBaseUrl](web-view-base-url.html) | [androidJvm]<br>val [webViewBaseUrl](web-view-base-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>The url to use as the [android.webkit.WebView](https://developer.android.com/reference/kotlin/android/webkit/WebView.html) page url when showing the checkin UI. If null, defaults to about:blank, as [documented](https://developer.android.com/reference/kotlin/android/webkit/WebView.html#loaddatawithbaseurl). |

