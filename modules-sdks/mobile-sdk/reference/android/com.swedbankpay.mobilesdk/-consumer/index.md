---
title: Consumer
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[Consumer](index.html)



# Consumer



[androidJvm]\
data class [Consumer](index.html)(operation: [ConsumerOperation](../-consumer-operation/index.html), language: [Language](../-language/index.html), shippingAddressRestrictedToCountryCodes: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

A consumer to identify using the [checkin](https://developer.swedbankpay.com/checkout/checkin) flow.



Please refer to the [Swedbank Pay documentation](https://developer.swedbankpay.com/checkout/checkin#checkin-back-end) for further information.



## Constructors


| | |
|---|---|
| [Consumer](-consumer.html) | [androidJvm]<br>fun [Consumer](-consumer.html)(operation: [ConsumerOperation](../-consumer-operation/index.html) = ConsumerOperation.INITIATE_CONSUMER_SESSION, language: [Language](../-language/index.html) = Language.ENGLISH, shippingAddressRestrictedToCountryCodes: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;) |


## Functions


| Name | Summary |
|---|---|
| [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [language](language.html) | [androidJvm]<br>@SerializedName(value = "language")<br>val [language](language.html): [Language](../-language/index.html)<br>The language to use in the checkin view. |
| [operation](operation.html) | [androidJvm]<br>@SerializedName(value = "operation")<br>val [operation](operation.html): [ConsumerOperation](../-consumer-operation/index.html)<br>The operation to perform. |
| [shippingAddressRestrictedToCountryCodes](shipping-address-restricted-to-country-codes.html) | [androidJvm]<br>@SerializedName(value = "shippingAddressRestrictedToCountryCodes")<br>val [shippingAddressRestrictedToCountryCodes](shipping-address-restricted-to-country-codes.html): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;<br>List of ISO-3166 codes of countries the merchant can ship to. |

