---
title: SwedbankPaySDK.MerchantBackendError
---
# SwedbankPaySDK.MerchantBackendError

Ways that the SwedbankPaySDK.MerchantBackendConfiguration
can fail

``` swift
enum MerchantBackendError: Error 
```

## Inheritance

`Error`

## Enumeration Cases

### `nonWhitelistedDomain`

The Merchant Backend attempted to link to a domain that was not whitelisted
(N.B\! By default, only the domain of the Merchant Backend and its subdomains are whitelisted)

``` swift
case nonWhitelistedDomain(failingUrl: URL)
```

### `networkError`

There was a network error. You can examine the contained error value for details.

``` swift
case networkError(Error)
```

### `problem`

There was a problem with the request. Please refer to the associated Problem value.

``` swift
case problem(Problem)
```

### `missingRequiredOperation`

Protocol error:​ a Merchant Backend response did not contain an operation that is required to continue

``` swift
case missingRequiredOperation(String)
```

### `paymentNotInInstrumentMode`

Attempt to set the instrument of a payment that is not in instrument mode

``` swift
case paymentNotInInstrumentMode
```
