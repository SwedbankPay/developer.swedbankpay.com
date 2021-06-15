---
title: richState
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentViewModel](index.html)/[richState](rich-state.html)



# richState



[androidJvm]\
val [richState](rich-state.html): [LiveData](https://developer.android.com/reference/kotlin/androidx/lifecycle/LiveData.html)&lt;[PaymentViewModel.RichState](-rich-state/index.html)&gt;



The current state and associated data of the [PaymentFragment](../-payment-fragment/index.html) corresponding to this [PaymentViewModel](index.html).



For convenience, this property will retain the last-known state of a PaymentFragment after it has been removed. When a new PaymentFragment is added to the same Activity, this property will reflect that PaymentFragment from there on. To support multiple PaymentFragments in an Activity, see [PaymentFragment.ArgumentsBuilder.viewModelProviderKey](../-payment-fragment/-arguments-builder/view-model-provider-key.html).



Due to the semantics of [Transformations](https://developer.android.com/reference/kotlin/androidx/lifecycle/Transformations.html), you should be careful if accessing this value using [LiveData.getValue](https://developer.android.com/reference/kotlin/androidx/lifecycle/LiveData.html#getvalue) directly rather than by an [Observer](https://developer.android.com/reference/kotlin/androidx/lifecycle/Observer.html). Specifically, if nothing is observing this property (possibly indirectly, such as through the [state](state.html) property), then the value will not be updated, and the state may be permanently lost if the PaymentFragment is removed before adding an observer to this property.




