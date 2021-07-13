---
title: decorateAnyRequest -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[RequestDecorator](index)/[decorateAnyRequest](decorate-any-request)



# decorateAnyRequest  
[androidJvm]  
Content  
open suspend fun [decorateAnyRequest](decorate-any-request)(userHeaders: [UserHeaders](../-user-headers/index), method: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), url: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?)  
More info  


Override this method to add custom headers to all backend requests.



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateAnyRequest/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#kotlin.String#kotlin.String?/PointingToDeclaration/"></a>userHeaders| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateAnyRequest/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#kotlin.String#kotlin.String?/PointingToDeclaration/"></a><br><br>headers added to this will be sent with the request<br><br>|
| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateAnyRequest/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#kotlin.String#kotlin.String?/PointingToDeclaration/"></a>method| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateAnyRequest/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#kotlin.String#kotlin.String?/PointingToDeclaration/"></a><br><br>the HTTP method of the request<br><br>|
| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateAnyRequest/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#kotlin.String#kotlin.String?/PointingToDeclaration/"></a>url| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateAnyRequest/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#kotlin.String#kotlin.String?/PointingToDeclaration/"></a><br><br>the URL of the request<br><br>|
| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateAnyRequest/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#kotlin.String#kotlin.String?/PointingToDeclaration/"></a>body| <a name="com.swedbankpay.mobilesdk/RequestDecorator/decorateAnyRequest/#com.swedbankpay.mobilesdk.UserHeaders#kotlin.String#kotlin.String#kotlin.String?/PointingToDeclaration/"></a><br><br>the body of the request, if any<br><br>|
  
  



