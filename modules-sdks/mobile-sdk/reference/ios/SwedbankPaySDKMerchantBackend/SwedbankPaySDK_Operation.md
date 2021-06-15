---
title: SwedbankPaySDK.Operation
---
# SwedbankPaySDK.Operation

Swedbank Pay Operation. Operations are invoked by making an HTTP request.

``` swift
struct Operation: Decodable 
```

Please refer to the Swedbank Pay documentation
(https://developer.swedbankpay.com/checkout/other-features\#operations).

## Inheritance

`Decodable`

## Properties

### `rel`

The purpose of the operation. The exact meaning is dependent on the Operation context.

``` swift
public var rel: String?
```

### `method`

The request method

``` swift
public var method: String?
```

### `href`

The request URL

``` swift
public var href: String?
```

### `contentType`

The Content-Type of the response

``` swift
public var contentType: String?
```
