---
title: PayerOwnedPaymentTokensResponse
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[PayerOwnedPaymentTokensResponse](index.html)



# PayerOwnedPaymentTokensResponse



[androidJvm]\
data class [PayerOwnedPaymentTokensResponse](index.html)(payerOwnedPaymentTokens: [PayerOwnedPaymentTokens](../-payer-owned-payment-tokens/index.html), operations: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[Operation](../-operation/index.html)&gt;)

Response to [MerchantBackend.getPayerOwnedPaymentTokens](../-merchant-backend/get-payer-owned-payment-tokens.html)



## Constructors


| | |
|---|---|
| [PayerOwnedPaymentTokensResponse](-payer-owned-payment-tokens-response.html) | [androidJvm]<br>fun [PayerOwnedPaymentTokensResponse](-payer-owned-payment-tokens-response.html)(payerOwnedPaymentTokens: [PayerOwnedPaymentTokens](../-payer-owned-payment-tokens/index.html), operations: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[Operation](../-operation/index.html)&gt;) |


## Properties


| Name | Summary |
|---|---|
| [operations](operations.html) | [androidJvm]<br>val [operations](operations.html): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[Operation](../-operation/index.html)&gt;<br>Operations you can perform on the whole list of tokens. Note that you generally cannot call these from your mobile app. |
| [payerOwnedPaymentTokens](payer-owned-payment-tokens.html) | [androidJvm]<br>val [payerOwnedPaymentTokens](payer-owned-payment-tokens.html): [PayerOwnedPaymentTokens](../-payer-owned-payment-tokens/index.html)<br>The response payload. |

