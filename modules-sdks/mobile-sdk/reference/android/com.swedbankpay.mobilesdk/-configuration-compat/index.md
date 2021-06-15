---
title: ConfigurationCompat
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[ConfigurationCompat](index.html)



# ConfigurationCompat



[androidJvm]\
abstract class [ConfigurationCompat](index.html) : [Configuration](../-configuration/index.html)

Java compatibility wrapper for [Configuration](../-configuration/index.html).



For each callback defined in [Configuration](../-configuration/index.html), this class contains a corresponding callback but without the suspend modifier. The suspending methods of [Configuration](../-configuration/index.html) invoke the corresponding regular methods using the [IO Dispatcher](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-dispatchers/-i-o.html). This means your callbacks run in a background thread, so be careful with synchronization.



## Constructors


| | |
|---|---|
| [ConfigurationCompat](-configuration-compat.html) | [androidJvm]<br>fun [ConfigurationCompat](-configuration-compat.html)() |


## Functions


| Name | Summary |
|---|---|
| [getErrorMessage](../-configuration/get-error-message.html) | [androidJvm]<br>open fun [getErrorMessage](../-configuration/get-error-message.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to show an error message because an operation failed. |
| [postConsumers](post-consumers.html) | [androidJvm]<br>suspend override fun [postConsumers](post-consumers.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), consumer: [Consumer](../-consumer/index.html)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [ViewConsumerIdentificationInfo](../-view-consumer-identification-info/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to start a consumer identification session. Your implementation must ultimately make the call to Swedbank Pay API and return a [ViewConsumerIdentificationInfo](../-view-consumer-identification-info/index.html) describing the result. |
| [postConsumersCompat](post-consumers-compat.html) | [androidJvm]<br>@[WorkerThread](https://developer.android.com/reference/kotlin/androidx/annotation/WorkerThread.html)<br>abstract fun [postConsumersCompat](post-consumers-compat.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), consumer: [Consumer](../-consumer/index.html)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [ViewConsumerIdentificationInfo](../-view-consumer-identification-info/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to start a consumer identification session. Your implementation must ultimately make the call to Swedbank Pay API and return a [ViewConsumerIdentificationInfo](../-view-consumer-identification-info/index.html) describing the result. |
| [postPaymentorders](post-paymentorders.html) | [androidJvm]<br>suspend override fun [postPaymentorders](post-paymentorders.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), paymentOrder: [PaymentOrder](../-payment-order/index.html)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?, consumerProfileRef: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?): [ViewPaymentOrderInfo](../-view-payment-order-info/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to create a payment order. Your implementation must ultimately make the call to Swedbank Pay API and return a [ViewPaymentOrderInfo](../-view-payment-order-info/index.html) describing the result. |
| [postPaymentordersCompat](post-paymentorders-compat.html) | [androidJvm]<br>@[WorkerThread](https://developer.android.com/reference/kotlin/androidx/annotation/WorkerThread.html)<br>abstract fun [postPaymentordersCompat](post-paymentorders-compat.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), paymentOrder: [PaymentOrder](../-payment-order/index.html)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?, consumerProfileRef: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?): [ViewPaymentOrderInfo](../-view-payment-order-info/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to create a payment order. Your implementation must ultimately make the call to Swedbank Pay API and return a [ViewPaymentOrderInfo](../-view-payment-order-info/index.html) describing the result. |
| [shouldRetryAfterPostConsumersException](should-retry-after-post-consumers-exception.html) | [androidJvm]<br>suspend override fun [shouldRetryAfterPostConsumersException](should-retry-after-post-consumers-exception.html)(exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) to determine whether it should fail or allow retry after it failed to start a consumer identification session. |
| [shouldRetryAfterPostConsumersExceptionCompat](should-retry-after-post-consumers-exception-compat.html) | [androidJvm]<br>@[WorkerThread](https://developer.android.com/reference/kotlin/androidx/annotation/WorkerThread.html)<br>open fun [shouldRetryAfterPostConsumersExceptionCompat](should-retry-after-post-consumers-exception-compat.html)(exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) to determine whether it should fail or allow retry after it failed to start a consumer identification session. |
| [shouldRetryAfterPostPaymentordersException](should-retry-after-post-paymentorders-exception.html) | [androidJvm]<br>suspend override fun [shouldRetryAfterPostPaymentordersException](should-retry-after-post-paymentorders-exception.html)(exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) to determine whether it should fail or allow retry after it failed to create the payment order. |
| [shouldRetryAfterPostPaymentordersExceptionCompat](should-retry-after-post-paymentorders-exception-compat.html) | [androidJvm]<br>@[WorkerThread](https://developer.android.com/reference/kotlin/androidx/annotation/WorkerThread.html)<br>open fun [shouldRetryAfterPostPaymentordersExceptionCompat](should-retry-after-post-paymentorders-exception-compat.html)(exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) to determine whether it should fail or allow retry after it failed to create the payment order. |
| [updatePaymentOrder](update-payment-order.html) | [androidJvm]<br>suspend override fun [updatePaymentOrder](update-payment-order.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), paymentOrder: [PaymentOrder](../-payment-order/index.html)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?, viewPaymentOrderInfo: [ViewPaymentOrderInfo](../-view-payment-order-info/index.html), updateInfo: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [ViewPaymentOrderInfo](../-view-payment-order-info/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to update a payment order. |
| [updatePaymentOrderCompat](update-payment-order-compat.html) | [androidJvm]<br>@[WorkerThread](https://developer.android.com/reference/kotlin/androidx/annotation/WorkerThread.html)<br>open fun [updatePaymentOrderCompat](update-payment-order-compat.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), paymentOrder: [PaymentOrder](../-payment-order/index.html)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?, viewPaymentOrderInfo: [ViewPaymentOrderInfo](../-view-payment-order-info/index.html), updateInfo: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [ViewPaymentOrderInfo](../-view-payment-order-info/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to update a payment order. |

