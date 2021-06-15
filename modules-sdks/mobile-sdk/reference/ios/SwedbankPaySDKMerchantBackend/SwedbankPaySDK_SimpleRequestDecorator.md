---
title: SwedbankPaySDK.SimpleRequestDecorator
---
# SwedbankPaySDK.SimpleRequestDecorator

``` swift
struct SimpleRequestDecorator: SwedbankPaySDKRequestDecorator 
```

## Inheritance

[`SwedbankPaySDKRequestDecorator`](SwedbankPaySDKRequestDecorator)

## Initializers

### `init(headers:)`

``` swift
public init(headers: [String: String]) 
```

## Properties

### `headers`

``` swift
public var headers: [String: String]
```

## Methods

### `decorateAny(request:)`

``` swift
public func decorateAny(request: inout URLRequest) 
```
