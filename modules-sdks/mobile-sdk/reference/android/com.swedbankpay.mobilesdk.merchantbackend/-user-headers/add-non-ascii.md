---
title: addNonAscii
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[UserHeaders](index.html)/[addNonAscii](add-non-ascii.html)



# addNonAscii



[androidJvm]\
fun [addNonAscii](add-non-ascii.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), value: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [UserHeaders](index.html)



Adds a header without validating the value.



The name still must not contain non-ASCII characters. However, the value can contain arbitrary characters.



N.B! The header value will be encoded in UTF-8. Be sure your backend expects this. Non-ASCII characters in headers are NOT valid in HTTP/1.1.



## Parameters


androidJvm

| | |
|---|---|
| name | the name of the header to add |
| value | the value of the header |



## Throws


| | |
|---|---|
| [kotlin.IllegalArgumentException](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-illegal-argument-exception/index.html) | if name is invalid |



