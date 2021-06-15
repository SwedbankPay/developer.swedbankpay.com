---
title: decorateAnyRequestCompat
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[RequestDecoratorCompat](index.html)/[decorateAnyRequestCompat](decorate-any-request-compat.html)



# decorateAnyRequestCompat



[androidJvm]\
open fun [decorateAnyRequestCompat](decorate-any-request-compat.html)(userHeaders: [UserHeaders](../-user-headers/index.html), method: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), url: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?)



Override this method to add custom headers to all backend requests.



## Parameters


androidJvm

| | |
|---|---|
| userHeaders | headers added to this will be sent with the request |
| method | the HTTP method of the request |
| url | the URL of the request |
| body | the body of the request, if any |




