---
title: RequestDecorator
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[RequestDecorator](index.html)



# RequestDecorator



[androidJvm]\
abstract class [RequestDecorator](index.html)

Callback for adding custom headers to backend requests.



For simple use-cases, see the [withHeaders](-companion/with-headers.html) factory methods.



All requests made to the merchant backend will call back to the [decorateAnyRequest](decorate-any-request.html) method. This is a good place to add API keys and session tokens and the like. Afterwards each request will call back to its specific decoration method, where you can add request-specific headers if such is relevant to your use-case.



The sequence of operations is this:



- 
   SDK prepares a request
- 
   decorateAnyRequest is called
- 
   decorateAnyRequest returns
- 
   decorate<SpecificRequest> is called
- 
   decorate<SpecificRequest> returns
- 
   the request is executed




Note that the methods in this class are Kotlin coroutines (suspending functions). This way you can include long-running tasks (e.g. network I/O) in your custom header creation. You must not return from the callback until you have set all your headers; indeed you must not call any methods on the passed UserHeaders object after returning from the method.



There is a [Java compatibility class](../-request-decorator-compat/index.html) where the callbacks are regular methods running in a background thread.



## Constructors


| | |
|---|---|
| [RequestDecorator](-request-decorator.html) | [androidJvm]<br>fun [RequestDecorator](-request-decorator.html)() |


## Types


| Name | Summary |
|---|---|
| [Companion](-companion/index.html) | [androidJvm]<br>object [Companion](-companion/index.html) |


## Functions


| Name | Summary |
|---|---|
| [decorateAnyRequest](decorate-any-request.html) | [androidJvm]<br>open suspend fun [decorateAnyRequest](decorate-any-request.html)(userHeaders: [UserHeaders](../-user-headers/index.html), method: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), url: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?)<br>Override this method to add custom headers to all backend requests. |
| [decorateCreatePaymentOrder](decorate-create-payment-order.html) | [androidJvm]<br>open suspend fun [decorateCreatePaymentOrder](decorate-create-payment-order.html)(userHeaders: [UserHeaders](../-user-headers/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), paymentOrder: PaymentOrder)<br>Override this method to add custom headers to the POST {paymentorders} request. |
| [decorateGetTopLevelResources](decorate-get-top-level-resources.html) | [androidJvm]<br>open suspend fun [decorateGetTopLevelResources](decorate-get-top-level-resources.html)(userHeaders: [UserHeaders](../-user-headers/index.html))<br>Override this method to add custom headers to the backend entry point request. |
| [decorateInitiateConsumerSession](decorate-initiate-consumer-session.html) | [androidJvm]<br>open suspend fun [decorateInitiateConsumerSession](decorate-initiate-consumer-session.html)(userHeaders: [UserHeaders](../-user-headers/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), consumer: Consumer)<br>Override this method to add custom headers to the POST {consumers} request. |
| [decoratePaymentOrderSetInstrument](decorate-payment-order-set-instrument.html) | [androidJvm]<br>open suspend fun [decoratePaymentOrderSetInstrument](decorate-payment-order-set-instrument.html)(userHeaders: [UserHeaders](../-user-headers/index.html), url: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), instrument: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))<br>Override this method to add custom headers to the PATCH {setInstrument} request of a payment order. |


## Inheritors


| Name |
|---|
| [RequestDecoratorCompat](../-request-decorator-compat/index.html) |

