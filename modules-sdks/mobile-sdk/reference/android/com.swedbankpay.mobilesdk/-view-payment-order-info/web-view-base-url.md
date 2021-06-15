---
title: webViewBaseUrl
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[ViewPaymentOrderInfo](index.html)/[webViewBaseUrl](web-view-base-url.html)



# webViewBaseUrl



[androidJvm]\
val [webViewBaseUrl](web-view-base-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null



The url to use as the [android.webkit.WebView](https://developer.android.com/reference/kotlin/android/webkit/WebView.html) page url when showing the checkin UI. If null, defaults to about:blank, as [documented](https://developer.android.com/reference/kotlin/android/webkit/WebView.html#loaddatawithbaseurl).



This should match your payment order's hostUrls.




