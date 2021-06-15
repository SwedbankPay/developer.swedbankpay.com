---
title: SwedbankPaySDKConfigurationAsync
---
# SwedbankPaySDKConfigurationAsync

The `SwedbankPaySDKConfigurationAsync` protocol allows you to implement your
`SwedbankPaySDKConfiguration` in terms of `async` functions.

``` swift
@available(iOS 15.0.0, *)
public protocol SwedbankPaySDKConfigurationAsync: SwedbankPaySDKConfiguration 
```

For each function in `SwedbankPaySDKConfiguration` that takes a completion callback,
`SwedbankPaySDKConfigurationAsync` contains a corresponding `async` function.
Implement these instead of the callback-taking ones.

E.g.

Legacy style:

``` 
func postPaymentorders(
    paymentOrder: SwedbankPaySDK.PaymentOrder?,
    userData: Any?,
    consumerProfileRef: String?,
    completion: @escaping (Result<SwedbankPaySDK.ViewPaymentOrderInfo, Error>) -> Void
) {
    let task = URLSession.dataTask(with: url) { (data, _, error) in
        if let error = error {
            completion(.failure(error))
        } else {
            let viewPaymentOrderInfo = process(data)
            completion(.success(viewPaymentOrderInfo))
        }
    }
    task.resume()
}
```

Async style:

``` 
func postPaymentorders(
    paymentOrder: SwedbankPaySDK.PaymentOrder?,
    userData: Any?,
    consumerProfileRef: String?
) async throws -> SwedbankPaySDK.ViewPaymentOrderInfo {
    let (data, _) = try await URLSession.data(from: url)
    return process(data)
}
```

## Inheritance

[`SwedbankPaySDKConfiguration`](SwedbankPaySDKConfiguration)

## Default Implementations

### `updatePaymentOrder(paymentOrder:userData:viewPaymentOrderInfo:updateInfo:)`

``` swift
func updatePaymentOrder(
        paymentOrder: SwedbankPaySDK.PaymentOrder?,
        userData: Any?,
        viewPaymentOrderInfo: SwedbankPaySDK.ViewPaymentOrderInfo,
        updateInfo: Any
    ) async throws -> SwedbankPaySDK.ViewPaymentOrderInfo 
```

### `urlMatchesListOfGoodRedirects(_:)`

Check if the given url matches the built-in list of known-good
payment menu redirects.

``` swift
func urlMatchesListOfGoodRedirects(_ url: URL) async -> Bool 
```

#### Parameters

  - url: the URL to check

#### Returns

`true` if url matches the list, `false` otherwise

### `decidePolicyForPaymentMenuRedirect(navigationAction:)`

``` swift
func decidePolicyForPaymentMenuRedirect(
        navigationAction: WKNavigationAction
    ) async -> SwedbankPaySDK.PaymentMenuRedirectPolicy 
```

### `postConsumers(consumer:userData:completion:)`

``` swift
func postConsumers(
        consumer: SwedbankPaySDK.Consumer?,
        userData: Any?,
        completion: @escaping (Result<SwedbankPaySDK.ViewConsumerIdentificationInfo, Error>) -> Void
    ) 
```

### `postPaymentorders(paymentOrder:userData:consumerProfileRef:completion:)`

``` swift
func postPaymentorders(
        paymentOrder: SwedbankPaySDK.PaymentOrder?,
        userData: Any?,
        consumerProfileRef: String?,
        completion: @escaping (Result<SwedbankPaySDK.ViewPaymentOrderInfo, Error>) -> Void
    ) 
```

### `updatePaymentOrder(paymentOrder:userData:viewPaymentOrderInfo:updateInfo:completion:)`

``` swift
func updatePaymentOrder(
        paymentOrder: SwedbankPaySDK.PaymentOrder?,
        userData: Any?,
        viewPaymentOrderInfo: SwedbankPaySDK.ViewPaymentOrderInfo,
        updateInfo: Any,
        completion: @escaping (Result<SwedbankPaySDK.ViewPaymentOrderInfo, Error>) -> Void
    ) -> SwedbankPaySDKRequest 
```

### `decidePolicyForPaymentMenuRedirect(navigationAction:completion:)`

``` swift
func decidePolicyForPaymentMenuRedirect(
        navigationAction: WKNavigationAction,
        completion: @escaping (SwedbankPaySDK.PaymentMenuRedirectPolicy) -> Void
    ) 
```

## Requirements

### postConsumers(consumer:​userData:​)

Called by SwedbankPaySDKController when it needs to start a consumer identification
session. Your implementation must make the call to Swedbank Pay API
and return a SwedbankPaySDK.ViewConsumerIdentificationInfo describing the result.

``` swift
func postConsumers(
        consumer: SwedbankPaySDK.Consumer?,
        userData: Any?
    ) async throws -> SwedbankPaySDK.ViewConsumerIdentificationInfo
```

#### Parameters

  - consumer: the SwedbankPaySDK.Consumer the SwedbankPaySDKController was created with
  - userData: the user data the SwedbankPaySDKController was created with

#### Returns

SwedbankPaySDK.ViewConsumerIdentificationInfo describing the created identification session

### postPaymentorders(paymentOrder:​userData:​consumerProfileRef:​)

Called by SwedbankPaySDKController when it needs to create a payment order.
Your implementation must make the call to Swedbank Pay API
and return a SwedbankPaySDK.ViewPaymentOrderInfo describing the result.

``` swift
func postPaymentorders(
        paymentOrder: SwedbankPaySDK.PaymentOrder?,
        userData: Any?,
        consumerProfileRef: String?
    ) async throws -> SwedbankPaySDK.ViewPaymentOrderInfo
```

#### Parameters

  - paymentOrder: the SwedbankPaySDK.PaymentOrder the SwedbankPaySDKController was created with
  - userData: the user data the SwedbankPaySDKController was created with
  - consumerProfileRef: if a checkin was performed first, the `consumerProfileRef` from checkin

#### Returns

SwedbankPaySDK.ViewPaymentOrderInfo describing the created payment order

### updatePaymentOrder(paymentOrder:​userData:​viewPaymentOrderInfo:​updateInfo:​)

Called by SwedbankPaySDKController when it needs to update the
ongoing payment order.

``` swift
func updatePaymentOrder(
        paymentOrder: SwedbankPaySDK.PaymentOrder?,
        userData: Any?,
        viewPaymentOrderInfo: SwedbankPaySDK.ViewPaymentOrderInfo,
        updateInfo: Any
    ) async throws -> SwedbankPaySDK.ViewPaymentOrderInfo
```

Your implementation should support cancellation.

#### Parameters

  - paymentOrder: the SwedbankPaySDK.PaymentOrder the SwedbankPaySDKController was created with
  - userData: the user data the SwedbankPaySDKController was created with
  - viewPaymentOrderInfo: the current ViewPaymentOrderInfo as returned from a call to this or postPaymentorders
  - updateInfo: the updateInfo value from the `updatePaymentOrder` call As you are in control of both the configuration and the update call, you can coordinate the actual type used here.
  - completion: callback you must invoke to supply the result

#### Returns

updated SwedbankPaySDK.ViewPaymentOrderInfo for the payment

### decidePolicyForPaymentMenuRedirect(navigationAction:​)

Called by SwedbankPaySDKController when the payment menu is about to navigate
to a different page. Testing has shown that some pages are incompatible with
WKWebView. The SDK contains a list of redirects tested to be working, but you
can customize the behaviour by providing a custom implementation of this method.

``` swift
func decidePolicyForPaymentMenuRedirect(
        navigationAction: WKNavigationAction
    ) async -> SwedbankPaySDK.PaymentMenuRedirectPolicy
```

The default implementation returns .openInWebView if the url of the navigation
matches the built-in list, and .openInBrowser otherwise.
If you override this method, but wish to access the built-in list of known-good
redirects, call urlMatchesListOfGoodRedirects.

#### Parameters

  - navigationAction: the navigation that is about to happen
  - completion: callback you must invoke to supply the result
