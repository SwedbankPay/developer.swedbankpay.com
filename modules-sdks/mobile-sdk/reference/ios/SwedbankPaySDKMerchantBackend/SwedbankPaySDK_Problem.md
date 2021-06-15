---
title: SwedbankPaySDK.Problem
---
# SwedbankPaySDK.Problem

Base class for any problems encountered in the payment.

``` swift
enum Problem 
```

All problems are either `Client` or `Server` problems. A Client problem is one where there was something wrong with the request
the client app sent to the service. A Client problem always implies an HTTP response status in the Client Error range, 400-499.

A Server problem is one where the service understood the request, but could not fulfill it. If the backend responds in an unexpected
manner, the situation will be interpreted as a Server error, unless the response status is in 400-499 range, in which case it is still considered a
Client error.

This separation to Client and Server errors provides a crude but often effective way of distinguishing between temporary service unavailability
and permanent configuration errors.

Client and Server errors are further divided to specific types. See individual documentation for details.

## Enumeration Cases

### `client`

``` swift
case client(ClientProblem)
```

### `server`

``` swift
case server(ServerProblem)
```
