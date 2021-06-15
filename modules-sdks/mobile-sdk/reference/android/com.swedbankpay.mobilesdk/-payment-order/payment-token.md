---
title: paymentToken
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentOrder](index.html)/[paymentToken](payment-token.html)



# paymentToken



[androidJvm]\




@SerializedName(value = "paymentToken")



val [paymentToken](payment-token.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null



A payment token to use for this payment.



You must also set [PaymentOrderPayer.payerReference](../-payment-order-payer/payer-reference.html) to use a payment token; the payerReference must match the one used when the payment token was generated.




