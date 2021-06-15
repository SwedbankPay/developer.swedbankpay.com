---
title: deletePayerOwnerPaymentToken
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[MerchantBackend](index.html)/[deletePayerOwnerPaymentToken](delete-payer-owner-payment-token.html)



# deletePayerOwnerPaymentToken



[androidJvm]\
suspend fun [deletePayerOwnerPaymentToken](delete-payer-owner-payment-token.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), configuration: [MerchantBackendConfiguration](../-merchant-backend-configuration/index.html), paymentTokenInfo: [PaymentTokenInfo](../-payment-token-info/index.html), comment: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), vararg extraHeaderNamesAndValues: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))



Deletes the specified payment token.



Your backend must enable this functionality separately. After you make this request, you should refresh your local list of tokens.



## Parameters


androidJvm

| | |
|---|---|
| context | a Context from your application |
| configuration | the backend configuration |
| paymentTokenInfo | the token to delete |
| comment | the reason for the deletion |
| extraHeaderNamesAndValues | any header names and values you wish to append to the request |




