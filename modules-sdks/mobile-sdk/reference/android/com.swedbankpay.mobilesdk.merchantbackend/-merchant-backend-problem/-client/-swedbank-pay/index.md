---
title: SwedbankPay
---
//[mobilesdk-merchantbackend](../../../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../../../index.html)/[MerchantBackendProblem](../../index.html)/[Client](../index.html)/[SwedbankPay](index.html)



# SwedbankPay



[androidJvm]\
sealed class [SwedbankPay](index.html) : [MerchantBackendProblem.Client](../index.html), [SwedbankPayProblem](../../../-swedbank-pay-problem/index.html)

Base class for [Client](../index.html) problems defined by the Swedbank Pay backend. https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HProblems



## Types


| Name | Summary |
|---|---|
| [Forbidden](-forbidden/index.html) | [androidJvm]<br>class [Forbidden](-forbidden/index.html)(jsonObject: JsonObject) : [MerchantBackendProblem.Client.SwedbankPay](index.html)<br>The request was understood, but the service is refusing to fulfill it. You may not have access to the requested resource. |
| [InputError](-input-error/index.html) | [androidJvm]<br>class [InputError](-input-error/index.html)(jsonObject: JsonObject) : [MerchantBackendProblem.Client.SwedbankPay](index.html)<br>The request could not be handled because the request was malformed somehow (e.g. an invalid field value) |
| [NotFound](-not-found/index.html) | [androidJvm]<br>class [NotFound](-not-found/index.html)(jsonObject: JsonObject) : [MerchantBackendProblem.Client.SwedbankPay](index.html)<br>The requested resource was not found. |


## Functions


| Name | Summary |
|---|---|
| [equals](../../-server/-unknown/index.html#317480221%2FFunctions%2F1689614965) | [androidJvm]<br>open operator override fun [equals](../../-server/-unknown/index.html#317480221%2FFunctions%2F1689614965)(other: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) |
| [hashCode](../../-server/-unknown/index.html#-2097273047%2FFunctions%2F1689614965) | [androidJvm]<br>open override fun [hashCode](../../-server/-unknown/index.html#-2097273047%2FFunctions%2F1689614965)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [toString](../../-server/-unknown/index.html#2019528184%2FFunctions%2F1689614965) | [androidJvm]<br>open override fun [toString](../../-server/-unknown/index.html#2019528184%2FFunctions%2F1689614965)(): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [writeToParcel](../../write-to-parcel.html) | [androidJvm]<br>open override fun [writeToParcel](../../write-to-parcel.html)(parcel: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), flags: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [action](action.html) | [androidJvm]<br>open override val [action](action.html): [SwedbankPayAction](../../../index.html#853214653%2FClasslikes%2F1689614965)?<br>Suggested action to take to recover from the error. |
| [detail](../../-server/-unknown/index.html#1929994611%2FProperties%2F1689614965) | [androidJvm]<br>val [detail](../../-server/-unknown/index.html#1929994611%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [instance](../../-server/-unknown/index.html#-1600398353%2FProperties%2F1689614965) | [androidJvm]<br>val [instance](../../-server/-unknown/index.html#-1600398353%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [jsonObject](../../-server/-unknown/index.html#301072573%2FProperties%2F1689614965) | [androidJvm]<br>val [jsonObject](../../-server/-unknown/index.html#301072573%2FProperties%2F1689614965): JsonObject |
| [problems](problems.html) | [androidJvm]<br>open override val [problems](problems.html): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[SwedbankPaySubproblem](../../../-swedbank-pay-subproblem/index.html)&gt;<br>Array of problem detail objects |
| [raw](../../-server/-unknown/index.html#1423991054%2FProperties%2F1689614965) | [androidJvm]<br>val [raw](../../-server/-unknown/index.html#1423991054%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [status](../../-server/-unknown/index.html#1109315826%2FProperties%2F1689614965) | [androidJvm]<br>val [status](../../-server/-unknown/index.html#1109315826%2FProperties%2F1689614965): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)? |
| [title](../../-server/-unknown/index.html#402428574%2FProperties%2F1689614965) | [androidJvm]<br>val [title](../../-server/-unknown/index.html#402428574%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [type](../../-server/-unknown/index.html#-542810006%2FProperties%2F1689614965) | [androidJvm]<br>val [type](../../-server/-unknown/index.html#-542810006%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |


## Inheritors


| Name |
|---|
| [InputError](-input-error/index.html) |
| [Forbidden](-forbidden/index.html) |
| [NotFound](-not-found/index.html) |

