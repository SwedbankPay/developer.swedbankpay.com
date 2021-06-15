---
title: SwedbankPaySDK.ReOrderPurchaseIndicator
---
# SwedbankPaySDK.ReOrderPurchaseIndicator

Re-order purchase indicator values for `SwedbankPaySDK.RiskIndicator`

``` swift
enum ReOrderPurchaseIndicator : String, Codable 
```

## Inheritance

`Codable`, `String`

## Enumeration Cases

### `FirstTimeOrdered`

First purchase of this merchandise

``` swift
case FirstTimeOrdered = "01"
```

### `Reordered`

Re-order of previously purchased merchandise

``` swift
case Reordered = "02"
```
