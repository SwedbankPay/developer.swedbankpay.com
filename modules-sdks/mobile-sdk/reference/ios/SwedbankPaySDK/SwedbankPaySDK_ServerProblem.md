---
title: SwedbankPaySDK.ServerProblem
---
# SwedbankPaySDK.ServerProblem

Any unexpected response where the HTTP status is outside 400-499 results in a `ServerProblem`; usually it means the status was in 500-599.

``` swift
enum ServerProblem 
```

## Enumeration Cases

### `mobileSDK`

Base class for `ServerProblem` defined by the example backend.

``` swift
case mobileSDK(MobileSDKProblem)
```

### `swedbankPay`

Base class for `ServerProblem` defined by the Swedbank Pay backend.

``` swift
case swedbankPay(
            type: SwedbankPayProblem,
            title: String?,
            status: Int,
            detail: String?,
            instance: String?,
            action: String?,
            problems: [SwedbankPaySubProblem]?,
            raw: [String: Any]
        )
```

\[https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/\#HProblems\]

### `unknown`

`ServerProblem` with an unrecognized type.

``` swift
case unknown(
            type: String,
            title: String?,
            status: Int,
            detail: String?,
            instance: String?,
            raw: [String: Any]
        )
```

### `unexpectedContent`

Pseudo-problem, not actually parsed from an application/problem+json response. This problem is emitted if the server response is in
an unexpected format and the HTTP status is not in the Client Error range.

``` swift
case unexpectedContent(
            status: Int,
            contentType: String?,
            body: Data?
        )
```
