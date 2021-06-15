---
title: InvalidBackendResponse
---
//[mobilesdk-merchantbackend](../../../../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../../../../index.html)/[MerchantBackendProblem](../../../index.html)/[Server](../../index.html)/[MobileSDK](../index.html)/[InvalidBackendResponse](index.html)



# InvalidBackendResponse



[androidJvm]\
class [InvalidBackendResponse](index.html)(jsonObject: JsonObject, backendStatus: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) : [MerchantBackendProblem.Server.MobileSDK](../index.html)

The merchant backend received an invalid response from the Swedbank Pay backend.



## Constructors


| | |
|---|---|
| [InvalidBackendResponse](-invalid-backend-response.html) | [androidJvm]<br>fun [InvalidBackendResponse](-invalid-backend-response.html)(jsonObject: JsonObject, backendStatus: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Functions


| Name | Summary |
|---|---|
| [equals](../../-unknown/index.html#317480221%2FFunctions%2F1689614965) | [androidJvm]<br>open operator override fun [equals](../../-unknown/index.html#317480221%2FFunctions%2F1689614965)(other: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) |
| [hashCode](../../-unknown/index.html#-2097273047%2FFunctions%2F1689614965) | [androidJvm]<br>open override fun [hashCode](../../-unknown/index.html#-2097273047%2FFunctions%2F1689614965)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [toString](../../-unknown/index.html#2019528184%2FFunctions%2F1689614965) | [androidJvm]<br>open override fun [toString](../../-unknown/index.html#2019528184%2FFunctions%2F1689614965)(): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [writeToParcel](../../../write-to-parcel.html) | [androidJvm]<br>open override fun [writeToParcel](../../../write-to-parcel.html)(parcel: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), flags: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [backendStatus](backend-status.html) | [androidJvm]<br>val [backendStatus](backend-status.html): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)<br>The HTTP status code received from the Swedback Pay backend |
| [body](body.html) | [androidJvm]<br>val [body](body.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>The unrecognized body received from the Swedback Pay backend |
| [detail](../../-unknown/index.html#1929994611%2FProperties%2F1689614965) | [androidJvm]<br>val [detail](../../-unknown/index.html#1929994611%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [instance](../../-unknown/index.html#-1600398353%2FProperties%2F1689614965) | [androidJvm]<br>val [instance](../../-unknown/index.html#-1600398353%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [jsonObject](../../-unknown/index.html#301072573%2FProperties%2F1689614965) | [androidJvm]<br>val [jsonObject](../../-unknown/index.html#301072573%2FProperties%2F1689614965): JsonObject |
| [raw](../../-unknown/index.html#1423991054%2FProperties%2F1689614965) | [androidJvm]<br>val [raw](../../-unknown/index.html#1423991054%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [status](../../-unknown/index.html#1109315826%2FProperties%2F1689614965) | [androidJvm]<br>val [status](../../-unknown/index.html#1109315826%2FProperties%2F1689614965): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)? |
| [title](../../-unknown/index.html#402428574%2FProperties%2F1689614965) | [androidJvm]<br>val [title](../../-unknown/index.html#402428574%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [type](../../-unknown/index.html#-542810006%2FProperties%2F1689614965) | [androidJvm]<br>val [type](../../-unknown/index.html#-542810006%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |

