---
title: SwedbankPaySDK.PayerOwnedPaymentTokens
---
# SwedbankPaySDK.PayerOwnedPaymentTokens

Payload of PayerOwnedPaymentTokensResponse

``` swift
struct PayerOwnedPaymentTokens: Decodable 
```

## Inheritance

`Decodable`

## Properties

### `id`

The id (url) of this resource.

``` swift
public var id: String
```

Note that you generally cannot dereference this from your mobile app.

### `payerReference`

The payerReference associated with these tokens

``` swift
public var payerReference: String
```

### `paymentTokens`

The list of tokens and associated information

``` swift
public var paymentTokens: [PaymentTokenInfo]?
```
