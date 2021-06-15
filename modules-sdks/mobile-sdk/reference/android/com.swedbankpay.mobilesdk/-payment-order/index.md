---
title: PaymentOrder
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[PaymentOrder](index.html)



# PaymentOrder



[androidJvm]\
data class [PaymentOrder](index.html)(operation: [PaymentOrderOperation](../-payment-order-operation/index.html), currency: [Currency](https://developer.android.com/reference/kotlin/java/util/Currency.html), amount: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html), vatAmount: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html), description: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), userAgent: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), language: [Language](../-language/index.html), instrument: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, generateRecurrenceToken: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html), generatePaymentToken: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html), disableStoredPaymentDetails: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html), restrictedToInstruments: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;?, urls: [PaymentOrderUrls](../-payment-order-urls/index.html), payeeInfo: [PayeeInfo](../-payee-info/index.html), payer: [PaymentOrderPayer](../-payment-order-payer/index.html)?, orderItems: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[OrderItem](../-order-item/index.html)&gt;?, riskIndicator: [RiskIndicator](../-risk-indicator/index.html)?, disablePaymentMenu: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html), paymentToken: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, initiatingSystemUserAgent: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

Description a payment order.



This class mirrors the body the Swedbank Pay [POST /psp/paymentorders](https://developer.swedbankpay.com/checkout/other-features#creating-a-payment-order) endpoint, and is designed to work together with com.swedbankpay.mobilesdk.merchantbackend.MerchantBackendConfiguration and a server implementing the [Merchant Backend API](https://https://developer.swedbankpay.com/modules-sdks/mobile-sdk/merchant-backend), but you can also use it with your custom [Configuration](../-configuration/index.html).



## Constructors


| | |
|---|---|
| [PaymentOrder](-payment-order.html) | [androidJvm]<br>fun [PaymentOrder](-payment-order.html)(operation: [PaymentOrderOperation](../-payment-order-operation/index.html) = PaymentOrderOperation.PURCHASE, currency: [Currency](https://developer.android.com/reference/kotlin/java/util/Currency.html), amount: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html), vatAmount: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html), description: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), userAgent: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html) = DEFAULT_USER_AGENT, language: [Language](../-language/index.html) = Language.ENGLISH, instrument: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, generateRecurrenceToken: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) = false, generatePaymentToken: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) = false, disableStoredPaymentDetails: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) = false, restrictedToInstruments: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;? = null, urls: [PaymentOrderUrls](../-payment-order-urls/index.html), payeeInfo: [PayeeInfo](../-payee-info/index.html) = PayeeInfo(), payer: [PaymentOrderPayer](../-payment-order-payer/index.html)? = null, orderItems: [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[OrderItem](../-order-item/index.html)&gt;? = null, riskIndicator: [RiskIndicator](../-risk-indicator/index.html)? = null, disablePaymentMenu: [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) = false, paymentToken: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, initiatingSystemUserAgent: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null) |


## Types


| Name | Summary |
|---|---|
| [Builder](-builder/index.html) | [androidJvm]<br>class [Builder](-builder/index.html) |
| [Companion](-companion/index.html) | [androidJvm]<br>object [Companion](-companion/index.html) |


## Functions


| Name | Summary |
|---|---|
| [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [amount](amount.html) | [androidJvm]<br>@SerializedName(value = "amount")<br>val [amount](amount.html): [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)<br>Payment amount, including VAT |
| [currency](currency.html) | [androidJvm]<br>@SerializedName(value = "currency")<br>val [currency](currency.html): [Currency](https://developer.android.com/reference/kotlin/java/util/Currency.html)<br>Currency to use |
| [description](description.html) | [androidJvm]<br>@SerializedName(value = "description")<br>val [description](description.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>A description of the payment order |
| [disablePaymentMenu](disable-payment-menu.html) | [androidJvm]<br>@SerializedName(value = "disablePaymentMenu")<br>val [disablePaymentMenu](disable-payment-menu.html): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) = false |
| [disableStoredPaymentDetails](disable-stored-payment-details.html) | [androidJvm]<br>@SerializedName(value = "disableStoredPaymentDetails")<br>val [disableStoredPaymentDetails](disable-stored-payment-details.html): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) = false<br>If true, the payment menu will not show any stored payment details. |
| [generatePaymentToken](generate-payment-token.html) | [androidJvm]<br>@SerializedName(value = "generatePaymentToken")<br>val [generatePaymentToken](generate-payment-token.html): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) = false<br>If true, a payment token will be created from this payment order |
| [generateRecurrenceToken](generate-recurrence-token.html) | [androidJvm]<br>@SerializedName(value = "generateRecurrenceToken")<br>val [generateRecurrenceToken](generate-recurrence-token.html): [Boolean](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-boolean/index.html) = false<br>If true, the a recurrence token will be created from this payment order |
| [initiatingSystemUserAgent](initiating-system-user-agent.html) | [androidJvm]<br>@SerializedName(value = "initiatingSystemUserAgent")<br>val [initiatingSystemUserAgent](initiating-system-user-agent.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null |
| [instrument](instrument.html) | [androidJvm]<br>@SerializedName(value = "instrument")<br>val [instrument](instrument.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>The payment instrument to use in instrument mode. |
| [language](language.html) | [androidJvm]<br>@SerializedName(value = "language")<br>val [language](language.html): [Language](../-language/index.html)<br>Language to use in the payment menu |
| [operation](operation.html) | [androidJvm]<br>@SerializedName(value = "operation")<br>val [operation](operation.html): [PaymentOrderOperation](../-payment-order-operation/index.html)<br>The operation to perform |
| [orderItems](order-items.html) | [androidJvm]<br>@SerializedName(value = "orderItems")<br>val [orderItems](order-items.html): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[OrderItem](../-order-item/index.html)&gt;? = null<br>A list of items that are being paid for by this payment order. |
| [payeeInfo](payee-info.html) | [androidJvm]<br>@SerializedName(value = "payeeInfo")<br>val [payeeInfo](payee-info.html): [PayeeInfo](../-payee-info/index.html)<br>Information about the payee (recipient) |
| [payer](payer.html) | [androidJvm]<br>@SerializedName(value = "payer")<br>val [payer](payer.html): [PaymentOrderPayer](../-payment-order-payer/index.html)? = null<br>Information about the payer |
| [paymentToken](payment-token.html) | [androidJvm]<br>@SerializedName(value = "paymentToken")<br>val [paymentToken](payment-token.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>A payment token to use for this payment. |
| [restrictedToInstruments](restricted-to-instruments.html) | [androidJvm]<br>@SerializedName(value = "restrictedToInstruments")<br>val [restrictedToInstruments](restricted-to-instruments.html): [List](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html)&lt;[String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)&gt;? = null<br>If set, only shows the specified payment instruments in the payment menu |
| [riskIndicator](risk-indicator.html) | [androidJvm]<br>@SerializedName(value = "riskIndicator")<br>val [riskIndicator](risk-indicator.html): [RiskIndicator](../-risk-indicator/index.html)? = null<br>A collection of additional data to minimize the risk of 3-D Secure strong authentication. |
| [urls](urls.html) | [androidJvm]<br>@SerializedName(value = "urls")<br>val [urls](urls.html): [PaymentOrderUrls](../-payment-order-urls/index.html)<br>A set of URLs related to the payment. |
| [userAgent](user-agent.html) | [androidJvm]<br>@SerializedName(value = "userAgent")<br>val [userAgent](user-agent.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>User-agent of the payer. |
| [vatAmount](vat-amount.html) | [androidJvm]<br>@SerializedName(value = "vatAmount")<br>val [vatAmount](vat-amount.html): [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)<br>Amount of VAT included in the payment |

