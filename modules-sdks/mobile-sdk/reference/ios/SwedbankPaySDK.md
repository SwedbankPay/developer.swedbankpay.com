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
