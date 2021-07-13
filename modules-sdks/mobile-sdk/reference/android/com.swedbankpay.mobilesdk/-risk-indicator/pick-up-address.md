---
title: pickUpAddress -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[RiskIndicator](index)/[pickUpAddress](pick-up-address)



# pickUpAddress  
[androidJvm]  
Content  
@SerializedName(value = pickUpAddress)  
  
val [pickUpAddress](pick-up-address): [PickUpAddress](../-pick-up-address/index)?  
More info  


If [shipIndicator](ship-indicator) is "04", i.e. [ShipIndicator.PICK_UP_AT_STORE](../-ship-indicator/-companion/-p-i-c-k_-u-p_-a-t_-s-t-o-r-e), this field should be populated.



You should use the constructor that takes a [ShipIndicator](../-ship-indicator/index) argument for shipIndicator, which also set sets this field properly.

  



