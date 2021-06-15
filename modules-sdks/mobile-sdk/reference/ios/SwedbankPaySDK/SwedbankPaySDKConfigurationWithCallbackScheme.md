---
title: SwedbankPaySDKConfigurationWithCallbackScheme
---
# SwedbankPaySDKConfigurationWithCallbackScheme

A refinement of SwedbankPaySDKConfiguration.
SwedbankPaySDKConfigurationWithCallbackScheme uses knowledge of the
custom scheme used for `paymentUrl` to only accept
`paymentUrl` with the original scheme or the specified scheme.

``` swift
public protocol SwedbankPaySDKConfigurationWithCallbackScheme : SwedbankPaySDKConfiguration 
```

## Inheritance

[`SwedbankPaySDKConfiguration`](SwedbankPaySDKConfiguration)

## Default Implementations

### `url(_:matchesPaymentUrl:)`

``` swift
func url(_ url: URL, matchesPaymentUrl paymentUrl: URL) -> Bool 
```

## Requirements

### callbackScheme

The URL scheme to be used as fallback to route paymentUrls to this app

``` swift
var callbackScheme: String 
```

This scheme must be registered to the application.
If your paymentUrl ends up being opened in a browser,
it should have such content that ultimately it will navigate to a url
that is otherwise equal to the original paymentUrl, but its scheme
is this scheme, and it may optionally have additional query
parameters (these parameters will be ignored by the SDK, but can be
used to control the behaviour of your backend).
