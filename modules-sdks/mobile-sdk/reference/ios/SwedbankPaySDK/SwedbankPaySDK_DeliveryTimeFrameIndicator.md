---
title: SwedbankPaySDK.DeliveryTimeFrameIndicator
---
# SwedbankPaySDK.DeliveryTimeFrameIndicator

Product delivery timeframe for a `SwedbankPaySDK.RiskIndicator`.

``` swift
enum DeliveryTimeFrameIndicator : String, Codable 
```

## Inheritance

`Codable`, `String`

## Enumeration Cases

### `ElectronicDelivery`

Product is delivered electronically; no physical shipping.

``` swift
case ElectronicDelivery = "01"
```

### `SameDayShipping`

Product is delivered on the same day.

``` swift
case SameDayShipping = "02"
```

### `OvernightShipping`

Product is delivered on the next day.

``` swift
case OvernightShipping = "03"
```

### `TwoDayOrMoreShipping`

Product is delivered in two days or later.

``` swift
case TwoDayOrMoreShipping = "04"
```
