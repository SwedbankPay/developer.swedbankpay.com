---
title: Quick Guide
description: Start here. Fast track to go through the essentials for making a payment
permalink: /:path/
menu_order: 10
---
## Simplest Form of Integration

This quick guide will take you through the essentials and hopefully speed up the process of getting your solution ready for the real action. It will show the basics and how a transaction is made and  what the response looks like. It will also show how to abort and how to retrieve result of a priviously made transaction.

Depending on the solution one wants to build, to make a payment just takes two requests with corresponding responses. A `LoginRequest` and a `PaymentRequest` with a happy flow that gives a successful `LoginResponse` and an approved payment that gives a successful `PaymentResponse` with the receipt data.
To make it a little more acceptable one probably wants to be able to abort using an `AbortRequest`, and ask for a transaction status with a `TransactionStatus` request.

{:.code-view-header}
**Typical Happy Flow simple integration**

```mermaid
sequenceDiagram
participant POS
participant Terminal
    POS->>+Terminal: Http POST LoginRequest
    Terminal->>-POS: rsp 200 LoginResponse

    loop Login session until logout or new login
        Note right of POS: Login session started
        POS->>+Terminal: Http POST PaymentRequest
        Terminal->>-POS: rsp 200 PaymentResponse
        Note left of Terminal: Success or Failure
    end

    POS->>+Terminal: Http POST LogoutRequest
    Terminal->>-POS: rsp 200 LogoutResponse
    Note right of POS: Login session ended
```

## Intended Form of Integration

When sending a `LoginRequest` message it is feasible to choose from two styles:

*   Default integration, where POS act as both server and client
*   Light integration, where POS acts as a client only

The default form of integration, full integration, includes a listener on the POS side as well. This makes it possible for the terminal to send requests to the POS. Those requests are mostly display messages letting the POS operator to see what is happening on the terminal. In case a receipt needs to be signed by the customer, the terminal sends an input request together with a print request. The input request will ask for a confirmation from the operator that the signature is ok. When implementing a listener there will also be event notification messages such as `card inserted`, `card removed`, `maintenance required`, `maintenance completed` etc.
The decision of having the terminal to send requests or not is made when sending the [`LoginRequest`][loginrequest] message.

{:.code-view-header}
**Typical Happy Flow full integration**

```mermaid
sequenceDiagram
participant POS
participant Terminal
    POS->>+Terminal: Http POST LoginRequest
    Terminal->>-POS: rsp 200 LoginResponse Success
    loop Login session started
        Terminal->>POS: Http POST DisplayRequest
        note over Terminal: "Please wait"
        POS->>Terminal: rsp 204
        Terminal->>POS: Http POST DisplayRequest
        note over Terminal: "Welcome"
        POS->>Terminal: rsp 204
        POS->>+Terminal: Http POST PaymentRequest
        Terminal->>POS: Http POST DisplayRequest
        note over Terminal: "Present card"
        POS->>Terminal: rsp 204
        Terminal->>POS: Http POST DisplayRequest
        note over Terminal: "Enter PIN"
        POS->>Terminal: rsp 204
        Terminal->>POS: Http POST DisplayRequest
        note over Terminal: "Enter PIN: *"
        POS->>Terminal: rsp 204
        Terminal->>POS: Http POST DisplayRequest
        note over Terminal: "Enter PIN: **"
        POS->>Terminal: rsp 204
        Terminal->>POS: Http POST DisplayRequest
        note over Terminal: "Enter PIN: ***"
        POS->>Terminal: rsp 204
        Terminal->>POS: Http POST DisplayRequest
        note over Terminal: "Enter PIN: ****"
        POS->>Terminal: rsp 204
        Terminal->>POS: Http POST DisplayRequest
        note over Terminal: "Authorizing"
        POS->>Terminal: rsp 204
        Terminal->>POS: Http POST DisplayRequest
        note over Terminal: "Approved"
        POS->>Terminal: rsp 204
        Terminal->>-POS: rsp 200 PaymentResponse Success/Failure
        Terminal->>POS: Http POST DisplayRequest
        note over Terminal: "Welcome"
        POS->>Terminal: rsp 204
    end
    POS->>+Terminal: Http POST LogoutRequest
    Terminal->>-POS: rsp 200 LogoutResponse Success
```

{% include iterator.html next_href="/pax-terminal/Nexo-Retailer/Quick-guide/messageformat" next_title="Next" %}

[loginrequest]: ./first-message
