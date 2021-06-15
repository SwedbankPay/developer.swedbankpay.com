---
title: PayerOwnedPaymentTokens
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[PayerOwnedPaymentTokens](index.html)



# PayerOwnedPaymentTokens



[androidJvm]\
data class [PayerOwnedPaymentTokens](index.html)(id: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), payerReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), paymentTokens: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[PaymentTokenInfo](../-payment-token-info/index.html)&gt;)

Payload of [PayerOwnedPaymentTokensResponse](../-payer-owned-payment-tokens-response/index.html)



## Constructors


| | |
|---|---|
| [PayerOwnedPaymentTokens](-payer-owned-payment-tokens.html) | [androidJvm]<br>fun [PayerOwnedPaymentTokens](-payer-owned-payment-tokens.html)(id: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), payerReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), paymentTokens: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[PaymentTokenInfo](../-payment-token-info/index.html)&gt;) |


## Properties


| Name | Summary |
|---|---|
| [id](id.html) | [androidJvm]<br>val [id](id.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>The id (url) of this resource. |
| [payerReference](payer-reference.html) | [androidJvm]<br>val [payerReference](payer-reference.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>The payerReference associated with these tokens |
| [paymentTokens](payment-tokens.html) | [androidJvm]<br>val [paymentTokens](payment-tokens.html): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[PaymentTokenInfo](../-payment-token-info/index.html)&gt;<br>The list of tokens and associated information |

