---
title: shouldRetryAfterPostConsumersExceptionCompat
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[ConfigurationCompat](index.html)/[shouldRetryAfterPostConsumersExceptionCompat](should-retry-after-post-consumers-exception-compat.html)



# shouldRetryAfterPostConsumersExceptionCompat



[androidJvm]\




@[WorkerThread](https://developer.android.com/reference/kotlin/androidx/annotation/WorkerThread.html)



open fun [shouldRetryAfterPostConsumersExceptionCompat](should-retry-after-post-consumers-exception-compat.html)(exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)



Called by [PaymentFragment](../-payment-fragment/index.html) to determine whether it should fail or allow retry after it failed to start a consumer identification session.



#### Return



true if retry should be allowed, false otherwise



## Parameters


androidJvm

| | |
|---|---|
| exception | the exception that caused the failure |




