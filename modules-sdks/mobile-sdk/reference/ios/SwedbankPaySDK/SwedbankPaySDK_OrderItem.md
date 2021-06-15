---
title: SwedbankPaySDK.OrderItem
---
# SwedbankPaySDK.OrderItem

An item being paid for, part of a `PaymentOrder`.

``` swift
struct OrderItem : Codable, Equatable 
```

OrderItems are an optional, but recommended, part of `PaymentOrder`s.
To use them, create an `OrderItem` for each distinct item the payment order
is for: e.g. if the consumer is paying for one Thingamajig and two
Watchamacallits, which will be shipped to the consumer's address,
you would create three `OrderItem`s: one for the lone Thingamajig,
one for the two Watchamacallits, and one for the shipping fee.

When using `OrderItem`s, make sure that the sum of the `OrderItem`s'
`amount` and `vatAmount` are equal to the `PaymentOrder`'s `amount`
and `vatAmount` properties, respectively.

## Inheritance

`Codable`, `Equatable`

## Initializers

### `init(reference:name:type:class:itemUrl:imageUrl:description:discountDescription:quantity:quantityUnit:unitPrice:discountPrice:vatPercent:amount:vatAmount:)`

``` swift
public init(
            reference: String,
            name: String,
            type: ItemType,
            class: String,
            itemUrl: URL? = nil,
            imageUrl: URL? = nil,
            description: String? = nil,
            discountDescription: String? = nil,
            quantity: Int,
            quantityUnit: String,
            unitPrice: Int64,
            discountPrice: Int64? = nil,
            vatPercent: Int,
            amount: Int64,
            vatAmount: Int64
        ) 
```

## Properties

### `reference`

A reference that identifies the item in your own systems.

``` swift
public var reference: String
```

### `name`

Name of the item

``` swift
public var name: String
```

### `type`

Type of the item

``` swift
public var type: ItemType
```

### `` `class` ``

A classification of the item. Must not contain spaces.

``` swift
public var `class`: String
```

Can be used for assigning the order item to a specific product category,
such as `"MobilePhone"`.

Swedbank Pay may use this field for statistics.

### `itemUrl`

URL of a web page that contains information about the item

``` swift
public var itemUrl: URL?
```

### `imageUrl`

URL to an image of the item

``` swift
public var imageUrl: URL?
```

### `description`

Human-friendly description of the item

``` swift
public var description: String?
```

### `discountDescription`

Human-friendly description of the discount on the item, if applicable

``` swift
public var discountDescription: String?
```

### `quantity`

Quantity of the item being purchased

``` swift
public var quantity: Int
```

### `quantityUnit`

Unit of the quantity

``` swift
public var quantityUnit: String
```

E.g. `"pcs"`, `"grams"`

### `unitPrice`

Price of a single unit, including VAT.

``` swift
public var unitPrice: Int64
```

### `discountPrice`

The discounted price of the item, if applicable

``` swift
public var discountPrice: Int64?
```

### `vatPercent`

The VAT percent value, multiplied by 100.

``` swift
public var vatPercent: Int
```

E.g. 25% would be represented as `2500`.

### `amount`

The total amount, including VAT, paid for the specified quantity of the item.

``` swift
public var amount: Int64
```

Denoted in the smallest monetary unit applicable, typically 1/100.
E.g. 50.00 SEK would be represented as `5000`.

### `vatAmount`

The total amount of VAT paid for the specified quantity of the item.

``` swift
public var vatAmount: Int64
```

Denoted in the smallest monetary unit applicable, typically 1/100.
E.g. 50.00 SEK would be represented as `5000`.
