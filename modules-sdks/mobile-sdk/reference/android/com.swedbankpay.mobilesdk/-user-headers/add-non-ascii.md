---
title: addNonAscii -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[UserHeaders](index)/[addNonAscii](add-non-ascii)



# addNonAscii  
[androidJvm]  
Content  
fun [addNonAscii](add-non-ascii)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), value: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [UserHeaders](index)  
More info  


Adds a header without validating the value.



The name still must not contain non-ASCII characters. However, the value can contain arbitrary characters.



N.B! The header value will be encoded in UTF-8. Be sure your backend expects this. Non-ASCII characters in headers are NOT valid in HTTP/1.1.



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/UserHeaders/addNonAscii/#kotlin.String#kotlin.String/PointingToDeclaration/"></a>name| <a name="com.swedbankpay.mobilesdk/UserHeaders/addNonAscii/#kotlin.String#kotlin.String/PointingToDeclaration/"></a><br><br>the name of the header to add<br><br>|
| <a name="com.swedbankpay.mobilesdk/UserHeaders/addNonAscii/#kotlin.String#kotlin.String/PointingToDeclaration/"></a>value| <a name="com.swedbankpay.mobilesdk/UserHeaders/addNonAscii/#kotlin.String#kotlin.String/PointingToDeclaration/"></a><br><br>the value of the header<br><br>|
  


#### Throws  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/UserHeaders/addNonAscii/#kotlin.String#kotlin.String/PointingToDeclaration/"></a>[kotlin.IllegalArgumentException](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-illegal-argument-exception/index.html)| <a name="com.swedbankpay.mobilesdk/UserHeaders/addNonAscii/#kotlin.String#kotlin.String/PointingToDeclaration/"></a><br><br>if name is invalid<br><br>|
  



