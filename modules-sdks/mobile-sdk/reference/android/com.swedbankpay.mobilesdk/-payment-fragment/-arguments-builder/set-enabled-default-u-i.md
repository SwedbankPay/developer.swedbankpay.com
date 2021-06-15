---
title: setEnabledDefaultUI
---
//[mobilesdk](../../../../index.html)/[com.swedbankpay.mobilesdk](../../index.html)/[PaymentFragment](../index.html)/[ArgumentsBuilder](index.html)/[setEnabledDefaultUI](set-enabled-default-u-i.html)



# setEnabledDefaultUI



[androidJvm]\
fun [setEnabledDefaultUI](set-enabled-default-u-i.html)(vararg defaultUI: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)): [PaymentFragment.ArgumentsBuilder](index.html)



Set the enabled default user interfaces.



There are four:



- 
   [RETRY_PROMPT](../-companion/-r-e-t-r-y_-p-r-o-m-p-t.html), a prompt to retry a failed request that can reasonably be retried
- 
   [COMPLETE_MESSAGE](../-companion/-c-o-m-p-l-e-t-e_-m-e-s-s-a-g-e.html), a laconic completion message
- 
   [ERROR_MESSAGE](../-companion/-e-r-r-o-r_-m-e-s-s-a-g-e.html) a less laconic, though a bit technical, error message
- 
   [RETRY_PROMPT_DETAIL](../-companion/-r-e-t-r-y_-p-r-o-m-p-t_-d-e-t-a-i-l.html), additional detail message for RETRY_PROMPT




If a default UI is not enabled, the fragment will be blank instead.



The default is to only enable RETRY_PROMPT. This is often useful, as a custom retry prompt is likely unnecessary, but the success and error states should cause the fragment to be dismissed. Also, the extra message from RETRY_PROMPT_DETAIL is unlikely to be useful to the user.



To disable everything, pass an empty argument list here (a value of 0 also works). If it is more convenient for you, you may also OR the flags manually and call this method with the result value.



## Parameters


androidJvm

| | |
|---|---|
| defaultUI | the default UI to enable |




