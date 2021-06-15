---
title: onTermsOfServiceClick
---
//[mobilesdk](../../../../index.html)/[com.swedbankpay.mobilesdk](../../index.html)/[PaymentViewModel](../index.html)/[OnTermsOfServiceClickListener](index.html)/[onTermsOfServiceClick](on-terms-of-service-click.html)



# onTermsOfServiceClick



[androidJvm]\
abstract fun [onTermsOfServiceClick](on-terms-of-service-click.html)(paymentViewModel: [PaymentViewModel](../index.html), url: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)



Called when the user clicks on the Terms of Service link in the Payment Menu.



#### Return



true if you handled the event yourself and wish to disable the default behaviour, false if you want to let the SDK show the ToS web page.



## Parameters


androidJvm

| | |
|---|---|
| paymentViewModel | the [PaymentViewModel](../index.html) of the [PaymentFragment](../../-payment-fragment/index.html) the user is interacting with |
| url | the Terms of Service url |




