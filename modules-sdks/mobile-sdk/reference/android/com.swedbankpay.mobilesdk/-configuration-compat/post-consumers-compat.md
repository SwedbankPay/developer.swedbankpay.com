---
title: postConsumersCompat -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[ConfigurationCompat](index)/[postConsumersCompat](post-consumers-compat)



# postConsumersCompat  
[androidJvm]  
Content  
@[WorkerThread](https://developer.android.com/reference/kotlin/androidx/annotation/WorkerThread.html)()  
  
abstract fun [postConsumersCompat](post-consumers-compat)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), consumer: [Consumer](../-consumer/index)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [ViewConsumerIdentificationInfo](../-view-consumer-identification-info/index)  
More info  


Called by [PaymentFragment](../-payment-fragment/index) when it needs to start a consumer identification session. Your implementation must ultimately make the call to Swedbank Pay API and return a [ViewConsumerIdentificationInfo](../-view-consumer-identification-info/index) describing the result.



#### Return  


ViewConsumerIdentificationInfo describing the consumer identification session



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/postConsumersCompat/#android.content.Context#com.swedbankpay.mobilesdk.Consumer?#kotlin.Any?/PointingToDeclaration/"></a>context| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/postConsumersCompat/#android.content.Context#com.swedbankpay.mobilesdk.Consumer?#kotlin.Any?/PointingToDeclaration/"></a><br><br>an application context<br><br>|
| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/postConsumersCompat/#android.content.Context#com.swedbankpay.mobilesdk.Consumer?#kotlin.Any?/PointingToDeclaration/"></a>consumer| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/postConsumersCompat/#android.content.Context#com.swedbankpay.mobilesdk.Consumer?#kotlin.Any?/PointingToDeclaration/"></a><br><br>the [Consumer](../-consumer/index) object set as the PaymentFragment argument<br><br>|
| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/postConsumersCompat/#android.content.Context#com.swedbankpay.mobilesdk.Consumer?#kotlin.Any?/PointingToDeclaration/"></a>userData| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/postConsumersCompat/#android.content.Context#com.swedbankpay.mobilesdk.Consumer?#kotlin.Any?/PointingToDeclaration/"></a><br><br>the user data object set as the PaymentFragment argument<br><br>|
  
  



