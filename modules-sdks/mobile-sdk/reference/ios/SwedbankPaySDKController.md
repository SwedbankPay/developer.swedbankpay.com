---
title: SwedbankPaySDKController
---
# SwedbankPaySDKController

Swedbank Pay SDK ViewController, initialize this to start the payment process

``` swift
public final class SwedbankPaySDKController: UIViewController 
```

## Inheritance

[`CallbackUrlDelegate`](CallbackUrlDelegate), [`SwedbankPayWebViewControllerDelegate`](SwedbankPayWebViewControllerDelegate), `UIViewController`

## Initializers

### `init(configuration:consumer:paymentOrder:)`

Initializes the Swedbank Pay SDK, and depending on the `consumerData`,
starts the payment process with consumer identification or anonymous process

``` swift
public convenience init(
        configuration: SwedbankPaySDKConfiguration,
        consumer: SwedbankPaySDK.Consumer? = nil,
        paymentOrder: SwedbankPaySDK.PaymentOrder
    ) 
```

#### Parameters

  - configuration: Configuration object that handles creating and manipulating Consumer Identification Sessions and Payment Orders as needed.
  - consumer: consumer identification information; *optional* - if not provided, consumer will be anonymous
  - paymentOrder: the payment order to create

### `init(configuration:withCheckin:consumer:paymentOrder:userData:)`

Initializes the Swedbank Pay SDK, and starts the payment process
with consumer identification or anonymous process

``` swift
public init(
        configuration: SwedbankPaySDKConfiguration,
        withCheckin: Bool,
        consumer: SwedbankPaySDK.Consumer?,
        paymentOrder: SwedbankPaySDK.PaymentOrder?,
        userData: Any?
    ) 
```

  - userData: user data for your configuration. This value will be provided to your configuration callbacks.

#### Parameters

  - configuration: Configuration object that handles creating and manipulating Consumer Identification Sessions and Payment Orders as needed.
  - withCheckin: if `true`, performs checkin berfore creating the payment order
  - consumer: consumer object for the checkin
  - paymentOrder: the payment order to create

## Properties

### `delegate`

A delegate to receive callbacks as the state of SwedbankPaySDKController changes.

``` swift
public weak var delegate: SwedbankPaySDKDelegate?
```

### `paymentMenuStyle`

Styling for the payment menu

``` swift
public var paymentMenuStyle: [String: Any]?
```

Styling the payment menu requires a separate agreement with Swedbank Pay.

### `currentPaymentOrder`

The current payment order in this SwedbankPaySDKController.

``` swift
public var currentPaymentOrder: SwedbankPaySDK.ViewPaymentOrderInfo? 
```

This will be `nil` until the first call to
SwedbankPaySDKDelegate.paymentOrderDidShow. It will not become `nil`
after that, so it does *not* represent the state of whether
the payment order is currently showing or not.
Is value is always the most recent value returned from your
`SwedbankPaySDKConfiguration` (currently from either
`postPaymentorders` or `patchUpdatePaymentorderSetinstrument`.

### `showingPaymentOrder`

`true` if the payment order is currently shown, `false` otherwise

``` swift
public var showingPaymentOrder: Bool 
```

### `updatingPaymentOrder`

`true` if the payment order is currently being updated, `false` otherwise

``` swift
public var updatingPaymentOrder: Bool 
```

### `webRedirectBehavior`

``` swift
public var webRedirectBehavior = WebRedirectBehavior.Default
```

### `webNavigationLogger`

``` swift
public var webNavigationLogger: ((URL) -> Void)? 
```

## Methods

### `updatePaymentOrder(updateInfo:)`

Performs an update on the current payment order.

``` swift
public func updatePaymentOrder(updateInfo: Any) 
```

When you call this method, it will result in a callback to your
`SwedbankPaySDKConfiguration.updatePaymentOrder` method;
the meaning of `updateInfo` is determined by your implementation
of that method.

After calling this method, you should disable user interaction
until the update finishes. Your delegate will receive either a
`paymentOrderDidShow` or `updatePaymentOrderFailed` when that happens.
If you call this method while an update is in progress,
the previous update will be canceled first.

See `SwedbankPaySDK.MerchantBackendConfiguration` for an example.

### `viewDidLoad()`

``` swift
public override func viewDidLoad() 
```

### `viewWillAppear(_:)`

``` swift
public override func viewWillAppear(_ animated: Bool) 
```

### `viewWillDisappear(_:)`

``` swift
public override func viewWillDisappear(_ animated: Bool) 
```
