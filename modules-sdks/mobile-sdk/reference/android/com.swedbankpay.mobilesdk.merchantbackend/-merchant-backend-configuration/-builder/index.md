---
title: Builder
---
//[mobilesdk-merchantbackend](../../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../../index.html)/[MerchantBackendConfiguration](../index.html)/[Builder](index.html)



# Builder



[androidJvm]\
class [Builder](index.html)(backendUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))

A builder object for [MerchantBackendConfiguration](../index.html).



## Parameters


androidJvm

| | |
|---|---|
| backendUrl | the URL of your merchant backend |



## Constructors


| | |
|---|---|
| [Builder](-builder.html) | [androidJvm]<br>fun [Builder](-builder.html)(backendUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)) |


## Functions


| Name | Summary |
|---|---|
| [build](build.html) | [androidJvm]<br>fun [build](build.html)(): [MerchantBackendConfiguration](../index.html)<br>Creates a Configuration object using the current values of the Builder. |
| [pinCertificates](pin-certificates.html) | [androidJvm]<br>fun [pinCertificates](pin-certificates.html)(pattern: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), vararg certificates: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [MerchantBackendConfiguration.Builder](index.html)<br>Pins certificates for a hostname pattern. |
| [requestDecorator](request-decorator.html) | [androidJvm]<br>fun [requestDecorator](request-decorator.html)(requestDecorator: [RequestDecorator](../../-request-decorator/index.html)): [MerchantBackendConfiguration.Builder](index.html)<br>Sets a [RequestDecorator](../../-request-decorator/index.html) that adds custom headers to backend requests. |
| [whitelistDomain](whitelist-domain.html) | [androidJvm]<br>fun [whitelistDomain](whitelist-domain.html)(domain: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), includeSubdomains: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)): [MerchantBackendConfiguration.Builder](index.html)<br>Adds a domain to the list of allowed domains. |


## Properties


| Name | Summary |
|---|---|
| [backendUrl](backend-url.html) | [androidJvm]<br>val [backendUrl](backend-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |

