---
title: UnexpectedResponseException
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[UnexpectedResponseException](index.html)



# UnexpectedResponseException



[androidJvm]\
class [UnexpectedResponseException](index.html)(status: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), contentType: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, cause: [Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html)?) : [IOException](https://developer.android.com/reference/kotlin/java/io/IOException.html)

The server returned a response that [MerchantBackendConfiguration](../-merchant-backend-configuration/index.html) was not prepared for.



## Constructors


| | |
|---|---|
| [UnexpectedResponseException](-unexpected-response-exception.html) | [androidJvm]<br>fun [UnexpectedResponseException](-unexpected-response-exception.html)(status: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), contentType: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, body: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, cause: [Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html)?) |


## Functions


| Name | Summary |
|---|---|
| [addSuppressed](index.html#282858770%2FFunctions%2F1689614965) | [androidJvm]<br>fun [addSuppressed](index.html#282858770%2FFunctions%2F1689614965)(p0: [Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html)) |
| [fillInStackTrace](index.html#-1102069925%2FFunctions%2F1689614965) | [androidJvm]<br>open fun [fillInStackTrace](index.html#-1102069925%2FFunctions%2F1689614965)(): [Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html) |
| [getLocalizedMessage](index.html#1043865560%2FFunctions%2F1689614965) | [androidJvm]<br>open fun [getLocalizedMessage](index.html#1043865560%2FFunctions%2F1689614965)(): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [getStackTrace](index.html#2050903719%2FFunctions%2F1689614965) | [androidJvm]<br>open fun [getStackTrace](index.html#2050903719%2FFunctions%2F1689614965)(): [Array](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-array/index.html)&lt;[StackTraceElement](https://developer.android.com/reference/kotlin/java/lang/StackTraceElement.html)&gt; |
| [getSuppressed](index.html#672492560%2FFunctions%2F1689614965) | [androidJvm]<br>fun [getSuppressed](index.html#672492560%2FFunctions%2F1689614965)(): [Array](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-array/index.html)&lt;[Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html)&gt; |
| [initCause](index.html#-418225042%2FFunctions%2F1689614965) | [androidJvm]<br>open fun [initCause](index.html#-418225042%2FFunctions%2F1689614965)(p0: [Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html)): [Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html) |
| [printStackTrace](index.html#-1769529168%2FFunctions%2F1689614965) | [androidJvm]<br>open fun [printStackTrace](index.html#-1769529168%2FFunctions%2F1689614965)()<br>open fun [printStackTrace](index.html#1841853697%2FFunctions%2F1689614965)(p0: [PrintStream](https://developer.android.com/reference/kotlin/java/io/PrintStream.html))<br>open fun [printStackTrace](index.html#1175535278%2FFunctions%2F1689614965)(p0: [PrintWriter](https://developer.android.com/reference/kotlin/java/io/PrintWriter.html)) |
| [setStackTrace](index.html#2135801318%2FFunctions%2F1689614965) | [androidJvm]<br>open fun [setStackTrace](index.html#2135801318%2FFunctions%2F1689614965)(p0: [Array](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-array/index.html)&lt;[StackTraceElement](https://developer.android.com/reference/kotlin/java/lang/StackTraceElement.html)&gt;) |


## Properties


| Name | Summary |
|---|---|
| [body](body.html) | [androidJvm]<br>val [body](body.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>The response body |
| [cause](index.html#-654012527%2FProperties%2F1689614965) | [androidJvm]<br>open val [cause](index.html#-654012527%2FProperties%2F1689614965): [Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html)? |
| [contentType](content-type.html) | [androidJvm]<br>val [contentType](content-type.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>The Content-Type of body, if available |
| [message](index.html#1824300659%2FProperties%2F1689614965) | [androidJvm]<br>open val [message](index.html#1824300659%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [status](status.html) | [androidJvm]<br>val [status](status.html): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)<br>The http status code |

