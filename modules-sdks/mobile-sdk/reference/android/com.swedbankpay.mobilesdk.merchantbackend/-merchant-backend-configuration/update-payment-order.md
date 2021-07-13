---
title: updatePaymentOrder -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk.merchantbackend](../index)/[MerchantBackendConfiguration](index)/[updatePaymentOrder](update-payment-order)



# updatePaymentOrder  
[androidJvm]  
Content  
open suspend override fun [updatePaymentOrder](update-payment-order)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), paymentOrder: [PaymentOrder](../../com.swedbankpay.mobilesdk/-payment-order/index)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?, viewPaymentOrderInfo: [ViewPaymentOrderInfo](../../com.swedbankpay.mobilesdk/-view-payment-order-info/index), updateInfo: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [ViewPaymentOrderInfo](../../com.swedbankpay.mobilesdk/-view-payment-order-info/index)  
More info  


Called by [PaymentFragment](../../com.swedbankpay.mobilesdk/-payment-fragment/index) when it needs to update a payment order.



If you do not update payment orders after they have been created, you do not need to override this method.



#### Return  


ViewPaymentOrderInfo describing the payment order with the changed instrument



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/updatePaymentOrder/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#com.swedbankpay.mobilesdk.ViewPaymentOrderInfo#kotlin.Any?/PointingToDeclaration/"></a>context| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/updatePaymentOrder/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#com.swedbankpay.mobilesdk.ViewPaymentOrderInfo#kotlin.Any?/PointingToDeclaration/"></a><br><br>an application context<br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/updatePaymentOrder/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#com.swedbankpay.mobilesdk.ViewPaymentOrderInfo#kotlin.Any?/PointingToDeclaration/"></a>paymentOrder| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/updatePaymentOrder/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#com.swedbankpay.mobilesdk.ViewPaymentOrderInfo#kotlin.Any?/PointingToDeclaration/"></a><br><br>the [PaymentOrder](../../com.swedbankpay.mobilesdk/-payment-order/index) object set as the PaymentFragment argument<br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/updatePaymentOrder/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#com.swedbankpay.mobilesdk.ViewPaymentOrderInfo#kotlin.Any?/PointingToDeclaration/"></a>userData| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/updatePaymentOrder/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#com.swedbankpay.mobilesdk.ViewPaymentOrderInfo#kotlin.Any?/PointingToDeclaration/"></a><br><br>the user data object set as the PaymentFragment argument<br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/updatePaymentOrder/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#com.swedbankpay.mobilesdk.ViewPaymentOrderInfo#kotlin.Any?/PointingToDeclaration/"></a>viewPaymentOrderInfo| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/updatePaymentOrder/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#com.swedbankpay.mobilesdk.ViewPaymentOrderInfo#kotlin.Any?/PointingToDeclaration/"></a><br><br>the current [ViewPaymentOrderInfo](../../com.swedbankpay.mobilesdk/-view-payment-order-info/index) as returned from a call to this or [postPaymentorders](post-paymentorders)<br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/updatePaymentOrder/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#com.swedbankpay.mobilesdk.ViewPaymentOrderInfo#kotlin.Any?/PointingToDeclaration/"></a>updateInfo| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration/updatePaymentOrder/#android.content.Context#com.swedbankpay.mobilesdk.PaymentOrder?#kotlin.Any?#com.swedbankpay.mobilesdk.ViewPaymentOrderInfo#kotlin.Any?/PointingToDeclaration/"></a><br><br>the updateInfo value from the [PaymentViewModel.updatePaymentOrder](../../com.swedbankpay.mobilesdk/-payment-view-model/update-payment-order) call<br><br>|
  
  



