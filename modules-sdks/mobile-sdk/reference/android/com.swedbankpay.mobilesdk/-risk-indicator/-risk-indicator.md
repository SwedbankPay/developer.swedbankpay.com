---
title: RiskIndicator
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[RiskIndicator](index.html)/[RiskIndicator](-risk-indicator.html)



# RiskIndicator



[androidJvm]\
fun [RiskIndicator](-risk-indicator.html)(deliveryEmailAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, deliveryTimeFrameIndicator: [DeliveryTimeFrameIndicator](../-delivery-time-frame-indicator/index.html)? = null, preOrderDate: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, preOrderPurchaseIndicator: [PreOrderPurchaseIndicator](../-pre-order-purchase-indicator/index.html)? = null, shipIndicator: [ShipIndicator](../-ship-indicator/index.html)? = null, giftCardPurchase: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)? = null, reOrderPurchaseIndicator: [ReOrderPurchaseIndicator](../-re-order-purchase-indicator/index.html)? = null)



Constructs a RiskIndicator with Kotlin-native value for shipIndicator



## Parameters


androidJvm

| | |
|---|---|
| deliveryEmailAddress | For electronic delivery, the e-mail address where the merchanise is delivered |
| deliveryTimeFrameIndicator | Indicator of merchandise delivery timeframe |
| preOrderDate | If this is a pre-order, the expected date that the merchandise will be available on. Format is YYYYMMDD; use [formatPreOrderDate](-companion/format-pre-order-date.html) to format some usual types correctly. |
| preOrderPurchaseIndicator | Indicates whether this is a pre-order |
| shipIndicator | Indicates the shipping method for this order |
| reOrderPurchaseIndicator | Indicates whether this is a re-order of previously purchased merchandise |





[androidJvm]\
fun [RiskIndicator](-risk-indicator.html)(deliveryEmailAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, deliveryTimeFrameIndicator: [DeliveryTimeFrameIndicator](../-delivery-time-frame-indicator/index.html)?, preOrderDate: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, preOrderPurchaseIndicator: [PreOrderPurchaseIndicator](../-pre-order-purchase-indicator/index.html)?, shipIndicator: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, pickUpAddress: [PickUpAddress](../-pick-up-address/index.html)?, giftCardPurchase: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)?, reOrderPurchaseIndicator: [ReOrderPurchaseIndicator](../-re-order-purchase-indicator/index.html)?)



"Raw" constructor. You must manually ensure you set the values for shipIndicator and pickUpAddress correctly. It is recommended to use the other constructor.




