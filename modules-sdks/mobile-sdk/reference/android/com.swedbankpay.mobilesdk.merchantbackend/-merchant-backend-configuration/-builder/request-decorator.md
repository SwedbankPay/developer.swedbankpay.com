---
title: requestDecorator
---
//[mobilesdk-merchantbackend](../../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../../index.html)/[MerchantBackendConfiguration](../index.html)/[Builder](index.html)/[requestDecorator](request-decorator.html)



# requestDecorator



[androidJvm]\
fun [requestDecorator](request-decorator.html)(requestDecorator: [RequestDecorator](../../-request-decorator/index.html)): [MerchantBackendConfiguration.Builder](index.html)



Sets a [RequestDecorator](../../-request-decorator/index.html) that adds custom headers to backend requests.



N.B! This object will can retained for an extended period, generally the lifetime of the process. Be careful not to inadvertently leak any resources this way. Be very careful if passing a (non-static) inner class instance here.



#### Return



this




