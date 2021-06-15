---
title: orderItems
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentOrder](index.html)/[orderItems](order-items.html)



# orderItems



[androidJvm]\




@SerializedName(value = "orderItems")



val [orderItems](order-items.html): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[OrderItem](../-order-item/index.html)&gt;? = null



A list of items that are being paid for by this payment order.



If used, the sum of the [OrderItem.amount](../-order-item/amount.html) and [OrderItem.vatAmount](../-order-item/vat-amount.html) should match [amount](amount.html)` and [vatAmount](vat-amount.html) of this payment order.




