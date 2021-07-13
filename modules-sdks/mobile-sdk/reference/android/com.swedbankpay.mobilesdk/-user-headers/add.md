---
title: add -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[UserHeaders](index)/[add](add)



# add  
[androidJvm]  
Content  
fun [add](add)(headerLine: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [UserHeaders](index)  
More info  


Adds a header line to the request.



The header line must be a valid http header line, i.e. it must have the format "Name:Value", and it must not contain non-ASCII characters.



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String/PointingToDeclaration/"></a>headerLine| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String/PointingToDeclaration/"></a><br><br>the header line to add to the request<br><br>|
  


#### Throws  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String/PointingToDeclaration/"></a>[kotlin.IllegalArgumentException](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-illegal-argument-exception/index.html)| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String/PointingToDeclaration/"></a><br><br>if headerLine is invalid<br><br>|
  


[androidJvm]  
Content  
fun [add](add)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), value: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [UserHeaders](index)  
More info  


Adds a header to the request.



The name and value must not contain non-ASCII characters.



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String#kotlin.String/PointingToDeclaration/"></a>name| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String#kotlin.String/PointingToDeclaration/"></a><br><br>the name of the header to add<br><br>|
| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String#kotlin.String/PointingToDeclaration/"></a>value| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String#kotlin.String/PointingToDeclaration/"></a><br><br>the value of the header<br><br>|
  


#### Throws  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String#kotlin.String/PointingToDeclaration/"></a>[kotlin.IllegalArgumentException](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-illegal-argument-exception/index.html)| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String#kotlin.String/PointingToDeclaration/"></a><br><br>if name or value is invalid<br><br>|
  


[androidJvm]  
Content  
fun [add](add)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), value: [Date](https://developer.android.com/reference/kotlin/java/util/Date.html)): [UserHeaders](index)  
More info  


Adds a header to the request.



The name must not contain non-ASCII characters. The value will be formatted as a http date [https://tools.ietf.org/html/rfc7231#section-7.1.1.2](https://tools.ietf.org/html/rfc7231#section-7.1.1.2)



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String#java.util.Date/PointingToDeclaration/"></a>name| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String#java.util.Date/PointingToDeclaration/"></a><br><br>the name of the header to add<br><br>|
| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String#java.util.Date/PointingToDeclaration/"></a>value| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String#java.util.Date/PointingToDeclaration/"></a><br><br>the value of the header<br><br>|
  


#### Throws  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String#java.util.Date/PointingToDeclaration/"></a>[kotlin.IllegalArgumentException](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-illegal-argument-exception/index.html)| <a name="com.swedbankpay.mobilesdk/UserHeaders/add/#kotlin.String#java.util.Date/PointingToDeclaration/"></a><br><br>if name or value is invalid<br><br>|
  



