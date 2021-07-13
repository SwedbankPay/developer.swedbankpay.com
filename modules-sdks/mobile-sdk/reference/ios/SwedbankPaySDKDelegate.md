---
title: SwedbankPaySDKDelegate
---
# SwedbankPaySDKDelegate

Swedbank Pay SDK protocol, conform to this to get the result of the payment process

``` swift
public protocol SwedbankPaySDKDelegate: AnyObject 
```

## Inheritance

`AnyObject`

## Default Implementations

### `paymentOrderDidShow(info:)`

``` swift
func paymentOrderDidShow(info: SwedbankPaySDK.ViewPaymentOrderInfo) 
```

### `paymentOrderDidHide()`

``` swift
func paymentOrderDidHide() 
```

### `updatePaymentOrderFailed(updateInfo:error:)`

``` swift
func updatePaymentOrderFailed(
        updateInfo: Any,
        error: Error
    ) 
```

### `overrideTermsOfServiceTapped(url:)`

``` swift
func overrideTermsOfServiceTapped(url: URL) -> Bool 
```

## Requirements

### paymentOrderDidShow(info:​)

Called whenever the payment order is shown in this
view controller's view.

``` swift
func paymentOrderDidShow(info: SwedbankPaySDK.ViewPaymentOrderInfo)
```

### paymentOrderDidHide()

Called when the payment order is no longer visible after being shown.
Usually this happens because the payment order needed to redirect
to a 3D-Secure page.

``` swift
func paymentOrderDidHide()
```

This is usually interesting if you are using instrument mode
to provide custom instrument selection. You should disallow
changing the instrument at this state.

### updatePaymentOrderFailed(updateInfo:​error:​)

Called if an attempt to update the payment order fails.

``` swift
func updatePaymentOrderFailed(
        updateInfo: Any,
        error: Error
    )
```

### paymentComplete()

``` swift
func paymentComplete()
```

### paymentCanceled()

``` swift
func paymentCanceled()
```

### paymentFailed(error:​)

Called if there is an error in performing the payment.
The error may be SwedbankPaySDKController.WebContentError,
or any error reported by your SwedbankPaySDKConfiguration.

``` swift
func paymentFailed(error: Error)
```

If you are using a SwedbankPaySDK.MerchantBackendConfiguration,
this means the error will be either
SwedbankPaySDKController.WebContentError, or
SwedbankPaySDK.MerchantBackendError.

#### Parameters

  - error: The error that caused the failure

### overrideTermsOfServiceTapped(url:​)

Called when the user taps on the Terms of Service Link
in the Payment Menu.

``` swift
func overrideTermsOfServiceTapped(url: URL) -> Bool
```

If your delegate does not override this method, the SDK will
present a view controller that loads the linked page.

#### Parameters

  - url: the URL of the Terms of Service page

#### Returns

`true` to consume the tap and disable the default behaviour, `false` to allow the SDK to show the ToS web page
