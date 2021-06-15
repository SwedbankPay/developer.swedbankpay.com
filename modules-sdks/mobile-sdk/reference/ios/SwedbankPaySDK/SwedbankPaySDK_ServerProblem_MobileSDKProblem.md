---
title: SwedbankPaySDK.ServerProblem.MobileSDKProblem
---
# SwedbankPaySDK.ServerProblem.MobileSDKProblem

``` swift
public enum MobileSDKProblem 
```

## Enumeration Cases

### `backendConnectionTimeout`

The merchant backend timed out trying to connect to the Swedbank Pay backend.

``` swift
case backendConnectionTimeout (
                message: String?,
                raw: [String: Any]
            )
```

### `backendConnectionFailure`

The merchant backend failed to connect to the Swedbank Pay backend.

``` swift
case backendConnectionFailure (
                message: String?,
                raw: [String: Any]
            )
```

### `invalidBackendResponse`

The merchant backend received an invalid response from the Swedbank Pay backend.

``` swift
case invalidBackendResponse (
                status: Int,
                gatewayStatus: Int,
                body: String?,
                raw: [String: Any]
            )
```
