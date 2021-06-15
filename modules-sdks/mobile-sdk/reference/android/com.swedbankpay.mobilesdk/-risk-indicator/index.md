---
title: RiskIndicator
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[RiskIndicator](index.html)



# RiskIndicator



[androidJvm]\
data class [RiskIndicator](index.html)(deliveryEmailAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, deliveryTimeFrameIndicator: [DeliveryTimeFrameIndicator](../-delivery-time-frame-indicator/index.html)?, preOrderDate: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, preOrderPurchaseIndicator: [PreOrderPurchaseIndicator](../-pre-order-purchase-indicator/index.html)?, shipIndicator: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, pickUpAddress: [PickUpAddress](../-pick-up-address/index.html)?, giftCardPurchase: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)?, reOrderPurchaseIndicator: [ReOrderPurchaseIndicator](../-re-order-purchase-indicator/index.html)?) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

Optional information to reduce the risk factor of a payment.



You should populate this data as completely as possible to decrease the likelihood of 3-D Secure Strong Authentication.



## Constructors


| | |
|---|---|
| [RiskIndicator](-risk-indicator.html) | [androidJvm]<br>fun [RiskIndicator](-risk-indicator.html)(deliveryEmailAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, deliveryTimeFrameIndicator: [DeliveryTimeFrameIndicator](../-delivery-time-frame-indicator/index.html)? = null, preOrderDate: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, preOrderPurchaseIndicator: [PreOrderPurchaseIndicator](../-pre-order-purchase-indicator/index.html)? = null, shipIndicator: [ShipIndicator](../-ship-indicator/index.html)? = null, giftCardPurchase: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)? = null, reOrderPurchaseIndicator: [ReOrderPurchaseIndicator](../-re-order-purchase-indicator/index.html)? = null)<br>Constructs a RiskIndicator with Kotlin-native value for shipIndicator |
| [RiskIndicator](-risk-indicator.html) | [androidJvm]<br>fun [RiskIndicator](-risk-indicator.html)(deliveryEmailAddress: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, deliveryTimeFrameIndicator: [DeliveryTimeFrameIndicator](../-delivery-time-frame-indicator/index.html)?, preOrderDate: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, preOrderPurchaseIndicator: [PreOrderPurchaseIndicator](../-pre-order-purchase-indicator/index.html)?, shipIndicator: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, pickUpAddress: [PickUpAddress](../-pick-up-address/index.html)?, giftCardPurchase: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)?, reOrderPurchaseIndicator: [ReOrderPurchaseIndicator](../-re-order-purchase-indicator/index.html)?)<br>"Raw" constructor. You must manually ensure you set the values for shipIndicator and pickUpAddress correctly. It is recommended to use the other constructor. |


## Types


| Name | Summary |
|---|---|
| [Builder](-builder/index.html) | [androidJvm]<br>class [Builder](-builder/index.html) |
| [Companion](-companion/index.html) | [androidJvm]<br>object [Companion](-companion/index.html) |


## Functions


| Name | Summary |
|---|---|
| [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [deliveryEmailAddress](delivery-email-address.html) | [androidJvm]<br>@SerializedName(value = "deliveryEmailAddress")<br>val [deliveryEmailAddress](delivery-email-address.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>For electronic delivery, the e-mail address where the merchandise is delivered |
| [deliveryTimeFrameIndicator](delivery-time-frame-indicator.html) | [androidJvm]<br>@SerializedName(value = "deliveryTimeFrameIndicator")<br>val [deliveryTimeFrameIndicator](delivery-time-frame-indicator.html): [DeliveryTimeFrameIndicator](../-delivery-time-frame-indicator/index.html)?<br>Indicator of merchandise delivery timeframe. See [DeliveryTimeFrameIndicator](../-delivery-time-frame-indicator/index.html) for options. |
| [giftCardPurchase](gift-card-purchase.html) | [androidJvm]<br>@SerializedName(value = "giftCardPurchase")<br>val [giftCardPurchase](gift-card-purchase.html): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)?<br>true if this is a purchase of a gift card |
| [pickUpAddress](pick-up-address.html) | [androidJvm]<br>@SerializedName(value = "pickUpAddress")<br>val [pickUpAddress](pick-up-address.html): [PickUpAddress](../-pick-up-address/index.html)?<br>If [shipIndicator](ship-indicator.html) is "04", i.e. [ShipIndicator.PICK_UP_AT_STORE](../-ship-indicator/-companion/-p-i-c-k_-u-p_-a-t_-s-t-o-r-e.html), this field should be populated. |
| [preOrderDate](pre-order-date.html) | [androidJvm]<br>@SerializedName(value = "preOrderDate")<br>val [preOrderDate](pre-order-date.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>If this is a pre-order, the expected date that the merchandise will be available on. |
| [preOrderPurchaseIndicator](pre-order-purchase-indicator.html) | [androidJvm]<br>@SerializedName(value = "preOrderPurchaseIndicator")<br>val [preOrderPurchaseIndicator](pre-order-purchase-indicator.html): [PreOrderPurchaseIndicator](../-pre-order-purchase-indicator/index.html)?<br>Indicates whether this is a pre-order. See [PreOrderPurchaseIndicator](../-pre-order-purchase-indicator/index.html) for options. |
| [reOrderPurchaseIndicator](re-order-purchase-indicator.html) | [androidJvm]<br>@SerializedName(value = "reOrderPurchaseIndicator")<br>val [reOrderPurchaseIndicator](re-order-purchase-indicator.html): [ReOrderPurchaseIndicator](../-re-order-purchase-indicator/index.html)?<br>Indicates whether this is a re-order of previously purchased merchandise. See [ReOrderPurchaseIndicator](../-re-order-purchase-indicator/index.html) for options. |
| [shipIndicator](ship-indicator.html) | [androidJvm]<br>@SerializedName(value = "shipIndicator")<br>val [shipIndicator](ship-indicator.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>Indicates the shipping method for this order. |

