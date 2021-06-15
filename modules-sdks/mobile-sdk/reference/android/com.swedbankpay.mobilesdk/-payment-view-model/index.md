---
title: PaymentViewModel
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentViewModel](index.html)



# PaymentViewModel



[androidJvm]\
class [PaymentViewModel](index.html) : [AndroidViewModel](https://developer.android.com/reference/kotlin/androidx/lifecycle/AndroidViewModel.html)

<a href="https://developer.android.com/reference/androidx/lifecycle/ViewModel" target="_blank">ViewModel</a> for communicating with a [PaymentFragment](../-payment-fragment/index.html).



Get a PaymentViewModel from the containing Activity (but see notes at [PaymentFragment](../-payment-fragment/index.html))

    ViewModelProviders.of(activity).get(PaymentViewModel::class.java)



## Types


| Name | Summary |
|---|---|
| [OnTermsOfServiceClickListener](-on-terms-of-service-click-listener/index.html) | [androidJvm]<br>fun interface [OnTermsOfServiceClickListener](-on-terms-of-service-click-listener/index.html)<br>Interface you can implement to be notified when the user clicks on the Terms of Service link in the Payment Menu, and optionally override the behaviour. |
| [RichState](-rich-state/index.html) | [androidJvm]<br>class [RichState](-rich-state/index.html)<br>Contains the state of the payment process and possible associated data. |
| [State](-state/index.html) | [androidJvm]<br>enum [State](-state/index.html) : [Enum](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-enum/index.html)&lt;[PaymentViewModel.State](-state/index.html)&gt; <br>State of a payment process |


## Functions


| Name | Summary |
|---|---|
| [clear](index.html#-1936886459%2FFunctions%2F-1074806346) | [androidJvm]<br>@[MainThread](https://developer.android.com/reference/kotlin/androidx/annotation/MainThread.html)<br>fun [clear](index.html#-1936886459%2FFunctions%2F-1074806346)() |
| [getApplication](index.html#1696759283%2FFunctions%2F-1074806346) | [androidJvm]<br>@[NonNull](https://developer.android.com/reference/kotlin/androidx/annotation/NonNull.html)<br>open fun &lt;[T](index.html#1696759283%2FFunctions%2F-1074806346) : [Application](https://developer.android.com/reference/kotlin/android/app/Application.html)&gt; [getApplication](index.html#1696759283%2FFunctions%2F-1074806346)(): [T](index.html#1696759283%2FFunctions%2F-1074806346) |
| [getTag](index.html#-215894976%2FFunctions%2F-1074806346) | [androidJvm]<br>open fun &lt;[T](index.html#-215894976%2FFunctions%2F-1074806346) : [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)&gt; [getTag](index.html#-215894976%2FFunctions%2F-1074806346)(p0: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [T](index.html#-215894976%2FFunctions%2F-1074806346) |
| [retryPreviousAction](retry-previous-action.html) | [androidJvm]<br>fun [retryPreviousAction](retry-previous-action.html)()<br>If the current state is [RETRYABLE_ERROR](-state/-r-e-t-r-y-a-b-l-e_-e-r-r-o-r/index.html), attempts the previous action again. This call transitions the state to [IN_PROGRESS](-state/-i-n_-p-r-o-g-r-e-s-s/index.html). |
| [setOnTermsOfServiceClickListener](set-on-terms-of-service-click-listener.html) | [androidJvm]<br>fun [setOnTermsOfServiceClickListener](set-on-terms-of-service-click-listener.html)(lifecycleOwner: [LifecycleOwner](https://developer.android.com/reference/kotlin/androidx/lifecycle/LifecycleOwner.html)?, listener: [PaymentViewModel.OnTermsOfServiceClickListener](-on-terms-of-service-click-listener/index.html)?)<br>Set an OnTermsOfServiceClickListener to be notified when the user clicks on the Terms of Service link in the Payment Menu. |
| [setTagIfAbsent](index.html#-1567230750%2FFunctions%2F-1074806346) | [androidJvm]<br>open fun &lt;[T](index.html#-1567230750%2FFunctions%2F-1074806346) : [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)&gt; [setTagIfAbsent](index.html#-1567230750%2FFunctions%2F-1074806346)(p0: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), p1: [T](index.html#-1567230750%2FFunctions%2F-1074806346)): [T](index.html#-1567230750%2FFunctions%2F-1074806346) |
| [updatePaymentOrder](update-payment-order.html) | [androidJvm]<br>fun [updatePaymentOrder](update-payment-order.html)(updateInfo: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?)<br>Attempts to update the ongoing payment order. The meaning of updateInfo is up to your  [Configuration.updatePaymentOrder](../-configuration/update-payment-order.html) implementation. |


## Properties


| Name | Summary |
|---|---|
| [richState](rich-state.html) | [androidJvm]<br>val [richState](rich-state.html): [LiveData](https://developer.android.com/reference/kotlin/androidx/lifecycle/LiveData.html)&lt;[PaymentViewModel.RichState](-rich-state/index.html)&gt;<br>The current state and associated data of the [PaymentFragment](../-payment-fragment/index.html) corresponding to this [PaymentViewModel](index.html). |
| [showingPaymentMenu](showing-payment-menu.html) | [androidJvm]<br>val [showingPaymentMenu](showing-payment-menu.html): [LiveData](https://developer.android.com/reference/kotlin/androidx/lifecycle/LiveData.html)&lt;[Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)&gt;<br>true if the payment menu is currently shown in the [PaymentFragment](../-payment-fragment/index.html), false otherwise. |
| [state](state.html) | [androidJvm]<br>val [state](state.html): [LiveData](https://developer.android.com/reference/kotlin/androidx/lifecycle/LiveData.html)&lt;[PaymentViewModel.State](-state/index.html)&gt;<br>The current state of the [PaymentFragment](../-payment-fragment/index.html) corresponding to this [PaymentViewModel](index.html). |

