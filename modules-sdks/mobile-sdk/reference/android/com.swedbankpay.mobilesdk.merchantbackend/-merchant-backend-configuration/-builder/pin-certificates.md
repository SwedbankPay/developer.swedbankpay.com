---
title: pinCertificates
---
//[mobilesdk-merchantbackend](../../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../../index.html)/[MerchantBackendConfiguration](../index.html)/[Builder](index.html)/[pinCertificates](pin-certificates.html)



# pinCertificates



[androidJvm]\
fun [pinCertificates](pin-certificates.html)(pattern: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), vararg certificates: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [MerchantBackendConfiguration.Builder](index.html)



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
| pattern | the hostname pattern to pin |
| certificates | the certificates to require for the pattern |




