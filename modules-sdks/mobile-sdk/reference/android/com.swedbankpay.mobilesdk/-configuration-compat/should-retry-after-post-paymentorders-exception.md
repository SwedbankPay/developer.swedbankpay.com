---
title: shouldRetryAfterPostPaymentordersException -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[ConfigurationCompat](index)/[shouldRetryAfterPostPaymentordersException](should-retry-after-post-paymentorders-exception)



# shouldRetryAfterPostPaymentordersException  
[androidJvm]  
Content  
suspend override fun [shouldRetryAfterPostPaymentordersException](should-retry-after-post-paymentorders-exception)(exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)  
More info  


Called by [PaymentFragment](../-payment-fragment/index) to determine whether it should fail or allow retry after it failed to create the payment order.



#### Return  


true if retry should be allowed, false otherwise



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/shouldRetryAfterPostPaymentordersException/#java.lang.Exception/PointingToDeclaration/"></a>exception| <a name="com.swedbankpay.mobilesdk/ConfigurationCompat/shouldRetryAfterPostPaymentordersException/#java.lang.Exception/PointingToDeclaration/"></a><br><br>the exception that caused the failure<br><br>|
  
  



