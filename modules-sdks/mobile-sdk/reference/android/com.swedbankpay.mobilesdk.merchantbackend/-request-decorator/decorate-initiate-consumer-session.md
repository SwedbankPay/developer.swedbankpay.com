---
title: decorateInitiateConsumerSession
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[RequestDecorator](index.html)/[decorateInitiateConsumerSession](decorate-initiate-consumer-session.html)



# decorateInitiateConsumerSession



[androidJvm]\
open suspend fun [decorateInitiateConsumerSession](decorate-initiate-consumer-session.html)(userHeaders: [UserHeaders](../-user-headers/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), consumer: Consumer)



Override this method to add custom headers to the POST {consumers} request.



The default implementation does nothing.



## Parameters


androidJvm

| | |
|---|---|
| userHeaders | headers added to this will be sent with the request |
| body | the body of the request |




