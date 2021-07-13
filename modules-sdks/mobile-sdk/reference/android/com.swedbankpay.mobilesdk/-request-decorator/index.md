---
title: RequestDecorator -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[RequestDecorator](index)



# RequestDecorator  
 [androidJvm] abstract class [RequestDecorator](index)

Callback for adding custom headers to backend requests.



For simple use-cases, see the [withHeaders](-companion/with-headers) factory methods.



All requests made to the merchant backend will call back to the [decorateAnyRequest](decorate-any-request) method. This is a good place to add API keys and session tokens and the like. Afterwards each request will call back to its specific decoration method, where you can add request-specific headers if such is relevant to your use-case.



The sequence of operations is this:

<ul><li>SDK prepares a request</li><li>decorateAnyRequest is called</li><li>decorateAnyRequest returns</li><li>decorate<SpecificRequest> is called</li><li>decorate<SpecificRequest> returns</li><li>the request is executed</li></ul>

Note that the methods in this class are Kotlin coroutines (suspending functions). This way you can include long-running tasks (e.g. network I/O) in your custom header creation. You must not return from the callback until you have set all your headers; indeed you must not call any methods on the passed UserHeaders object after returning from the method.



There is a [Java compatibility class](../-request-decorator-compat/index) where the callbacks are regular methods running in a background thread.

   


## Constructors  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/RequestDecorator/RequestDecorator/#/PointingToDeclaration/"></a>[RequestDecorator](-request-decorator)| <a name="com.swedbankpay.mobilesdk/RequestDecorator/RequestDecorator/#/PointingToDeclaration/"></a> [androidJvm] fun [RequestDecorator](-request-decorator)()   <br>|


## Types  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/RequestDecorator.Companion///PointingToDeclaration/"></a>[Companion](-companion/index)| <a name="com.swedbankpay.mobilesdk/RequestDecorator.Companion///PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>object [Companion](-companion/index)  <br><br><br>|


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateAnyRequest/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#kotlin.String#kotlin.String?/PointingToDeclaration/"></a>[decorateAnyRequest](decorate-any-request)| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateAnyRequest/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#kotlin.String#kotlin.String?/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open suspend fun [decorateAnyRequest](decorate-any-request)(userHeaders: [UserHeaders](../-user-headers/index), method: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), url: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?)  <br>More info  <br>Override this method to add custom headers to all backend requests.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateCreatePaymentOrder/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#com.swedbankpay.mobilesdk.PaymentOrder/PointingToDeclaration/"></a>[decorateCreatePaymentOrder](decorate-create-payment-order)| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateCreatePaymentOrder/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#com.swedbankpay.mobilesdk.PaymentOrder/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open suspend fun [decorateCreatePaymentOrder](decorate-create-payment-order)(userHeaders: [UserHeaders](../-user-headers/index), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), paymentOrder: [PaymentOrder](../-payment-order/index))  <br>More info  <br>Override this method to add custom headers to the POST {paymentorders} request.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateGetTopLevelResources/#com.swedbankpay.mobilesdk.UserHeaders/PointingToDeclaration/"></a>[decorateGetTopLevelResources](decorate-get-top-level-resources)| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateGetTopLevelResources/#com.swedbankpay.mobilesdk.UserHeaders/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open suspend fun [decorateGetTopLevelResources](decorate-get-top-level-resources)(userHeaders: [UserHeaders](../-user-headers/index))  <br>More info  <br>Override this method to add custom headers to the backend entry point request.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateInitiateConsumerSession/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#com.swedbankpay.mobilesdk.Consumer/PointingToDeclaration/"></a>[decorateInitiateConsumerSession](decorate-initiate-consumer-session)| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateInitiateConsumerSession/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#com.swedbankpay.mobilesdk.Consumer/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open suspend fun [decorateInitiateConsumerSession](decorate-initiate-consumer-session)(userHeaders: [UserHeaders](../-user-headers/index), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), consumer: [Consumer](../-consumer/index))  <br>More info  <br>Override this method to add custom headers to the POST {consumers} request.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decoratePaymentOrderSetInstrument/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#kotlin.String#kotlin.String/PointingToDeclaration/"></a>[decoratePaymentOrderSetInstrument](decorate-payment-order-set-instrument)| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decoratePaymentOrderSetInstrument/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#kotlin.String#kotlin.String/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open suspend fun [decoratePaymentOrderSetInstrument](decorate-payment-order-set-instrument)(userHeaders: [UserHeaders](../-user-headers/index), url: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), instrument: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))  <br>More info  <br>Override this method to add custom headers to the PATCH {setInstrument} request of a payment order.  <br><br><br>|


## Inheritors  
  
|  Name | 
|---|
| <a name="com.swedbankpay.mobilesdk/RequestDecoratorCompat///PointingToDeclaration/"></a>[RequestDecoratorCompat](../-request-decorator-compat/index)|

