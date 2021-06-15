---
title: completeUrl
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentOrderUrls](index.html)/[completeUrl](complete-url.html)



# completeUrl



[androidJvm]\




@SerializedName(value = "completeUrl")



val [completeUrl](complete-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)



The URL that the payment menu will redirect to when the payment is complete.



The SDK will capture the navigation before it happens; the completeUrl will never be actually loaded in the WebView. Thus, the only requirement for this URL is that is is formally valid.




