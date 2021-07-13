---
title: pinCertificates -
---
//[sdk](../../../../index)/[com.swedbankpay.mobilesdk.merchantbackend](../../index)/[MerchantBackendConfiguration](../index)/[Builder](index)/[pinCertificates](pin-certificates)



# pinCertificates  
[androidJvm]  
Content  
fun [pinCertificates](pin-certificates)(pattern: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), vararg certificates: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [MerchantBackendConfiguration.Builder](index)  
More info  


Pins certificates for a hostname pattern.



The pattern may contain an asterisk (*) as the left-most part. The asterisk will only match one part of the hostname, so *.foo.com will match bar.foo.com, but not baz.bar.foo.com.



The certificates are [HPKP](https://tools.ietf.org/html/rfc7469) SHA-256 hashes.



Please see [okhttp](https://square.github.io/okhttp/3.x/okhttp/okhttp3/CertificatePinner.html) documentation for discussion on how to do certificate pinning and its consequences.



#### Return  


this



## Parameters  
  
androidJvm  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/pinCertificates/#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a>pattern| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/pinCertificates/#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a><br><br>the hostname pattern to pin<br><br>|
| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/pinCertificates/#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a>certificates| <a name="com.swedbankpay.mobilesdk.merchantbackend/MerchantBackendConfiguration.Builder/pinCertificates/#kotlin.String#kotlin.Array[kotlin.String]/PointingToDeclaration/"></a><br><br>the certificates to require for the pattern<br><br>|
  
  



