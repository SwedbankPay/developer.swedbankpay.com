---
title: SwedbankPaySDK.MerchantBackendConfiguration
---
# SwedbankPaySDK.MerchantBackendConfiguration

A SwedbankPaySDKConfiguration for integrating with a backend
implementing the Merchant Backend API.

``` swift
struct MerchantBackendConfiguration: SwedbankPaySDKConfiguration 
```

When using this configuration, you can use `updatePaymentOrder`
to set the instrument of an instrument mode payment by calling
it with the desired instrument,
e.g. `updatePaymentOrder(updateInfo: SwedbankPaySDK.Instrument.creditCard)`.

## Inheritance

`SwedbankPaySDKConfiguration`

## Initializers

### `init(backendUrl:callbackScheme:headers:domainWhitelist:pinPublicKeys:additionalAllowedWebViewRedirects:)`

Initializer for `SwedbankPaySDK.MerchantBackendConfiguration`

``` swift
public init(
            backendUrl: URL,
            callbackScheme: String? = nil,
            headers: [String: String]?,
            domainWhitelist: [WhitelistedDomain]? = nil,
            pinPublicKeys: [PinPublicKeys]? = nil,
            additionalAllowedWebViewRedirects: [WebViewRedirect]? = nil
        ) 
```

#### Parameters

  - backendUrl: backend URL
  - callbackScheme: A custom scheme for callback urls. This scheme must be registered to your app. If nil, the Info.plist will be searched for a URL type with a com.swedbank.SwedbankPaySDK.callback property having a Boolean type and a YES value.
  - headers: HTTP Request headers Dictionary in a form of 'apikey, access token' -pair
  - domainWhitelist: Optional array of domains allowed to be connected to; defaults to `backendURL` if nil
  - pinPublicKeys: Optional array of domains for certification pinning, matched against any certificate found anywhere in the app bundle
  - additionalAllowedWebViewRedirects: additional url patterns that will be opened in the web view

## Properties

### `backendUrl`

The url of the Merchant Backend

``` swift
public var backendUrl: URL 
```

### `callbackScheme`

``` swift
public let callbackScheme: String
```

### `additionalAllowedWebViewRedirects`

``` swift
let additionalAllowedWebViewRedirects: [WebViewRedirect]?
```

## Methods

### `postConsumers(consumer:userData:completion:)`

``` swift
public func postConsumers(
            consumer: SwedbankPaySDK.Consumer?,
            userData: Any?,
            completion: @escaping (Result<SwedbankPaySDK.ViewConsumerIdentificationInfo, Error>) -> Void
        ) 
```

### `postPaymentorders(paymentOrder:userData:consumerProfileRef:completion:)`

``` swift
public func postPaymentorders(
            paymentOrder: SwedbankPaySDK.PaymentOrder?,
            userData: Any?,
            consumerProfileRef: String?,
            completion: @escaping (Result<SwedbankPaySDK.ViewPaymentOrderInfo, Error>) -> Void
        ) 
```

### `updatePaymentOrder(paymentOrder:userData:viewPaymentOrderInfo:updateInfo:completion:)`

``` swift
public func updatePaymentOrder(
            paymentOrder: SwedbankPaySDK.PaymentOrder?,
            userData: Any?,
            viewPaymentOrderInfo: SwedbankPaySDK.ViewPaymentOrderInfo,
            updateInfo: Any,
            completion: @escaping (Result<SwedbankPaySDK.ViewPaymentOrderInfo, Error>
            ) -> Void
        ) -> SwedbankPaySDKRequest? 
```

### `decidePolicyForPaymentMenuRedirect(navigationAction:completion:)`

``` swift
public func decidePolicyForPaymentMenuRedirect(
            navigationAction: WKNavigationAction,
            completion: @escaping (SwedbankPaySDK.PaymentMenuRedirectPolicy) -> Void
        ) 
```
