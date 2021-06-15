---
title: updatePaymentOrder
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentViewModel](index.html)/[updatePaymentOrder](update-payment-order.html)



# updatePaymentOrder



[androidJvm]\
fun [updatePaymentOrder](update-payment-order.html)(updateInfo: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?)



Attempts to update the ongoing payment order. The meaning of updateInfo is up to your  [Configuration.updatePaymentOrder](../-configuration/update-payment-order.html) implementation.



If you are using com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration, and the payment order is in instrument mode, you can set the instrument by calling this with a String argument specifying the new instrument; see [PaymentInstruments](../-payment-instruments/index.html).



## Parameters


androidJvm

| | |
|---|---|
| updateInfo | any data you need to perform the update. The value must be one that is valid for [Parcel.writeValue](https://developer.android.com/reference/kotlin/android/os/Parcel.html#writevalue), e.g. [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) or [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html). |




