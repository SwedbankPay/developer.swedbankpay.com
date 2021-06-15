---
title: exception
---
//[mobilesdk](../../../../index.html)/[com.swedbankpay.mobilesdk](../../index.html)/[PaymentViewModel](../index.html)/[RichState](index.html)/[exception](exception.html)



# exception



[androidJvm]\
val [exception](exception.html): [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)?



If the current state is [RETRYABLE_ERROR](../-state/-r-e-t-r-y-a-b-l-e_-e-r-r-o-r/index.html), or [FAILURE](../-state/-f-a-i-l-u-r-e/index.html) caused by an [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html), this property contains that exception.



The exception is of any type thrown by your [Configuration](../../-configuration/index.html).



When using com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration, you should be prepared for [java.io.IOException](https://developer.android.com/reference/kotlin/java/io/IOException.html) in general, and com.swedbankpay.mobilesdk.merchantbackend.RequestProblemException in particular. If com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration throws an [IllegalStateException](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-illegal-state-exception/index.html), it means you are not using it correctly; please refer to the exception message for advice.




