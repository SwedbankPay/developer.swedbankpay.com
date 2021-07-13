---
title: ARG_USER_DATA -
---
//[sdk](../../../../index)/[com.swedbankpay.mobilesdk](../../index)/[PaymentFragment](../index)/[Companion](index)/[ARG_USER_DATA](-a-r-g_-u-s-e-r_-d-a-t-a)



# ARG_USER_DATA  
[androidJvm]  
Content  
const val [ARG_USER_DATA](-a-r-g_-u-s-e-r_-d-a-t-a): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)  
More info  


Argument key: Any data that you may need in your [Configuration](../../-configuration/index) to prepare the checkin and payment menu for this payment. You will receive this value as the userData argument in your [Configuration.postConsumers](../../-configuration/post-consumers) and [Configuration.postPaymentorders](../../-configuration/post-paymentorders) methods.



Value must be [android.os.Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html) or [Serializable](https://developer.android.com/reference/kotlin/java/io/Serializable.html).

  



