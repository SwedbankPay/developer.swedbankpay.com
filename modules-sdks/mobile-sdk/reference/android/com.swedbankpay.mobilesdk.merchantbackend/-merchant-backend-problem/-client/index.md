---
title: Client
---
//[mobilesdk-merchantbackend](../../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../../index.html)/[MerchantBackendProblem](../index.html)/[Client](index.html)



# Client



[androidJvm]\
sealed class [Client](index.html) : [MerchantBackendProblem](../index.html)

Base class for [Problems](../index.html) caused by the service refusing or not understanding a request sent to it by the client.



A Client Problem always implies a HTTP status in 400-499.



## Types


| Name | Summary |
|---|---|
| [Companion](-companion/index.html) | [androidJvm]<br>object [Companion](-companion/index.html) |
| [MobileSDK](-mobile-s-d-k/index.html) | [androidJvm]<br>sealed class [MobileSDK](-mobile-s-d-k/index.html) : [MerchantBackendProblem.Client](index.html)<br>Base class for [Client](index.html) Problems defined by the example backend. |
| [SwedbankPay](-swedbank-pay/index.html) | [androidJvm]<br>sealed class [SwedbankPay](-swedbank-pay/index.html) : [MerchantBackendProblem.Client](index.html), [SwedbankPayProblem](../../-swedbank-pay-problem/index.html)<br>Base class for [Client](index.html) problems defined by the Swedbank Pay backend. https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HProblems |
| [Unknown](-unknown/index.html) | [androidJvm]<br>class [Unknown](-unknown/index.html)(jsonObject: JsonObject) : [MerchantBackendProblem.Client](index.html)<br>[Client](index.html) problem with an unrecognized type. |


## Functions


| Name | Summary |
|---|---|
| [equals](../-server/-unknown/index.html#317480221%2FFunctions%2F1689614965) | [androidJvm]<br>open operator override fun [equals](../-server/-unknown/index.html#317480221%2FFunctions%2F1689614965)(other: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) |
| [hashCode](../-server/-unknown/index.html#-2097273047%2FFunctions%2F1689614965) | [androidJvm]<br>open override fun [hashCode](../-server/-unknown/index.html#-2097273047%2FFunctions%2F1689614965)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [toString](../-server/-unknown/index.html#2019528184%2FFunctions%2F1689614965) | [androidJvm]<br>open override fun [toString](../-server/-unknown/index.html#2019528184%2FFunctions%2F1689614965)(): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [writeToParcel](../write-to-parcel.html) | [androidJvm]<br>open override fun [writeToParcel](../write-to-parcel.html)(parcel: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), flags: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [detail](../-server/-unknown/index.html#1929994611%2FProperties%2F1689614965) | [androidJvm]<br>val [detail](../-server/-unknown/index.html#1929994611%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [instance](../-server/-unknown/index.html#-1600398353%2FProperties%2F1689614965) | [androidJvm]<br>val [instance](../-server/-unknown/index.html#-1600398353%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [jsonObject](../-server/-unknown/index.html#301072573%2FProperties%2F1689614965) | [androidJvm]<br>val [jsonObject](../-server/-unknown/index.html#301072573%2FProperties%2F1689614965): JsonObject |
| [raw](../-server/-unknown/index.html#1423991054%2FProperties%2F1689614965) | [androidJvm]<br>val [raw](../-server/-unknown/index.html#1423991054%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [status](../-server/-unknown/index.html#1109315826%2FProperties%2F1689614965) | [androidJvm]<br>val [status](../-server/-unknown/index.html#1109315826%2FProperties%2F1689614965): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)? |
| [title](../-server/-unknown/index.html#402428574%2FProperties%2F1689614965) | [androidJvm]<br>val [title](../-server/-unknown/index.html#402428574%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [type](../-server/-unknown/index.html#-542810006%2FProperties%2F1689614965) | [androidJvm]<br>val [type](../-server/-unknown/index.html#-542810006%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |


## Inheritors


| Name |
|---|
| [MobileSDK](-mobile-s-d-k/index.html) |
| [SwedbankPay](-swedbank-pay/index.html) |
| [Unknown](-unknown/index.html) |

