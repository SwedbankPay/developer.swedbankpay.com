---
title: add
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[UserHeaders](index.html)/[add](add.html)



# add



[androidJvm]\
fun [add](add.html)(headerLine: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [UserHeaders](index.html)



Adds a header line to the request.



The header line must be a valid http header line, i.e. it must have the format "Name:Value", and it must not contain non-ASCII characters.



## Parameters


androidJvm

| | |
|---|---|
| headerLine | the header line to add to the request |



## Throws


| | |
|---|---|
| [kotlin.IllegalArgumentException](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-illegal-argument-exception/index.html) | if headerLine is invalid |




[androidJvm]\
fun [add](add.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), value: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [UserHeaders](index.html)



Adds a header to the request.



The name and value must not contain non-ASCII characters.



## Parameters


androidJvm

| | |
|---|---|
| name | the name of the header to add |
| value | the value of the header |



## Throws


| | |
|---|---|
| [kotlin.IllegalArgumentException](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-illegal-argument-exception/index.html) | if name or value is invalid |




[androidJvm]\
fun [add](add.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), value: [Date](https://developer.android.com/reference/kotlin/java/util/Date.html)): [UserHeaders](index.html)



Adds a header to the request.



The name must not contain non-ASCII characters. The value will be formatted as a http date [https://tools.ietf.org/html/rfc7231#section-7.1.1.2](https://tools.ietf.org/html/rfc7231#section-7.1.1.2)



## Parameters


androidJvm

| | |
|---|---|
| name | the name of the header to add |
| value | the value of the header |



## Throws


| | |
|---|---|
| [kotlin.IllegalArgumentException](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-illegal-argument-exception/index.html) | if name or value is invalid |



