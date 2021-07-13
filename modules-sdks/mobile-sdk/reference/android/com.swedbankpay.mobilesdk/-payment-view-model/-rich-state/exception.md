---
title: exception -
---
//[sdk](../../../../index)/[com.swedbankpay.mobilesdk](../../index)/[PaymentViewModel](../index)/[RichState](index)/[exception](exception)



# exception  
[androidJvm]  
Content  
val [exception](exception): [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)?  
More info  


If the current state is [RETRYABLE_ERROR](../-state/-r-e-t-r-y-a-b-l-e_-e-r-r-o-r/index), or [FAILURE](../-state/-f-a-i-l-u-r-e/index) caused by an [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html), this property contains that exception.



The exception is of any type thrown by your [Configuration](../../-configuration/index).



When using [com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration](../../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-configuration/index), you should be prepared for [java.io.IOException](https://developer.android.com/reference/kotlin/java/io/IOException.html) in general, and [com.swedbankpay.mobilesdk.merchantbackend.RequestProblemException](../../../com.swedbankpay.mobilesdk.merchantbackend/-request-problem-exception/index) in particular. If [com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration](../../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-configuration/index) throws an [IllegalStateException](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-illegal-state-exception/index.html), it means you are not using it correctly; please refer to the exception message for advice.

  



