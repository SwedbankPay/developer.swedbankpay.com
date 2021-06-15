---
title: RequestDecoratorCompat
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[RequestDecoratorCompat](index.html)



# RequestDecoratorCompat



[androidJvm]\
@[WorkerThread](https://developer.android.com/reference/kotlin/androidx/annotation/WorkerThread.html)



open class [RequestDecoratorCompat](index.html) : [RequestDecorator](../-request-decorator/index.html)

Java compatibility wrapper for [RequestDecorator](../-request-decorator/index.html).



For each callback defined in [RequestDecorator](../-request-decorator/index.html), this class contains a corresponding callback but without the suspend modifier. The suspending methods of [RequestDecorator](../-request-decorator/index.html) invoke the corresponding regular methods using the [IO Dispatcher](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-dispatchers/-i-o.html). This means your callbacks run in a background thread, so be careful with synchronization.



## Constructors


| | |
|---|---|
| [RequestDecoratorCompat](-request-decorator-compat.html) | [androidJvm]<br>fun [RequestDecoratorCompat](-request-decorator-compat.html)() |


## Functions


| Name | Summary |
|---|---|
| [decorateAnyRequest](decorate-any-request.html) | [androidJvm]<br>suspend override fun [decorateAnyRequest](decorate-any-request.html)(userHeaders: [UserHeaders](../-user-headers/index.html), method: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), url: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?)<br>Override this method to add custom headers to all backend requests. |
| [decorateAnyRequestCompat](decorate-any-request-compat.html) | [androidJvm]<br>open fun [decorateAnyRequestCompat](decorate-any-request-compat.html)(userHeaders: [UserHeaders](../-user-headers/index.html), method: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), url: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?)<br>Override this method to add custom headers to all backend requests. |
| [decorateCreatePaymentOrder](decorate-create-payment-order.html) | [androidJvm]<br>suspend override fun [decorateCreatePaymentOrder](decorate-create-payment-order.html)(userHeaders: [UserHeaders](../-user-headers/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), paymentOrder: PaymentOrder)<br>Override this method to add custom headers to the POST {paymentorders} request. |
| [decorateCreatePaymentOrderCompat](decorate-create-payment-order-compat.html) | [androidJvm]<br>open fun [decorateCreatePaymentOrderCompat](decorate-create-payment-order-compat.html)(userHeaders: [UserHeaders](../-user-headers/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), paymentOrder: PaymentOrder)<br>Override this method to add custom headers to the POST {paymentorders} request. |
| [decorateGetTopLevelResources](decorate-get-top-level-resources.html) | [androidJvm]<br>suspend override fun [decorateGetTopLevelResources](decorate-get-top-level-resources.html)(userHeaders: [UserHeaders](../-user-headers/index.html))<br>Override this method to add custom headers to the backend entry point request. |
| [decorateGetTopLevelResourcesCompat](decorate-get-top-level-resources-compat.html) | [androidJvm]<br>open fun [decorateGetTopLevelResourcesCompat](decorate-get-top-level-resources-compat.html)(userHeaders: [UserHeaders](../-user-headers/index.html))<br>Override this method to add custom headers to the backend entry point request. |
| [decorateInitiateConsumerSession](decorate-initiate-consumer-session.html) | [androidJvm]<br>suspend override fun [decorateInitiateConsumerSession](decorate-initiate-consumer-session.html)(userHeaders: [UserHeaders](../-user-headers/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), consumer: Consumer)<br>Override this method to add custom headers to the POST {consumers} request. |
| [decorateInitiateConsumerSessionCompat](decorate-initiate-consumer-session-compat.html) | [androidJvm]<br>open fun [decorateInitiateConsumerSessionCompat](decorate-initiate-consumer-session-compat.html)(userHeaders: [UserHeaders](../-user-headers/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), consumer: Consumer)<br>Override this method to add custom headers to the POST {consumers} request. |
| [decoratePaymentOrderSetInstrument](decorate-payment-order-set-instrument.html) | [androidJvm]<br>suspend override fun [decoratePaymentOrderSetInstrument](decorate-payment-order-set-instrument.html)(userHeaders: [UserHeaders](../-user-headers/index.html), url: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), instrument: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))<br>Override this method to add custom headers to the PATCH {setInstrument} request of a payment order. |
| [decoratePaymentOrderSetInstrumentCompat](decorate-payment-order-set-instrument-compat.html) | [androidJvm]<br>open fun [decoratePaymentOrderSetInstrumentCompat](decorate-payment-order-set-instrument-compat.html)(userHeaders: [UserHeaders](../-user-headers/index.html), url: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), instrument: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))<br>Override this method to add custom headers to the PATCH {setInstrument} request of a payment order. |

