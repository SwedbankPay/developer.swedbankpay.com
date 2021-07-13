---
title: orderItems -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PaymentOrder](index)/[orderItems](order-items)



# orderItems  
[androidJvm]  
Content  
@SerializedName(value = orderItems)  
  
val [orderItems](order-items): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)<[OrderItem](../-order-item/index)>? = null  
More info  


A list of items that are being paid for by this payment order.



If used, the sum of the [OrderItem.amount](../-order-item/amount) and [OrderItem.vatAmount](../-order-item/vat-amount) should match [amount](amount)` and [vatAmount](vat-amount) of this payment order.

  



