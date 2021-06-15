---
title: SwedbankPaySDK.PaymentOrderUrls
---
# Extensions on SwedbankPaySDK.PaymentOrderUrls

## Initializers

### `init(configuration:language:callbackUrl:termsOfServiceUrl:identifier:)`

Convenience initializer that generates a set of urls
for a payment using `MerchantBackendConfiguration`

``` swift
init(
        configuration: SwedbankPaySDK.MerchantBackendConfiguration,
        language: SwedbankPaySDK.Language,
        callbackUrl: URL? = nil,
        termsOfServiceUrl: URL? = nil,
        identifier: String = UUID().uuidString
    ) 
```

#### Parameters

  - configuration: the MerchantBackendConfiguration where this payment is to be used
  - language: the language of the payment
  - callbackUrl: the callbackUrl to set for the payment
  - termsOfServiceUrl: the Terms of Service url of the payment
  - identifier: an unique identifier that is used to identify this payment **inside this application**

### `init(configuration:language:hostUrl:callbackUrl:termsOfServiceUrl:identifier:)`

Convenience initializer that generates a set of urls
for a payment using `MerchantBackendConfiguration`

``` swift
init(
        configuration: SwedbankPaySDK.MerchantBackendConfiguration,
        language: SwedbankPaySDK.Language,
        hostUrl: URL,
        callbackUrl: URL? = nil,
        termsOfServiceUrl: URL? = nil,
        identifier: String = UUID().uuidString
    ) 
```

#### Parameters

  - configuration: the MerchantBackendConfiguration where this payment is to be used
  - language: the language of the payment
  - hostUrl: the url to set in the hostUrls of the payment. This will also become the `webViewBaseURL` of the `ViewPaymentOrderInfo` created for this payment
  - callbackUrl: the callbackUrl to set for the payment
  - termsOfServiceUrl: the Terms of Service url of the payment
  - identifier: an unique identifier that is used to identify this payment **inside this application**
