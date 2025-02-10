---
title: PaymentResponse
permalink: /:path/payment-response/
description: |
 Payment response holds the receipt data
menu_order: 45
---
A payment is approved if the `Result` attribute of the `/PaymentResponse/Response` element is `Success`.
For all unapproved payments the same attribute is `Failure` and the actual response code is found in the receipt data if wanted.
Depending on why a payment is unapproved the response may not contain a receipt. However, make sure to always make a payment terminal receipt available if a card has been used.

The payment response carries both a merchant receipt and a customer receipt. The customer receipt should always be used. The merchant receipt is used if the receipt needs to be signed by the customer.
The receiptdata is a Base64 encoded JSON structure.

{% include pax-payment-response.md %}

## For CVM method Signature default integration

If the full integration is made and the login was made with SaleCapabilities including `CashierInput`, the following sequence diagram shows how a purchase that is apporoved with a card holder signature would look like.

```mermaid
sequenceDiagram
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
Note over Terminal: Merchant receipt
POS->>Terminal: rsp 204 - no content
Terminal->>POS: Http POST InputRequest Confirmation
Note over Terminal: Is signature OK?
alt 
    Note right of POS: Approve signature
    POS->>Terminal: rsp 200 InputResponse True
    Terminal->>POS: Http POST DisplayRequest
    Note over Terminal: "Approved"
    POS->>Terminal: rsp 204 - no content
else 
    Note right of POS: Disapprove signature
    POS->>Terminal: rsp 200 InputResponse False
    Terminal->>POS: Http POST DisplayRequest
    Note over Terminal: "Disapproved"
    POS->>Terminal: rsp 204 - no content
end 
Terminal->>-POS: rsp 200 PaymentResponse Success/Failure
Terminal->>POS: Http POST DisplayRequest
Note over Terminal: "Welcome"
POS->>Terminal: rsp 204 - no content
```

## For CVM method Signature Client Only mode

If the Client-Only integration is made or rather, if login was made without SaleCapabilites `CashierInput`, it is **essential** to check the receipt data Json for `{"Merchant":{"Mandatory":{"Payment":"SignatureBlock":true"}}}`. If SignatureBlock is true, the merchant receipt must be printed and signed by the customer.
The following sequence diagram shows how a purchase that is apporoved with a card holder signature would look like when running Client-Only mode.

```mermaid
sequenceDiagram
POS->>+Terminal: Http POST PaymentRequest
Terminal->>-POS: Http Response 200 PaymentResponse
Note over Terminal: Merchant receipt data<br>JSON SignatureBlock is true
    Note over POS: Print merchant receipt
    Note over POS: Ask customer to sign<br>verify ID of customer
alt Approve
    Note over POS: Print Customer receipt
else Don't approve
    Note right of POS: Disapprove signature
    POS->>Terminal: Http POST ReversalRequest
    Terminal->>POS: Http Response 200 
    Note over Terminal: includes new customer receipt
    Note over POS: Print customer receipt
end 
Note over Terminal: Ready for new request
```

{% include iterator.html prev_href="/pax-terminal/Nexo-Retailer/Quick-guide/make-payment" prev_title="Back to PaymentRequest" %}
{% include iterator.html next_href="/pax-terminal/Nexo-Retailer/Quick-guide/reversal" next_title="Reverse successful transaction" %}
