---
title: com.swedbankpay.mobilesdk.merchantbackend
---
//[mobilesdk-merchantbackend](../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](index.html)



# Package com.swedbankpay.mobilesdk.merchantbackend



## Types


| Name | Summary |
|---|---|
| [InvalidInstrumentException](-invalid-instrument-exception/index.html) | [androidJvm]<br>class [InvalidInstrumentException](-invalid-instrument-exception/index.html)(instrument: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), cause: [Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html)?) : [Exception](https://developer.android.com/reference/kotlin/java/lang/Exception.html)<br>Reported as the com.swedbankpay.mobilesdk.PaymentViewModel.RichState.updateException if the instrument was not valid for the payment order. |
| [MerchantBackend](-merchant-backend/index.html) | [androidJvm]<br>object [MerchantBackend](-merchant-backend/index.html)<br>Additional utilities supported by the Merchant Backend |
| [MerchantBackendConfiguration](-merchant-backend-configuration/index.html) | [androidJvm]<br>class [MerchantBackendConfiguration](-merchant-backend-configuration/index.html) : Configuration<br>A Configuration class for the Merchant Backend API. |
| [MerchantBackendProblem](-merchant-backend-problem/index.html) | [androidJvm]<br>sealed class [MerchantBackendProblem](-merchant-backend-problem/index.html) : Problem<br>Base class for any problems encountered in the payment. |
| [Operation](-operation/index.html) | [androidJvm]<br>data class [Operation](-operation/index.html)(rel: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, method: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, href: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, contentType: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?)<br>Swedbank Pay Operation. Operations are invoked by making an HTTP request. |
| [PayerOwnedPaymentTokens](-payer-owned-payment-tokens/index.html) | [androidJvm]<br>data class [PayerOwnedPaymentTokens](-payer-owned-payment-tokens/index.html)(id: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), payerReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), paymentTokens: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[PaymentTokenInfo](-payment-token-info/index.html)&gt;)<br>Payload of [PayerOwnedPaymentTokensResponse](-payer-owned-payment-tokens-response/index.html) |
| [PayerOwnedPaymentTokensResponse](-payer-owned-payment-tokens-response/index.html) | [androidJvm]<br>data class [PayerOwnedPaymentTokensResponse](-payer-owned-payment-tokens-response/index.html)(payerOwnedPaymentTokens: [PayerOwnedPaymentTokens](-payer-owned-payment-tokens/index.html), operations: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[Operation](-operation/index.html)&gt;)<br>Response to [MerchantBackend.getPayerOwnedPaymentTokens](-merchant-backend/get-payer-owned-payment-tokens.html) |
| [PaymentTokenInfo](-payment-token-info/index.html) | [androidJvm]<br>data class [PaymentTokenInfo](-payment-token-info/index.html)<br>A payment token and associated information. |
| [RequestDecorator](-request-decorator/index.html) | [androidJvm]<br>abstract class [RequestDecorator](-request-decorator/index.html)<br>Callback for adding custom headers to backend requests. |
| [RequestDecoratorCompat](-request-decorator-compat/index.html) | [androidJvm]<br>@[WorkerThread](https://developer.android.com/reference/kotlin/androidx/annotation/WorkerThread.html)<br>open class [RequestDecoratorCompat](-request-decorator-compat/index.html) : [RequestDecorator](-request-decorator/index.html)<br>Java compatibility wrapper for [RequestDecorator](-request-decorator/index.html). |
| [RequestProblemException](-request-problem-exception/index.html) | [androidJvm]<br>class [RequestProblemException](-request-problem-exception/index.html)(problem: Problem) : [IOException](https://developer.android.com/reference/kotlin/java/io/IOException.html)<br>IOException containing an RFC 7807 Problem object describing the error. |
| [SwedbankPayAction](index.html#853214653%2FClasslikes%2F1689614965) | [androidJvm]<br>typealias [SwedbankPayAction](index.html#853214653%2FClasslikes%2F1689614965) = [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>Action to take to correct a problem reported by the Swedbank Pay backend.<br>This is a [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) currently. Please refer to Swedbank Pay for possible values. |
| [SwedbankPayProblem](-swedbank-pay-problem/index.html) | [androidJvm]<br>interface [SwedbankPayProblem](-swedbank-pay-problem/index.html)<br>A Problem defined by the Swedbank Pay backend. https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HProblems |
| [SwedbankPaySubproblem](-swedbank-pay-subproblem/index.html) | [androidJvm]<br>data class [SwedbankPaySubproblem](-swedbank-pay-subproblem/index.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, description: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?) : [Serializable](https://developer.android.com/reference/kotlin/java/io/Serializable.html)<br>Object detailing the reason for a [SwedbankPayProblem](-swedbank-pay-problem/index.html). |
| [UnexpectedResponseException](-unexpected-response-exception/index.html) | [androidJvm]<br>class [UnexpectedResponseException](-unexpected-response-exception/index.html)(status: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), contentType: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, cause: [Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html)?) : [IOException](https://developer.android.com/reference/kotlin/java/io/IOException.html)<br>The server returned a response that [MerchantBackendConfiguration](-merchant-backend-configuration/index.html) was not prepared for. |
| [UserHeaders](-user-headers/index.html) | [androidJvm]<br>class [UserHeaders](-user-headers/index.html)<br>Builder for custom headers. |

