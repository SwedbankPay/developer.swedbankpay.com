---
title: MerchantBackend
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[MerchantBackend](index.html)



# MerchantBackend



[androidJvm]\
object [MerchantBackend](index.html)

Additional utilities supported by the Merchant Backend



## Functions


| Name | Summary |
|---|---|
| [deletePayerOwnerPaymentToken](delete-payer-owner-payment-token.html) | [androidJvm]<br>suspend fun [deletePayerOwnerPaymentToken](delete-payer-owner-payment-token.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), configuration: [MerchantBackendConfiguration](../-merchant-backend-configuration/index.html), paymentTokenInfo: [PaymentTokenInfo](../-payment-token-info/index.html), comment: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), vararg extraHeaderNamesAndValues: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))<br>Deletes the specified payment token. |
| [getPayerOwnedPaymentTokens](get-payer-owned-payment-tokens.html) | [androidJvm]<br>suspend fun [getPayerOwnedPaymentTokens](get-payer-owned-payment-tokens.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), configuration: [MerchantBackendConfiguration](../-merchant-backend-configuration/index.html), payerReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), vararg extraHeaderNamesAndValues: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [PayerOwnedPaymentTokensResponse](../-payer-owned-payment-tokens-response/index.html)<br>Retrieves the payment tokens owned by the given payerReference. |

