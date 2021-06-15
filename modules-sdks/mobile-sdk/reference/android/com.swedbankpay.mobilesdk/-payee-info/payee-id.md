---
title: payeeId
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PayeeInfo](index.html)/[payeeId](payee-id.html)



# payeeId



[androidJvm]\




@SerializedName(value = "payeeId")



val [payeeId](payee-id.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)



The unique identifier of this payee set by Swedbank Pay.



This is usually the Merchant ID. However, usually best idea to set this value in your backend instead. Thus, this property defaults to the empty string, but it is included in the data model for completeness.




