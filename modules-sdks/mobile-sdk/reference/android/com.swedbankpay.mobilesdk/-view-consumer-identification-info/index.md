---
title: ViewConsumerIdentificationInfo
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[ViewConsumerIdentificationInfo](index.html)



# ViewConsumerIdentificationInfo



[androidJvm]\
data class [ViewConsumerIdentificationInfo](index.html)(webViewBaseUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, viewConsumerIdentification: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html))

Data required to show the checkin view.



If you provide a custom [Configuration](../-configuration/index.html), you must get the relevant data from your services and return a ViewConsumerIdentificationInfo object in your [Configuration.postConsumers](../-configuration/post-consumers.html) method.



## Constructors


| | |
|---|---|
| [ViewConsumerIdentificationInfo](-view-consumer-identification-info.html) | [androidJvm]<br>fun [ViewConsumerIdentificationInfo](-view-consumer-identification-info.html)(webViewBaseUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, viewConsumerIdentification: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [viewConsumerIdentification](view-consumer-identification.html) | [androidJvm]<br>val [viewConsumerIdentification](view-consumer-identification.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>The view-consumer-identification link from Swedbank Pay. |
| [webViewBaseUrl](web-view-base-url.html) | [androidJvm]<br>val [webViewBaseUrl](web-view-base-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>The url to use as the [android.webkit.WebView](https://developer.android.com/reference/kotlin/android/webkit/WebView.html) page url when showing the checkin UI. If null, defaults to about:blank, as [documented](https://developer.android.com/reference/kotlin/android/webkit/WebView.html#loaddatawithbaseurl). |

