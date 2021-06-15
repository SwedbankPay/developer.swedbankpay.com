---
title: Problem
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[Problem](index.html)



# Problem



[androidJvm]\
open class [Problem](index.html) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html), [Serializable](https://developer.android.com/reference/kotlin/java/io/Serializable.html)

An RFC 7807 HTTP API Problem Details object.



The SDK defines a subclass of Problem for problems expected to be reported from a server implementing the Merchant Backend API.



There is a com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendProblem for problems expected to be reported by a server implementing the Merchant Backend API.



## Constructors


| | |
|---|---|
| [Problem](-problem.html) | [androidJvm]<br>fun [Problem](-problem.html)(parcel: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html))<br>Constructs a Problem from a parcel where it was previously written using writeToParcel. |
| [Problem](-problem.html) | [androidJvm]<br>fun [Problem](-problem.html)(jsonObject: JsonObject)<br>Interprets a Gson JsonObject as a Problem. |
| [Problem](-problem.html) | [androidJvm]<br>fun [Problem](-problem.html)(raw: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))<br>Parses a Problem from a String. |


## Functions


| Name | Summary |
|---|---|
| [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [equals](equals.html) | [androidJvm]<br>open operator override fun [equals](equals.html)(other: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) |
| [hashCode](hash-code.html) | [androidJvm]<br>open override fun [hashCode](hash-code.html)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [toString](to-string.html) | [androidJvm]<br>open override fun [toString](to-string.html)(): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [detail](detail.html) | [androidJvm]<br>val [detail](detail.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>RFC 7807 default property: a detailed explanation of the problem |
| [instance](instance.html) | [androidJvm]<br>val [instance](instance.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>RFC 7807 default property: a URI reference that identifies the specific occurrence of the problem |
| [jsonObject](json-object.html) | [androidJvm]<br>val [jsonObject](json-object.html): JsonObject<br>The raw RFC 7807 object parsed as a Gson JsonObject. |
| [raw](raw.html) | [androidJvm]<br>val [raw](raw.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>The raw RFC 7807 object. |
| [status](status.html) | [androidJvm]<br>val [status](status.html): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)?<br>RFC 7807 default property: the HTTP status code |
| [title](title.html) | [androidJvm]<br>val [title](title.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>RFC 7807 default property: a short summary of the problem. |
| [type](type.html) | [androidJvm]<br>val [type](type.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>RFC 7807 default property: a URI reference that identifies the problem type. |

