---
title: set
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[UserHeaders](index.html)/[set](set.html)



# set



[androidJvm]\
fun [set](set.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), value: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [UserHeaders](index.html)



Sets a header in the request.



The name and value must not contain non-ASCII characters.



If a header with the same name has not been [add](add.html)ed or [set](set.html), this functions identically to [add](add.html). Otherwise the new value will replace any previous value.



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
fun [set](set.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), value: [Date](https://developer.android.com/reference/kotlin/java/util/Date.html)): [UserHeaders](index.html)



Sets a header in the request.



The name must not contain non-ASCII characters. The value will be formatted as a http date [https://tools.ietf.org/html/rfc7231#section-7.1.1.2](https://tools.ietf.org/html/rfc7231#section-7.1.1.2)



If a header with the same name has not been [add](add.html)ed or [set](set.html), this functions identically to [add](add.html). Otherwise the new value will replace any previous value.



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



