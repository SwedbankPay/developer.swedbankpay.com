---
title: SwedbankPaySDK.ShipIndicator
---
# SwedbankPaySDK.ShipIndicator

Shipping method for `SwedbankPaySDK.RiskIndicator`

``` swift
enum ShipIndicator 
```

## Enumeration Cases

### `ShipToBillingAddress`

Ship to cardholder's billing address

``` swift
case ShipToBillingAddress
```

### `ShipToVerifiedAddress`

Ship to another verified address on file with the merchant

``` swift
case ShipToVerifiedAddress
```

### `ShipToDifferentAddress`

Ship to an address different to the cardholder's billing address

``` swift
case ShipToDifferentAddress
```

### `PickUpAtStore`

Ship to store/pick-up at store. Populate the pick-up address as completely as possible.

``` swift
case PickUpAtStore(pickUpAddress: PickUpAddress)
```

### `DigitalGoods`

Digital goods, no physical delivery

``` swift
case DigitalGoods
```

### `Tickets`

Travel and event tickets, no shipping

``` swift
case Tickets
```

### `Other`

Other, e.g. gaming, digital service

``` swift
case Other
```

## Properties

### `raw`

``` swift
var raw: Raw 
```

### `pickUpAddress`

``` swift
var pickUpAddress: SwedbankPaySDK.PickUpAddress? 
```
