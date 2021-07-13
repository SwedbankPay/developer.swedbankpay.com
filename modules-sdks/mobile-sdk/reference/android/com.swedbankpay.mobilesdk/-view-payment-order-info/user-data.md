---
title: userData -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[ViewPaymentOrderInfo](index)/[userData](user-data)



# userData  
[androidJvm]  
Content  
val [userData](user-data): [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)? = null  
More info  


Any value you may need for your [Configuration](../-configuration/index).



The value must be one that is valid for [Parcel.writeValue](https://developer.android.com/reference/kotlin/android/os/Parcel.html#writevalue), e.g. [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) or [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html).



See [Configuration.updatePaymentOrder](../-configuration/update-payment-order); you will receive this ViewPaymentOrderInfo object there.

  



