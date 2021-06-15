---
title: SwedbankPaySDK.PaymentOrderOperation
---
# SwedbankPaySDK.PaymentOrderOperation

Type of operation the payment order performs

``` swift
enum PaymentOrderOperation : String, Codable 
```

## Inheritance

`Codable`, `String`

## Enumeration Cases

### `Purchase`

A purchase, i.e. a single payment

``` swift
case Purchase
```

### `Verify`

Pre-verification of a payment method. This operation will not charge the payment method,
but it can create a token for future payments.

``` swift
case Verify
```

See `PaymentOrder.generateRecurrenceToken`, `PaymentOrder.generatePaymentToken`
