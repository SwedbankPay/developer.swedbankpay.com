---
title: MerchantBackendConfiguration
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[MerchantBackendConfiguration](index.html)



# MerchantBackendConfiguration



[androidJvm]\
class [MerchantBackendConfiguration](index.html) : Configuration

A Configuration class for the Merchant Backend API.



Get an instance using [Builder](-builder/index.html).



## Types


| Name | Summary |
|---|---|
| [Builder](-builder/index.html) | [androidJvm]<br>class [Builder](-builder/index.html)(backendUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))<br>A builder object for [MerchantBackendConfiguration](index.html). |


## Functions


| Name | Summary |
|---|---|
| [getErrorMessage](get-error-message.html) | [androidJvm]<br>open override fun [getErrorMessage](get-error-message.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [postConsumers](post-consumers.html) | [androidJvm]<br>open suspend override fun [postConsumers](post-consumers.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), consumer: Consumer?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): ViewConsumerIdentificationInfo |
| [postPaymentorders](post-paymentorders.html) | [androidJvm]<br>open suspend override fun [postPaymentorders](post-paymentorders.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), paymentOrder: PaymentOrder?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?, consumerProfileRef: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?): ViewPaymentOrderInfo |
| [shouldRetryAfterPostConsumersException](should-retry-after-post-consumers-exception.html) | [androidJvm]<br>open suspend override fun [shouldRetryAfterPostConsumersException](should-retry-after-post-consumers-exception.html)(exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) |
| [shouldRetryAfterPostPaymentordersException](should-retry-after-post-paymentorders-exception.html) | [androidJvm]<br>open suspend override fun [shouldRetryAfterPostPaymentordersException](should-retry-after-post-paymentorders-exception.html)(exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) |
| [updatePaymentOrder](update-payment-order.html) | [androidJvm]<br>open suspend override fun [updatePaymentOrder](update-payment-order.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), paymentOrder: PaymentOrder?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?, viewPaymentOrderInfo: ViewPaymentOrderInfo, updateInfo: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): ViewPaymentOrderInfo |


## Properties


| Name | Summary |
|---|---|
| [backendUrl](backend-url.html) | [androidJvm]<br>val [backendUrl](backend-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>The URL of the Merchant Backend. |

