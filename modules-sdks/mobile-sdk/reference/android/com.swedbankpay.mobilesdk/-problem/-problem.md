---
title: Problem
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[Problem](index.html)/[Problem](-problem.html)



# Problem



[androidJvm]\
fun [Problem](-problem.html)(parcel: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html))



Constructs a Problem from a parcel where it was previously written using writeToParcel.





[androidJvm]\
fun [Problem](-problem.html)(jsonObject: JsonObject)



Interprets a Gson JsonObject as a Problem.



N.B! From an API stability perspective, please consider this constructor an implementation detail. It is, however, exposed for convenience.





[androidJvm]\
fun [Problem](-problem.html)(raw: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))



Parses a Problem from a String.



## Throws


| | |
|---|---|
| [kotlin.IllegalArgumentException](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-illegal-argument-exception/index.html) | if raw  does not represent a JSON object |



