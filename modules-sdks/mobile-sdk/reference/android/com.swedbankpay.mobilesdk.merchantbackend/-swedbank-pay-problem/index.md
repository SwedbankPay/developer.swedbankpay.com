---
title: SwedbankPayProblem -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk.merchantbackend](../index)/[SwedbankPayProblem](index)



# SwedbankPayProblem  
 [androidJvm] interface [SwedbankPayProblem](index)

A Problem defined by the Swedbank Pay backend. https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HProblems

   


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/action/#/PointingToDeclaration/"></a>[action](action)| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/action/#/PointingToDeclaration/"></a> [androidJvm] abstract val [action](action): [SwedbankPayAction](../index.md#853214653%2FClasslikes%2F-1404661416)?Suggested action to take to recover from the error.   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/detail/#/PointingToDeclaration/"></a>[detail](detail)| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/detail/#/PointingToDeclaration/"></a> [androidJvm] abstract val [detail](detail): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?Human-readable details about the problem   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/instance/#/PointingToDeclaration/"></a>[instance](instance)| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/instance/#/PointingToDeclaration/"></a> [androidJvm] abstract val [instance](instance): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?Swedbank Pay internal identifier of the problem.   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/problems/#/PointingToDeclaration/"></a>[problems](problems)| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/problems/#/PointingToDeclaration/"></a> [androidJvm] abstract val [problems](problems): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)<[SwedbankPaySubproblem](../-swedbank-pay-subproblem/index)>Array of problem detail objects   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/raw/#/PointingToDeclaration/"></a>[raw](raw)| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/raw/#/PointingToDeclaration/"></a> [androidJvm] abstract val [raw](raw): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)The raw application/problem+json object.   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/status/#/PointingToDeclaration/"></a>[status](status)| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/status/#/PointingToDeclaration/"></a> [androidJvm] abstract val [status](status): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)?The HTTP status.   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/title/#/PointingToDeclaration/"></a>[title](title)| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/title/#/PointingToDeclaration/"></a> [androidJvm] abstract val [title](title): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?Human-readable description of the problem   <br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/type/#/PointingToDeclaration/"></a>[type](type)| <a name="com.swedbankpay.mobilesdk.merchantbackend/SwedbankPayProblem/type/#/PointingToDeclaration/"></a> [androidJvm] abstract val [type](type): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)RFC 7807 default property: a URI reference that identifies the problem type.   <br>|


## Inheritors  
  
|  Name | 
|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Client.SwedbankPay///PointingToDeclaration/"></a>[MerchantBackendProblem.Client](../-merchant-backend-problem/-client/-swedbank-pay/index)|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendProblem.Server.SwedbankPay///PointingToDeclaration/"></a>[MerchantBackendProblem.Server](../-merchant-backend-problem/-server/-swedbank-pay/index)|

