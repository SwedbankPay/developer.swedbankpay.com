---
title: setEnabledDefaultUI -
---
//[sdk](../../../../index)/[com.swedbankpay.mobilesdk](../../index)/[PaymentFragment](../index)/[ArgumentsBuilder](index)/[setEnabledDefaultUI](set-enabled-default-u-i)



# setEnabledDefaultUI  
[androidJvm]  
Content  
fun [setEnabledDefaultUI](set-enabled-default-u-i)(vararg defaultUI: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)): [PaymentFragment.ArgumentsBuilder](index)  
More info  


Set the enabled default user interfaces.



There are four:

<ul><li>[RETRY_PROMPT](../-companion/-r-e-t-r-y_-p-r-o-m-p-t), a prompt to retry a failed request that can reasonably be retried</li><li>[COMPLETE_MESSAGE](../-companion/-c-o-m-p-l-e-t-e_-m-e-s-s-a-g-e), a laconic completion message</li><li>[ERROR_MESSAGE](../-companion/-e-r-r-o-r_-m-e-s-s-a-g-e) a less laconic, though a bit technical, error message</li></ul>

If a default UI is not enabled, the fragment will be blank instead.



The default is to only enable RETRY_PROMPT. This is often useful, as a custom retry prompt is likely unnecessary, but the success and error states should cause the fragment to be dismissed.



To disable everything, pass an empty argument list here (a value of 0 also works). If it is more convenient for you, you may also OR the flags manually and call this method with the result value.



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/PaymentFragment.ArgumentsBuilder/setEnabledDefaultUI/#kotlin.IntArray/PointingToDeclaration/"></a>defaultUI| <a name="com.swedbankpay.mobilesdk/PaymentFragment.ArgumentsBuilder/setEnabledDefaultUI/#kotlin.IntArray/PointingToDeclaration/"></a><br><br>the default UI to enable<br><br>|
  
  



