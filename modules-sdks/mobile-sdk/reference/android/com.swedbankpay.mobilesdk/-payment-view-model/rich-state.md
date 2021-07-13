---
title: richState -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PaymentViewModel](index)/[richState](rich-state)



# richState  
[androidJvm]  
Content  
val [richState](rich-state): [LiveData](https://developer.android.com/reference/kotlin/androidx/lifecycle/LiveData.html)<[PaymentViewModel.RichState](-rich-state/index)>  
More info  


The current state and associated data of the [PaymentFragment](../-payment-fragment/index) corresponding to this [PaymentViewModel](index).



For convenience, this property will retain the last-known state of a PaymentFragment after it has been removed. When a new PaymentFragment is added to the same Activity, this property will reflect that PaymentFragment from there on. To support multiple PaymentFragments in an Activity, see [PaymentFragment.ArgumentsBuilder.viewModelProviderKey](../-payment-fragment/-arguments-builder/view-model-provider-key).



Due to the semantics of [Transformations](https://developer.android.com/reference/kotlin/androidx/lifecycle/Transformations.html), you should be careful if accessing this value using [LiveData.getValue](https://developer.android.com/reference/kotlin/androidx/lifecycle/LiveData.html#getvalue) directly rather than by an [Observer](https://developer.android.com/reference/kotlin/androidx/lifecycle/Observer.html). Specifically, if nothing is observing this property (possibly indirectly, such as through the [state](state) property), then the value will not be updated, and the state may be permanently lost if the PaymentFragment is removed before adding an observer to this property.

  



