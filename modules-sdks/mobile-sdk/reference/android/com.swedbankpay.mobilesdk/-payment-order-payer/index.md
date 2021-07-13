---
title: PaymentOrderPayer -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PaymentOrderPayer](index)



# PaymentOrderPayer  
 [androidJvm] data class [PaymentOrderPayer](index)(**consumerProfileRef**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **email**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **msisdn**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **payerReference**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

Information about the payer of a payment order

   


## Constructors  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderPayer/PaymentOrderPayer/#kotlin.String?#kotlin.String?#kotlin.String?#kotlin.String?/PointingToDeclaration/"></a>[PaymentOrderPayer](-payment-order-payer)| <a name="com.swedbankpay.mobilesdk/PaymentOrderPayer/PaymentOrderPayer/#kotlin.String?#kotlin.String?#kotlin.String?#kotlin.String?/PointingToDeclaration/"></a> [androidJvm] fun [PaymentOrderPayer](-payment-order-payer)(consumerProfileRef: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, email: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, msisdn: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, payerReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null)   <br>|


## Types  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderPayer.Builder///PointingToDeclaration/"></a>[Builder](-builder/index)| <a name="com.swedbankpay.mobilesdk/PaymentOrderPayer.Builder///PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>class [Builder](-builder/index)  <br><br><br>|


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[describeContents](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [describeContents](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)  <br><br><br>|
| <a name="android.os/Parcelable/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[writeToParcel](../-view-payment-order-info/index.md#-1754457655%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [writeToParcel](../-view-payment-order-info/index.md#-1754457655%2FFunctions%2F-1404661416)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html))  <br><br><br>|


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderPayer/consumerProfileRef/#/PointingToDeclaration/"></a>[consumerProfileRef](consumer-profile-ref)| <a name="com.swedbankpay.mobilesdk/PaymentOrderPayer/consumerProfileRef/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = consumerProfileRef)  <br>  <br>val [consumerProfileRef](consumer-profile-ref): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullA consumer profile reference obtained through the Checkin flow.   <br>|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderPayer/email/#/PointingToDeclaration/"></a>[email](email)| <a name="com.swedbankpay.mobilesdk/PaymentOrderPayer/email/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = email)  <br>  <br>val [email](email): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullThe email address of the payer.   <br>|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderPayer/msisdn/#/PointingToDeclaration/"></a>[msisdn](msisdn)| <a name="com.swedbankpay.mobilesdk/PaymentOrderPayer/msisdn/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = msisdn)  <br>  <br>val [msisdn](msisdn): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullThe phone number of the payer.   <br>|
| <a name="com.swedbankpay.mobilesdk/PaymentOrderPayer/payerReference/#/PointingToDeclaration/"></a>[payerReference](payer-reference)| <a name="com.swedbankpay.mobilesdk/PaymentOrderPayer/payerReference/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = payerReference)  <br>  <br>val [payerReference](payer-reference): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullAn opaque, unique reference to the payer.   <br>|

