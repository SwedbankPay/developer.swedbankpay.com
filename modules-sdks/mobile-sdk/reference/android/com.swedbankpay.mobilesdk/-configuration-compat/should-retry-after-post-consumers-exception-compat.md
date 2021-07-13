---
title: shouldRetryAfterPostConsumersExceptionCompat -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[ConfigurationCompat](index)/[shouldRetryAfterPostConsumersExceptionCompat](should-retry-after-post-consumers-exception-compat)



# shouldRetryAfterPostConsumersExceptionCompat  
[androidJvm]  
Content  
@[WorkerThread](https://developer.android.com/reference/kotlin/androidx/annotation/WorkerThread.html)()  
  
open fun [shouldRetryAfterPostConsumersExceptionCompat](should-retry-after-post-consumers-exception-compat)(exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)  
More info  


Called by [PaymentFragment](../-payment-fragment/index) to determine whether it should fail or allow retry after it failed to start a consumer identification session.



#### Return  


true if retry should be allowed, false otherwise



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/shouldRetryAfterPostConsumersExceptionCompat/#java.lang.Exception/PointingToDeclaration/"></a>exception| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/shouldRetryAfterPostConsumersExceptionCompat/#java.lang.Exception/PointingToDeclaration/"></a><br><br>the exception that caused the failure<br><br>|
  
  



