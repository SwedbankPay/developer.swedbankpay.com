---
title: PaymentTokenInfo
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[PaymentTokenInfo](index.html)



# PaymentTokenInfo



[androidJvm]\
data class [PaymentTokenInfo](index.html)

A payment token and associated information.



## Properties


| Name | Summary |
|---|---|
| [instrument](instrument.html) | [androidJvm]<br>val [instrument](instrument.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>Payment instrument type of this token |
| [instrumentDisplayName](instrument-display-name.html) | [androidJvm]<br>val [instrumentDisplayName](instrument-display-name.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>User-friendly name of the payment instrument |
| [instrumentParameters](instrument-parameters.html) | [androidJvm]<br>val [instrumentParameters](instrument-parameters.html): [Map](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;?<br>Instrument-specific parameters. |
| [operations](operations.html) | [androidJvm]<br>val [operations](operations.html): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[Operation](../-operation/index.html)&gt;<br>Operations you can perform on this token. Note that you generally cannot call these from your mobile app. |
| [paymentToken](payment-token.html) | [androidJvm]<br>val [paymentToken](payment-token.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>The actual paymentToken |

