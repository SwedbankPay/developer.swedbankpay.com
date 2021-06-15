---
title: SwedbankPaySDKController.StateRestorationError
---
# SwedbankPaySDKController.StateRestorationError

If you are using state restoration, and there is an error in the restoration process,
the SwedbankPaySDKController will be put in an error state with one of these errors.

``` swift
public enum StateRestorationError: Error 
```

## Inheritance

`Codable`, `Error`

## Initializers

### `init(from:)`

``` swift
public init(from decoder: Decoder) throws 
```

## Enumeration Cases

### `unregisteredCodable`

You tried to use a `Codable` as `userData` or as
`SwedbankPaySDK.ViewPaymentOrderInfo.userInfo`,
but the type was not registered  with `SwedbankPaySDK.registerCodable`.

``` swift
case unregisteredCodable(String)
```

The associated value is the type name.
You should call `SwedbankPaySDK.registerCodable(Foo.self)` during app initialization,
e.g. in `UIApplicationDelegate.application(_:willFinishLaunchingWithOptions:)`.

### `nonpersistableConfiguration`

The state was restored from a `SwedbankPaySDKController` that was initialized using
the legacy initializer that takes a configuration directly. State restoration will not work with such a setup.

``` swift
case nonpersistableConfiguration
```

### `unknown`

There was an unexpected error condition during the restoration process.

``` swift
case unknown
```

## Methods

### `encode(to:)`

``` swift
public func encode(to encoder: Encoder) throws 
```
