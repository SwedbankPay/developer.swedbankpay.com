---
title: Configuration
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[Configuration](index.html)



# Configuration



[androidJvm]\
abstract class [Configuration](index.html)

The Swedbank Pay configuration for your application.



You need a Configuration to use [PaymentFragment](../-payment-fragment/index.html). If you want to use a custom way of communicating with your services, you can create a subclass of Configuration. If you wish to use the specified Merchant Backend API, create a com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration using com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration.Builder.



In most cases, it is enough to set a [default Configuration](../-payment-fragment/-companion/default-configuration.html). However, for more advanced situations, you may override [PaymentFragment.getConfiguration](../-payment-fragment/get-configuration.html) to provide a Configuration dynamically.



N.B! Configuration is specified as suspend functions, i.e. Kotlin coroutines. As Java does not support these, a [compatibility class](../-configuration-compat/index.html) is provided.



## Constructors


| | |
|---|---|
| [Configuration](-configuration.html) | [androidJvm]<br>fun [Configuration](-configuration.html)() |


## Functions


| Name | Summary |
|---|---|
| [getErrorMessage](get-error-message.html) | [androidJvm]<br>open fun [getErrorMessage](get-error-message.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to show an error message because an operation failed. |
| [postConsumers](post-consumers.html) | [androidJvm]<br>abstract suspend fun [postConsumers](post-consumers.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), consumer: [Consumer](../-consumer/index.html)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [ViewConsumerIdentificationInfo](../-view-consumer-identification-info/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to start a consumer identification session. Your implementation must ultimately make the call to Swedbank Pay API and return a [ViewConsumerIdentificationInfo](../-view-consumer-identification-info/index.html) describing the result. |
| [postPaymentorders](post-paymentorders.html) | [androidJvm]<br>abstract suspend fun [postPaymentorders](post-paymentorders.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), paymentOrder: [PaymentOrder](../-payment-order/index.html)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?, consumerProfileRef: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?): [ViewPaymentOrderInfo](../-view-payment-order-info/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to create a payment order. Your implementation must ultimately make the call to Swedbank Pay API and return a [ViewPaymentOrderInfo](../-view-payment-order-info/index.html) describing the result. |
| [shouldRetryAfterPostConsumersException](should-retry-after-post-consumers-exception.html) | [androidJvm]<br>open suspend fun [shouldRetryAfterPostConsumersException](should-retry-after-post-consumers-exception.html)(exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) to determine whether it should fail or allow retry after it failed to start a consumer identification session. |
| [shouldRetryAfterPostPaymentordersException](should-retry-after-post-paymentorders-exception.html) | [androidJvm]<br>open suspend fun [shouldRetryAfterPostPaymentordersException](should-retry-after-post-paymentorders-exception.html)(exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) to determine whether it should fail or allow retry after it failed to create the payment order. |
| [updatePaymentOrder](update-payment-order.html) | [androidJvm]<br>open suspend fun [updatePaymentOrder](update-payment-order.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), paymentOrder: [PaymentOrder](../-payment-order/index.html)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?, viewPaymentOrderInfo: [ViewPaymentOrderInfo](../-view-payment-order-info/index.html), updateInfo: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [ViewPaymentOrderInfo](../-view-payment-order-info/index.html)<br>Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to update a payment order. |


## Inheritors


| Name |
|---|
| [ConfigurationCompat](../-configuration-compat/index.html) |

