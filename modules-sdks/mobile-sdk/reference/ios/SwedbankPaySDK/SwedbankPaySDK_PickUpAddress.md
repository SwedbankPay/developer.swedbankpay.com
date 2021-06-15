---
title: SwedbankPaySDK.PickUpAddress
---
# SwedbankPaySDK.PickUpAddress

Pick-up address data for `SwedbankPaySDK.RiskIndicator`

``` swift
struct PickUpAddress : Codable, Equatable 
```

When using `ShipIndicator.PickUpAtStore`, you should populate this data as completely as
possible to decrease the risk factor of the purchase.

## Inheritance

`Codable`, `Equatable`

## Properties

### `name`

Name of the payer

``` swift
public var name: String?
```

### `streetAddress`

Street address of the payer

``` swift
public var streetAddress: String?
```

### `coAddress`

C/O address of the payer

``` swift
public var coAddress: String?
```

### `city`

City of the payer

``` swift
public var city: String?
```

### `zipCode`

Zip code of the payer

``` swift
public var zipCode: String?
```

### `countryCode`

Country code of the payer

``` swift
public var countryCode: String?
```
