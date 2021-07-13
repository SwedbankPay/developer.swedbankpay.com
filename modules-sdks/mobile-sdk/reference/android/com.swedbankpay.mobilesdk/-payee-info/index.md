---
title: PayeeInfo -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PayeeInfo](index)



# PayeeInfo  
 [androidJvm] data class [PayeeInfo](index)(**payeeId**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), **payeeReference**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), **payeeName**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **productCategory**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **orderReference**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **subsite**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

Information about the payee (recipient) of a payment order

   


## Constructors  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/PayeeInfo/PayeeInfo/#kotlin.String#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String?#kotlin.String?/PointingToDeclaration/"></a>[PayeeInfo](-payee-info)| <a name="com.swedbankpay.mobilesdk/PayeeInfo/PayeeInfo/#kotlin.String#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String?#kotlin.String?/PointingToDeclaration/"></a> [androidJvm] fun [PayeeInfo](-payee-info)(payeeId: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) = "", payeeReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) = "", payeeName: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, productCategory: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, orderReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, subsite: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null)   <br>|


## Types  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/PayeeInfo.Builder///PointingToDeclaration/"></a>[Builder](-builder/index)| <a name="com.swedbankpay.mobilesdk/PayeeInfo.Builder///PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>class [Builder](-builder/index)  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk/PayeeInfo.Companion///PointingToDeclaration/"></a>[Companion](-companion/index)| <a name="com.swedbankpay.mobilesdk/PayeeInfo.Companion///PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>object [Companion](-companion/index)  <br><br><br>|


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[describeContents](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [describeContents](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)  <br><br><br>|
| <a name="android.os/Parcelable/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[writeToParcel](../-view-payment-order-info/index.md#-1754457655%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [writeToParcel](../-view-payment-order-info/index.md#-1754457655%2FFunctions%2F-1404661416)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html))  <br><br><br>|


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/PayeeInfo/orderReference/#/PointingToDeclaration/"></a>[orderReference](order-reference)| <a name="com.swedbankpay.mobilesdk/PayeeInfo/orderReference/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = orderReference)  <br>  <br>val [orderReference](order-reference): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullA reference to your own merchant system.   <br>|
| <a name="com.swedbankpay.mobilesdk/PayeeInfo/payeeId/#/PointingToDeclaration/"></a>[payeeId](payee-id)| <a name="com.swedbankpay.mobilesdk/PayeeInfo/payeeId/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = payeeId)  <br>  <br>val [payeeId](payee-id): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)The unique identifier of this payee set by Swedbank Pay.   <br>|
| <a name="com.swedbankpay.mobilesdk/PayeeInfo/payeeName/#/PointingToDeclaration/"></a>[payeeName](payee-name)| <a name="com.swedbankpay.mobilesdk/PayeeInfo/payeeName/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = payeeName)  <br>  <br>val [payeeName](payee-name): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullName of the payee, usually the name of the merchant.   <br>|
| <a name="com.swedbankpay.mobilesdk/PayeeInfo/payeeReference/#/PointingToDeclaration/"></a>[payeeReference](payee-reference)| <a name="com.swedbankpay.mobilesdk/PayeeInfo/payeeReference/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = payeeReference)  <br>  <br>val [payeeReference](payee-reference): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)[A unique reference for this operation](https://developer.swedbankpay.com/checkout/other-features#payee-reference).   <br>|
| <a name="com.swedbankpay.mobilesdk/PayeeInfo/productCategory/#/PointingToDeclaration/"></a>[productCategory](product-category)| <a name="com.swedbankpay.mobilesdk/PayeeInfo/productCategory/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = productCategory)  <br>  <br>val [productCategory](product-category): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullA product category or number sent in from the payee/merchant.   <br>|
| <a name="com.swedbankpay.mobilesdk/PayeeInfo/subsite/#/PointingToDeclaration/"></a>[subsite](subsite)| <a name="com.swedbankpay.mobilesdk/PayeeInfo/subsite/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = subsite)  <br>  <br>val [subsite](subsite): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullUsed for split settlement.   <br>|

