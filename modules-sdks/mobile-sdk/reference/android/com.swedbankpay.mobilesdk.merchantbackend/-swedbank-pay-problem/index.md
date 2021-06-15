---
title: SwedbankPayProblem
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[SwedbankPayProblem](index.html)



# SwedbankPayProblem



[androidJvm]\
interface [SwedbankPayProblem](index.html)

A Problem defined by the Swedbank Pay backend. https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HProblems



## Properties


| Name | Summary |
|---|---|
| [action](action.html) | [androidJvm]<br>abstract val [action](action.html): [SwedbankPayAction](../index.html#853214653%2FClasslikes%2F1689614965)?<br>Suggested action to take to recover from the error. |
| [detail](detail.html) | [androidJvm]<br>abstract val [detail](detail.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>Human-readable details about the problem |
| [instance](instance.html) | [androidJvm]<br>abstract val [instance](instance.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>Swedbank Pay internal identifier of the problem. This may be useful in debugging the issue with Swedbank Pay support. |
| [problems](problems.html) | [androidJvm]<br>abstract val [problems](problems.html): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[SwedbankPaySubproblem](../-swedbank-pay-subproblem/index.html)&gt;<br>Array of problem detail objects |
| [raw](raw.html) | [androidJvm]<br>abstract val [raw](raw.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>The raw application/problem+json object. |
| [status](status.html) | [androidJvm]<br>abstract val [status](status.html): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)?<br>The HTTP status. |
| [title](title.html) | [androidJvm]<br>abstract val [title](title.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>Human-readable description of the problem |
| [type](type.html) | [androidJvm]<br>abstract val [type](type.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>RFC 7807 default property: a URI reference that identifies the problem type. |


## Inheritors


| Name |
|---|
| [SwedbankPay](../-merchant-backend-problem/-client/-swedbank-pay/index.html) |
| [SwedbankPay](../-merchant-backend-problem/-server/-swedbank-pay/index.html) |

