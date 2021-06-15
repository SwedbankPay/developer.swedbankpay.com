---
title: MerchantBackendProblem
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[MerchantBackendProblem](index.html)



# MerchantBackendProblem



[androidJvm]\
sealed class [MerchantBackendProblem](index.html) : Problem

Base class for any problems encountered in the payment.



Problems always result from communication with the backend; lower-level network errors are not represented by Problems, but rather by IOExceptions as is usual.



Swedbank interfaces, as well as the example merchant backend, report problems using the Problem Details for HTTP APIs protocol (https://tools.ietf.org/html/rfc7807), specifically the json representation. Your custom merchant backend is enouraged to do so as well. These classes provide a convenient java representation of the problems so your client code does not need to deal with the raw json. Any custom problem cases you add to your merchant backend will be reported as "Unknown" problems, and you will have to implement parsing for those in your client, of course.



All problems are either [Client](-client/index.html) or [Server](-server/index.html) problems. A Client problem is one where there was something wrong with the request the client app sent to the service. A Client problem always implies an HTTP response status in the Client Error range, 400-499.



A Server problem in one where the service understood the request, but could not fulfill it. If the backend responds in an unexpected manner, the situation will be interpreted as a Server error, unless the response status is in 400-499, in which case it is still considered a Client error.



This separation to Client and Server errors provides a crude but often effective way of distinguishing between temporary service unavailability and permanent configuration errors. Indeed, the PaymentFragment will internally consider any Client errors to be fatal, but most Server errors to be retryable.



Client and Server errors are further divided to specific types. See individual class documentation for details.



## Types


| Name | Summary |
|---|---|
| [Client](-client/index.html) | [androidJvm]<br>sealed class [Client](-client/index.html) : [MerchantBackendProblem](index.html)<br>Base class for [Problems](index.html) caused by the service refusing or not understanding a request sent to it by the client. |
| [Server](-server/index.html) | [androidJvm]<br>sealed class [Server](-server/index.html) : [MerchantBackendProblem](index.html)<br>Base class for [Problems](index.html) caused by the service backend. |


## Functions


| Name | Summary |
|---|---|
| [equals](-server/-unknown/index.html#317480221%2FFunctions%2F1689614965) | [androidJvm]<br>open operator override fun [equals](-server/-unknown/index.html#317480221%2FFunctions%2F1689614965)(other: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) |
| [hashCode](-server/-unknown/index.html#-2097273047%2FFunctions%2F1689614965) | [androidJvm]<br>open override fun [hashCode](-server/-unknown/index.html#-2097273047%2FFunctions%2F1689614965)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [toString](-server/-unknown/index.html#2019528184%2FFunctions%2F1689614965) | [androidJvm]<br>open override fun [toString](-server/-unknown/index.html#2019528184%2FFunctions%2F1689614965)(): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [writeToParcel](write-to-parcel.html) | [androidJvm]<br>open override fun [writeToParcel](write-to-parcel.html)(parcel: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), flags: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [detail](-server/-unknown/index.html#1929994611%2FProperties%2F1689614965) | [androidJvm]<br>val [detail](-server/-unknown/index.html#1929994611%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [instance](-server/-unknown/index.html#-1600398353%2FProperties%2F1689614965) | [androidJvm]<br>val [instance](-server/-unknown/index.html#-1600398353%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [jsonObject](-server/-unknown/index.html#301072573%2FProperties%2F1689614965) | [androidJvm]<br>val [jsonObject](-server/-unknown/index.html#301072573%2FProperties%2F1689614965): JsonObject |
| [raw](-server/-unknown/index.html#1423991054%2FProperties%2F1689614965) | [androidJvm]<br>val [raw](-server/-unknown/index.html#1423991054%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [status](-server/-unknown/index.html#1109315826%2FProperties%2F1689614965) | [androidJvm]<br>val [status](-server/-unknown/index.html#1109315826%2FProperties%2F1689614965): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)? |
| [title](-server/-unknown/index.html#402428574%2FProperties%2F1689614965) | [androidJvm]<br>val [title](-server/-unknown/index.html#402428574%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [type](-server/-unknown/index.html#-542810006%2FProperties%2F1689614965) | [androidJvm]<br>val [type](-server/-unknown/index.html#-542810006%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |


## Inheritors


| Name |
|---|
| [Client](-client/index.html) |
| [Server](-server/index.html) |

