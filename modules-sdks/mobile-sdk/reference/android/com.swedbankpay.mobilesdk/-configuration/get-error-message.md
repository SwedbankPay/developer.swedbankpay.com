---
title: getErrorMessage
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[Configuration](index.html)/[getErrorMessage](get-error-message.html)



# getErrorMessage



[androidJvm]\
open fun [getErrorMessage](get-error-message.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?



Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to show an error message because an operation failed.



You can return null if you have no further details to provide.



#### Return



an error message



## Parameters


androidJvm

| | |
|---|---|
| context | an application context |
| exception | the exception that caused the failure |




