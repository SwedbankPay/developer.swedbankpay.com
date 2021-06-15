---
title: userData
---
//[mobilesdk](../../../../index.html)/[com.swedbankpay.mobilesdk](../../index.html)/[PaymentFragment](../index.html)/[ArgumentsBuilder](index.html)/[userData](user-data.html)



# userData



[androidJvm]\
fun [userData](user-data.html)(userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [PaymentFragment.ArgumentsBuilder](index.html)



Sets custom data for the payment.



com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration does not use this parameter. If you create a custom [Configuration](../../-configuration/index.html), you may set any [android.os.Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html) or [Serializable](https://developer.android.com/reference/kotlin/java/io/Serializable.html) object here, and receive it in your [Configuration](../../-configuration/index.html) callbacks. Note that due to possible saving and restoring of the argument bundle, you should not rely on receiving the same object as you set here, but an equal one.



Note that passing general Serializable objects is not recommended. [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) has special treatment and is okay to pass here.



## Parameters


androidJvm

| | |
|---|---|
| userData | data for your [Configuration](../../-configuration/index.html) |




