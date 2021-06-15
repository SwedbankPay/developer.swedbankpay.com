---
title: updatePaymentOrder
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[ConfigurationCompat](index.html)/[updatePaymentOrder](update-payment-order.html)



# updatePaymentOrder



[androidJvm]\
suspend override fun [updatePaymentOrder](update-payment-order.html)(context: [Context](https://developer.android.com/reference/kotlin/android/content/Context.html), paymentOrder: [PaymentOrder](../-payment-order/index.html)?, userData: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?, viewPaymentOrderInfo: [ViewPaymentOrderInfo](../-view-payment-order-info/index.html), updateInfo: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [ViewPaymentOrderInfo](../-view-payment-order-info/index.html)



Called by [PaymentFragment](../-payment-fragment/index.html) when it needs to update a payment order.



If you do not update payment orders after they have been created, you do not need to override this method.



#### Return



ViewPaymentOrderInfo describing the payment order with the changed instrument



## Parameters


androidJvm

| | |
|---|---|
| context | an application context |
| paymentOrder | the [PaymentOrder](../-payment-order/index.html) object set as the PaymentFragment argument |
| userData | the user data object set as the PaymentFragment argument |
| viewPaymentOrderInfo | the current [ViewPaymentOrderInfo](../-view-payment-order-info/index.html) as returned from a call to this or [postPaymentorders](post-paymentorders.html) |
| updateInfo | the updateInfo value from the [PaymentViewModel.updatePaymentOrder](../-payment-view-model/update-payment-order.html) call |




