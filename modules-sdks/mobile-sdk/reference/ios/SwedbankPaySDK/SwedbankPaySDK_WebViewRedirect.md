---
title: SwedbankPaySDK.WebViewRedirect
---
# SwedbankPaySDK.WebViewRedirect

``` swift
enum WebViewRedirect 
```

## Enumeration Cases

### `Domain`

``` swift
case Domain(name: String)
```

### `DomainOrSubdomain`

``` swift
case DomainOrSubdomain(suffix: String, allowNestedSubdomains: Bool = false)
```

## Methods

### `allows(url:)`

``` swift
func allows(url: URL) -> Bool 
```
