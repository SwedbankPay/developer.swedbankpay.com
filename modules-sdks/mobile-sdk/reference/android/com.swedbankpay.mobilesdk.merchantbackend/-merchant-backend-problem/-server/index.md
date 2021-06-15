---
title: Server
---
//[mobilesdk-merchantbackend](../../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../../index.html)/[MerchantBackendProblem](../index.html)/[Server](index.html)



# Server



[androidJvm]\
sealed class [Server](index.html) : [MerchantBackendProblem](../index.html)

Base class for [Problems](../index.html) caused by the service backend.



Any unexpected response where the HTTP status is outside 400-499 results in a Server Problem; usually it means the status was in 500-599.



## Types


| Name | Summary |
|---|---|
| [Companion](-companion/index.html) | [androidJvm]<br>object [Companion](-companion/index.html) |
| [MobileSDK](-mobile-s-d-k/index.html) | [androidJvm]<br>sealed class [MobileSDK](-mobile-s-d-k/index.html) : [MerchantBackendProblem.Server](index.html)<br>Base class for [Server](index.html) Problems defined by the example backend. |
| [SwedbankPay](-swedbank-pay/index.html) | [androidJvm]<br>sealed class [SwedbankPay](-swedbank-pay/index.html) : [MerchantBackendProblem.Server](index.html), [SwedbankPayProblem](../../-swedbank-pay-problem/index.html)<br>Base class for [Server](index.html) problems defined by the Swedbank Pay backend. https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HProblems |
| [Unknown](-unknown/index.html) | [androidJvm]<br>class [Unknown](-unknown/index.html)(jsonObject: JsonObject) : [MerchantBackendProblem.Server](index.html)<br>[Server](index.html) problem with an unrecognized type. |


## Functions


| Name | Summary |
|---|---|
| [equals](-unknown/index.html#317480221%2FFunctions%2F1689614965) | [androidJvm]<br>open operator override fun [equals](-unknown/index.html#317480221%2FFunctions%2F1689614965)(other: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) |
| [hashCode](-unknown/index.html#-2097273047%2FFunctions%2F1689614965) | [androidJvm]<br>open override fun [hashCode](-unknown/index.html#-2097273047%2FFunctions%2F1689614965)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [toString](-unknown/index.html#2019528184%2FFunctions%2F1689614965) | [androidJvm]<br>open override fun [toString](-unknown/index.html#2019528184%2FFunctions%2F1689614965)(): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [writeToParcel](../write-to-parcel.html) | [androidJvm]<br>open override fun [writeToParcel](../write-to-parcel.html)(parcel: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), flags: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [detail](-unknown/index.html#1929994611%2FProperties%2F1689614965) | [androidJvm]<br>val [detail](-unknown/index.html#1929994611%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [instance](-unknown/index.html#-1600398353%2FProperties%2F1689614965) | [androidJvm]<br>val [instance](-unknown/index.html#-1600398353%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [jsonObject](-unknown/index.html#301072573%2FProperties%2F1689614965) | [androidJvm]<br>val [jsonObject](-unknown/index.html#301072573%2FProperties%2F1689614965): JsonObject |
| [raw](-unknown/index.html#1423991054%2FProperties%2F1689614965) | [androidJvm]<br>val [raw](-unknown/index.html#1423991054%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [status](-unknown/index.html#1109315826%2FProperties%2F1689614965) | [androidJvm]<br>val [status](-unknown/index.html#1109315826%2FProperties%2F1689614965): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)? |
| [title](-unknown/index.html#402428574%2FProperties%2F1689614965) | [androidJvm]<br>val [title](-unknown/index.html#402428574%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [type](-unknown/index.html#-542810006%2FProperties%2F1689614965) | [androidJvm]<br>val [type](-unknown/index.html#-542810006%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |


## Inheritors


| Name |
|---|
| [MobileSDK](-mobile-s-d-k/index.html) |
| [SwedbankPay](-swedbank-pay/index.html) |
| [Unknown](-unknown/index.html) |

