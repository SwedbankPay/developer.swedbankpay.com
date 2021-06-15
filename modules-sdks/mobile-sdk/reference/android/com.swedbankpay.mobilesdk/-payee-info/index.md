---
title: PayeeInfo
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PayeeInfo](index.html)



# PayeeInfo



[androidJvm]\
data class [PayeeInfo](index.html)(payeeId: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), payeeReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), payeeName: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, productCategory: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, orderReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, subsite: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

Information about the payee (recipient) of a payment order



## Constructors


| | |
|---|---|
| [PayeeInfo](-payee-info.html) | [androidJvm]<br>fun [PayeeInfo](-payee-info.html)(payeeId: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) = "", payeeReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) = "", payeeName: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, productCategory: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, orderReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, subsite: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null) |


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
| [orderReference](order-reference.html) | [androidJvm]<br>@SerializedName(value = "orderReference")<br>val [orderReference](order-reference.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>A reference to your own merchant system. |
| [payeeId](payee-id.html) | [androidJvm]<br>@SerializedName(value = "payeeId")<br>val [payeeId](payee-id.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>The unique identifier of this payee set by Swedbank Pay. |
| [payeeName](payee-name.html) | [androidJvm]<br>@SerializedName(value = "payeeName")<br>val [payeeName](payee-name.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>Name of the payee, usually the name of the merchant. |
| [payeeReference](payee-reference.html) | [androidJvm]<br>@SerializedName(value = "payeeReference")<br>val [payeeReference](payee-reference.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>[A unique reference for this operation](https://developer.swedbankpay.com/checkout/other-features#payee-reference). |
| [productCategory](product-category.html) | [androidJvm]<br>@SerializedName(value = "productCategory")<br>val [productCategory](product-category.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>A product category or number sent in from the payee/merchant. |
| [subsite](subsite.html) | [androidJvm]<br>@SerializedName(value = "subsite")<br>val [subsite](subsite.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>Used for split settlement. |

