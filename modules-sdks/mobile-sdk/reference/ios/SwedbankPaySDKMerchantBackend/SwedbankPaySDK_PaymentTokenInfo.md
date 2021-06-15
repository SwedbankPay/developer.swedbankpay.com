---
title: SwedbankPaySDK.PaymentTokenInfo
---
# SwedbankPaySDK.PaymentTokenInfo

Information about a payment token

``` swift
struct PaymentTokenInfo: Decodable 
```

## Inheritance

`Decodable`

## Properties

### `paymentToken`

The actual paymentToken

``` swift
public var paymentToken: String
```

### `instrument`

Payment instrument type of this token

``` swift
public var instrument: Instrument?
```

### `instrumentDisplayName`

User-friendly description of the payment instrument

``` swift
public var instrumentDisplayName: String?
```

### `instrumentParameters`

Instrument-specific parameters.

``` swift
public var instrumentParameters: [String: String]?
```

### `operations`

Operations you can perform on this token.

``` swift
public var operations: [Operation]?
```

Note that you generally cannot call these from your mobile app.

### `mobileSDK`

``` swift
var mobileSDK: MobileSDK?
```
