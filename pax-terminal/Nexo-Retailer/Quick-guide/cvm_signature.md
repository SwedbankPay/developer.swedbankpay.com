---
title: CVM Signature
permalink: /:path/cvm_signature/
description: |
 Payment response for signature approved transaction
menu_order: 47
---
## For CVM method Signature default integration

If the full integration is made and the login was made with SaleCapabilities including `CashierInput`, the following sequence diagram shows how a purchase that is apporoved with a card holder signature would look like. Such cards are from non EU countries and we have no obligation to verify the customer signature. All transactions with signature approval must be accepted. The terminal may still act as if the cashier has to approve or reject the transaction, but the transaction must always be approved. The liability is on the issuer.

```mermaid
sequenceDiagram
title: Payment Response
POS->>+Terminal: Http POST PaymentRequest
Terminal->>POS: Http POST DisplayRequest
POS->>Terminal: rsp 204 - no content
Terminal->>POS: Http POST DisplayRequest
Note over Terminal: "Please wait"
POS->>Terminal: rsp 204 - no content
Terminal->>POS: Http POST DisplayRequest
Note over Terminal: "Authorizing"
POS->>Terminal: rsp 204 - no content
Terminal->>POS: Http POST PrintRequest
Note over Terminal: Merchant receipt should be printed.
POS->>Terminal: rsp 204 - no content
Terminal->>POS: Http POST InputRequest Confirmation
Note over POS: Do not show the text and don't let the<br>cashier decide.
Note right of POS: Always approve the transaction
POS->>Terminal: rsp 200 InputResponse True
Terminal->>POS: Http POST DisplayRequest
Note over Terminal: "Approved"
POS->>Terminal: rsp 204 - no content
Terminal->>-POS: rsp 200 PaymentResponse Success/Failure
Terminal->>POS: Http POST DisplayRequest
Note over Terminal: "Welcome"
POS->>Terminal: rsp 204 - no content
```

## For CVM method Signature Client Only mode

If the Client-Only integration is made or rather, if login was made without SaleCapabilites `CashierInput`, it is **essential** to check the receipt data Json for `{"Merchant":{"Mandatory":{"Payment":"SignatureBlock":true"}}}`. If SignatureBlock is true, the merchant receipt should be printed in case the customer wants to sign it.
The following sequence diagram shows how a purchase that is apporoved with a card holder signature would look like when running Client-Only mode.

```mermaid
sequenceDiagram
title: Payment Response
POS->>+Terminal: Http POST PaymentRequest
Terminal->>-POS: Http Response 200 PaymentResponse
Note over Terminal: JSON: Merchant receipt data<br>Mandatory.Payment.SignatureBlock<br>is true
Note over POS: Print merchant receipt
Note over POS: Let customer sign if they want
Note over POS: Print Customer receipt
Note over Terminal: Ready for new request
```
{% include iterator.html prev_href="/pax-terminal/Nexo-Retailer/Quick-guide/make-payment" prev_title="Back to PaymentRequest" %}
{% include iterator.html next_href="/pax-terminal/Nexo-Retailer/Quick-guide/reversal" next_title="Reverse successful transaction" %}