---
title: userData
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[ViewPaymentOrderInfo](index.html)/[userData](user-data.html)



# userData



[androidJvm]\
val [userData](user-data.html): [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)? = null



Any value you may need for your [Configuration](../-configuration/index.html).



The value must be one that is valid for [Parcel.writeValue](https://developer.android.com/reference/kotlin/android/os/Parcel.html#writevalue), e.g. [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) or [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html).



See [Configuration.updatePaymentOrder](../-configuration/update-payment-order.html); you will receive this ViewPaymentOrderInfo object there.




