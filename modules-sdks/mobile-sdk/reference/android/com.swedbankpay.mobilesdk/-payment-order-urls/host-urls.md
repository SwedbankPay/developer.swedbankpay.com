---
title: hostUrls
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentOrderUrls](index.html)/[hostUrls](host-urls.html)



# hostUrls



[androidJvm]\




@SerializedName(value = "hostUrls")



val [hostUrls](host-urls.html): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;



Array of URLs that are valid for embedding this payment order.



The SDK generates the web page that embeds the payment order internally, so it is not really hosted anywhere. However, the WebView will use the value returned in [ViewPaymentOrderInfo.webViewBaseUrl](../-view-payment-order-info/web-view-base-url.html) as the url of that generated page. Therefore, the webViewBaseUrl you use should match hostUrls here.




