---
title: decorateInitiateConsumerSession -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[RequestDecoratorCompat](index)/[decorateInitiateConsumerSession](decorate-initiate-consumer-session)



# decorateInitiateConsumerSession  
[androidJvm]  
Content  
suspend override fun [decorateInitiateConsumerSession](decorate-initiate-consumer-session)(userHeaders: [UserHeaders](../-user-headers/index), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), consumer: [Consumer](../-consumer/index))  
More info  


Override this method to add custom headers to the POST {consumers} request.



The default implementation does nothing.



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/RequestDecoratorCompat/decorateInitiateConsumerSession/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#com.swedbankpay.mobilesdk.Consumer/PointingToDeclaration/"></a>userHeaders| <a name="com.swedbankpay.mobilesdk/RequestDecoratorCompat/decorateInitiateConsumerSession/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#com.swedbankpay.mobilesdk.Consumer/PointingToDeclaration/"></a><br><br>headers added to this will be sent with the request<br><br>|
| <a name="com.swedbankpay.mobilesdk/RequestDecoratorCompat/decorateInitiateConsumerSession/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#com.swedbankpay.mobilesdk.Consumer/PointingToDeclaration/"></a>body| <a name="com.swedbankpay.mobilesdk/RequestDecoratorCompat/decorateInitiateConsumerSession/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#com.swedbankpay.mobilesdk.Consumer/PointingToDeclaration/"></a><br><br>the body of the request<br><br>|
  
  



