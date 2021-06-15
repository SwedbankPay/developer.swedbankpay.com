---
title: getPayerOwnedPaymentTokens
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[MerchantBackend](index.html)/[getPayerOwnedPaymentTokens](get-payer-owned-payment-tokens.html)



# getPayerOwnedPaymentTokens



[androidJvm]\
suspend fun [getPayerOwnedPaymentTokens](get-payer-owned-payment-tokens.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), configuration: [MerchantBackendConfiguration](../-merchant-backend-configuration/index.html), payerReference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), vararg extraHeaderNamesAndValues: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [PayerOwnedPaymentTokensResponse](../-payer-owned-payment-tokens-response/index.html)



Retrieves the payment tokens owned by the given payerReference.



Your backend must enable this functionality separately.



#### Return



the response from Swedbank Pay



## Parameters


androidJvm

| | |
|---|---|
| context | a Context from your application |
| configuration | the backend configuration |
| payerReference | the reference to query |
| extraHeaderNamesAndValues | any header names and values you wish to append to the request |




