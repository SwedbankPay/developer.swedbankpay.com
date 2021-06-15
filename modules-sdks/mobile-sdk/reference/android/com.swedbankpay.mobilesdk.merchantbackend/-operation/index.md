---
title: Operation
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[Operation](index.html)



# Operation



[androidJvm]\
data class [Operation](index.html)(rel: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, method: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, href: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, contentType: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?)

Swedbank Pay Operation. Operations are invoked by making an HTTP request.



Please refer to the [Swedbank Pay documentation](https://developer.swedbankpay.com/checkout/other-features#operations).



## Constructors


| | |
|---|---|
| [Operation](-operation.html) | [androidJvm]<br>fun [Operation](-operation.html)(rel: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, method: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, href: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, contentType: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?) |


## Properties


| Name | Summary |
|---|---|
| [contentType](content-type.html) | [androidJvm]<br>val [contentType](content-type.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>The Content-Type of the response |
| [href](href.html) | [androidJvm]<br>val [href](href.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>The request URL |
| [method](method.html) | [androidJvm]<br>val [method](method.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>The request method |
| [rel](rel.html) | [androidJvm]<br>val [rel](rel.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>The purpose of the operation. The exact meaning is dependent on the Operation context. |

