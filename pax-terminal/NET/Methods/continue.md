---
title: Continue
description: |
    The Continue method is only relevant if card has been read before amount and lets the terminal proceed with PIN dialogue.
---
### Method Signature

*   **void Continue()**

### Description

When a card has been read using `GetPaymentInstrument` and the amount is still not known, this method will let the terminal to proceed with PIN dialogue if appropriate. For contactless the terminal will wait for an amount.
