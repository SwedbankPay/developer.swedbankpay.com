---
title: paymentToken -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PaymentOrder](index)/[paymentToken](payment-token)



# paymentToken  
[androidJvm]  
Content  
@SerializedName(value = paymentToken)  
  
val [paymentToken](payment-token): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null  
More info  


A payment token to use for this payment.



You must also set [PaymentOrderPayer.payerReference](../-payment-order-payer/payer-reference) to use a payment token; the payerReference must match the one used when the payment token was generated.

  



