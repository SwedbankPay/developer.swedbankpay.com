---
title: Swedbank Pay Payments Invoice Redirect
sidebar:
  navigation:
  - title: Payments
    items:
    - url: /payments/
      title: Introduction
    - url: /payments/credit-account
      title: Credit Account Payments
    - url: /payments/credit-card
      title: Credit Card Payments
    - url: /payments/invoice
      title: Invoice Payments
    - url: /payments/invoice/redirect
      title: Invoice Payments Redirect
    - url: /payments/invoice/seamless-view
      title: Invoice Payments Seamless View
    - url: /payments/invoice/after-payment
      title: Invoice Payments After Payment
    - url: /payments/invoice/optional-features
      title: Invoice Payments Optional Features
    - url: /payments/direct-debit
      title: Direct Debit Payments
    - url: /payments/mobile-pay
      title: Mobile Pay Payments
    - url: /payments/swish
      title: Swish Payments
    - url: /payments/vipps
      title: Vipps Payments
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

### Options before posting a payment

All valid options when posting a payment with operation equal to FinancingConsumer, are described in [the technical reference][technical-reference].

{:.table .table-striped}
| *POST Request* |	**Sweden** ![Swedish flag][se-png] |	**Norway** ![Norwegian flag][no-png] |	**FInland** ![Finish flag][fi-png] |
| *Operation* |	FinancingConsumer	| FinancingConsumer |	FinancingConsumer |
| *Intent* |	Authorization |	Authorization |	Authorization |
| *Currency* |	SEK |	NOK |	EUR |
| *InvoiceType* |	PayExFinancingSE |	PayExFinancingNO |	PayExFinancingFI |

*   An invoice payment is always two-phased based - you create an Authorize transaction, that is followed by a Capture or Cancel request.
*   **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL ][callback-url]in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.][callback-api]

## Invoice flow

The sequence diagram below shows the two requests you have to send to PayEx to make a purchase. The diagram also shows in high level, the sequence of the process of a complete purchase.


```mermaid
sequenceDiagram
    Consumer->>Merchant: Start purchase
    activate Merchant
    note left of Merchant: First API request 
    Merchant->>+PayEx: POST [Invoice Payments][invoice-payments] \n\n(operation=FinancingConsumer)
    PayEx-->>-Merchant: payment resource
    Merchant-->>-Consumer: authorization page
    note left of Consumer: redirect to PayEx
    Consumer->>+PayEx: enter consumer details
    PayEx-->>-Consumer: redirect to merchant
    note left of Consumer: redirect back to Merchant
    Consumer->>Merchant: access merchant page
    activate Merchant
    note left of Merchant: Second API request
    Merchant->>+PayEx: GET [Invoice payments][invoice-payments] 
    PayEx-->>-Merchant: payment resource
    Merchant-->>Consumer: display purchase result
    deactivate Merchant
```

### Options after posting a payment

Head over to [after payment][after-payment] to see what you can do when a payment is completed.  
Here you will also find info on `Capture`, `Cancel`, and `Reversal`.

[after-payment]: /payments/invoice/after-payment
[no-png]: /assets/img/no.png
[se-png]: /assets/img/se.png