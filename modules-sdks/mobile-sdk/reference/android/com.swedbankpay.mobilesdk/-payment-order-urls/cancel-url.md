---
title: cancelUrl -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PaymentOrderUrls](index)/[cancelUrl](cancel-url)



# cancelUrl  
[androidJvm]  
Content  
@SerializedName(value = cancelUrl)  
  
val [cancelUrl](cancel-url): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null  
More info  


The URL that the payment menu will redirect to when the payment is canceled.



The SDK will capture the navigation before it happens; i.e. this works similarly to how [completeUrl](complete-url) does.

  



