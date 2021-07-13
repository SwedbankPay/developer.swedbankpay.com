---
title: PaymentTokenInfo -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk.merchantbackend](../index)/[PaymentTokenInfo](index)



# PaymentTokenInfo  
 [androidJvm] data class [PaymentTokenInfo](index)

A payment token and associated information.

   


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/PaymentTokenInfo/instrument/#/PointingToDeclaration/"></a>[instrument](instrument)| <a name="com.swedbankpay.mobilesdk.merchantbackend/PaymentTokenInfo/instrument/#/PointingToDeclaration/"></a> [androidJvm] val [instrument](instrument): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?Payment instrument type of this token   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/PaymentTokenInfo/instrumentDisplayName/#/PointingToDeclaration/"></a>[instrumentDisplayName](instrument-display-name)| <a name="com.swedbankpay.mobilesdk.merchantbackend/PaymentTokenInfo/instrumentDisplayName/#/PointingToDeclaration/"></a> [androidJvm] val [instrumentDisplayName](instrument-display-name): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?User-friendly name of the payment instrument   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/PaymentTokenInfo/instrumentParameters/#/PointingToDeclaration/"></a>[instrumentParameters](instrument-parameters)| <a name="com.swedbankpay.mobilesdk.merchantbackend/PaymentTokenInfo/instrumentParameters/#/PointingToDeclaration/"></a> [androidJvm] val [instrumentParameters](instrument-parameters): [Map](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/index.html)<[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)>?Instrument-specific parameters.   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/PaymentTokenInfo/operations/#/PointingToDeclaration/"></a>[operations](operations)| <a name="com.swedbankpay.mobilesdk.merchantbackend/PaymentTokenInfo/operations/#/PointingToDeclaration/"></a> [androidJvm] val [operations](operations): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)<[Operation](../-operation/index)>Operations you can perform on this token.   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/PaymentTokenInfo/paymentToken/#/PointingToDeclaration/"></a>[paymentToken](payment-token)| <a name="com.swedbankpay.mobilesdk.merchantbackend/PaymentTokenInfo/paymentToken/#/PointingToDeclaration/"></a> [androidJvm] val [paymentToken](payment-token): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)The actual paymentToken   <br>|

