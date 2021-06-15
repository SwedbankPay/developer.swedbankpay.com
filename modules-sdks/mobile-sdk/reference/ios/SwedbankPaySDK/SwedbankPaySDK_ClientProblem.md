---
title: SwedbankPaySDK.ClientProblem
---
# SwedbankPaySDK.ClientProblem

A `ClientProblem` always implies a HTTP status in 400-499.

``` swift
enum ClientProblem 
```

## Enumeration Cases

### `mobileSDK`

Base class for `ClientProblem` defined by the example backend

``` swift
case mobileSDK(MobileSDKProblem)
```

### `swedbankPay`

Base class for `ClientProblem` defined by the Swedbank Pay backend.

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

`ClientProblem` with an unrecognized type.

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
an unexpected format and the HTTP status is in the Client Error range (400-499).

``` swift
case unexpectedContent(
            status: Int,
            contentType: String?,
            body: Data?
        )
```
