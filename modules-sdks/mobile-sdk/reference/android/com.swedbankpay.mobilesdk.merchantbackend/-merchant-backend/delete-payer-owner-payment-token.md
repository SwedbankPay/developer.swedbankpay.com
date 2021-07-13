---
title: deletePayerOwnerPaymentToken -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk.merchantbackend](../index)/[MerchantBackend](index)/[deletePayerOwnerPaymentToken](delete-payer-owner-payment-token)



# deletePayerOwnerPaymentToken  
[androidJvm]  
Content  
suspend fun [deletePayerOwnerPaymentToken](delete-payer-owner-payment-token)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), configuration: [MerchantBackendConfiguration](../-merchant-backend-configuration/index), paymentTokenInfo: [PaymentTokenInfo](../-payment-token-info/index), comment: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), vararg extraHeaderNamesAndValues: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))  
More info  


Deletes the specified payment token.



Your backend must enable this functionality separately. After you make this request, you should refresh your local list of tokens.



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackend/deletePayerOwnerPaymentToken/#android.content.Context#com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration#com.swedbankpay.mobilesdk.merchantbackend.PaymentTokenInfo#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a>context| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackend/deletePayerOwnerPaymentToken/#android.content.Context#com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration#com.swedbankpay.mobilesdk.merchantbackend.PaymentTokenInfo#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a><br><br>a Context from your application<br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackend/deletePayerOwnerPaymentToken/#android.content.Context#com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration#com.swedbankpay.mobilesdk.merchantbackend.PaymentTokenInfo#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a>configuration| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackend/deletePayerOwnerPaymentToken/#android.content.Context#com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration#com.swedbankpay.mobilesdk.merchantbackend.PaymentTokenInfo#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a><br><br>the backend configuration<br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackend/deletePayerOwnerPaymentToken/#android.content.Context#com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration#com.swedbankpay.mobilesdk.merchantbackend.PaymentTokenInfo#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a>paymentTokenInfo| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackend/deletePayerOwnerPaymentToken/#android.content.Context#com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration#com.swedbankpay.mobilesdk.merchantbackend.PaymentTokenInfo#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a><br><br>the token to delete<br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackend/deletePayerOwnerPaymentToken/#android.content.Context#com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration#com.swedbankpay.mobilesdk.merchantbackend.PaymentTokenInfo#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a>comment| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackend/deletePayerOwnerPaymentToken/#android.content.Context#com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration#com.swedbankpay.mobilesdk.merchantbackend.PaymentTokenInfo#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a><br><br>the reason for the deletion<br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackend/deletePayerOwnerPaymentToken/#android.content.Context#com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration#com.swedbankpay.mobilesdk.merchantbackend.PaymentTokenInfo#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a>extraHeaderNamesAndValues| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackend/deletePayerOwnerPaymentToken/#android.content.Context#com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration#com.swedbankpay.mobilesdk.merchantbackend.PaymentTokenInfo#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a><br><br>any header names and values you wish to append to the request<br><br>|
  
  



