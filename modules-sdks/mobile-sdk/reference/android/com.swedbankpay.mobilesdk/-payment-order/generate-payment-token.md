---
title: generatePaymentToken
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentOrder](index.html)/[generatePaymentToken](generate-payment-token.html)



# generatePaymentToken



[androidJvm]\




@SerializedName(value = "generatePaymentToken")



val [generatePaymentToken](generate-payment-token.html): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) = false



If true, a payment token will be created from this payment order



You must also set [PaymentOrderPayer.payerReference](../-payment-order-payer/payer-reference.html) to generate a payment token. The payment token can be used later to reuse the same payment details; see [paymentToken](payment-token.html).




