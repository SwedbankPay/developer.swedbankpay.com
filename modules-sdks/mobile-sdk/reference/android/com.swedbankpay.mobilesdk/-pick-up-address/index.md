---
title: PickUpAddress
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PickUpAddress](index.html)



# PickUpAddress



[androidJvm]\
data class [PickUpAddress](index.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, streetAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, coAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, city: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, zipCode: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, countryCode: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

Pick-up address data for [RiskIndicator](../-risk-indicator/index.html).



When using [ShipIndicator.PICK_UP_AT_STORE](../-ship-indicator/-companion/-p-i-c-k_-u-p_-a-t_-s-t-o-r-e.html), you should populate this data as completely as possible to decrease the risk factor of the purchase.



## Constructors


| | |
|---|---|
| [PickUpAddress](-pick-up-address.html) | [androidJvm]<br>fun [PickUpAddress](-pick-up-address.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, streetAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, coAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, city: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, zipCode: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, countryCode: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null) |


## Functions


| Name | Summary |
|---|---|
| [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [city](city.html) | [androidJvm]<br>@SerializedName(value = "city")<br>val [city](city.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>City of the payer |
| [coAddress](co-address.html) | [androidJvm]<br>@SerializedName(value = "coAddress")<br>val [coAddress](co-address.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>C/O address of the payer |
| [countryCode](country-code.html) | [androidJvm]<br>@SerializedName(value = "countryCode")<br>val [countryCode](country-code.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>Country code of the payer |
| [name](name.html) | [androidJvm]<br>@SerializedName(value = "name")<br>val [name](name.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>Name of the payer |
| [streetAddress](street-address.html) | [androidJvm]<br>@SerializedName(value = "streetAddress")<br>val [streetAddress](street-address.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>Street address of the payer |
| [zipCode](zip-code.html) | [androidJvm]<br>@SerializedName(value = "zipCode")<br>val [zipCode](zip-code.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>Zip code of the payer |

