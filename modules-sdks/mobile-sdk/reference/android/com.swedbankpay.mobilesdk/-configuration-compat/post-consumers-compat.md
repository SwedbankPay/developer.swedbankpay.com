---
title: postConsumersCompat
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[ConfigurationCompat](index.html)/[postConsumersCompat](post-consumers-compat.html)



# postConsumersCompat



[androidJvm]\




@[WorkerThread](https://developer.android.com/reference/kotlin/androidx/annotation/WorkerThread.html)



abstract fun [postConsumersCompat](post-consumers-compat.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), consumer: [Consumer](../-consumer/index.html)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [ViewConsumerIdentificationInfo](../-view-consumer-identification-info/index.html)



Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to start a consumer identification session. Your implementation must ultimately make the call to Swedbank Pay API and return a [ViewConsumerIdentificationInfo](../-view-consumer-identification-info/index.html) describing the result.



#### Return



ViewConsumerIdentificationInfo describing the consumer identification session



## Parameters


androidJvm

| | |
|---|---|
| context | an application context |
| consumer | the [Consumer](../-consumer/index.html) object set as the PaymentFragment argument |
| userData | the user data object set as the PaymentFragment argument |




