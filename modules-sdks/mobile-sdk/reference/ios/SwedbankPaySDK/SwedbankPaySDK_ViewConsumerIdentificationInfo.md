---
title: SwedbankPaySDK.ViewConsumerIdentificationInfo
---
# SwedbankPaySDK.ViewConsumerIdentificationInfo

Data required to show the checkin view.

``` swift
struct ViewConsumerIdentificationInfo: Codable 
```

If you provide a custom SwedbankPayConfiguration
you must get the relevant data from your services
and supply a ViewConsumerIdentificationInfo
in your SwedbankPayConfiguration.postConsumers
completion call.

## Inheritance

`Codable`

## Initializers

### `init(webViewBaseURL:viewConsumerIdentification:)`

``` swift
public init(
            webViewBaseURL: URL?,
            viewConsumerIdentification: URL
        ) 
```

## Properties

### `webViewBaseURL`

The url to use as the WKWebView page url
when showing the checkin UI.

``` swift
public var webViewBaseURL: URL?
```

### `viewConsumerIdentification`

The `view-consumer-identification` link from Swedbank Pay.

``` swift
public var viewConsumerIdentification: URL
```
