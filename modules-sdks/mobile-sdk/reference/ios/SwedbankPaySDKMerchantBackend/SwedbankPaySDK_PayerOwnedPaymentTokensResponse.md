---
title: SwedbankPaySDK.PayerOwnedPaymentTokensResponse
---
# SwedbankPaySDK.PayerOwnedPaymentTokensResponse

Response to MerchantBackend.getPayerOwnedPaymentTokens

``` swift
struct PayerOwnedPaymentTokensResponse: Decodable 
```

## Inheritance

`Decodable`

## Properties

### `payerOwnedPaymentTokens`

The response payload.

``` swift
public var payerOwnedPaymentTokens: PayerOwnedPaymentTokens
```

### `operations`

Operations you can perform on the whole list of tokens.
Note that you generally cannot call these from your mobile app.

``` swift
public var operations: [SwedbankPaySDK.Operation]?
```
