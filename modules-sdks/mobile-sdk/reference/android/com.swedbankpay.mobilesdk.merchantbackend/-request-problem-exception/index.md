---
title: RequestProblemException
---
//[mobilesdk-merchantbackend](../../../index.html)/[com.swedbankpay.mobilesdk.merchantbackend](../index.html)/[RequestProblemException](index.html)



# RequestProblemException



[androidJvm]\
class [RequestProblemException](index.html)(problem: Problem) : [IOException](https://developer.android.com/reference/kotlin/java/io/IOException.html)

IOException containing an RFC 7807 Problem object describing the error.



## Constructors


| | |
|---|---|
| [RequestProblemException](-request-problem-exception.html) | [androidJvm]<br>fun [RequestProblemException](-request-problem-exception.html)(problem: Problem) |


## Functions


| Name | Summary |
|---|---|
| [addSuppressed](../-unexpected-response-exception/index.html#282858770%2FFunctions%2F1689614965) | [androidJvm]<br>fun [addSuppressed](../-unexpected-response-exception/index.html#282858770%2FFunctions%2F1689614965)(p0: [Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html)) |
| [fillInStackTrace](../-unexpected-response-exception/index.html#-1102069925%2FFunctions%2F1689614965) | [androidJvm]<br>open fun [fillInStackTrace](../-unexpected-response-exception/index.html#-1102069925%2FFunctions%2F1689614965)(): [Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html) |
| [getLocalizedMessage](../-unexpected-response-exception/index.html#1043865560%2FFunctions%2F1689614965) | [androidJvm]<br>open fun [getLocalizedMessage](../-unexpected-response-exception/index.html#1043865560%2FFunctions%2F1689614965)(): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [getStackTrace](../-unexpected-response-exception/index.html#2050903719%2FFunctions%2F1689614965) | [androidJvm]<br>open fun [getStackTrace](../-unexpected-response-exception/index.html#2050903719%2FFunctions%2F1689614965)(): [Array](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-array/index.html)&lt;[StackTraceElement](https://developer.android.com/reference/kotlin/java/lang/StackTraceElement.html)&gt; |
| [getSuppressed](../-unexpected-response-exception/index.html#672492560%2FFunctions%2F1689614965) | [androidJvm]<br>fun [getSuppressed](../-unexpected-response-exception/index.html#672492560%2FFunctions%2F1689614965)(): [Array](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-array/index.html)&lt;[Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html)&gt; |
| [initCause](../-unexpected-response-exception/index.html#-418225042%2FFunctions%2F1689614965) | [androidJvm]<br>open fun [initCause](../-unexpected-response-exception/index.html#-418225042%2FFunctions%2F1689614965)(p0: [Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html)): [Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html) |
| [printStackTrace](../-unexpected-response-exception/index.html#-1769529168%2FFunctions%2F1689614965) | [androidJvm]<br>open fun [printStackTrace](../-unexpected-response-exception/index.html#-1769529168%2FFunctions%2F1689614965)()<br>open fun [printStackTrace](../-unexpected-response-exception/index.html#1841853697%2FFunctions%2F1689614965)(p0: [PrintStream](https://developer.android.com/reference/kotlin/java/io/PrintStream.html))<br>open fun [printStackTrace](../-unexpected-response-exception/index.html#1175535278%2FFunctions%2F1689614965)(p0: [PrintWriter](https://developer.android.com/reference/kotlin/java/io/PrintWriter.html)) |
| [setStackTrace](../-unexpected-response-exception/index.html#2135801318%2FFunctions%2F1689614965) | [androidJvm]<br>open fun [setStackTrace](../-unexpected-response-exception/index.html#2135801318%2FFunctions%2F1689614965)(p0: [Array](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-array/index.html)&lt;[StackTraceElement](https://developer.android.com/reference/kotlin/java/lang/StackTraceElement.html)&gt;) |


## Properties


| Name | Summary |
|---|---|
| [cause](../-unexpected-response-exception/index.html#-654012527%2FProperties%2F1689614965) | [androidJvm]<br>open val [cause](../-unexpected-response-exception/index.html#-654012527%2FProperties%2F1689614965): [Throwable](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-throwable/index.html)? |
| [message](../-unexpected-response-exception/index.html#1824300659%2FProperties%2F1689614965) | [androidJvm]<br>open val [message](../-unexpected-response-exception/index.html#1824300659%2FProperties%2F1689614965): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? |
| [problem](problem.html) | [androidJvm]<br>val [problem](problem.html): Problem<br>The problem that occurred |

