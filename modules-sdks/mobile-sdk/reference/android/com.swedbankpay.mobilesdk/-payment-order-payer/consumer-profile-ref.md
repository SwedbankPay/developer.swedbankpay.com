---
title: consumerProfileRef
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentOrderPayer](index.html)/[consumerProfileRef](consumer-profile-ref.html)



# consumerProfileRef



[androidJvm]\




@SerializedName(value = "consumerProfileRef")



val [consumerProfileRef](consumer-profile-ref.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null



A consumer profile reference obtained through the Checkin flow.



If you have your [PaymentFragment](../-payment-fragment/index.html) to do the Checkin flow (see [PaymentFragment.ArgumentsBuilder.consumer](../-payment-fragment/-arguments-builder/consumer.html) and [PaymentFragment.ArgumentsBuilder.useCheckin](../-payment-fragment/-arguments-builder/use-checkin.html)), your [Configuration.postPaymentorders](../-configuration/post-paymentorders.html) will be called with the consumerProfileRef received from the Checkin flow. Your Configuration can then use that value here to forward it to your backend for payment order creation.




