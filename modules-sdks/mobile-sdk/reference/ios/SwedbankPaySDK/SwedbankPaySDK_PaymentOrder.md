---
title: SwedbankPaySDK.PaymentOrder
---
# SwedbankPaySDK.PaymentOrder

Description of a payment order to be created

``` swift
struct PaymentOrder : Codable, Equatable 
```

This type mirrors the fields used in the `POST /psp/paymentorders` request
(`https://developer.swedbankpay.com/checkout/other-features#creating-a-payment-order`).
`PaymentOrder` is designed to work with `SwedbankPaySDK.MerchantBackendConfiguration`
and a server implementing the Merchant Backend API, such as the example backends
provided by Swedbank Pay, but it can be useful when using a  custom
`SwedbankPaySDKConfiguration` as well.

## Inheritance

`Codable`, `Equatable`

## Initializers

### `init(operation:currency:amount:vatAmount:description:userAgent:language:instrument:generateRecurrenceToken:generatePaymentToken:disableStoredPaymentDetails:restrictedToInstruments:urls:payeeInfo:payer:orderItems:riskIndicator:disablePaymentMenu:paymentToken:initiatingSystemUserAgent:)`

``` swift
public init(
            operation: PaymentOrderOperation = .Purchase,
            currency: String,
            amount: Int64,
            vatAmount: Int64,
            description: String,
            userAgent: String = defaultUserAgent,
            language: Language = .English,
            instrument: Instrument? = nil,
            generateRecurrenceToken: Bool = false,
            generatePaymentToken: Bool = false,
            disableStoredPaymentDetails: Bool = false,
            restrictedToInstruments: [String]? = nil,
            urls: PaymentOrderUrls,
            payeeInfo: PayeeInfo = .init(),
            payer: PaymentOrderPayer? = nil,
            orderItems: [OrderItem]? = nil,
            riskIndicator: RiskIndicator? = nil,
            disablePaymentMenu: Bool = false,
            paymentToken: String? = nil,
            initiatingSystemUserAgent: String? = nil
        ) 
```

## Properties

### `operation`

The operation to perform

``` swift
public var operation: PaymentOrderOperation
```

### `currency`

Currency to use

``` swift
public var currency: String
```

### `amount`

Payment amount, including VAT

``` swift
public var amount: Int64
```

Denoted in the smallest monetary unit applicable, typically 1/100.
E.g. 50.00 SEK would be represented as `5000`.

### `vatAmount`

Amount of VAT included in the payment

``` swift
public var vatAmount: Int64
```

Denoted in the smallest monetary unit applicable, typically 1/100.
E.g. 50.00 SEK would be represented as `5000`.

### `description`

A description of the payment order

``` swift
public var description: String
```

### `userAgent`

User-agent of the payer.

``` swift
public var userAgent: String
```

Defaults to `"SwedbankPaySDK-iOS/{version}"`.

### `language`

Language to use in the payment menu

``` swift
public var language: Language
```

### `instrument`

The payment instrument to use in instrument mode.

``` swift
public var instrument: Instrument?
```

### `generateRecurrenceToken`

If `true`, the a recurrence token will be created from this payment order

``` swift
public var generateRecurrenceToken: Bool
```

The recurrence token should be retrieved by your server from Swedbank Pay.
Your server can then use the token for recurring server-to-server payments.

### `generatePaymentToken`

If `true`, a payment token will be created from this payment order

``` swift
public var generatePaymentToken: Bool
```

You must also set `payer.payerReference` to generate a payment token.
The payment token can be used later to reuse the same payment details;
see `paymentToken`.

### `disableStoredPaymentDetails`

If `true`, the payment menu will not show any stored payment details.

``` swift
public var disableStoredPaymentDetails: Bool
```

This is useful mainly if you are implementing a custom UI for stored
payment details.

### `restrictedToInstruments`

If set, only shows the specified payment instruments in the payment menu

``` swift
public var restrictedToInstruments: [String]?
```

### `urls`

A set of URLs related to the payment.

``` swift
public var urls: PaymentOrderUrls
```

See `SwedbankPaySDK.PaymentOrderUrls` for details.

### `payeeInfo`

Information about the payee (recipient)

``` swift
public var payeeInfo: PayeeInfo
```

See `SwedbankPaySDK.PayeeInfo` for details.

### `payer`

Information about the payer

``` swift
public var payer: PaymentOrderPayer?
```

See `SwedbankPaySDK.PaymentOrderPayer` for details.

### `orderItems`

A list of items that are being paid for by this payment order.

``` swift
public var orderItems: [OrderItem]?
```

The sum of the items' `amount` and `vatAmount` should match
the `amount` and `vatAmount` of the payment order.

### `riskIndicator`

A collection of additional data to minimize the risk of 3-D Secure strong authentication.

``` swift
public var riskIndicator: RiskIndicator?
```

For best user experience, you should fill this field as completely as possible.

### `disablePaymentMenu`

``` swift
public var disablePaymentMenu: Bool
```

### `paymentToken`

A payment token to use for this payment.

``` swift
public var paymentToken: String?
```

You must also set `payer.payerReference` to use a payment token;
the `payerReference` must match the one used when the payment token
was generated.

### `initiatingSystemUserAgent`

``` swift
public var initiatingSystemUserAgent: String?
```
