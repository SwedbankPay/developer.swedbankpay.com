---
title: SwedbankPaySDKRequest
---
# SwedbankPaySDKRequest

A handle to a request started by a call to SwedbankPaySDKConfiguration.

``` swift
public protocol SwedbankPaySDKRequest 
```

## Requirements

### cancel()

Cancels the request. If should not call its completion block
after this method returns.

``` swift
func cancel()
```
