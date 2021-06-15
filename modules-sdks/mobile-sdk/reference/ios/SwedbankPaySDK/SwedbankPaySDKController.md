---
title: SwedbankPaySDKController
---
# SwedbankPaySDKController

Swedbank Pay SDK ViewController, initialize this to start the payment process

``` swift
open class SwedbankPaySDKController: UIViewController, UIViewControllerRestoration 
```

`SwedbankPaySDKController` supports subclassing. In most cases you should not
need to do so, but if you select the `SwedbankPaySDKConfiguration` dynamically,
and you support view controller state saving, then you must create a subclass
and override the `configuration` property.

`SwedbankPaySDKController` conforms to `UIViewControllerRestoration`;
it can restore itself and subclasses. For convenience, the no-argument constructor sets `Self`
as the restoration class. It is also possible to use `Self` as the restoration class for a
`SwedbankPaySDKController` created form a storyboard, but the regular restoration
mechanism should also work in that case. Notably, state restoration will not work if you use the
legacy intitializers that take a `SwedbankPaySDKConfiguration` directly.

If you use state restoration, and make use of the `userData` argument of `startPayment`,
or the `userInfo` property of `SwedbankPaySDK.ViewPaymentOrderInfo`, then those values
must be either `NSCoding` or `Codable`. If you use `Codable` types (recommended), you must also
register them with the SDK by calling `SwedbankPaySDK.registerCodable` for those types.
You can also register any custom `Codable` `Error` types your  `SwedbankPaySDKConfiguration`
may throw; otherwise those will be turned to `NSError` during state saving.

## Inheritance

[`CallbackUrlDelegate`](CallbackUrlDelegate), [`SwedbankPayWebViewControllerDelegate`](SwedbankPayWebViewControllerDelegate), `UIViewController`, `UIViewControllerRestoration`

## Initializers

### `init?(coder:)`

``` swift
public required init?(coder aDecoder: NSCoder) 
```

### `init()`

Create a new `SwedbankPaySDKController`.
Call `startPayment` to start the payment.

``` swift
public required init() 
```

### `init(configuration:consumer:paymentOrder:)`

Note:​ This is a legacy initializer. Please consider using the no-argument initializer
and `startPayment` instead.

``` swift
public convenience init(
        configuration: SwedbankPaySDKConfiguration,
        consumer: SwedbankPaySDK.Consumer? = nil,
        paymentOrder: SwedbankPaySDK.PaymentOrder
    ) 
```

Initializes the SwedbankPaySDKController, and depending on the `consumerData`,
starts the payment process with consumer identification or anonymous process

#### Parameters

  - configuration: Configuration object that handles creating and manipulating Consumer Identification Sessions and Payment Orders as needed.
  - consumer: consumer identification information; *optional* - if not provided, consumer will be anonymous
  - paymentOrder: the payment order to create

### `init(configuration:withCheckin:consumer:paymentOrder:userData:)`

Note:​ This is a legacy initializer. Please consider using the no-argument initializer
and `startPayment` instead.

``` swift
public init(
        configuration: SwedbankPaySDKConfiguration,
        withCheckin: Bool,
        consumer: SwedbankPaySDK.Consumer?,
        paymentOrder: SwedbankPaySDK.PaymentOrder?,
        userData: Any?
    ) 
```

Initializes the SwedbankPaySDKController, and starts the payment process
with consumer identification or anonymous process

#### Parameters

  - configuration: Configuration object that handles creating and manipulating Consumer Identification Sessions and Payment Orders as needed.
  - withCheckin: if `true`, performs checkin berfore creating the payment order
  - consumer: consumer object for the checkin
  - paymentOrder: the payment order to create
  - userData: user data for your configuration. This value will be provided to your configuration callbacks.

## Properties

### `defaultConfiguration`

The default value for `configuration`. If your setup does not need multiple configurations
in a single app, then you should set your configuration here and not worry about subclassing
`SwedbankPaySDKController`.

``` swift
public static var defaultConfiguration: SwedbankPaySDKConfiguration?
```

### `configuration`

The `SwedbankPaySDKConfiguration` used by this `SwedbankPaySDKController`.

``` swift
open var configuration: SwedbankPaySDKConfiguration 
```

Note that `SwedbankPaySDKController` accesses this property only once during initialization,
and will use the returned value thereafter. Hence, you cannot change the configuration "in-flight"
by changing the value returned from here.

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

### `viewDidLoad()`

``` swift
open override func viewDidLoad() 
```

### `viewWillAppear(_:)`

``` swift
open override func viewWillAppear(_ animated: Bool) 
```

### `viewWillDisappear(_:)`

``` swift
open override func viewWillDisappear(_ animated: Bool) 
```

### `startPayment(withCheckin:consumer:paymentOrder:userData:)`

Starts a new payment.

``` swift
public func startPayment(
        withCheckin: Bool,
        consumer: SwedbankPaySDK.Consumer?,
        paymentOrder: SwedbankPaySDK.PaymentOrder?,
        userData: Any?
    ) 
```

Calling this when a payment is already started has no effect.

#### Parameters

  - withCheckin: `true` to include the customer identification flow, `false` otherwise
  - consumer: the `Consumer` to use for customer identification
  - paymentOrder: the `PaymentOrder` to use to create the payment
  - userData: any additional data you may need for the identification and/or payment

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

### `viewController(withRestorationIdentifierPath:coder:)`

``` swift
open class func viewController(
        withRestorationIdentifierPath identifierComponents: [String],
        coder: NSCoder
    ) -> UIViewController? 
```

### `encodeRestorableState(with:)`

``` swift
open override func encodeRestorableState(with coder: NSCoder) 
```

### `decodeRestorableState(with:)`

``` swift
open override func decodeRestorableState(with coder: NSCoder) 
```

### `applicationFinishedRestoringState()`

``` swift
open override func applicationFinishedRestoringState() 
```
