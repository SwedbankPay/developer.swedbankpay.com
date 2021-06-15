---
title: setOnTermsOfServiceClickListener
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentViewModel](index.html)/[setOnTermsOfServiceClickListener](set-on-terms-of-service-click-listener.html)



# setOnTermsOfServiceClickListener



[androidJvm]\
fun [setOnTermsOfServiceClickListener](set-on-terms-of-service-click-listener.html)(lifecycleOwner: [LifecycleOwner](https://developer.android.com/reference/kotlin/androidx/lifecycle/LifecycleOwner.html)?, listener: [PaymentViewModel.OnTermsOfServiceClickListener](-on-terms-of-service-click-listener/index.html)?)



Set an OnTermsOfServiceClickListener to be notified when the user clicks on the Terms of Service link in the Payment Menu.



Optionally, you may provide a [LifecycleOwner](https://developer.android.com/reference/kotlin/androidx/lifecycle/LifecycleOwner.html) that this listener is bound to. It will then be automatically removed when the LifecycleOwner is destroyed. If you do not provide a LifecycleOwner, be careful not to leak expensive objects here.



## Parameters


androidJvm

| | |
|---|---|
| lifecycleOwner | : the LifecycleOwner to bind the listener to, or null to keep the listener until the next call to this method |
| listener | the OnTermsOfServiceClickListener to set, or null to remove the listener |




