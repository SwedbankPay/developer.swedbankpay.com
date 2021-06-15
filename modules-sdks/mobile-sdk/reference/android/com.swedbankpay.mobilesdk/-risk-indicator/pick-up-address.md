---
title: pickUpAddress
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[RiskIndicator](index.html)/[pickUpAddress](pick-up-address.html)



# pickUpAddress



[androidJvm]\




@SerializedName(value = "pickUpAddress")



val [pickUpAddress](pick-up-address.html): [PickUpAddress](../-pick-up-address/index.html)?



If [shipIndicator](ship-indicator.html) is "04", i.e. [ShipIndicator.PICK_UP_AT_STORE](../-ship-indicator/-companion/-p-i-c-k_-u-p_-a-t_-s-t-o-r-e.html), this field should be populated.



You should use the constructor that takes a [ShipIndicator](../-ship-indicator/index.html) argument for shipIndicator, which also set sets this field properly.




