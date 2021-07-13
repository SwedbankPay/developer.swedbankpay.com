---
title: PaymentViewModel -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PaymentViewModel](index)



# PaymentViewModel  
 [androidJvm] class [PaymentViewModel](index) : [AndroidViewModel](https://developer.android.com/reference/kotlin/androidx/lifecycle/AndroidViewModel.html)

<a href="https://developer.android.com/reference/androidx/lifecycle/ViewModel" target="_blank">ViewModel</a> for communicating with a [PaymentFragment](../-payment-fragment/index).



Get a PaymentViewModel from the containing Activity (but see notes at [PaymentFragment](../-payment-fragment/index))

    ViewModelProviders.of(activity).get(PaymentViewModel::class.java)   


## Types  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/PaymentViewModel.OnTermsOfServiceClickListener///PointingToDeclaration/"></a>[OnTermsOfServiceClickListener](-on-terms-of-service-click-listener/index)| <a name="com.swedbankpay.mobilesdk/PaymentViewModel.OnTermsOfServiceClickListener///PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>fun fun interface [OnTermsOfServiceClickListener](-on-terms-of-service-click-listener/index)  <br>More info  <br>Interface you can implement to be notified when the user clicks on the Terms of Service link in the Payment Menu, and optionally override the behaviour.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentViewModel.RichState///PointingToDeclaration/"></a>[RichState](-rich-state/index)| <a name="com.swedbankpay.mobilesdk/PaymentViewModel.RichState///PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>class [RichState](-rich-state/index)  <br>More info  <br>Contains the state of the payment process and possible associated data.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentViewModel.State///PointingToDeclaration/"></a>[State](-state/index)| <a name="com.swedbankpay.mobilesdk/PaymentViewModel.State///PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>enum [State](-state/index) : [Enum](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-enum/index.html)<[PaymentViewModel.State](-state/index)>   <br>More info  <br>State of a payment process  <br><br><br>|


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="androidx.lifecycle/ViewModel/clear/#/PointingToDeclaration/"></a>[clear](index.md#-1936886459%2FFunctions%2F-1404661416)| <a name="androidx.lifecycle/ViewModel/clear/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>@[MainThread](https://developer.android.com/reference/kotlin/androidx/annotation/MainThread.html)()  <br>  <br>fun [clear](index.md#-1936886459%2FFunctions%2F-1404661416)()  <br><br><br>|
| <a name="androidx.lifecycle/AndroidViewModel/getApplication/#/PointingToDeclaration/"></a>[getApplication](index.md#1696759283%2FFunctions%2F-1404661416)| <a name="androidx.lifecycle/AndroidViewModel/getApplication/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>@[NonNull](https://developer.android.com/reference/kotlin/androidx/annotation/NonNull.html)()  <br>  <br>open fun <[T](index.md#1696759283%2FFunctions%2F-1404661416) : [Application](https://developer.android.com/reference/kotlin/android/app/Application.html)> [getApplication](index.md#1696759283%2FFunctions%2F-1404661416)(): [T](index.md#1696759283%2FFunctions%2F-1404661416)  <br><br><br>|
| <a name="androidx.lifecycle/ViewModel/getTag/#kotlin.String/PointingToDeclaration/"></a>[getTag](index.md#-215894976%2FFunctions%2F-1404661416)| <a name="androidx.lifecycle/ViewModel/getTag/#kotlin.String/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun <[T](index.md#-215894976%2FFunctions%2F-1404661416) : [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)> [getTag](index.md#-215894976%2FFunctions%2F-1404661416)(p0: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [T](index.md#-215894976%2FFunctions%2F-1404661416)  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/retryPreviousAction/#/PointingToDeclaration/"></a>[retryPreviousAction](retry-previous-action)| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/retryPreviousAction/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>fun [retryPreviousAction](retry-previous-action)()  <br>More info  <br>If the current state is [RETRYABLE_ERROR](-state/-r-e-t-r-y-a-b-l-e_-e-r-r-o-r/index), attempts the previous action again.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/setOnTermsOfServiceClickListener/#androidx.lifecycle.LifecycleOwner?#com.swedbankpay.mobilesdk.PaymentViewModel.OnTermsOfServiceClickListener?/PointingToDeclaration/"></a>[setOnTermsOfServiceClickListener](set-on-terms-of-service-click-listener)| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/setOnTermsOfServiceClickListener/#androidx.lifecycle.LifecycleOwner?#com.swedbankpay.mobilesdk.PaymentViewModel.OnTermsOfServiceClickListener?/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>fun [setOnTermsOfServiceClickListener](set-on-terms-of-service-click-listener)(lifecycleOwner: [LifecycleOwner](https://developer.android.com/reference/kotlin/androidx/lifecycle/LifecycleOwner.html)?, listener: [PaymentViewModel.OnTermsOfServiceClickListener](-on-terms-of-service-click-listener/index)?)  <br>More info  <br>Set an OnTermsOfServiceClickListener to be notified when the user clicks on the Terms of Service link in the Payment Menu.  <br><br><br>|
| <a name="androidx.lifecycle/ViewModel/setTagIfAbsent/#kotlin.String#TypeParam(bounds=[kotlin.Any])/PointingToDeclaration/"></a>[setTagIfAbsent](index.md#-1567230750%2FFunctions%2F-1404661416)| <a name="androidx.lifecycle/ViewModel/setTagIfAbsent/#kotlin.String#TypeParam(bounds=[kotlin.Any])/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open fun <[T](index.md#-1567230750%2FFunctions%2F-1404661416) : [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)> [setTagIfAbsent](index.md#-1567230750%2FFunctions%2F-1404661416)(p0: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), p1: [T](index.md#-1567230750%2FFunctions%2F-1404661416)): [T](index.md#-1567230750%2FFunctions%2F-1404661416)  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/updatePaymentOrder/#kotlin.Any?/PointingToDeclaration/"></a>[updatePaymentOrder](update-payment-order)| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/updatePaymentOrder/#kotlin.Any?/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>fun [updatePaymentOrder](update-payment-order)(updateInfo: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?)  <br>More info  <br>Attempts to update the ongoing payment order.  <br><br><br>|


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/richState/#/PointingToDeclaration/"></a>[richState](rich-state)| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/richState/#/PointingToDeclaration/"></a> [androidJvm] val [richState](rich-state): [LiveData](https://developer.android.com/reference/kotlin/androidx/lifecycle/LiveData.html)<[PaymentViewModel.RichState](-rich-state/index)>The current state and associated data of the [PaymentFragment](../-payment-fragment/index) corresponding to this [PaymentViewModel](index).   <br>|
| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/showingPaymentMenu/#/PointingToDeclaration/"></a>[showingPaymentMenu](showing-payment-menu)| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/showingPaymentMenu/#/PointingToDeclaration/"></a> [androidJvm] val [showingPaymentMenu](showing-payment-menu): [LiveData](https://developer.android.com/reference/kotlin/androidx/lifecycle/LiveData.html)<[Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)>true if the payment menu is currently shown in the [PaymentFragment](../-payment-fragment/index), false otherwise.   <br>|
| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/state/#/PointingToDeclaration/"></a>[state](state)| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/state/#/PointingToDeclaration/"></a> [androidJvm] val [state](state): [LiveData](https://developer.android.com/reference/kotlin/androidx/lifecycle/LiveData.html)<[PaymentViewModel.State](-state/index)>The current state of the [PaymentFragment](../-payment-fragment/index) corresponding to this [PaymentViewModel](index).   <br>|

