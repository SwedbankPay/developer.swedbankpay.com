---
title: PickUpAddress -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PickUpAddress](index)



# PickUpAddress  
 [androidJvm] data class [PickUpAddress](index)(**name**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **streetAddress**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **coAddress**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **city**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **zipCode**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **countryCode**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

Pick-up address data for [RiskIndicator](../-risk-indicator/index).



When using [ShipIndicator.PICK_UP_AT_STORE](../-ship-indicator/-companion/-p-i-c-k_-u-p_-a-t_-s-t-o-r-e), you should populate this data as completely as possible to decrease the risk factor of the purchase.

   


## Constructors  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/PickUpAddress/PickUpAddress/#kotlin.String?#kotlin.String?#kotlin.String?#kotlin.String?#kotlin.String?#kotlin.String?/PointingToDeclaration/"></a>[PickUpAddress](-pick-up-address)| <a name="com.swedbankpay.mobilesdk/PickUpAddress/PickUpAddress/#kotlin.String?#kotlin.String?#kotlin.String?#kotlin.String?#kotlin.String?#kotlin.String?/PointingToDeclaration/"></a> [androidJvm] fun [PickUpAddress](-pick-up-address)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, streetAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, coAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, city: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, zipCode: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, countryCode: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null)   <br>|


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[describeContents](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [describeContents](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)  <br><br><br>|
| <a name="android.os/Parcelable/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[writeToParcel](../-view-payment-order-info/index.md#-1754457655%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [writeToParcel](../-view-payment-order-info/index.md#-1754457655%2FFunctions%2F-1404661416)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html))  <br><br><br>|


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/PickUpAddress/city/#/PointingToDeclaration/"></a>[city](city)| <a name="com.swedbankpay.mobilesdk/PickUpAddress/city/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = city)  <br>  <br>val [city](city): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullCity of the payer   <br>|
| <a name="com.swedbankpay.mobilesdk/PickUpAddress/coAddress/#/PointingToDeclaration/"></a>[coAddress](co-address)| <a name="com.swedbankpay.mobilesdk/PickUpAddress/coAddress/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = coAddress)  <br>  <br>val [coAddress](co-address): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullC/O address of the payer   <br>|
| <a name="com.swedbankpay.mobilesdk/PickUpAddress/countryCode/#/PointingToDeclaration/"></a>[countryCode](country-code)| <a name="com.swedbankpay.mobilesdk/PickUpAddress/countryCode/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = countryCode)  <br>  <br>val [countryCode](country-code): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullCountry code of the payer   <br>|
| <a name="com.swedbankpay.mobilesdk/PickUpAddress/name/#/PointingToDeclaration/"></a>[name](name)| <a name="com.swedbankpay.mobilesdk/PickUpAddress/name/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = name)  <br>  <br>val [name](name): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullName of the payer   <br>|
| <a name="com.swedbankpay.mobilesdk/PickUpAddress/streetAddress/#/PointingToDeclaration/"></a>[streetAddress](street-address)| <a name="com.swedbankpay.mobilesdk/PickUpAddress/streetAddress/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = streetAddress)  <br>  <br>val [streetAddress](street-address): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullStreet address of the payer   <br>|
| <a name="com.swedbankpay.mobilesdk/PickUpAddress/zipCode/#/PointingToDeclaration/"></a>[zipCode](zip-code)| <a name="com.swedbankpay.mobilesdk/PickUpAddress/zipCode/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = zipCode)  <br>  <br>val [zipCode](zip-code): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullZip code of the payer   <br>|

