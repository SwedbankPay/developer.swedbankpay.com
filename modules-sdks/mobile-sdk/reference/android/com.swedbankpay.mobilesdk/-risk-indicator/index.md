---
title: RiskIndicator -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[RiskIndicator](index)



# RiskIndicator  
 [androidJvm] data class [RiskIndicator](index)(**deliveryEmailAddress**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **deliveryTimeFrameIndicator**: [DeliveryTimeFrameIndicator](../-delivery-time-frame-indicator/index)?, **preOrderDate**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **preOrderPurchaseIndicator**: [PreOrderPurchaseIndicator](../-pre-order-purchase-indicator/index)?, **shipIndicator**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **pickUpAddress**: [PickUpAddress](../-pick-up-address/index)?, **giftCardPurchase**: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)?, **reOrderPurchaseIndicator**: [ReOrderPurchaseIndicator](../-re-order-purchase-indicator/index)?) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

Optional information to reduce the risk factor of a payment.



You should populate this data as completely as possible to decrease the likelihood of 3-D Secure Strong Authentication.

   


## Constructors  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#com.swedbankpay.mobilesdk.ShipIndicator?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a>[RiskIndicator](-risk-indicator)| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#com.swedbankpay.mobilesdk.ShipIndicator?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a> [androidJvm] fun [RiskIndicator](-risk-indicator)(deliveryEmailAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, deliveryTimeFrameIndicator: [DeliveryTimeFrameIndicator](../-delivery-time-frame-indicator/index)? = null, preOrderDate: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, preOrderPurchaseIndicator: [PreOrderPurchaseIndicator](../-pre-order-purchase-indicator/index)? = null, shipIndicator: [ShipIndicator](../-ship-indicator/index)? = null, giftCardPurchase: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)? = null, reOrderPurchaseIndicator: [ReOrderPurchaseIndicator](../-re-order-purchase-indicator/index)? = null)Constructs a RiskIndicator with Kotlin-native value for shipIndicator   <br>|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PickUpAddress?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a>[RiskIndicator](-risk-indicator)| <a name="com.swedbankpay.mobilesdk/RiskIndicator/RiskIndicator/#kotlin.String?#com.swedbankpay.mobilesdk.DeliveryTimeFrameIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PreOrderPurchaseIndicator?#kotlin.String?#com.swedbankpay.mobilesdk.PickUpAddress?#kotlin.Boolean?#com.swedbankpay.mobilesdk.ReOrderPurchaseIndicator?/PointingToDeclaration/"></a> [androidJvm] fun [RiskIndicator](-risk-indicator)(deliveryEmailAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, deliveryTimeFrameIndicator: [DeliveryTimeFrameIndicator](../-delivery-time-frame-indicator/index)?, preOrderDate: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, preOrderPurchaseIndicator: [PreOrderPurchaseIndicator](../-pre-order-purchase-indicator/index)?, shipIndicator: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, pickUpAddress: [PickUpAddress](../-pick-up-address/index)?, giftCardPurchase: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)?, reOrderPurchaseIndicator: [ReOrderPurchaseIndicator](../-re-order-purchase-indicator/index)?)"Raw" constructor.   <br>|


## Types  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator.Builder///PointingToDeclaration/"></a>[Builder](-builder/index)| <a name="com.swedbankpay.mobilesdk/RiskIndicator.Builder///PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>class [Builder](-builder/index)  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator.Companion///PointingToDeclaration/"></a>[Companion](-companion/index)| <a name="com.swedbankpay.mobilesdk/RiskIndicator.Companion///PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>object [Companion](-companion/index)  <br><br><br>|


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[describeContents](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [describeContents](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)  <br><br><br>|
| <a name="android.os/Parcelable/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[writeToParcel](../-view-payment-order-info/index.md#-1754457655%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [writeToParcel](../-view-payment-order-info/index.md#-1754457655%2FFunctions%2F-1404661416)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html))  <br><br><br>|


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/deliveryEmailAddress/#/PointingToDeclaration/"></a>[deliveryEmailAddress](delivery-email-address)| <a name="com.swedbankpay.mobilesdk/RiskIndicator/deliveryEmailAddress/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = deliveryEmailAddress)  <br>  <br>val [deliveryEmailAddress](delivery-email-address): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?For electronic delivery, the e-mail address where the merchandise is delivered   <br>|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/deliveryTimeFrameIndicator/#/PointingToDeclaration/"></a>[deliveryTimeFrameIndicator](delivery-time-frame-indicator)| <a name="com.swedbankpay.mobilesdk/RiskIndicator/deliveryTimeFrameIndicator/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = deliveryTimeFrameIndicator)  <br>  <br>val [deliveryTimeFrameIndicator](delivery-time-frame-indicator): [DeliveryTimeFrameIndicator](../-delivery-time-frame-indicator/index)?Indicator of merchandise delivery timeframe.   <br>|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/giftCardPurchase/#/PointingToDeclaration/"></a>[giftCardPurchase](gift-card-purchase)| <a name="com.swedbankpay.mobilesdk/RiskIndicator/giftCardPurchase/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = giftCardPurchase)  <br>  <br>val [giftCardPurchase](gift-card-purchase): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)?true if this is a purchase of a gift card   <br>|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/pickUpAddress/#/PointingToDeclaration/"></a>[pickUpAddress](pick-up-address)| <a name="com.swedbankpay.mobilesdk/RiskIndicator/pickUpAddress/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = pickUpAddress)  <br>  <br>val [pickUpAddress](pick-up-address): [PickUpAddress](../-pick-up-address/index)?If [shipIndicator](ship-indicator) is "04", i.e.   <br>|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/preOrderDate/#/PointingToDeclaration/"></a>[preOrderDate](pre-order-date)| <a name="com.swedbankpay.mobilesdk/RiskIndicator/preOrderDate/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = preOrderDate)  <br>  <br>val [preOrderDate](pre-order-date): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?If this is a pre-order, the expected date that the merchandise will be available on.   <br>|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/preOrderPurchaseIndicator/#/PointingToDeclaration/"></a>[preOrderPurchaseIndicator](pre-order-purchase-indicator)| <a name="com.swedbankpay.mobilesdk/RiskIndicator/preOrderPurchaseIndicator/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = preOrderPurchaseIndicator)  <br>  <br>val [preOrderPurchaseIndicator](pre-order-purchase-indicator): [PreOrderPurchaseIndicator](../-pre-order-purchase-indicator/index)?Indicates whether this is a pre-order.   <br>|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/reOrderPurchaseIndicator/#/PointingToDeclaration/"></a>[reOrderPurchaseIndicator](re-order-purchase-indicator)| <a name="com.swedbankpay.mobilesdk/RiskIndicator/reOrderPurchaseIndicator/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = reOrderPurchaseIndicator)  <br>  <br>val [reOrderPurchaseIndicator](re-order-purchase-indicator): [ReOrderPurchaseIndicator](../-re-order-purchase-indicator/index)?Indicates whether this is a re-order of previously purchased merchandise.   <br>|
| <a name="com.swedbankpay.mobilesdk/RiskIndicator/shipIndicator/#/PointingToDeclaration/"></a>[shipIndicator](ship-indicator)| <a name="com.swedbankpay.mobilesdk/RiskIndicator/shipIndicator/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = shipIndicator)  <br>  <br>val [shipIndicator](ship-indicator): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?Indicates the shipping method for this order.   <br>|

