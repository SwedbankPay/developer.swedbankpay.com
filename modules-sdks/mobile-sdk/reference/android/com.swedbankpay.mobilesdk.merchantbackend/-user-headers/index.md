---
title: UserHeaders
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[UserHeaders](index.html)



# UserHeaders



[androidJvm]\
class [UserHeaders](index.html)

Builder for custom headers.



To add headers to a request, override the desired method in [RequestDecorator](../-request-decorator/index.html) and call userHeaders.[add](add.html), eg:

    override fun decorateCreatePaymentOrder(userHeaders: UserHeaders, body: String, consumerProfileRef: String?, merchantData: String?) {
        userHeaders.add("api-key", "secret-api-key")
        userHeaders.add("hmac", getHmac(body))
    }



## Functions


| Name | Summary |
|---|---|
| [add](add.html) | [androidJvm]<br>fun [add](add.html)(headerLine: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [UserHeaders](index.html)<br>Adds a header line to the request.<br>[androidJvm]<br>fun [add](add.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), value: [Date](https://developer.android.com/reference/kotlin/java/util/Date.html)): [UserHeaders](index.html)<br>fun [add](add.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), value: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [UserHeaders](index.html)<br>Adds a header to the request. |
| [addNonAscii](add-non-ascii.html) | [androidJvm]<br>fun [addNonAscii](add-non-ascii.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), value: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [UserHeaders](index.html)<br>Adds a header without validating the value. |
| [set](set.html) | [androidJvm]<br>fun [set](set.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), value: [Date](https://developer.android.com/reference/kotlin/java/util/Date.html)): [UserHeaders](index.html)<br>fun [set](set.html)(name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), value: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)): [UserHeaders](index.html)<br>Sets a header in the request. |

