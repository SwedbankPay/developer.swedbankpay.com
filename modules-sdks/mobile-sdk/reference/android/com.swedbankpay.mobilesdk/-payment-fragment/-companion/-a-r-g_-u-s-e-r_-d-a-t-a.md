---
title: ARG_USER_DATA
---
//[mobilesdk](../../../../index.html)/[com.swedbankpay.mobilesdk](../../index.html)/[PaymentFragment](../index.html)/[Companion](index.html)/[ARG_USER_DATA](-a-r-g_-u-s-e-r_-d-a-t-a.html)



# ARG_USER_DATA



[androidJvm]\
const val [ARG_USER_DATA](-a-r-g_-u-s-e-r_-d-a-t-a.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)



Argument key: Any data that you may need in your [Configuration](../../-configuration/index.html) to prepare the checkin and payment menu for this payment. You will receive this value as the userData argument in your [Configuration.postConsumers](../../-configuration/post-consumers.html) and [Configuration.postPaymentorders](../../-configuration/post-paymentorders.html) methods.



Value must be [android.os.Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html) or [Serializable](https://developer.android.com/reference/kotlin/java/io/Serializable.html).




