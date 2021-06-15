---
title: shouldRetryAfterPostPaymentordersException
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[Configuration](index.html)/[shouldRetryAfterPostPaymentordersException](should-retry-after-post-paymentorders-exception.html)



# shouldRetryAfterPostPaymentordersException



[androidJvm]\
open suspend fun [shouldRetryAfterPostPaymentordersException](should-retry-after-post-paymentorders-exception.html)(exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)



Called by [PaymentFragment](../-payment-fragment/index.html) to determine whether it should fail or allow retry after it failed to create the payment order.



#### Return



true if retry should be allowed, false otherwise



## Parameters


androidJvm

| | |
|---|---|
| exception | the exception that caused the failure |




