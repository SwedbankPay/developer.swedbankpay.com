---
title: SwedbankPaySDK
---
# SwedbankPaySDK

Class defining data types exposed to the client app using the SDK

``` swift
public final class SwedbankPaySDK 
```

## Properties

### `defaultUserAgent`

``` swift
static var defaultUserAgent: String 
```

## Methods

### `open(url:)`

Call from your `UIApplicationDelegate.application(_:​open:​options:​)`
implementation to forward paymentUrls to the SDK

``` swift
static func open(url: URL) -> Bool 
```

#### Parameters

  - url: the URL to forward

#### Returns

`true` if the url was successfully processed by the SDK, `false` otherwise (e.g. if the url was not an active payment url)

### `` `continue`(userActivity:) ``

Call from your
`UIApplicationDelegate.application(_:​continue:​restorationHandler:​)`
implementation to forward paymentUrls to the SDK

``` swift
static func `continue`(userActivity: NSUserActivity) -> Bool 
```

#### Parameters

  - userActivity: the NSUserActivity to forward to the SDK

#### Returns

`true` if `userActivity` was successfully processed by the SDK, `false` otherwise (e.g. if it was not a navigation to an active payment url)

### `registerCodable(_:)`

To use a `Codable` type as the `userData` parameter for `SwedbankPaySDKController`,
or as the `userInfo` property of `SwedbankPaySDK.ViewPaymentOrderInfo`,
the type should be registered by calling this function. Failure to do so results
in exceptions being throw during state saving and/or restoration.

``` swift
static func registerCodable<T: Codable>(_ type: T.Type) 
```

In addition, if you need lossless preservation of custom `Error` types as part of
`SwedbankPaySDKController` state preservation, you can register those types here as well.
Otherwise, `Error`s will be converted to `NSError` when saving and restoring the state.

The type should not be a private or local type. Use of such types may result in decoding failures.

### `registerCodable(_:encodedTypeName:)`

Variant of `registerCodable` that allows to manually set the encoded name for the `Codable` type.

``` swift
static func registerCodable<T: Codable>(_ type: T.Type, encodedTypeName: String) 
```

If you must use a private or local type, then this function may help, as the default encoded name
for such types is unpredictable. Otherwise, there is ususaly no need to use this function.

Encoded type names beginning with `"com.swedbankpay."` are reserved for the SDK.
