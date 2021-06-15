---
title: paymentUrl
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentOrderUrls](index.html)/[paymentUrl](payment-url.html)



# paymentUrl



[androidJvm]\




@SerializedName(value = "paymentUrl")



val [paymentUrl](payment-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null



A URL that will be navigated to when the payment menu needs to be reloaded.



The paymentUrl is used to get back to the payment menu after some third-party process related to the payment is completed. As long as the process stays within the SDK controlled WebView, we can intercept the navigation, like [completeUrl](complete-url.html), and reload the payment menu. However, because those processes may involve opening other applications, we must also be prepared for paymentUrl being opened in other contexts; in particular, the browser app.



When paymentUrl is opened in the browser app, what we want to happen is for the browser to open app where the SDK is running, and hand the paymentUrl to the SDK. The SDK, of course, provides an interface for the browser to do that, so what remains is that you must set up a web server such that paymentUrl is hosted on that server, and when it is opened, it serves an html page that uses the aforementioned interface to open the app using the SDK.



To have the web page hosted at paymentUrl hand over the url to the SDK, you must use an [intent-scheme URL](https://developer.chrome.com/docs/multidevice/android/intents/) that starts an activity in your application (so make sure to set the package correctly), with the action com.swedbankpay.mobilesdk.VIEW_PAYMENTORDER, with the intent uri being the paymentUrl.



Example: if paymentUrl is https://example.com/payment/1234, and your app's package is com.example.app, then https://example.com/payment/1234 should serve an html page that navigates (you should implement both an immediate redirect and a button the user can press for the navigation) to intent://example.com/payment/1234#Intent;package=com.example.app;action=com.swedbankpay.mobilesdk.VIEW_PAYMENTORDER;scheme=https



Each paymentUrl you create should be unique inside your application.




