---
title: withHeaders
---
//[mobilesdk-merchantbackend](../../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../../index.html)/[RequestDecorator](../index.html)/[Companion](index.html)/[withHeaders](with-headers.html)



# withHeaders



[androidJvm]\




@[JvmStatic](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.jvm/-jvm-static/index.html)



fun [withHeaders](with-headers.html)(vararg namesAndValues: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [RequestDecorator](../index.html)



Create a RequestDecorator that attaches the specified headers to all SDK requests.



## Parameters


androidJvm

| | |
|---|---|
| namesAndValues | the header names and values, alternating |





[androidJvm]\




@[JvmStatic](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.jvm/-jvm-static/index.html)



fun [withHeaders](with-headers.html)(headers: [Map](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;): [RequestDecorator](../index.html)



Create a RequestDecorator that attaches the specified headers to all SDK requests.



## Parameters


androidJvm

| | |
|---|---|
| headers | map of header names to corresponding values |




