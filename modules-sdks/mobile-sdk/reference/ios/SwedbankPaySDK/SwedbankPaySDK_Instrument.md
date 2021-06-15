---
title: SwedbankPaySDK.Instrument
---
# SwedbankPaySDK.Instrument

Payment instrument for an Instrument mode payment order.

``` swift
struct Instrument: RawRepresentable, Hashable, Codable 
```

## Inheritance

`Codable`, `Hashable`, `RawRepresentable`

## Initializers

### `init(rawValue:)`

``` swift
public init(rawValue: String) 
```

## Properties

### `creditCard`

Credit or Debit Card

``` swift
public static let creditCard 
```

### `swish`

Swish

``` swift
public static let swish 
```

### `vipps`

Vipps

``` swift
public static let vipps 
```

### `invoiceSE`

Swedbank Pay Invoice (Sweden)

``` swift
public static let invoiceSE 
```

### `invoiceNO`

Swedbank Pay Invoice (Norway)

``` swift
public static let invoiceNO 
```

### `monthlyInvoiceSE`

Swedbank Pay Monthly Invoice (Sweden)

``` swift
public static let monthlyInvoiceSE 
```

### `carPay`

Volvofinans CarPay

``` swift
public static let carPay 
```

### `creditAccount`

Credit Account

``` swift
public static let creditAccount 
```

### `rawValue`

``` swift
public var rawValue: String
```

### `invoice`

``` swift
@available(*, deprecated, message: "Use invoiceSE instead")
    static var invoice: Self 
```
