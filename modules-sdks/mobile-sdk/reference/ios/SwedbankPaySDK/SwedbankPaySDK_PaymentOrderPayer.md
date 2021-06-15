---
title: SwedbankPaySDK.PaymentOrderPayer
---
# SwedbankPaySDK.PaymentOrderPayer

Information about the payer of a payment order

``` swift
struct PaymentOrderPayer : Codable, Equatable 
```

## Inheritance

`Codable`, `Equatable`

## Initializers

### `init(consumerProfileRef:email:msisdn:payerReference:)`

``` swift
public init(
            consumerProfileRef: String? = nil,
            email: String? = nil,
            msisdn: String? = nil,
            payerReference: String? = nil
        ) 
```

## Properties

### `consumerProfileRef`

A consumer profile reference obtained through the Checkin flow.

``` swift
public var consumerProfileRef: String?
```

If you have your `SwedbankPaySDKController` to do the Checkin flow, your
`SwedbankPaySDKConfiguration.postPaymentorders` will be called with
the `consumerProfileRef` received from the Checkin flow. Your
`SwedbankPaySDKConfiguration` can then use that value here to forward it
to your backend for payment order creation.

### `email`

The email address of the payer.

``` swift
public var email: String?
```

Can be used even if you do not set a `consumerProfileRef`; will be used to prefill
appropriate fields.

### `msisdn`

The phone number of the payer.

``` swift
public var msisdn: String?
```

Can be used even if you do not set a `consumerProfileRef`; will be used to prefill
appropriate fields.

### `payerReference`

An opaque, unique reference to the payer. Alternative to the other fields.

``` swift
public var payerReference: String?
```

Using `payerReference` is required when generating or using payment tokens
(N.B\! not recurrence tokens).

If you use `payerReference`, you should not set the other fields.
The `payerReference` must be unique to a payer, and your backend must have access control
such that is ensures that the `payerReference` is owned by the authenticated user.
It is usually best to only populate this field in the backend.
