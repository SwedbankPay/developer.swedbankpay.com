---
title: RiskIndicator -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[RiskIndicator](index)/[RiskIndicator](-risk-indicator)



# RiskIndicator  
[androidJvm]  
Content  
fun [RiskIndicator](-risk-indicator)(deliveryEmailAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, deliveryTimeFrameIndicator: [DeliveryTimeFrameIndicator](../-delivery-time-frame-indicator/index)? = null, preOrderDate: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, preOrderPurchaseIndicator: [PreOrderPurchaseIndicator](../-pre-order-purchase-indicator/index)? = null, shipIndicator: [ShipIndicator](../-ship-indicator/index)? = null, giftCardPurchase: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)? = null, reOrderPurchaseIndicator: [ReOrderPurchaseIndicator](../-re-order-purchase-indicator/index)? = null)  
More info  


Constructs a RiskIndicator with Kotlin-native value for shipIndicator



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#com.swedbankpay.mobilesdk.ShipIndicator?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a>deliveryEmailAddress| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#com.swedbankpay.mobilesdk.ShipIndicator?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a><br><br>For electronic delivery, the e-mail address where the merchanise is delivered<br><br>|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#com.swedbankpay.mobilesdk.ShipIndicator?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a>deliveryTimeFrameIndicator| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#com.swedbankpay.mobilesdk.ShipIndicator?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a><br><br>Indicator of merchandise delivery timeframe<br><br>|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#com.swedbankpay.mobilesdk.ShipIndicator?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a>preOrderDate| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#com.swedbankpay.mobilesdk.ShipIndicator?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a><br><br>If this is a pre-order, the expected date that the merchandise will be available on. Format is YYYYMMDD; use [formatPreOrderDate](-companion/format-pre-order-date) to format some usual types correctly.<br><br>|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#com.swedbankpay.mobilesdk.ShipIndicator?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a>preOrderPurchaseIndicator| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#com.swedbankpay.mobilesdk.ShipIndicator?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a><br><br>Indicates whether this is a pre-order<br><br>|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#com.swedbankpay.mobilesdk.ShipIndicator?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a>shipIndicator| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#com.swedbankpay.mobilesdk.ShipIndicator?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a><br><br>Indicates the shipping method for this order<br><br>|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#com.swedbankpay.mobilesdk.ShipIndicator?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a>reOrderPurchaseIndicator| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#com.swedbankpay.mobilesdk.ShipIndicator?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a><br><br>Indicates whether this is a re-order of previously purchased merchandise<br><br>|
  
  


[androidJvm]  
Content  
fun [RiskIndicator](-risk-indicator)(deliveryEmailAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, deliveryTimeFrameIndicator: [DeliveryTimeFrameIndicator](../-delivery-time-frame-indicator/index)?, preOrderDate: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, preOrderPurchaseIndicator: [PreOrderPurchaseIndicator](../-pre-order-purchase-indicator/index)?, shipIndicator: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, pickUpAddress: [PickUpAddress](../-pick-up-address/index)?, giftCardPurchase: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)?, reOrderPurchaseIndicator: [ReOrderPurchaseIndicator](../-re-order-purchase-indicator/index)?)  
More info  


"Raw" constructor. You must manually ensure you set the values for shipIndicator and pickUpAddress correctly. It is recommended to use the other constructor.

  



