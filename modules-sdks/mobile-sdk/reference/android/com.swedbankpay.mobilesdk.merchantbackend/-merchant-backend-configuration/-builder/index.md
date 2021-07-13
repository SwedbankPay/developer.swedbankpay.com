---
title: Builder -
---
//[sdk](../../../../index)/[com.swedbankpay.mobilesdk.merchantbackend](../../index)/[MerchantBackendConfiguration](../index)/[Builder](index)



# Builder  
 [androidJvm] class [Builder](index)(**backendUrl**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))

A builder object for [MerchantBackendConfiguration](../index).

   


## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder///PointingToDeclaration/"></a>backendUrl| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder///PointingToDeclaration/"></a><br><br>the URL of your merchant backend<br><br>|
  


## Constructors  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/Builder/#kotlin.String/PointingToDeclaration/"></a>[Builder](-builder)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/Builder/#kotlin.String/PointingToDeclaration/"></a> [androidJvm] fun [Builder](-builder)(backendUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))the URL of your merchant backend   <br>|


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/build/#/PointingToDeclaration/"></a>[build](build)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/build/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>fun [build](build)(): [MerchantBackendConfiguration](../index)  <br>More info  <br>Creates a [Configuration](../../../com.swedbankpay.mobilesdk/-configuration/index) object using the current values of the Builder.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/pinCertificates/#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a>[pinCertificates](pin-certificates)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/pinCertificates/#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>fun [pinCertificates](pin-certificates)(pattern: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), vararg certificates: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [MerchantBackendConfiguration.Builder](index)  <br>More info  <br>Pins certificates for a hostname pattern.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/requestDecorator/#com.swedbankpay.mobilesdk.RequestDecorator/PointingToDeclaration/"></a>[requestDecorator](request-decorator)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/requestDecorator/#com.swedbankpay.mobilesdk.RequestDecorator/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>fun [requestDecorator](request-decorator)(requestDecorator: [RequestDecorator](../../../com.swedbankpay.mobilesdk/-request-decorator/index)): [MerchantBackendConfiguration.Builder](index)  <br>More info  <br>Sets a [RequestDecorator](../../../com.swedbankpay.mobilesdk/-request-decorator/index) that adds custom headers to backend requests.  <br><br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/whitelistDomain/#kotlin.String#kotlin.Boolean/PointingToDeclaration/"></a>[whitelistDomain](whitelist-domain)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/whitelistDomain/#kotlin.String#kotlin.Boolean/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>fun [whitelistDomain](whitelist-domain)(domain: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), includeSubdomains: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)): [MerchantBackendConfiguration.Builder](index)  <br>More info  <br>Adds a domain to the list of allowed domains.  <br><br><br>|


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/backendUrl/#/PointingToDeclaration/"></a>[backendUrl](backend-url)| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/backendUrl/#/PointingToDeclaration/"></a> [androidJvm] val [backendUrl](backend-url): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)the URL of your merchant backend   <br>|

