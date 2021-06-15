---
title: whitelistDomain
---
//[mobilesdk-merchantbackend](../../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../../index.html)/[MerchantBackendConfiguration](../index.html)/[Builder](index.html)/[whitelistDomain](whitelist-domain.html)



# whitelistDomain



[androidJvm]\
fun [whitelistDomain](whitelist-domain.html)(domain: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), includeSubdomains: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)): [MerchantBackendConfiguration.Builder](index.html)



Adds a domain to the list of allowed domains.



By default, the list contains the domain of the backend URL, including its subdomains. If you wish to change that default, you must call this method for each domain you wish to allow. If you call this method, the default will NOT be used, so you need to add the domain of the backend URL explicitly.



#### Return



this



## Parameters


androidJvm

| | |
|---|---|
| domain | the domain to whitelist |
| includeSubdomains | if true, also adds any subdomains of domain to the whitelist |




