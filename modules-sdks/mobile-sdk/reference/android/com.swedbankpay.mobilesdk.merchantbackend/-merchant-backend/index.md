---
title: MerchantBackend -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk.merchantbackend](../index)/[MerchantBackend](index)



# MerchantBackend  
 [androidJvm] object [MerchantBackend](index)

Additional utilities supported by the Merchant Backend

   


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackend/deletePayerOwnerPaymentToken/#android.content.Context#com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration#com.swedbankpay.mobilesdk.merchantbackend.PaymentTokenInfo#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a>[deletePayerOwnerPaymentToken](delete-payer-owner-payment-token)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackend/deletePayerOwnerPaymentToken/#android.content.Context#com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration#com.swedbankpay.mobilesdk.merchantbackend.PaymentTokenInfo#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>suspend fun [deletePayerOwnerPaymentToken](delete-payer-owner-payment-token)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), configuration: [MerchantBackendConfiguration](../-merchant-backend-configuration/index), paymentTokenInfo: [PaymentTokenInfo](../-payment-token-info/index), comment: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), vararg extraHeaderNamesAndValues: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))  <br>More info  <br>Deletes the specified payment token.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackend/getPayerOwnedPaymentTokens/#android.content.Context#com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a>[getPayerOwnedPaymentTokens](get-payer-owned-payment-tokens)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackend/getPayerOwnedPaymentTokens/#android.content.Context#com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>suspend fun [getPayerOwnedPaymentTokens](get-payer-owned-payment-tokens)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), configuration: [MerchantBackendConfiguration](../-merchant-backend-configuration/index), payerReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), vararg extraHeaderNamesAndValues: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [PayerOwnedPaymentTokensResponse](../-payer-owned-payment-tokens-response/index)  <br>More info  <br>Retrieves the payment tokens owned by the given payerReference.  <br><br><br>|

