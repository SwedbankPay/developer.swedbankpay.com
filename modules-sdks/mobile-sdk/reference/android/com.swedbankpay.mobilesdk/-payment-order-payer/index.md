---
title: PaymentOrderPayer
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentOrderPayer](index.html)



# PaymentOrderPayer



[androidJvm]\
data class [PaymentOrderPayer](index.html)(consumerProfileRef: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, email: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, msisdn: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, payerReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

Information about the payer of a payment order



## Constructors


| | |
|---|---|
| [PaymentOrderPayer](-payment-order-payer.html) | [androidJvm]<br>fun [PaymentOrderPayer](-payment-order-payer.html)(consumerProfileRef: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, email: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, msisdn: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, payerReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null) |


## Types


| Name | Summary |
|---|---|
| [Builder](-builder/index.html) | [androidJvm]<br>class [Builder](-builder/index.html) |


## Functions


| Name | Summary |
|---|---|
| [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [consumerProfileRef](consumer-profile-ref.html) | [androidJvm]<br>@SerializedName(value = "consumerProfileRef")<br>val [consumerProfileRef](consumer-profile-ref.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>A consumer profile reference obtained through the Checkin flow. |
| [email](email.html) | [androidJvm]<br>@SerializedName(value = "email")<br>val [email](email.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>The email address of the payer. |
| [msisdn](msisdn.html) | [androidJvm]<br>@SerializedName(value = "msisdn")<br>val [msisdn](msisdn.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>The phone number of the payer. |
| [payerReference](payer-reference.html) | [androidJvm]<br>@SerializedName(value = "payerReference")<br>val [payerReference](payer-reference.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>An opaque, unique reference to the payer. Alternative to the other fields. |

