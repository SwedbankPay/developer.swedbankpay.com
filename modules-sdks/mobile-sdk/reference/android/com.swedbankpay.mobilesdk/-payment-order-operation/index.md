---
title: PaymentOrderOperation
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentOrderOperation](index.html)



# PaymentOrderOperation



[androidJvm]\
enum [PaymentOrderOperation](index.html) : [Enum](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-enum/index.html)&lt;[PaymentOrderOperation](index.html)&gt; 

Type of operation the payment order performs



## Entries


| | |
|---|---|
| [VERIFY](-v-e-r-i-f-y/index.html) | [androidJvm]<br>@SerializedName(value = "Verify")<br>[VERIFY](-v-e-r-i-f-y/index.html)()<br>Pre-verification of a payment method. This operation will not charge the payment method, but it can create a token for future payments. |
| [PURCHASE](-p-u-r-c-h-a-s-e/index.html) | [androidJvm]<br>@SerializedName(value = "Purchase")<br>[PURCHASE](-p-u-r-c-h-a-s-e/index.html)()<br>A purchase, i.e. a single payment |


## Properties


| Name | Summary |
|---|---|
| [name](../-re-order-purchase-indicator/-f-i-r-s-t_-t-i-m-e_-o-r-d-e-r-e-d/index.html#-372974862%2FProperties%2F-1074806346) | [androidJvm]<br>val [name](../-re-order-purchase-indicator/-f-i-r-s-t_-t-i-m-e_-o-r-d-e-r-e-d/index.html#-372974862%2FProperties%2F-1074806346): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) |
| [ordinal](../-re-order-purchase-indicator/-f-i-r-s-t_-t-i-m-e_-o-r-d-e-r-e-d/index.html#-739389684%2FProperties%2F-1074806346) | [androidJvm]<br>val [ordinal](../-re-order-purchase-indicator/-f-i-r-s-t_-t-i-m-e_-o-r-d-e-r-e-d/index.html#-739389684%2FProperties%2F-1074806346): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |

