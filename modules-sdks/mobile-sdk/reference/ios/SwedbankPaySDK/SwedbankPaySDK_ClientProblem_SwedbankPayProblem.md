---
title: SwedbankPaySDK.ClientProblem.SwedbankPayProblem
---
# SwedbankPaySDK.ClientProblem.SwedbankPayProblem

``` swift
public enum SwedbankPayProblem 
```

## Enumeration Cases

### `inputError`

The request could not be handled because the request was malformed somehow (e.g. an invalid field value).

``` swift
case inputError
```

### `forbidden`

The request was understood, but the service is refusing to fulfill it. You may not have access to the requested resource.

``` swift
case forbidden
```

### `notFound`

The requested resource was not found.

``` swift
case notFound
```
