---
title: postPaymentordersCompat -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[ConfigurationCompat](index)/[postPaymentordersCompat](post-paymentorders-compat)



# postPaymentordersCompat  
[androidJvm]  
Content  
@[WorkerThread](https://developer.android.com/reference/kotlin/androidx/annotation/WorkerThread.html)()  
  
abstract fun [postPaymentordersCompat](post-paymentorders-compat)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), paymentOrder: [PaymentOrder](../-payment-order/index)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?, consumerProfileRef: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?): [ViewPaymentOrderInfo](../-view-payment-order-info/index)  
More info  


Called by [PaymentFragment](../-payment-fragment/index) when it needs to create a payment order. Your implementation must ultimately make the call to Swedbank Pay API and return a [ViewPaymentOrderInfo](../-view-payment-order-info/index) describing the result.



#### Return  


ViewPaymentOrderInfo describing the payment order



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/postPaymentordersCompat/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#kotlin.String?/PointingToDeclaration/"></a>context| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/postPaymentordersCompat/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#kotlin.String?/PointingToDeclaration/"></a><br><br>an application context<br><br>|
| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/postPaymentordersCompat/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#kotlin.String?/PointingToDeclaration/"></a>paymentOrder| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/postPaymentordersCompat/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#kotlin.String?/PointingToDeclaration/"></a><br><br>the [PaymentOrder](../-payment-order/index) object set as the PaymentFragment argument<br><br>|
| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/postPaymentordersCompat/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#kotlin.String?/PointingToDeclaration/"></a>userData| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/postPaymentordersCompat/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#kotlin.String?/PointingToDeclaration/"></a><br><br>the user data object set as the PaymentFragment argument<br><br>|
| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/postPaymentordersCompat/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#kotlin.String?/PointingToDeclaration/"></a>consumerProfileRef| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/postPaymentordersCompat/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#kotlin.String?/PointingToDeclaration/"></a><br><br>if a checkin was performed first, the consumerProfileRef from checkin<br><br>|
  
  



