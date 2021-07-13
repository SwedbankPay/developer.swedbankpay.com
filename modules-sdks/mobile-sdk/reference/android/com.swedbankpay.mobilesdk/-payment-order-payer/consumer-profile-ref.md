---
title: consumerProfileRef -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PaymentOrderPayer](index)/[consumerProfileRef](consumer-profile-ref)



# consumerProfileRef  
[androidJvm]  
Content  
@SerializedName(value = consumerProfileRef)  
  
val [consumerProfileRef](consumer-profile-ref): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null  
More info  


A consumer profile reference obtained through the Checkin flow.



If you have your [PaymentFragment](../-payment-fragment/index) to do the Checkin flow (see [PaymentFragment.ArgumentsBuilder.consumer](../-payment-fragment/-arguments-builder/consumer) and [PaymentFragment.ArgumentsBuilder.useCheckin](../-payment-fragment/-arguments-builder/use-checkin)), your [Configuration.postPaymentorders](../-configuration/post-paymentorders) will be called with the consumerProfileRef received from the Checkin flow. Your Configuration can then use that value here to forward it to your backend for payment order creation.

  



