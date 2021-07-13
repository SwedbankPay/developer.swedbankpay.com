---
title: OrderItem -
---
//[sdk](../../../index)/[com.swedbankpay.mobilesdk](../index)/[OrderItem](index)



# OrderItem  
 [androidJvm] data class [OrderItem](index)(**reference**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), **name**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), **type**: [ItemType](../-item-type/index), **class**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), **itemUrl**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **imageUrl**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **description**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **discountDescription**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)?, **quantity**: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), **quantityUnit**: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), **unitPrice**: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html), **discountPrice**: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)?, **vatPercent**: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), **amount**: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html), **vatAmount**: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)) : [Parcelable](https://developer.android.com/reference/kotlin/android/os/Parcelable.html)

An item being paid for, part of a [PaymentOrder](../-payment-order/index).



OrderItems are an optional, but recommended, part of PaymentOrders. To use them, create an OrderItem for each distinct item the paymentorder is for: e.g. if the consumer is paying for one Thingamajig and two Watchamacallits, which will be shipped to the consumer's address, you would create three OrderItems: one for the lone Thingamajig, one for the two Watchamacallits, and one for the shipping fee.



When using OrderItems, make sure that the sum of the OrderItems' amount and vatAmount are equal to the PaymentOrder's amount and vatAmount properties, respectively.

   


## Constructors  
  
| | |
|---|---|
| <a name="com.swedbankpay.mobilesdk/OrderItem/OrderItem/#kotlin.String#kotlin.String#com.swedbankpay.mobilesdk.ItemType#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String?#kotlin.String?#kotlin.Int#kotlin.String#kotlin.Long#kotlin.Long?#kotlin.Int#kotlin.Long#kotlin.Long/PointingToDeclaration/"></a>[OrderItem](-order-item)| <a name="com.swedbankpay.mobilesdk/OrderItem/OrderItem/#kotlin.String#kotlin.String#com.swedbankpay.mobilesdk.ItemType#kotlin.String#kotlin.String?#kotlin.String?#kotlin.String?#kotlin.String?#kotlin.Int#kotlin.String#kotlin.Long#kotlin.Long?#kotlin.Int#kotlin.Long#kotlin.Long/PointingToDeclaration/"></a> [androidJvm] fun [OrderItem](-order-item)(reference: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), name: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), type: [ItemType](../-item-type/index), class: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), itemUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, imageUrl: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, description: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, discountDescription: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = null, quantity: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), quantityUnit: [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html), unitPrice: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html), discountPrice: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)? = null, vatPercent: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html), amount: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html), vatAmount: [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html))   <br>|


## Types  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/OrderItem.Builder///PointingToDeclaration/"></a>[Builder](-builder/index)| <a name="com.swedbankpay.mobilesdk/OrderItem.Builder///PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>class [Builder](-builder/index)  <br><br><br>|


## Functions  
  
|  Name |  Summary | 
|---|---|
| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[describeContents](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/describeContents/#/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [describeContents](../../com.swedbankpay.mobilesdk.merchantbackend/-merchant-backend-problem/-server/-unknown/index.md#-1578325224%2FFunctions%2F-1404661416)(): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)  <br><br><br>|
| <a name="android.os/Parcelable/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[writeToParcel](../-view-payment-order-info/index.md#-1754457655%2FFunctions%2F-1404661416)| <a name="android.os/Parcelable/writeToParcel/#android.os.Parcel#kotlin.Int/PointingToDeclaration/"></a>[androidJvm]  <br>Content  <br>abstract fun [writeToParcel](../-view-payment-order-info/index.md#-1754457655%2FFunctions%2F-1404661416)(p0: [Parcel](https://developer.android.com/reference/kotlin/android/os/Parcel.html), p1: [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html))  <br><br><br>|


## Properties  
  
|  Name |  Summary | 
|---|---|
| <a name="com.swedbankpay.mobilesdk/OrderItem/amount/#/PointingToDeclaration/"></a>[amount](amount)| <a name="com.swedbankpay.mobilesdk/OrderItem/amount/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = amount)  <br>  <br>val [amount](amount): [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)The total amount, including VAT, paid for the specified quantity of the item.   <br>|
| <a name="com.swedbankpay.mobilesdk/OrderItem/class/#/PointingToDeclaration/"></a>[class](class)| <a name="com.swedbankpay.mobilesdk/OrderItem/class/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = class)  <br>  <br>val [class](class): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)A classification of the item.   <br>|
| <a name="com.swedbankpay.mobilesdk/OrderItem/description/#/PointingToDeclaration/"></a>[description](description)| <a name="com.swedbankpay.mobilesdk/OrderItem/description/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = description)  <br>  <br>val [description](description): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullHuman-friendly description of the item   <br>|
| <a name="com.swedbankpay.mobilesdk/OrderItem/discountDescription/#/PointingToDeclaration/"></a>[discountDescription](discount-description)| <a name="com.swedbankpay.mobilesdk/OrderItem/discountDescription/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = discountDescription)  <br>  <br>val [discountDescription](discount-description): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullHuman-friendly description of the discount on the item, if applicable   <br>|
| <a name="com.swedbankpay.mobilesdk/OrderItem/discountPrice/#/PointingToDeclaration/"></a>[discountPrice](discount-price)| <a name="com.swedbankpay.mobilesdk/OrderItem/discountPrice/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = discountPrice)  <br>  <br>val [discountPrice](discount-price): [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)? = nullThe discounted price of the item, if applicable   <br>|
| <a name="com.swedbankpay.mobilesdk/OrderItem/imageUrl/#/PointingToDeclaration/"></a>[imageUrl](image-url)| <a name="com.swedbankpay.mobilesdk/OrderItem/imageUrl/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = imageUrl)  <br>  <br>val [imageUrl](image-url): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullURL to an image of the item   <br>|
| <a name="com.swedbankpay.mobilesdk/OrderItem/itemUrl/#/PointingToDeclaration/"></a>[itemUrl](item-url)| <a name="com.swedbankpay.mobilesdk/OrderItem/itemUrl/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = itemUrl)  <br>  <br>val [itemUrl](item-url): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)? = nullURL of a web page that contains information about the item   <br>|
| <a name="com.swedbankpay.mobilesdk/OrderItem/name/#/PointingToDeclaration/"></a>[name](name)| <a name="com.swedbankpay.mobilesdk/OrderItem/name/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = name)  <br>  <br>val [name](name): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)Name of the item   <br>|
| <a name="com.swedbankpay.mobilesdk/OrderItem/quantity/#/PointingToDeclaration/"></a>[quantity](quantity)| <a name="com.swedbankpay.mobilesdk/OrderItem/quantity/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = quantity)  <br>  <br>val [quantity](quantity): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)Quantity of the item being purchased   <br>|
| <a name="com.swedbankpay.mobilesdk/OrderItem/quantityUnit/#/PointingToDeclaration/"></a>[quantityUnit](quantity-unit)| <a name="com.swedbankpay.mobilesdk/OrderItem/quantityUnit/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = quantityUnit)  <br>  <br>val [quantityUnit](quantity-unit): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)Unit of the quantityE.g.   <br>|
| <a name="com.swedbankpay.mobilesdk/OrderItem/reference/#/PointingToDeclaration/"></a>[reference](reference)| <a name="com.swedbankpay.mobilesdk/OrderItem/reference/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = reference)  <br>  <br>val [reference](reference): [String](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)A reference that identifies the item in your own systems.   <br>|
| <a name="com.swedbankpay.mobilesdk/OrderItem/type/#/PointingToDeclaration/"></a>[type](type)| <a name="com.swedbankpay.mobilesdk/OrderItem/type/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = type)  <br>  <br>val [type](type): [ItemType](../-item-type/index)Type of the item   <br>|
| <a name="com.swedbankpay.mobilesdk/OrderItem/unitPrice/#/PointingToDeclaration/"></a>[unitPrice](unit-price)| <a name="com.swedbankpay.mobilesdk/OrderItem/unitPrice/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = unitPrice)  <br>  <br>val [unitPrice](unit-price): [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)Price of a single unit, including VAT.   <br>|
| <a name="com.swedbankpay.mobilesdk/OrderItem/vatAmount/#/PointingToDeclaration/"></a>[vatAmount](vat-amount)| <a name="com.swedbankpay.mobilesdk/OrderItem/vatAmount/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = vatAmount)  <br>  <br>val [vatAmount](vat-amount): [Long](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-long/index.html)The total amount of VAT paid for the specified quantity of the item.   <br>|
| <a name="com.swedbankpay.mobilesdk/OrderItem/vatPercent/#/PointingToDeclaration/"></a>[vatPercent](vat-percent)| <a name="com.swedbankpay.mobilesdk/OrderItem/vatPercent/#/PointingToDeclaration/"></a> [androidJvm] @SerializedName(value = vatPercent)  <br>  <br>val [vatPercent](vat-percent): [Int](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-int/index.html)The VAT percent value, multiplied by 100.   <br>|

