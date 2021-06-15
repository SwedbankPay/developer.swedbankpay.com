---
title: SwedbankPaySDK.MerchantBackend
---
# SwedbankPaySDK.MerchantBackend

Additional utilities supported by the Merchant Backend

``` swift
enum MerchantBackend 
```

## Methods

### `getPayerOwnedPaymentTokens(configuration:payerReference:extraHeaders:completion:)`

Retrieves the payment tokens owned by the given
payerReference.

``` swift
public static func getPayerOwnedPaymentTokens(
            configuration: MerchantBackendConfiguration,
            payerReference: String,
            extraHeaders: [String: String]? = nil,
            completion: @escaping (Result<PayerOwnedPaymentTokensResponse, Error>) -> Void
        ) -> SwedbankPaySDKRequest? 
```

Your backend must enable this functionality separately.

#### Parameters

  - configuration: the backend configuration
  - payerReference: the reference to query
  - extraHeaders: any headers you wish to append to the request
  - completion: when the request completes, this is called with the result

#### Returns

a handle that you can use to cancel the request

### `deletePayerOwnerPaymentToken(configuration:paymentToken:comment:extraHeaders:completion:)`

Deletes the specified payment token.

``` swift
public static func deletePayerOwnerPaymentToken(
            configuration: MerchantBackendConfiguration,
            paymentToken: PaymentTokenInfo,
            comment: String,
            extraHeaders: [String: String]? = nil,
            completion: @escaping (Result<Void, Error>) -> Void
        ) -> SwedbankPaySDKRequest? 
```

Your backend must enable this functionality separately.
After you make this request, you should refresh your local list of tokens.

#### Parameters

  - configuration: the backend configuration
  - paymentToken: the token to delete
  - comment: the reason for the deletion
  - extraHeaders: any headers you wish to append to the request
  - completion: when the request completes, this is called with the result

#### Returns

a handle that you can use to cancel the request
