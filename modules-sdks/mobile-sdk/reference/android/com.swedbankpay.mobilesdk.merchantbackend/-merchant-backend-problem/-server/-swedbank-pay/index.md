---
title: SwedbankPay
---
//[mobilesdk-merchantbackend](../../../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../../../index.html)/[MerchantBackendProblem](../../index.html)/[Server](../index.html)/[SwedbankPay](index.html)



# SwedbankPay



[androidJvm]\
sealed class [SwedbankPay](index.html) : [MerchantBackendProblem.Server](../index.html), [SwedbankPayProblem](../../../-swedbank-pay-problem/index.html)

Base class for [Server](../index.html) problems defined by the Swedbank Pay backend. https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HProblems



## Types


| Name | Summary |
|---|---|
| [ConfigurationError](-configuration-error/index.html) | [androidJvm]<br>class [ConfigurationError](-configuration-error/index.html)(jsonObject: JsonObject) : [MerchantBackendProblem.Server.SwedbankPay](index.html)<br>There is a problem with your merchant configuration. |
| [SystemError](-system-error/index.html) | [androidJvm]<br>class [SystemError](-system-error/index.html)(jsonObject: JsonObject) : [MerchantBackendProblem.Server.SwedbankPay](index.html)<br>General internal error in Swedbank Pay systems. |


## Functions


| Name | Summary |
|---|---|
| [equals](../-unknown/index.html#317480221%2FFunctions%2F1689614965) | [androidJvm]<br>open operator override fun [equals](../-unknown/index.html#317480221%2FFunctions%2F1689614965)(other: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) |
| [hashCode](../-unknown/index.html#-2097273047%2FFunctions%2F1689614965) | [androidJvm]<br>open override fun [hashCode](../-unknown/index.html#-2097273047%2FFunctions%2F1689614965)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [toString](../-unknown/index.html#2019528184%2FFunctions%2F1689614965) | [androidJvm]<br>open override fun [toString](../-unknown/index.html#2019528184%2FFunctions%2F1689614965)(): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [writeToParcel](../../write-to-parcel.html) | [androidJvm]<br>open override fun [writeToParcel](../../write-to-parcel.html)(parcel: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), flags: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [action](action.html) | [androidJvm]<br>open override val [action](action.html): [SwedbankPayAction](../../../index.html#853214653%2FClasslikes%2F1689614965)?<br>Suggested action to take to recover from the error. |
| [detail](../-unknown/index.html#1929994611%2FProperties%2F1689614965) | [androidJvm]<br>val [detail](../-unknown/index.html#1929994611%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [instance](../-unknown/index.html#-1600398353%2FProperties%2F1689614965) | [androidJvm]<br>val [instance](../-unknown/index.html#-1600398353%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [jsonObject](../-unknown/index.html#301072573%2FProperties%2F1689614965) | [androidJvm]<br>val [jsonObject](../-unknown/index.html#301072573%2FProperties%2F1689614965): JsonObject |
| [problems](problems.html) | [androidJvm]<br>open override val [problems](problems.html): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[SwedbankPaySubproblem](../../../-swedbank-pay-subproblem/index.html)&gt;<br>Array of problem detail objects |
| [raw](../-unknown/index.html#1423991054%2FProperties%2F1689614965) | [androidJvm]<br>val [raw](../-unknown/index.html#1423991054%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [status](../-unknown/index.html#1109315826%2FProperties%2F1689614965) | [androidJvm]<br>val [status](../-unknown/index.html#1109315826%2FProperties%2F1689614965): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)? |
| [title](../-unknown/index.html#402428574%2FProperties%2F1689614965) | [androidJvm]<br>val [title](../-unknown/index.html#402428574%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [type](../-unknown/index.html#-542810006%2FProperties%2F1689614965) | [androidJvm]<br>val [type](../-unknown/index.html#-542810006%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |


## Inheritors


| Name |
|---|
| [SystemError](-system-error/index.html) |
| [ConfigurationError](-configuration-error/index.html) |

