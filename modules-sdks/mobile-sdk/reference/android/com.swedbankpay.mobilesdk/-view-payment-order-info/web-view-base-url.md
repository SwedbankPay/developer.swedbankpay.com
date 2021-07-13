---
title: webViewBaseUrl -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[ViewPaymentOrderInfo](index)/[webViewBaseUrl](web-view-base-url)



# webViewBaseUrl  
[androidJvm]  
Content  
val [webViewBaseUrl](web-view-base-url): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null  
More info  


The url to use as the [android.webkit.WebView](https://developer.android.com/reference/kotlin/android/webkit/WebView.html) page url when showing the checkin UI. If null, defaults to about:blank, as [documented](https://developer.android.com/reference/kotlin/android/webkit/WebView.html#loaddatawithbaseurl).



This should match your payment order's hostUrls.

  



