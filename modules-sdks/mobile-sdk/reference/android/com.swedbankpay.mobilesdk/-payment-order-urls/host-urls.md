---
title: hostUrls -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PaymentOrderUrls](index)/[hostUrls](host-urls)



# hostUrls  
[androidJvm]  
Content  
@SerializedName(value = hostUrls)  
  
val [hostUrls](host-urls): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)<[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)>  
More info  


Array of URLs that are valid for embedding this payment order.



The SDK generates the web page that embeds the payment order internally, so it is not really hosted anywhere. However, the WebView will use the value returned in [ViewPaymentOrderInfo.webViewBaseUrl](../-view-payment-order-info/web-view-base-url) as the url of that generated page. Therefore, the webViewBaseUrl you use should match hostUrls here.

  



