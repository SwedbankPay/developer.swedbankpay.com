---
title: Consumer -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[Consumer](index)



# Consumer  
 [androidJvm] data class [Consumer](index)(**operation**: [ConsumerOperation](../-consumer-operation/index), **language**: [Language](../-language/index), **shippingAddressRestrictedToCountryCodes**: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)<[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)>) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

A consumer to identify using the [checkin](https://developer.swedbankpay.com/checkout/checkin) flow.



Please refer to the [Swedbank Pay documentation](https://developer.swedbankpay.com/checkout/checkin#checkin-back-end) for further information.

   


## Constructors  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/Consumer/Consumer/#com.swedbankpay.mobilesdk.ConsumerOperation#com.swedbankpay.mobilesdk.Language#kotlin.collections.List[kotlin.String]/PointingToDeclaration/"></a>[Consumer](-consumer)| <a name="com.swedbankpay.mobilesdk/Consumer/Consumer/#com.swedbankpay.mobilesdk.ConsumerOperation#com.swedbankpay.mobilesdk.Language#kotlin.collections.List[kotlin.String]/PointingToDeclaration/"></a> [androidJvm] fun [Consumer](-consumer)(operation: [ConsumerOperation](../-consumer-operation/index) = ConsumerOperation.INITIATE_CONSUMER_SESSION, language: [Language](../-language/index) = Language.ENGLISH, shippingAddressRestrictedToCountryCodes: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)<[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)>)   <br>|


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[describeContents](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [describeContents](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)  <br><br><br>|
| <a name="android.os/Parcelable/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[writeToParcel](../-view-payment-order-info/index.md#-1754457655%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [writeToParcel](../-view-payment-order-info/index.md#-1754457655%2FFunctions%2F-1404661416)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html))  <br><br><br>|


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/Consumer/language/#/PointingToDeclaration/"></a>[language](language)| <a name="com.swedbankpay.mobilesdk/Consumer/language/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = language)  <br>  <br>val [language](language): [Language](../-language/index)The language to use in the checkin view.   <br>|
| <a name="com.swedbankpay.mobilesdk/Consumer/operation/#/PointingToDeclaration/"></a>[operation](operation)| <a name="com.swedbankpay.mobilesdk/Consumer/operation/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = operation)  <br>  <br>val [operation](operation): [ConsumerOperation](../-consumer-operation/index)The operation to perform.   <br>|
| <a name="com.swedbankpay.mobilesdk/Consumer/shippingAddressRestrictedToCountryCodes/#/PointingToDeclaration/"></a>[shippingAddressRestrictedToCountryCodes](shipping-address-restricted-to-country-codes)| <a name="com.swedbankpay.mobilesdk/Consumer/shippingAddressRestrictedToCountryCodes/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = shippingAddressRestrictedToCountryCodes)  <br>  <br>val [shippingAddressRestrictedToCountryCodes](shipping-address-restricted-to-country-codes): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)<[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)>List of ISO-3166 codes of countries the merchant can ship to.   <br>|

