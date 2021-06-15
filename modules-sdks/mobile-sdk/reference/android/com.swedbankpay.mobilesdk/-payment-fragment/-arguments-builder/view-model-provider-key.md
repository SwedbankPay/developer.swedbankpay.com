---
title: viewModelProviderKey
---
//[mobilesdk](../../../../index.html)/[com.swedbankpay.mobilesdk](../../index.html)/[PaymentFragment](../index.html)/[ArgumentsBuilder](index.html)/[viewModelProviderKey](view-model-provider-key.html)



# viewModelProviderKey



[androidJvm]\
fun [viewModelProviderKey](view-model-provider-key.html)(viewModelKey: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?): [PaymentFragment.ArgumentsBuilder](index.html)



Sets the key used on the containing [activity's](https://developer.android.com/reference/kotlin/androidx/fragment/app/FragmentActivity.html)[ViewModelProvider](https://developer.android.com/reference/kotlin/androidx/lifecycle/ViewModelProvider.html) for the [PaymentViewModel](../../-payment-view-model/index.html). This is only useful for special scenarios.



## Parameters


androidJvm

| | |
|---|---|
| viewModelKey | the [androidx.lifecycle.ViewModelProvider](https://developer.android.com/reference/kotlin/androidx/lifecycle/ViewModelProvider.html) key the PaymentFragment uses to find its [PaymentViewModel](../../-payment-view-model/index.html) in the containing [activity](https://developer.android.com/reference/kotlin/androidx/fragment/app/FragmentActivity.html) |




