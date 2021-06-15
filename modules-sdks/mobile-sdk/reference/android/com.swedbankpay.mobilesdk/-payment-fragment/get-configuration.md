---
title: getConfiguration
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentFragment](index.html)/[getConfiguration](get-configuration.html)



# getConfiguration



[androidJvm]\
open fun [getConfiguration](get-configuration.html)(): [Configuration](../-configuration/index.html)



Provides the [Configuration](../-configuration/index.html) for this PaymentFragment.



The default implementation returns the value set in [defaultConfiguration](-companion/default-configuration.html), throwing an exception if it is not set. Override this method to choose the [Configuration](../-configuration/index.html) dynamically. Note, however, that this method is only called once for each PaymentFragment instance, namely in the [onCreate](on-create.html) method. This means that the Configuration of a given PaymentFragment instance cannot change once set.




