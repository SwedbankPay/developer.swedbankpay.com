---
title: generatePaymentToken -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PaymentOrder](index)/[generatePaymentToken](generate-payment-token)



# generatePaymentToken  
[androidJvm]  
Content  
@SerializedName(value = generatePaymentToken)  
  
val [generatePaymentToken](generate-payment-token): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) = false  
More info  


If true, a payment token will be created from this payment order



You must also set [PaymentOrderPayer.payerReference](../-payment-order-payer/payer-reference) to generate a payment token. The payment token can be used later to reuse the same payment details; see [paymentToken](payment-token).

  



