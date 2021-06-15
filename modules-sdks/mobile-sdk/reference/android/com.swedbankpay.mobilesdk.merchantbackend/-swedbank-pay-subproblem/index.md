---
title: SwedbankPaySubproblem
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[SwedbankPaySubproblem](index.html)



# SwedbankPaySubproblem



[androidJvm]\
data class [SwedbankPaySubproblem](index.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, description: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?) : [Serializable](https://developer.android.com/reference/kotlin/java/io/Serializable.html)

Object detailing the reason for a [SwedbankPayProblem](../-swedbank-pay-problem/index.html).



See https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HProblems.



## Constructors


| | |
|---|---|
| [SwedbankPaySubproblem](-swedbank-pay-subproblem.html) | [androidJvm]<br>fun [SwedbankPaySubproblem](-swedbank-pay-subproblem.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, description: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?) |


## Properties


| Name | Summary |
|---|---|
| [description](description.html) | [androidJvm]<br>val [description](description.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>A description of what was wrong |
| [name](name.html) | [androidJvm]<br>val [name](name.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>Name of the erroneous part of the request |

