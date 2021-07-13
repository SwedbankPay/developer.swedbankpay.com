---
title: MerchantBackendConfiguration -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk.merchantbackend](../index)/[MerchantBackendConfiguration](index)



# MerchantBackendConfiguration  
 [androidJvm] class [MerchantBackendConfiguration](index) : [Configuration](../../com.swedbankpay.mobilesdk/-configuration/index)

A [Configuration](../../com.swedbankpay.mobilesdk/-configuration/index) class for the Merchant Backend API.



Get an instance using [Builder](-builder/index).

   


## Types  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder///PointingToDeclaration/"></a>[Builder](-builder/index)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder///PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>class [Builder](-builder/index)(**backendUrl**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))  <br>More info  <br>A builder object for [MerchantBackendConfiguration](index).  <br><br><br>|


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/getErrorMessage/#android.content.Context#java.lang.Exception/PointingToDeclaration/"></a>[getErrorMessage](get-error-message)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/getErrorMessage/#android.content.Context#java.lang.Exception/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open override fun [getErrorMessage](get-error-message)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?  <br>More info  <br>Called by [PaymentFragment](../../com.swedbankpay.mobilesdk/-payment-fragment/index) when it needs to show an error message because an operation failed.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/postConsumers/#android.content.Context#com.swedbankpay.mobilesdk.Consumer?#kotlin.Any?/PointingToDeclaration/"></a>[postConsumers](post-consumers)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/postConsumers/#android.content.Context#com.swedbankpay.mobilesdk.Consumer?#kotlin.Any?/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open suspend override fun [postConsumers](post-consumers)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), consumer: [Consumer](../../com.swedbankpay.mobilesdk/-consumer/index)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [ViewConsumerIdentificationInfo](../../com.swedbankpay.mobilesdk/-view-consumer-identification-info/index)  <br>More info  <br>Called by [PaymentFragment](../../com.swedbankpay.mobilesdk/-payment-fragment/index) when it needs to start a consumer identification session.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/postPaymentorders/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#kotlin.String?/PointingToDeclaration/"></a>[postPaymentorders](post-paymentorders)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/postPaymentorders/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#kotlin.String?/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open suspend override fun [postPaymentorders](post-paymentorders)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), paymentOrder: [PaymentOrder](../../com.swedbankpay.mobilesdk/-payment-order/index)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?, consumerProfileRef: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?): [ViewPaymentOrderInfo](../../com.swedbankpay.mobilesdk/-view-payment-order-info/index)  <br>More info  <br>Called by [PaymentFragment](../../com.swedbankpay.mobilesdk/-payment-fragment/index) when it needs to create a payment order.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/shouldRetryAfterPostConsumersException/#java.lang.Exception/PointingToDeclaration/"></a>[shouldRetryAfterPostConsumersException](should-retry-after-post-consumers-exception)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/shouldRetryAfterPostConsumersException/#java.lang.Exception/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open suspend override fun [shouldRetryAfterPostConsumersException](should-retry-after-post-consumers-exception)(exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)  <br>More info  <br>Called by [PaymentFragment](../../com.swedbankpay.mobilesdk/-payment-fragment/index) to determine whether it should fail or allow retry after it failed to start a consumer identification session.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/shouldRetryAfterPostPaymentordersException/#java.lang.Exception/PointingToDeclaration/"></a>[shouldRetryAfterPostPaymentordersException](should-retry-after-post-paymentorders-exception)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/shouldRetryAfterPostPaymentordersException/#java.lang.Exception/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open suspend override fun [shouldRetryAfterPostPaymentordersException](should-retry-after-post-paymentorders-exception)(exception: [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)  <br>More info  <br>Called by [PaymentFragment](../../com.swedbankpay.mobilesdk/-payment-fragment/index) to determine whether it should fail or allow retry after it failed to create the payment order.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/updatePaymentOrder/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#com.swedbankpay.mobilesdk.ViewPaymentOrderInfo#kotlin.Any?/PointingToDeclaration/"></a>[updatePaymentOrder](update-payment-order)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/updatePaymentOrder/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#com.swedbankpay.mobilesdk.ViewPaymentOrderInfo#kotlin.Any?/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open suspend override fun [updatePaymentOrder](update-payment-order)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), paymentOrder: [PaymentOrder](../../com.swedbankpay.mobilesdk/-payment-order/index)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?, viewPaymentOrderInfo: [ViewPaymentOrderInfo](../../com.swedbankpay.mobilesdk/-view-payment-order-info/index), updateInfo: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [ViewPaymentOrderInfo](../../com.swedbankpay.mobilesdk/-view-payment-order-info/index)  <br>More info  <br>Called by [PaymentFragment](../../com.swedbankpay.mobilesdk/-payment-fragment/index) when it needs to update a payment order.  <br><br><br>|


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/backendUrl/#/PointingToDeclaration/"></a>[backendUrl](backend-url)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/backendUrl/#/PointingToDeclaration/"></a> [androidJvm] val [backendUrl](backend-url): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)The URL of the Merchant Backend.   <br>|

