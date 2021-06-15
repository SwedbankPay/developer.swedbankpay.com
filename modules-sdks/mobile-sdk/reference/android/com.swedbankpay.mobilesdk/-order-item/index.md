---
title: OrderItem
---
//[mobilesdk](../../../index.html)/[com.swedbankpay.mobilesdk](../index.html)/[OrderItem](index.html)



# OrderItem



[androidJvm]\
data class [OrderItem](index.html)(reference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), type: [ItemType](../-item-type/index.html), class: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), itemUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, imageUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, description: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, discountDescription: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, quantity: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), quantityUnit: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), unitPrice: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html), discountPrice: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)?, vatPercent: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), amount: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html), vatAmount: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

An item being paid for, part of a [PaymentOrder](../-payment-order/index.html).



OrderItems are an optional, but recommended, part of PaymentOrders. To use them, create an OrderItem for each distinct item the paymentorder is for: e.g. if the consumer is paying for one Thingamajig and two Watchamacallits, which will be shipped to the consumer's address, you would create three OrderItems: one for the lone Thingamajig, one for the two Watchamacallits, and one for the shipping fee.



When using OrderItems, make sure that the sum of the OrderItems' amount and vatAmount are equal to the PaymentOrder's amount and vatAmount properties, respectively.



## Constructors


| | |
|---|---|
| [OrderItem](-order-item.html) | [androidJvm]<br>fun [OrderItem](-order-item.html)(reference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), type: [ItemType](../-item-type/index.html), class: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), itemUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, imageUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, description: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, discountDescription: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, quantity: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), quantityUnit: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), unitPrice: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html), discountPrice: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)? = null, vatPercent: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), amount: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html), vatAmount: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)) |


## Types


| Name | Summary |
|---|---|
| [Builder](-builder/index.html) | [androidJvm]<br>class [Builder](-builder/index.html) |


## Functions


| Name | Summary |
|---|---|
| [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [describeContents](../-view-payment-order-info/index.html#-1578325224%2FFunctions%2F-1074806346)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html) |
| [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346) | [androidJvm]<br>abstract fun [writeToParcel](../-view-payment-order-info/index.html#-1754457655%2FFunctions%2F-1074806346)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)) |


## Properties


| Name | Summary |
|---|---|
| [amount](amount.html) | [androidJvm]<br>@SerializedName(value = "amount")<br>val [amount](amount.html): [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)<br>The total amount, including VAT, paid for the specified quantity of the item. |
| [class](class.html) | [androidJvm]<br>@SerializedName(value = "class")<br>@get:[JvmName](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.jvm/-jvm-name/index.html)(name = "getItemClass")<br>val [class](class.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>A classification of the item. Must not contain spaces. |
| [description](description.html) | [androidJvm]<br>@SerializedName(value = "description")<br>val [description](description.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>Human-friendly description of the item |
| [discountDescription](discount-description.html) | [androidJvm]<br>@SerializedName(value = "discountDescription")<br>val [discountDescription](discount-description.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>Human-friendly description of the discount on the item, if applicable |
| [discountPrice](discount-price.html) | [androidJvm]<br>@SerializedName(value = "discountPrice")<br>val [discountPrice](discount-price.html): [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)? = null<br>The discounted price of the item, if applicable |
| [imageUrl](image-url.html) | [androidJvm]<br>@SerializedName(value = "imageUrl")<br>val [imageUrl](image-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>URL to an image of the item |
| [itemUrl](item-url.html) | [androidJvm]<br>@SerializedName(value = "itemUrl")<br>val [itemUrl](item-url.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null<br>URL of a web page that contains information about the item |
| [name](name.html) | [androidJvm]<br>@SerializedName(value = "name")<br>val [name](name.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>Name of the item |
| [quantity](quantity.html) | [androidJvm]<br>@SerializedName(value = "quantity")<br>val [quantity](quantity.html): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)<br>Quantity of the item being purchased |
| [quantityUnit](quantity-unit.html) | [androidJvm]<br>@SerializedName(value = "quantityUnit")<br>val [quantityUnit](quantity-unit.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>Unit of the quantity |
| [reference](reference.html) | [androidJvm]<br>@SerializedName(value = "reference")<br>val [reference](reference.html): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)<br>A reference that identifies the item in your own systems. |
| [type](type.html) | [androidJvm]<br>@SerializedName(value = "type")<br>val [type](type.html): [ItemType](../-item-type/index.html)<br>Type of the item |
| [unitPrice](unit-price.html) | [androidJvm]<br>@SerializedName(value = "unitPrice")<br>val [unitPrice](unit-price.html): [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)<br>Price of a single unit, including VAT. |
| [vatAmount](vat-amount.html) | [androidJvm]<br>@SerializedName(value = "vatAmount")<br>val [vatAmount](vat-amount.html): [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)<br>The total amount of VAT paid for the specified quantity of the item. |
| [vatPercent](vat-percent.html) | [androidJvm]<br>@SerializedName(value = "vatPercent")<br>val [vatPercent](vat-percent.html): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)<br>The VAT percent value, multiplied by 100. |

