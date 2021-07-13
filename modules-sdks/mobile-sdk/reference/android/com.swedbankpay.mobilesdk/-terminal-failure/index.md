---
title: TerminalFailure -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[TerminalFailure](index)



# TerminalFailure  
 [androidJvm] data class [TerminalFailure](index) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

Describes a terminal error condition signaled by an onError callback from Swedbank Pay.



See https://developer.swedbankpay.com/checkout/other-features#onerror

   


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[describeContents](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [describeContents](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)  <br><br><br>|
| <a name="android.os/Parcelable/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[writeToParcel](../-view-payment-order-info/index.md#-1754457655%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [writeToParcel](../-view-payment-order-info/index.md#-1754457655%2FFunctions%2F-1404661416)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html))  <br><br><br>|


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/TerminalFailure/details/#/PointingToDeclaration/"></a>[details](details)| <a name="com.swedbankpay.mobilesdk/TerminalFailure/details/#/PointingToDeclaration/"></a> [androidJvm] val [details](details): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?A human readable and descriptive text of the error.   <br>|
| <a name="com.swedbankpay.mobilesdk/TerminalFailure/messageId/#/PointingToDeclaration/"></a>[messageId](message-id)| <a name="com.swedbankpay.mobilesdk/TerminalFailure/messageId/#/PointingToDeclaration/"></a> [androidJvm] val [messageId](message-id): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?A unique identifier for the message.   <br>|
| <a name="com.swedbankpay.mobilesdk/TerminalFailure/origin/#/PointingToDeclaration/"></a>[origin](origin)| <a name="com.swedbankpay.mobilesdk/TerminalFailure/origin/#/PointingToDeclaration/"></a> [androidJvm] val [origin](origin): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?"consumer", "paymentmenu", "creditcard", identifies the system that originated the error.   <br>|

