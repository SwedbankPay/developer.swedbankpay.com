---
title: requestDecorator -
---
//[sdk](../../../../index)/[com.swedbankpay.mobilesdk.merchantbackend](../../index)/[MerchantBackendConfiguration](../index)/[Builder](index)/[requestDecorator](request-decorator)



# requestDecorator  
[androidJvm]  
Content  
fun [requestDecorator](request-decorator)(requestDecorator: [RequestDecorator](../../../com.swedbankpay.mobilesdk/-request-decorator/index)): [MerchantBackendConfiguration.Builder](index)  
More info  


Sets a [RequestDecorator](../../../com.swedbankpay.mobilesdk/-request-decorator/index) that adds custom headers to backend requests.



N.B! This object will can retained for an extended period, generally the lifetime of the process. Be careful not to inadvertently leak any resources this way. Be very careful if passing a (non-static) inner class instance here.



#### Return  


this

  



