---
title: SwedbankPaySDK_Consumer
---
# SwedbankPaySDK.Consumer

Consumer object for Swedbank Pay SDK

``` swift
struct Consumer: Codable 
```

## Inheritance

`Codable`

## Initializers

### `init(operation:language:shippingAddressRestrictedToCountryCodes:)`

``` swift
public init(
            operation: ConsumerOperation = .InitiateConsumerSession,
            language: Language = .English,
            shippingAddressRestrictedToCountryCodes: [String]
        ) 
```

## Properties

### `operation`

``` swift
public var operation: ConsumerOperation
```

### `language`

``` swift
public var language: Language
```

### `shippingAddressRestrictedToCountryCodes`

``` swift
public var shippingAddressRestrictedToCountryCodes: [String]
```
