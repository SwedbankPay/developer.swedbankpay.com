---
title: BackendConnectionTimeout -
---
//[sdk](../../../../../../index)/[com.swedbankpay.mobilesdk.merchantbackend](../../../../index)/[MerchantBackendProblem](../../../index)/[Server](../../index)/[MobileSDK](../index)/[BackendConnectionTimeout](index)



# BackendConnectionTimeout  
 [androidJvm] class [BackendConnectionTimeout](index)(**jsonObject**: JsonObject) : [MerchantBackendProblem.Server.MobileSDK](../index)

The merchant backend timed out trying to connect to the Swedbank Pay backend.



The [detail](../../../../../com.swedbankpay.mobilesdk/-problem/detail) property may optionally contain a message describing the error.

   


## Constructors  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/BackendConnectionTimeout/#com.google.gson.JsonObject/PointingToDeclaration/"></a>[BackendConnectionTimeout](-backend-connection-timeout)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/BackendConnectionTimeout/#com.google.gson.JsonObject/PointingToDeclaration/"></a> [androidJvm] fun [BackendConnectionTimeout](-backend-connection-timeout)(jsonObject: JsonObject)   <br>|


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[describeContents](../../-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [describeContents](../../-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk/Problem/equals/#kotlin.Any?/PointingToDeclaration/"></a>[equals](../../../../../com.swedbankpay.mobilesdk/-problem/equals)| <a name="com.swedbankpay.mobilesdk/Problem/equals/#kotlin.Any?/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open operator override fun [equals](../../../../../com.swedbankpay.mobilesdk/-problem/equals)(other: [Any](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-any/index.html)?): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk/Problem/hashCode/#/PointingToDeclaration/"></a>[hashCode](../../../../../com.swedbankpay.mobilesdk/-problem/hash-code)| <a name="com.swedbankpay.mobilesdk/Problem/hashCode/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open override fun [hashCode](../../../../../com.swedbankpay.mobilesdk/-problem/hash-code)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk/Problem/toString/#/PointingToDeclaration/"></a>[toString](../../../../../com.swedbankpay.mobilesdk/-problem/to-string)| <a name="com.swedbankpay.mobilesdk/Problem/toString/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open override fun [toString](../../../../../com.swedbankpay.mobilesdk/-problem/to-string)(): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[writeToParcel](../../../write-to-parcel)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>open override fun [writeToParcel](../../../write-to-parcel)(parcel: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), flags: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html))  <br><br><br>|


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/detail/#/PointingToDeclaration/"></a>[detail](index.md#-575970019%2FProperties%2F-1404661416)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/detail/#/PointingToDeclaration/"></a> [androidJvm] val [detail](index.md#-575970019%2FProperties%2F-1404661416): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?RFC 7807 default property: a detailed explanation of the problem   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/instance/#/PointingToDeclaration/"></a>[instance](index.md#-355754727%2FProperties%2F-1404661416)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/instance/#/PointingToDeclaration/"></a> [androidJvm] val [instance](index.md#-355754727%2FProperties%2F-1404661416): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?RFC 7807 default property: a URI reference that identifies the specific occurrence of the problem   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/jsonObject/#/PointingToDeclaration/"></a>[jsonObject](index.md#-1892278425%2FProperties%2F-1404661416)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/jsonObject/#/PointingToDeclaration/"></a> [androidJvm] val [jsonObject](index.md#-1892278425%2FProperties%2F-1404661416): JsonObjectThe raw RFC 7807 object parsed as a Gson JsonObject.   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/raw/#/PointingToDeclaration/"></a>[raw](index.md#1467157924%2FProperties%2F-1404661416)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/raw/#/PointingToDeclaration/"></a> [androidJvm] val [raw](index.md#1467157924%2FProperties%2F-1404661416): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)The raw RFC 7807 object.   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/status/#/PointingToDeclaration/"></a>[status](index.md#-1396648804%2FProperties%2F-1404661416)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/status/#/PointingToDeclaration/"></a> [androidJvm] val [status](index.md#-1396648804%2FProperties%2F-1404661416): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)?RFC 7807 default property: the HTTP status codeThis should always be the same as the actual HTTP status code reported by the server.   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/title/#/PointingToDeclaration/"></a>[title](index.md#-1063882316%2FProperties%2F-1404661416)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/title/#/PointingToDeclaration/"></a> [androidJvm] val [title](index.md#-1063882316%2FProperties%2F-1404661416): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?RFC 7807 default property: a short summary of the problem.   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/type/#/PointingToDeclaration/"></a>[type](index.md#795362964%2FProperties%2F-1404661416)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.MobileSDK.BackendConnectionTimeout/type/#/PointingToDeclaration/"></a> [androidJvm] val [type](index.md#795362964%2FProperties%2F-1404661416): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)RFC 7807 default property: a URI reference that identifies the problem type.   <br>|

