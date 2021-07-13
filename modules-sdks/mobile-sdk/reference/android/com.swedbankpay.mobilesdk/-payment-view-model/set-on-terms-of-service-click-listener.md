---
title: setOnTermsOfServiceClickListener -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PaymentViewModel](index)/[setOnTermsOfServiceClickListener](set-on-terms-of-service-click-listener)



# setOnTermsOfServiceClickListener  
[androidJvm]  
Content  
fun [setOnTermsOfServiceClickListener](set-on-terms-of-service-click-listener)(lifecycleOwner: [LifecycleOwner](https://developer.android.com/reference/kotlin/androidx/lifecycle/LifecycleOwner.html)?, listener: [PaymentViewModel.OnTermsOfServiceClickListener](-on-terms-of-service-click-listener/index)?)  
More info  


Set an OnTermsOfServiceClickListener to be notified when the user clicks on the Terms of Service link in the Payment Menu.



Optionally, you may provide a [LifecycleOwner](https://developer.android.com/reference/kotlin/androidx/lifecycle/LifecycleOwner.html) that this listener is bound to. It will then be automatically removed when the LifecycleOwner is destroyed. If you do not provide a LifecycleOwner, be careful not to leak expensive objects here.



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/setOnTermsOfServiceClickListener/#androidx.lifecycle.LifecycleOwner?#com.swedbankpay.mobilesdk.PaymentViewModel.OnTermsOfServiceClickListener?/PointingToDeclaration/"></a>lifecycleOwner| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/setOnTermsOfServiceClickListener/#androidx.lifecycle.LifecycleOwner?#com.swedbankpay.mobilesdk.PaymentViewModel.OnTermsOfServiceClickListener?/PointingToDeclaration/"></a><br><br>: the LifecycleOwner to bind the listener to, or null to keep the listener until the next call to this method<br><br>|
| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/setOnTermsOfServiceClickListener/#androidx.lifecycle.LifecycleOwner?#com.swedbankpay.mobilesdk.PaymentViewModel.OnTermsOfServiceClickListener?/PointingToDeclaration/"></a>listener| <a name="com.swedbankpay.mobilesdk/PaymentViewModel/setOnTermsOfServiceClickListener/#androidx.lifecycle.LifecycleOwner?#com.swedbankpay.mobilesdk.PaymentViewModel.OnTermsOfServiceClickListener?/PointingToDeclaration/"></a><br><br>the OnTermsOfServiceClickListener to set, or null to remove the listener<br><br>|
  
  



