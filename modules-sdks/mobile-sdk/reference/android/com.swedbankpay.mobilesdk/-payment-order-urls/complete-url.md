---
title: completeUrl -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PaymentOrderUrls](index)/[completeUrl](complete-url)



# completeUrl  
[androidJvm]  
Content  
@SerializedName(value = completeUrl)  
  
val [completeUrl](complete-url): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)  
More info  


The URL that the payment menu will redirect to when the payment is complete.



The SDK will capture the navigation before it happens; the completeUrl will never be actually loaded in the WebView. Thus, the only requirement for this URL is that is is formally valid.

  



