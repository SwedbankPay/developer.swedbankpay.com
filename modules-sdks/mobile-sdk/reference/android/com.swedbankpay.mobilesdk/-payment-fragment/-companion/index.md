---
title: Companion
---
//[mobilesdk](../../../../index.html)/[com.swedbankpay.mobilesdk](../../index.html)/[PaymentFragment](../index.html)/[Companion](index.html)



# Companion



[androidJvm]\
object [Companion](index.html)



## Properties


| Name | Summary |
|---|---|
| [ARG_CONSUMER](-a-r-g_-c-o-n-s-u-m-e-r.html) | [androidJvm]<br>const val [ARG_CONSUMER](-a-r-g_-c-o-n-s-u-m-e-r.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>Argument key: a [Consumer](../../-consumer/index.html) object to prepare checkin. You will receive this value in your [Configuration.postConsumers](../../-configuration/post-consumers.html). |
| [ARG_DEBUG_INTENT_URIS](-a-r-g_-d-e-b-u-g_-i-n-t-e-n-t_-u-r-i-s.html) | [androidJvm]<br>const val [ARG_DEBUG_INTENT_URIS](-a-r-g_-d-e-b-u-g_-i-n-t-e-n-t_-u-r-i-s.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>Argument key: if true, will add debugging information to the error dialog when a web site attempts to start an Activity but fails. |
| [ARG_ENABLED_DEFAULT_UI](-a-r-g_-e-n-a-b-l-e-d_-d-e-f-a-u-l-t_-u-i.html) | [androidJvm]<br>const val [ARG_ENABLED_DEFAULT_UI](-a-r-g_-e-n-a-b-l-e-d_-d-e-f-a-u-l-t_-u-i.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>Argument key: the enabled deafult UI. A bitwise combination of [RETRY_PROMPT](-r-e-t-r-y_-p-r-o-m-p-t.html), [COMPLETE_MESSAGE](-c-o-m-p-l-e-t-e_-m-e-s-s-a-g-e.html), and/or [ERROR_MESSAGE](-e-r-r-o-r_-m-e-s-s-a-g-e.html) |
| [ARG_PAYMENT_ORDER](-a-r-g_-p-a-y-m-e-n-t_-o-r-d-e-r.html) | [androidJvm]<br>const val [ARG_PAYMENT_ORDER](-a-r-g_-p-a-y-m-e-n-t_-o-r-d-e-r.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>Argument key: a [PaymentOrder](../../-payment-order/index.html) object to prepare the payment menu. You will receive this value in your [Configuration.postPaymentorders](../../-configuration/post-paymentorders.html). |
| [ARG_STYLE](-a-r-g_-s-t-y-l-e.html) | [androidJvm]<br>const val [ARG_STYLE](-a-r-g_-s-t-y-l-e.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>Argument key: a [Bundle](https://developer.android.com/reference/kotlin/android/os/Bundle.html) that contains styling parameters. You can use [toStyleBundle](../../to-style-bundle.html) to create the style bundle from a [Map](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-map/index.html). |
| [ARG_USE_BROWSER](-a-r-g_-u-s-e_-b-r-o-w-s-e-r.html) | [androidJvm]<br>const val [ARG_USE_BROWSER](-a-r-g_-u-s-e_-b-r-o-w-s-e-r.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>Argument key: if true, any navigation to out of the payment menu will be done in the web browser app instead. This can be useful for debugging, but is not recommended for general use. |
| [ARG_USE_CHECKIN](-a-r-g_-u-s-e_-c-h-e-c-k-i-n.html) | [androidJvm]<br>const val [ARG_USE_CHECKIN](-a-r-g_-u-s-e_-c-h-e-c-k-i-n.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>Argument key: true to do checkin before payment menu to get a consumerProfileRef |
| [ARG_USER_DATA](-a-r-g_-u-s-e-r_-d-a-t-a.html) | [androidJvm]<br>const val [ARG_USER_DATA](-a-r-g_-u-s-e-r_-d-a-t-a.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>Argument key: Any data that you may need in your [Configuration](../../-configuration/index.html) to prepare the checkin and payment menu for this payment. You will receive this value as the userData argument in your [Configuration.postConsumers](../../-configuration/post-consumers.html) and [Configuration.postPaymentorders](../../-configuration/post-paymentorders.html) methods. |
| [ARG_VIEW_MODEL_PROVIDER_KEY](-a-r-g_-v-i-e-w_-m-o-d-e-l_-p-r-o-v-i-d-e-r_-k-e-y.html) | [androidJvm]<br>const val [ARG_VIEW_MODEL_PROVIDER_KEY](-a-r-g_-v-i-e-w_-m-o-d-e-l_-p-r-o-v-i-d-e-r_-k-e-y.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>Argument key: the key to use in [ViewModelProvider.get](https://developer.android.com/reference/kotlin/androidx/lifecycle/ViewModelProvider.html#get) to retrieve the [PaymentViewModel](../../-payment-view-model/index.html) of this PaymentFragment. Use this if you have multiple PaymentFragments in the same Activity (not recommended). |
| [COMPLETE_MESSAGE](-c-o-m-p-l-e-t-e_-m-e-s-s-a-g-e.html) | [androidJvm]<br>const val [COMPLETE_MESSAGE](-c-o-m-p-l-e-t-e_-m-e-s-s-a-g-e.html): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)<br>Default UI flag: a laconic completion message See [ArgumentsBuilder.setEnabledDefaultUI](../-arguments-builder/set-enabled-default-u-i.html) |
| [defaultConfiguration](default-configuration.html) | [androidJvm]<br>var [defaultConfiguration](default-configuration.html): [Configuration](../../-configuration/index.html)? = null<br>The [Configuration](../../-configuration/index.html) to use if [getConfiguration](../get-configuration.html) is not overridden. |
| [ERROR_MESSAGE](-e-r-r-o-r_-m-e-s-s-a-g-e.html) | [androidJvm]<br>const val [ERROR_MESSAGE](-e-r-r-o-r_-m-e-s-s-a-g-e.html): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)<br>Default UI flag: a less laconic, though a bit technical, error message See [ArgumentsBuilder.setEnabledDefaultUI](../-arguments-builder/set-enabled-default-u-i.html) |
| [RETRY_PROMPT](-r-e-t-r-y_-p-r-o-m-p-t.html) | [androidJvm]<br>const val [RETRY_PROMPT](-r-e-t-r-y_-p-r-o-m-p-t.html): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)<br>Default UI flag: a prompt to retry a failed request that can reasonably be retried See [ArgumentsBuilder.setEnabledDefaultUI](../-arguments-builder/set-enabled-default-u-i.html) |
| [RETRY_PROMPT_DETAIL](-r-e-t-r-y_-p-r-o-m-p-t_-d-e-t-a-i-l.html) | [androidJvm]<br>const val [RETRY_PROMPT_DETAIL](-r-e-t-r-y_-p-r-o-m-p-t_-d-e-t-a-i-l.html): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)<br>Default UI flag: a detail message about what went wrong. This flag affects how the [RETRY_PROMPT](-r-e-t-r-y_-p-r-o-m-p-t.html) UI works; it has no effect if RETRY_PROMPT is not enabled. |

