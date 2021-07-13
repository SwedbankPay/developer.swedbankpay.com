---
title: Problem -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[Problem](index)/[Problem](-problem)



# Problem  
[androidJvm]  
Content  
fun [Problem](-problem)(parcel: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html))  
More info  


Constructs a Problem from a parcel where it was previously written using writeToParcel.

  


[androidJvm]  
Content  
fun [Problem](-problem)(jsonObject: JsonObject)  
More info  


Interprets a Gson JsonObject as a Problem.



N.B! From an API stability perspective, please consider this constructor an implementation detail. It is, however, exposed for convenience.

  


[androidJvm]  
Content  
fun [Problem](-problem)(raw: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))  
More info  


Parses a Problem from a String.



#### Throws  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/Problem/Problem/#kotlin.String/PointingToDeclaration/"></a>[kotlin.IllegalArgumentException](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-illegal-argument-exception/index.html)| <a name="com.swedbankpay.mobilesdk/Problem/Problem/#kotlin.String/PointingToDeclaration/"></a><br><br>if raw  does not represent a JSON object<br><br>|
  



