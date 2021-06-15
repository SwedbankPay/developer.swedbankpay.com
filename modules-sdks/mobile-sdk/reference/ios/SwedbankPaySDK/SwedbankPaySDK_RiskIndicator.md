---
title: SwedbankPaySDK.RiskIndicator
---
# SwedbankPaySDK.RiskIndicator

Optional information to reduce the risk factor of a payment.

``` swift
struct RiskIndicator : Codable, Equatable 
```

You should populate this data as completely as possible to decrease the likelihood of 3-D Secure
Strong Authentication.

## Inheritance

`Codable`, `Equatable`

## Initializers

### `init(deliveryEmailAddress:deliveryTimeFrameIndicator:preOrderDate:preOrderPurchaseIndicator:shipIndicator:giftCardPurchase:reOrderPurchaseIndicator:)`

``` swift
public init(
            deliveryEmailAddress: String? = nil,
            deliveryTimeFrameIndicator: SwedbankPaySDK.DeliveryTimeFrameIndicator? = nil,
            preOrderDate: DateComponents? = nil,
            preOrderPurchaseIndicator: SwedbankPaySDK.PreOrderPurchaseIndicator? = nil,
            shipIndicator: SwedbankPaySDK.ShipIndicator? = nil,
            giftCardPurchase: Bool? = nil,
            reOrderPurchaseIndicator: SwedbankPaySDK.ReOrderPurchaseIndicator? = nil
        ) 
```

## Properties

### `deliveryEmailAddress`

For electronic delivery, the e-mail address where the merchandise is delivered

``` swift
public var deliveryEmailAddress: String?
```

### `deliveryTimeFrameIndicator`

Indicator of merchandise delivery timeframe.

``` swift
public var deliveryTimeFrameIndicator: DeliveryTimeFrameIndicator?
```

### `preOrderDate`

If this is a pre-order, the expected date that the merchandise will be available on.

``` swift
public var preOrderDate: String?
```

Format is `YYYYMMDD`. The initializer formats a `DateComponents` value to the correct
format for this field.

### `preOrderPurchaseIndicator`

Indicates whether this is a pre-order.

``` swift
public var preOrderPurchaseIndicator: PreOrderPurchaseIndicator?
```

### `shipIndicator`

Indicates the shipping method for this order.

``` swift
public var shipIndicator: ShipIndicator.Raw?
```

Values are according to the Swedbank Pay documentation;
see `https://developer.swedbankpay.com/checkout/payment-menu#request`.
The initializer takes a  a \[SwedbankPaySDK.ShipIndicator\] argument, which
models the different options in a Swift-native way.

### `pickUpAddress`

If `shipIndicator` is `"04"`, i.e. `.PickUpAtStore`,
this field should be populated.

``` swift
public var pickUpAddress: PickUpAddress?
```

The initializer takes care of setting this field correctly according
to the passed-in `SwedbankPaySDK.ShipIndicator`.

### `giftCardPurchase`

`true` if this is a purchase of a gift card

``` swift
public var giftCardPurchase: Bool?
```

### `reOrderPurchaseIndicator`

Indicates whether this is a re-order of previously purchased merchandise.

``` swift
public var reOrderPurchaseIndicator: ReOrderPurchaseIndicator?
```
