---
title: RichState
---
//[mobilesdk](../../../../index.html)/[com.swedbankpay.mobilesdk](../../index.html)/[PaymentViewModel](../index.html)/[RichState](index.html)



# RichState



[androidJvm]\
class [RichState](index.html)

Contains the state of the payment process and possible associated data.



## Properties


| Name | Summary |
|---|---|
| [exception](exception.html) | [androidJvm]<br>val [exception](exception.html): [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)?<br>If the current state is [RETRYABLE_ERROR](../-state/-r-e-t-r-y-a-b-l-e_-e-r-r-o-r/index.html), or [FAILURE](../-state/-f-a-i-l-u-r-e/index.html) caused by an [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html), this property contains that exception. |
| [failingUri](failing-uri.html) | [androidJvm]<br>val [failingUri](failing-uri.html): [Uri](https://developer.android.com/reference/kotlin/android/net/Uri.html)?<br>If the current state is [FAILURE](../-state/-f-a-i-l-u-r-e/index.html), and it was caused by a failing redirect, this property contains the redirect [Uri](https://developer.android.com/reference/kotlin/android/net/Uri.html) that failed to load. |
| [redirectErrorCode](redirect-error-code.html) | [androidJvm]<br>val [redirectErrorCode](redirect-error-code.html): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)?<br>If the current state is [FAILURE](../-state/-f-a-i-l-u-r-e/index.html), and it was caused by a failing redirect, the error code describing the failure. The value is one of the [WebViewClient](https://developer.android.com/reference/kotlin/android/webkit/WebViewClient.html) ERROR_* constants. |
| [redirectErrorDescription](redirect-error-description.html) | [androidJvm]<br>val [redirectErrorDescription](redirect-error-description.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>If the current state is [FAILURE](../-state/-f-a-i-l-u-r-e/index.html), and it was caused by a failing redirect, a textual description of the failure. |
| [redirectHttpErrorReason](redirect-http-error-reason.html) | [androidJvm]<br>val [redirectHttpErrorReason](redirect-http-error-reason.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>If the current state is [FAILURE](../-state/-f-a-i-l-u-r-e/index.html), and it was caused by an error http response to a redirect, the reason phrase of that respone. |
| [redirectHttpErrorStatus](redirect-http-error-status.html) | [androidJvm]<br>val [redirectHttpErrorStatus](redirect-http-error-status.html): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)?<br>If the current state is [FAILURE](../-state/-f-a-i-l-u-r-e/index.html), and it was caused by an error http response to a redirect, the status code of that response. |
| [retryableErrorMessage](retryable-error-message.html) | [androidJvm]<br>val [retryableErrorMessage](retryable-error-message.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?<br>If the current state is [RETRYABLE_ERROR](../-state/-r-e-t-r-y-a-b-l-e_-e-r-r-o-r/index.html), this property contains an error message describing the situation. |
| [state](state.html) | [androidJvm]<br>val [state](state.html): [PaymentViewModel.State](../-state/index.html)<br>The state of the payment process. |
| [terminalFailure](terminal-failure.html) | [androidJvm]<br>val [terminalFailure](terminal-failure.html): [TerminalFailure](../../-terminal-failure/index.html)?<br>If the current state is [FAILURE](../-state/-f-a-i-l-u-r-e/index.html), and it was caused by an onError callback from the Chekout API, this property contains an object describing the error. |
| [updateException](update-exception.html) | [androidJvm]<br>val [updateException](update-exception.html): [Exception](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-exception/index.html)?<br>If the current state is [IN_PROGRESS](../-state/-i-n_-p-r-o-g-r-e-s-s/index.html), and an attempt to update the payment order failed, the cause of the failure. |
| [viewPaymentOrderInfo](view-payment-order-info.html) | [androidJvm]<br>val [viewPaymentOrderInfo](view-payment-order-info.html): [ViewPaymentOrderInfo](../../-view-payment-order-info/index.html)?<br>If the current state is [IN_PROGRESS](../-state/-i-n_-p-r-o-g-r-e-s-s/index.html) or [UPDATING_PAYMENT_ORDER](../-state/-u-p-d-a-t-i-n-g_-p-a-y-m-e-n-t_-o-r-d-e-r/index.html), the [ViewPaymentOrderInfo](../../-view-payment-order-info/index.html) object describing the current payment order. If the state is UPDATING_PAYMENT_ORDER, this is the last-known ViewPaymentOrderInfo. |

