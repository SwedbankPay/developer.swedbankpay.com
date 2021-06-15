---
title: SwedbankPaySDK.WhitelistedDomain
---
# SwedbankPaySDK.WhitelistedDomain

Whitelisted domains

``` swift
struct WhitelistedDomain 
```

## Initializers

### `init(domain:includeSubdomains:)`

Initializer for `SwedbankPaySDK.WhitelistedDomain`

``` swift
public init(domain: String?, includeSubdomains: Bool) 
```

#### Parameters

  - domain: URL of the domain as a String
  - includeSubdomains: if `true`, means any subdomain of `domain` is valid

## Properties

### `domain`

``` swift
public var domain: String?
```

### `includeSubdomains`

``` swift
public var includeSubdomains: Bool
```
