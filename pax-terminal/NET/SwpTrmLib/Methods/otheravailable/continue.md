---
title: Continue
permalink: /:path/continue/
description: |
    The Continue method is only relevant if card has been read before amount and lets the terminal proceed with PIN dialog.
icon:
    content: arrow_forward
    outlined: true
menu_order: 50
---
### Method Signature

*   void Continue()

### Description

When a card has been read using `GetPaymentInstrument` and the amount is still not known, this method will let the terminal to proceed with PIN dialog if appropriate. For contactless the terminal will wait for an amount.

```mermaid
sequenceDiagram
participant SaleSystem
participant SDK
participant Terminal
    activate SDK
    SaleSystem->>SDK: GetPaymentInstrument()
    SDK->>Terminal: CardAcquisition
    Note over Terminal: "Wait for card"
    Terminal->>SDK: CardAcquisitionResponse
    deactivate SDK
    Note left of Terminal: Chip card read
    SDK->>SaleSystem: GetPaymentInstrumentResult
    Note over Terminal: "Please wait"
    SaleSystem->>SDK: Continue()
    Note over Terminal: "Enter PIN"
```
