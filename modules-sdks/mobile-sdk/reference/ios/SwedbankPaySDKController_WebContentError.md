---
title: SwedbankPaySDKController_WebContentError
---
# SwedbankPaySDKController.WebContentError

Ways that the payment can fail after the configuration
has successfully started it.

``` swift
public enum WebContentError: Error 
```

## Inheritance

`Error`

## Enumeration Cases

### `ScriptLoadingFailure`

The script (the "view-\*" link) failed to load.
As WKWebView will not provide details on the failure,
we cannot know more than the script url here.

``` swift
case ScriptLoadingFailure(scriptUrl: URL?)
```

### `ScriptError`

The script made an onError callback
The associated value if the Terminal Failure reported by the callback

``` swift
case ScriptError(SwedbankPaySDK.TerminalFailure?)
```

### `RedirectFailure`

The payment tried to redirect to a web page,
but the loading failed

``` swift
case RedirectFailure(error: Error)
```
