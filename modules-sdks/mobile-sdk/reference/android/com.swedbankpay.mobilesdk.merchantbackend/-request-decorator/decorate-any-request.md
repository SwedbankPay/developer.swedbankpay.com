---
title: decorateAnyRequest
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[RequestDecorator](index.html)/[decorateAnyRequest](decorate-any-request.html)



# decorateAnyRequest



[androidJvm]\
open suspend fun [decorateAnyRequest](decorate-any-request.html)(userHeaders: [UserHeaders](../-user-headers/index.html), method: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), url: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?)



Override this method to add custom headers to all backend requests.



## Parameters


androidJvm

| | |
|---|---|
| userHeaders | headers added to this will be sent with the request |
| method | the HTTP method of the request |
| url | the URL of the request |
| body | the body of the request, if any |




