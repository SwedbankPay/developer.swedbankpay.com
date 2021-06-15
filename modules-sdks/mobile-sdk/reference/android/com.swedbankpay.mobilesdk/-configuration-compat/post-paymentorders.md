---
title: postPaymentorders
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[ConfigurationCompat](index.html)/[postPaymentorders](post-paymentorders.html)



# postPaymentorders



[androidJvm]\
suspend override fun [postPaymentorders](post-paymentorders.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), paymentOrder: [PaymentOrder](../-payment-order/index.html)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?, consumerProfileRef: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?): [ViewPaymentOrderInfo](../-view-payment-order-info/index.html)



Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to create a payment order. Your implementation must ultimately make the call to Swedbank Pay API and return a [ViewPaymentOrderInfo](../-view-payment-order-info/index.html) describing the result.



#### Return



ViewPaymentOrderInfo describing the payment order



## Parameters


androidJvm

| | |
|---|---|
| context | an application context |
| paymentOrder | the [PaymentOrder](../-payment-order/index.html) object set as the PaymentFragment argument |
| userData | the user data object set as the PaymentFragment argument |
| consumerProfileRef | if a checkin was performed first, the consumerProfileRef from checkin |




