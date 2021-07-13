---
title: userData -
---
//[sdk](../../../../index)/[com.swedbankpay.mobilesdk](../../index)/[PaymentFragment](../index)/[ArgumentsBuilder](index)/[userData](user-data)



# userData  
[androidJvm]  
Content  
fun [userData](user-data)(userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [PaymentFragment.ArgumentsBuilder](index)  
More info  


Sets custom data for the payment.



[com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration](../../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-configuration/index) does not use this parameter. If you create a custom [Configuration](../../-configuration/index), you may set any [android.os.Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html) or [Serializable](https://developer.android.com/reference/kotlin/java/io/Serializable.html) object here, and receive it in your [Configuration](../../-configuration/index) callbacks. Note that due to possible saving and restoring of the argument bundle, you should not rely on receiving the same object as you set here, but an equal one.



Note that passing general Serializable objects is not recommended. [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) has special treatment and is okay to pass here.



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/PaymentFragment.ArgumentsBuilder/userData/#kotlin.Any?/PointingToDeclaration/"></a>userData| <a name="com.swedbankpay.mobilesdk/PaymentFragment.ArgumentsBuilder/userData/#kotlin.Any?/PointingToDeclaration/"></a><br><br>data for your [Configuration](../../-configuration/index)<br><br>|
  
  



