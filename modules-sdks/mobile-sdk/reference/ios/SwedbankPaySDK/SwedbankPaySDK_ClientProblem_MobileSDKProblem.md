---
title: SwedbankPaySDK.ClientProblem.MobileSDKProblem
---
# SwedbankPaySDK.ClientProblem.MobileSDKProblem

``` swift
public enum MobileSDKProblem 
```

## Enumeration Cases

### `unauthorized`

The merchant backend rejected the request because its authentication headers were invalid.

``` swift
case unauthorized (
                message: String?,
                raw: [String: Any]
            )
```

### `invalidRequest`

The merchant backend did not understand the request.

``` swift
case invalidRequest (
                message: String?,
                raw: [String: Any]
            )
```
