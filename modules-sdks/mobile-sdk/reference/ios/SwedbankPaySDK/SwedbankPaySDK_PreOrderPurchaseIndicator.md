---
title: SwedbankPaySDK.PreOrderPurchaseIndicator
---
# SwedbankPaySDK.PreOrderPurchaseIndicator

Pre-order purchase indicator values for `SwedbankPaySDK.RiskIndicator`

``` swift
enum PreOrderPurchaseIndicator : String, Codable 
```

## Inheritance

`Codable`, `String`

## Enumeration Cases

### `MerchandiseAvailable`

Merchandise available now

``` swift
case MerchandiseAvailable = "01"
```

### `FutureAvailability`

Merchandise will be available in the future

``` swift
case FutureAvailability = "02"
```
