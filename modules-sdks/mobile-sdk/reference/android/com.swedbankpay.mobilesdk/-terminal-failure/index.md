---
title: TerminalFailure
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[TerminalFailure](index.html)



# TerminalFailure



[androidJvm]\
data class [TerminalFailure](index.html) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

Describes a terminal error condition signaled by an onError callback from Swedbank Pay.



See https://developer.swedbankpay.com/checkout/other-features#onerror



## Functions


| Name | Summary |
|---|---|
| [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [details](details.html) | [androidJvm]<br>val [details](details.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>A human readable and descriptive text of the error. |
| [messageId](message-id.html) | [androidJvm]<br>val [messageId](message-id.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>A unique identifier for the message. |
| [origin](origin.html) | [androidJvm]<br>val [origin](origin.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>"consumer", "paymentmenu", "creditcard", identifies the system that originated the error. |

