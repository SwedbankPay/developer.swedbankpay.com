---
title: SwedbankPaySDK.PinPublicKeys
---
# SwedbankPaySDK.PinPublicKeys

Object for certificate pinning with public keys found in app bundle certificates

``` swift
struct PinPublicKeys 
```

## Initializers

### `init(pattern:publicKeys:)`

Initializer for `SwedbankPaySDK.PinPublicKeys`, by default uses public keys of all certificates found in app bundle

``` swift
public init(pattern: String, publicKeys: [SecKey] = Bundle.main.af.publicKeys) 
```

#### Parameters

  - pattern: the hostname pattern to pin
  - publicKeys: by default, searches for all certificates in app bundle and uses them

### `init(pattern:certificateFileNames:)`

Initializer for `SwedbankPaySDK.PinPublicKeys`, expects an array of certificate file names for each hostname pattern

``` swift
public init(pattern: String, certificateFileNames: String...) 
```

#### Parameters

  - pattern: the hostname pattern to pin
  - certificateFileNames: certificate filenames to look for from the app bundle

## Properties

### `pattern`

``` swift
var pattern: String
```

### `publicKeys`

``` swift
var publicKeys: [SecKey]
```
