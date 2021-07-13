---
title: getConfiguration -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[PaymentFragment](index)/[getConfiguration](get-configuration)



# getConfiguration  
[androidJvm]  
Content  
open fun [getConfiguration](get-configuration)(): [Configuration](../-configuration/index)  
More info  


Provides the [Configuration](../-configuration/index) for this PaymentFragment.



The default implementation returns the value set in [defaultConfiguration](-companion/default-configuration), throwing an exception if it is not set. Override this method to choose the [Configuration](../-configuration/index) dynamically. Note, however, that this method is only called once for each PaymentFragment instance, namely in the [onCreate](on-create) method. This means that the Configuration of a given PaymentFragment instance cannot change once set.

  



