---
title: Swedbank Pay Payments Invoice Seamless View
sidebar:
  navigation:
  - title: Checkout
    items:
    - url: /checkout/
      title: Introduction
    - url: /checkout/payment
      title: Checkout Payment
    - url: /checkout/after-payment
      title: Checkout After Payment
    - url: /checkout/other-features
      title: Checkout Other Features
  - title: Payments
    items:
    - url: /payments/
      title: Introduction
    - url: /payments/credit-card
      title: Credit Card Payments
    - url: /payments/credit-card/redirect
      title: Credit Card Redirect
    - url: /payments/credit-card/seamless-view
      title: Credit Card Seamless View
    - url: /payments/credit-card/after-payment
      title: Credit Card After Payments
    - url: /payments/credit-card/other-features
      title: Credit Card Other Features
    - url: /payments/invoice
      title: Invoice Payments
    - url: /payments/invoice/redirect
      title: Invoice Redirect
    - url: /payments/invoice/seamless-view
      title: Invoice Seamless View
    - url: /payments/invoice/after-payment
      title: Invoice After Payment
    - url: /payments/invoice/other-features
      title: Invoice Other Features
    - url: /payments/mobile-pay
      title: Mobile Pay Payments
    - url: /payments/mobile-pay/redirect
      title: Mobile Pay Redirect
    - url: /payments/mobile-pay/seamless-view
      title: Mobile Pay Seamless View
    - url: /payments/mobile-pay/after-payment
      title: Mobile Pay After Payment
    - url: /payments/mobile-pay/other-features
      title: Mobile Pay Other Features
    - url: /payments/swish
      title: Swish Payments
    - url: /payments/swish/redirect
      title: Swish Redirect
    - url: /payments/swish/seamless-view
      title: Swish Seamless View
    - url: /payments/swish/after-payment
      title: Swish After Payment
    - url: /payments/swish/other-features
      title: Swish Other Features
    - url: /payments/vipps
      title: Vipps Payments
    - url: /payments/vipps/redirect
      title: Vipps Redirect
    - url: /payments/vipps/seamless-view
      title: Vipps Seamless View
    - url: /payments/vipps/after-payment
      title: Vipps After After Payment
    - url: /payments/vipps/other-features    
      title: Vipps Other Features
    - url: /payments/direct-debit
      title: Direct Debit Payments
    - url: /payments/direct-debit/redirect
      title: Direct Debit Redirect
    - url: /payments/direct-debit/seamless-view
      title: Direct Debit Seamless View
    - url: /payments/direct-debit/after-payment
      title: Direct Debit After Payments
    - url: /payments/direct-debit/other-features
      title: Direct Debit Other Features
    - url: /payments/credit-account
      title: Credit Account
    - url: /payments/credit-account/after-payment
      title: Credit Account After Payment
    - url: /payments/credit-account/other-features
      title: Credit Account Other Features
  - title: Resources
    items:
    - url: /resources/
      title: Introduction
    - url: /resources/test-data
      title: Test Data
    - url: /resources/demoshop
      title: Demoshop
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

## Introduction

*   To create an invoice payment, you need to collect all purchase information and make a `POST` request towards PayEx.
*   You also need to collect social security number (SSN) / person number and postal number from the consumer, and make another `POST` request towards PayEx in order to retrieve the name and address from the consumer.
*   To create the authorization transaction, you need to calculate the final price / amount, and make a third `POST` request where you send in the consumer data.
*   To get the authorization result, you need  to follow up with a `GET` request using the paymentID received in the first step.
*   Finally, when you are ready to ship your order, you will have to make a `POST` request to make a Capture. **At this point PayEx will generate the invoice to the consumer.**

## Important steps before you launch PayEx Faktura at your website

Prior to launching PayEx Faktura at your site, make sure that you have done the following:  

1.  Send a merchant logo in .JPG format to [setup.ecom@PayEx.com][setup-mail]. The logo will be displayed on all your invoices. Minimum accepted size is 600x200 pixels, and at least 300 DPI.
2.  Included a link to "Terms and Conditions" for PayEx Faktura.

## API requests

The API requests are displayed in the [invoice flow](#invoice-flow). The options you can choose from when creating a payment with key operation set to Value FinancingConsumer are listed below. The general REST based API model is described in the [technical reference][technical-reference].

### Options before posting a payment

**POST Request**

{:.table .table-striped}
| *POST Request* |	**Sweden** ![Swedish flag][se-png] |	**Norway** ![Norwegian flag][no-png] |	**FInland** ![Finish flag][fi-png] |
| *Operation* |	FinancingConsumer	| FinancingConsumer |	FinancingConsumer |
| *Intent* |	Authorization |	Authorization |	Authorization |
| *Currency* |	SEK |	NOK |	EUR |
| *InvoiceType* |	PayExFinancingSE |	PayExFinancingNO |	PayExFinancingFI |

*   An invoice payment is always two-phased based - you create an Authorize transaction, that is followed by a Capture or Cancel request.
*   **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL][callback-url]in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.][callback-api]

# Invoice flow

The sequence diagram below shows a high level description of the invoice process, including the four requests you have to send to PayEx to create an authorize transaction. **Note that the invoice will not be created/distributed before you have made a Capture request.** The Capture/Cancel/Reversal opions are described below under "Options after posting a payment". The links will take you directly to the API description for the specific request. 

```mermaid
sequenceDiagram
    Consumer->>Merchant: Start purchase (collect SSN and postal number)
    activate Merchant
    note left of Merchant: First API request 
    Merchant->>PayEx: POST [Invoice Payments][invoice-payments] (operation=FinancingConsumer)
    activate PayEx
    PayEx-->>Merchant: payment resource
    note left of Merchant: Second API request
    Merchant-->>PayEx: Post [approvedLegalAddress][approved-legal-address] (SNN and postal number)
    PayEx-->>PayEx: Update payment with consumer delivery address
    PayEx-->>Merchant: Approved legaladdress information
    deactivate PayEx
    Merchant-->>Consumer: Display all details and final price
    Consumer->>Consumer: Input email and mobile number
    deactivate Merchant
    Consumer->>Merchant: Confirm purchase
    activate Merchant
    note left of Merchant: Third API request
    Merchant->>+PayEx: Post [invoice authorizations][invoice-authorizations] (Transaction Activity=FinancingConsumer)
    PayEx-->>-Merchant: Transaction result
    note left of Merchant: Fourth API request
    Merchant->>+PayEx: GET [invoice payments][invoice-payments] 
    PayEx-->>-Merchant: payment resource
    Merchant-->>Consumer: Display result
    deactivate Merchant
```

[approved-legal-address]: #
[callback-api]: #
[callback-url]: #
[fi-png]: /assets/img/fi.png
[invoice-payments]: #
[no-png]: /assets/img/no.png
[se-png]: /assets/img/se.png
[setup-mail]: mailto:setup.ecom@PayEx.com
[technical-reference]: #
