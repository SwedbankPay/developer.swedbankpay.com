---
title: SwedbankPaySDK.PayeeInfo
---
# SwedbankPaySDK.PayeeInfo

Information about the payee (recipient) of a payment order

``` swift
struct PayeeInfo : Codable, Equatable 
```

## Inheritance

`Codable`, `Equatable`

## Initializers

### `init(payeeId:payeeReference:payeeName:productCategory:orderReference:subsite:)`

``` swift
public init(
            payeeId: String = "",
            payeeReference: String = "",
            payeeName: String? = nil,
            productCategory: String? = nil,
            orderReference: String? = nil,
            subsite: String? = nil
        ) 
```

## Properties

### `payeeId`

The unique identifier of this payee set by Swedbank Pay.

``` swift
public var payeeId: String
```

This is usually the Merchant ID. However, usually best idea to set this value in your backend
instead. Thus, this property defaults to the empty string, but it is included in the data
model for completeness.

### `payeeReference`

A unique reference for this operation.

``` swift
public var payeeReference: String
```

See `https://developer.swedbankpay.com/checkout/other-features#payee-reference`

Like `payeeId`, this is usually best to set in your backend, and this property thus defaults
to the empty string.

### `payeeName`

Name of the payee, usually the name of the merchant.

``` swift
public var payeeName: String?
```

### `productCategory`

A product category or number sent in from the payee/merchant.

``` swift
public var productCategory: String?
```

This is not validated by Swedbank Pay, but will be passed through the payment process and may
be used in the settlement process.

### `orderReference`

A reference to your own merchant system.

``` swift
public var orderReference: String?
```

### `subsite`

Used for split settlement.

``` swift
public var subsite: String?
```
