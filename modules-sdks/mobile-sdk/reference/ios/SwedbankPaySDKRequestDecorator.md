---
title: SwedbankPaySDKRequestDecorator
---
# SwedbankPaySDKRequestDecorator

``` swift
public protocol SwedbankPaySDKRequestDecorator 
```

## Default Implementations

### `decorateAny(request:)`

``` swift
func decorateAny(request: inout URLRequest) 
```

### `decorateGetTopLevelResources(request:)`

``` swift
func decorateGetTopLevelResources(request: inout URLRequest) 
```

### `decorateInitiateConsumerSession(request:consumer:userData:)`

``` swift
func decorateInitiateConsumerSession(
        request: inout URLRequest,
        consumer: SwedbankPaySDK.Consumer,
        userData: Any?
    ) 
```

### `decorateCreatePaymentOrder(request:paymentOrder:userData:)`

``` swift
func decorateCreatePaymentOrder(
        request: inout URLRequest,
        paymentOrder: SwedbankPaySDK.PaymentOrder,
        userData: Any?
    ) 
```

### `decoratePaymentOrderSetInstrument(request:instrument:userData:)`

``` swift
func decoratePaymentOrderSetInstrument(
        request: inout URLRequest,
        instrument: SwedbankPaySDK.Instrument,
        userData: Any?
    ) 
```

## Requirements

### decorateAny(request:​)

``` swift
func decorateAny(request: inout URLRequest)
```

### decorateGetTopLevelResources(request:​)

``` swift
func decorateGetTopLevelResources(request: inout URLRequest)
```

### decorateInitiateConsumerSession(request:​consumer:​userData:​)

``` swift
func decorateInitiateConsumerSession(
        request: inout URLRequest,
        consumer: SwedbankPaySDK.Consumer,
        userData: Any?
    )
```

### decorateCreatePaymentOrder(request:​paymentOrder:​userData:​)

``` swift
func decorateCreatePaymentOrder(
        request: inout URLRequest,
        paymentOrder: SwedbankPaySDK.PaymentOrder,
        userData: Any?
    )
```

### decoratePaymentOrderSetInstrument(request:​instrument:​userData:​)

``` swift
func decoratePaymentOrderSetInstrument(
        request: inout URLRequest,
        instrument: SwedbankPaySDK.Instrument,
        userData: Any?
    )
```
