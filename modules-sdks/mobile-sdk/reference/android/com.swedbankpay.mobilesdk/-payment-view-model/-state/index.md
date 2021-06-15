---
title: State
---
//[mobilesdk](../../../../index.html)/[com.swedbankpay.mobilesdk](../../index.html)/[PaymentViewModel](../index.html)/[State](index.html)



# State



[androidJvm]\
enum [State](index.html) : [Enum](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-enum/index.html)&lt;[PaymentViewModel.State](index.html)&gt; 

State of a payment process



## Entries


| | |
|---|---|
| [FAILURE](-f-a-i-l-u-r-e/index.html) | [androidJvm]<br>[FAILURE](-f-a-i-l-u-r-e/index.html)()<br>Payment has failed. You should hide the [PaymentFragment](../../-payment-fragment/index.html) and show a failure message. |
| [RETRYABLE_ERROR](-r-e-t-r-y-a-b-l-e_-e-r-r-o-r/index.html) | [androidJvm]<br>[RETRYABLE_ERROR](-r-e-t-r-y-a-b-l-e_-e-r-r-o-r/index.html)()<br>Payment is active, but could not proceed. |
| [CANCELED](-c-a-n-c-e-l-e-d/index.html) | [androidJvm]<br>[CANCELED](-c-a-n-c-e-l-e-d/index.html)()<br>Payment was canceled by the user. You should hide the [PaymentFragment](../../-payment-fragment/index.html). |
| [COMPLETE](-c-o-m-p-l-e-t-e/index.html) | [androidJvm]<br>[COMPLETE](-c-o-m-p-l-e-t-e/index.html)()<br>Payment is complete. You should hide the [PaymentFragment](../../-payment-fragment/index.html). This status does not signal anything of whether the payment was successful. You need to check the status from your servers. |
| [UPDATING_PAYMENT_ORDER](-u-p-d-a-t-i-n-g_-p-a-y-m-e-n-t_-o-r-d-e-r/index.html) | [androidJvm]<br>[UPDATING_PAYMENT_ORDER](-u-p-d-a-t-i-n-g_-p-a-y-m-e-n-t_-o-r-d-e-r/index.html)()<br>Payment order is being updated (because you called [updatePaymentOrder](../update-payment-order.html)). |
| [IN_PROGRESS](-i-n_-p-r-o-g-r-e-s-s/index.html) | [androidJvm]<br>[IN_PROGRESS](-i-n_-p-r-o-g-r-e-s-s/index.html)()<br>Payment is active and is waiting either for user interaction or backend response |
| [IDLE](-i-d-l-e/index.html) | [androidJvm]<br>[IDLE](-i-d-l-e/index.html)()<br>No payment active |


## Properties


| Name | Summary |
|---|---|
| [isFinal](is-final.html) | [androidJvm]<br>abstract val [isFinal](is-final.html): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html)<br>true if this is a final state for [PaymentFragment](../../-payment-fragment/index.html), false otherwise |
| [name](../../-re-order-purchase-indicator/-f-i-r-s-t_-t-i-m-e_-o-r-d-e-r-e-d/index.html#-372974862%2FProperties%2F-1074806346) | [androidJvm]<br>val [name](../../-re-order-purchase-indicator/-f-i-r-s-t_-t-i-m-e_-o-r-d-e-r-e-d/index.html#-372974862%2FProperties%2F-1074806346): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [ordinal](../../-re-order-purchase-indicator/-f-i-r-s-t_-t-i-m-e_-o-r-d-e-r-e-d/index.html#-739389684%2FProperties%2F-1074806346) | [androidJvm]<br>val [ordinal](../../-re-order-purchase-indicator/-f-i-r-s-t_-t-i-m-e_-o-r-d-e-r-e-d/index.html#-739389684%2FProperties%2F-1074806346): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |

