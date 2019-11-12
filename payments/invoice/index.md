---
title: Swedbank Pay Payments Invoice
sidebar:
  navigation:
  - title: Invoice Payments
    items:
    - url: /payments/invoice
      title: Introduction
    - url: /payments/invoice/redirect
      title: Redirect
    - url: /payments/invoice/seamless-view
      title: Seamless View
    - url: /payments/invoice/after-payment
      title: After Payment
    - url: /payments/invoice/other-features
      title: Other Features
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under 
                      construction and should not be used to integrate against 
                      Swedbank Pay's APIs yet." %}

>PayEx Invoice implements the *Financing Invoice API* and is a service where 
PayEx helps improve cashflow by purchasing merchant invoices.

## Financing Invoice Direct API (FI)

>PayEx Invoice (PayEx Faktura) is a payment service where PayEx helps improve 
cashflow by purchasing merchant invoices. PayEx receives invoice data, which is 
used to produce and distribute invoices to the consumer/end-user.  

### Introduction

*   To create an invoice payment, you need to collect all purchase information 
    and make a `POST` request towards PayEx.
*   You also need to collect name, address, post number, social security number 
    (SSN) / person number, e-mail and mobile number, and make another `POST` 
    request towards PayEx in order to create an authorization transaction.
*   To get the authorization result, you need  to follow up with a `GET` request
     using the paymentID received in the first step.
*   Finally, when you are ready to ship your order, you will have to make a 
    `POST` request to make a Capture. **At this point PayEx will generate the 
    invoice to the consumer.**

### Important steps before you launch PayEx Faktura at your website

Prior to launching PayEx Faktura at your site, make sure that you 
have done the following:  

1.  Sent a merchant logo in .JPG format to [setup.ecom@payex.com][setup-mail]. 
    The logo will be displayed on all your invoices. Minimum accepted size is 
    600x200 pixels, and at least 300 DPI.
2.  Included a link to "Terms and Conditions" for PayEx Faktura.

### API requests

The API requests are displayed in the [invoice flow](#invoice-flow). 
The options you can choose from when creating a payment with key operation set 
to Value FinancingConsumer are listed [here][optional-features]. The general 
REST based API model is described in the [technical reference].


## Invoice flow

The sequence diagram below shows the high level description of the invoice 
process, including the three requests you have to send to PayEx to create an 
authorize transaction. **Note that the invoice will not be created/distributed 
before you have made a Capture request.** The Capture/Cancel/Reversal opions are 
described in [optional features][optional-features]. 
The links will take you directly to the API description for the specific request. 

```mermaid
sequenceDiagram
    Consumer->>+Merchant: start purchase
    note left of Merchant: First API request 
    Merchant->>+PayEx: POST <Invoice Payments> (operation=FinancingConsumer)
    PayEx-->>-Merchant: payment resource
    Merchant-->>-Consumer: Display All detail and final price
    Consumer-->>Consumer: Input consumer data
    Consumer->>Merchant: Confirm purchase
    Activate Merchant
    note left of Merchant: Second API request
    Merchant->>+PayEx: Post <Invoice autorizations> (Transaction Activity=FinancingConsumer)
    PayEx->>-Merchant: Tranaction result
    note left of Merchant: Third API request
    Merchant->>+PayEx: GET <Invoice payments>
    PayEx-->>-Merchant: payment resource
    Merchant-->>Consumer: Display result
    Deactivate Merchant
```

## Financing Invoice Direct API (SE and NO)

>PayEx Invoice (PayEx Faktura) is a payment service where PayEx helps improve 
cashflow by purchasing merchant invoices. PayEx receives invoice data, which is 
used to produce and distribute invoices to the consumer/end-user.  

### Introduction

*   To create an invoice payment, you need to collect all purchase information 
    and make a `POST` request towards PayEx.
*   You also need to collect social security number (SSN) / person number and 
    postal number from the consumer, and make another `POST` request towards 
    PayEx in order to retrieve the name and address from the consumer.
*   To create the authorization transaction, you need to calculate the final 
    price / amount, and make a third `POST` request where you send in 
    the consumer data.
*   To get the authorization result, you need  to follow up with a `GET` 
    request using the paymentID received in the first step.
*   Finally, when you are ready to ship your order, you will have to make 
    a `POST` request to make a Capture. **At this point PayEx will generate 
    the invoice to the consumer.**

### Important steps before you launch PayEx Faktura at your website

Prior to launching PayEx Faktura at your site, make sure that you have done 
the following:  

1.  Send a merchant logo in .JPG format to [setup.ecom@PayEx.com][setup-mail]. 
    The logo will be displayed on all your invoices. Minimum accepted size is 
    600x200 pixels, and at least 300 DPI.
2.  Included a link to "Terms and Conditions" for PayEx Faktura.

### API requests

The API requests are displayed in the [invoice flow](#invoice-flow). 
The options you can choose from when creating a payment with key operation set 
to Value FinancingConsumer are listed below.

#### Options before posting a payment

**POST Request**

{:.table .table-striped}
| **POST Request** |	Sweden ![Sweedish flag][se-png]|	Norway ![Norwegian flag][no-png]
| **Operation** |	FinancingConsumer |	FinancingConsumer |
| **Intent** | Authorization | Authorization |
| **Currency** | SEK | NOK |
| **InvoiceType** |	PayExFinancingSE |	PayExFinancingNO |


*   An invoice payment is always two-phased based - you create an Authorize 
    transaction, that is followed by a Capture or Cancel request.
*   **Defining CallbackURL**: When implementing a scenario, it is optional to 
    set a [CallbackURL][callback-api] in the `POST` request. If `callbackURL` 
    is set PayEx will send a postback request to this URL when the consumer 
    has fulfilled the payment.

## Invoice flow

The sequence diagram below shows a high level description of the invoice 
process, including the four requests you have to send to PayEx to create an 
authorize transaction. **Note that the invoice will not be created/distributed 
before you have made a Capture request**. The Capture/Cancel/Reversal opions 
are described below under "Options after posting a payment". The links will 
take you directly to the API description for the specific request. 

```mermaid
sequenceDiagram
    Consumer->>Merchant: Start purchase (collect SSN and postal number)
    Activate Merchant
    note left of Merchant: First API request 
    Merchant->>PayEx: POST <Invoice Payments> (operation=FinancingConsumer)
    Activate PayEx
    PayEx-->>Merchant: payment resource
    note left of Merchant: Second API request
    Merchant-->>PayEx: Post <approvedLegalAddress> (SNN and postal number)
    PayEx-->>PayEx: Update payment with consumer delivery address
    PayEx-->>Merchant: Approved legaladdress information
    Deactivate PayEx
    Merchant-->>Consumer: Display all details and final price
    Consumer->>Consumer: Input email and mobile number
    Deactivate Merchant
    Consumer->>Merchant: Confirm purchase
    Activate Merchant
    note left of Merchant: Third API request
    Merchant->>+PayEx: Post <invoice authorizations> (Transaction Activity=FinancingConsumer)
    PayEx-->>-Merchant: Transaction result
    note left of Merchant: Fourth API request
    Merchant->>+PayEx: GET <invoice payments>
    PayEx-->>-Merchant: payment resource
    Merchant-->>Consumer: Display result
    Deactivate Merchant
```

## Financing Invoice Payment Pages

>PayEx Invoice (PayEx Faktura) is a payment service where PayEx helps improve 
cashflow by purchasing merchant invoices. The Redirect purchase scenario is the 
easiest way to implement PayEx Invoice.  

### Introduction

*   When the consumer begins the purchase process in your merchant/webshop 
    site, you need to make a `POST` request towards PayEx with your Purchase 
    information. This will generate a payment object with a unique paymentID. 
    You either receive a Redirect URL to a hosted page or a JavaScript source 
    in response.
*   You need to [redirect][redirect] the payer to the Redirect payment page or 
    embed the script source on you site to create a [Hosted View][hosted-view] 
    in an iFrame; so that she may enter her details (social security number, 
    email address, etc.) in a secure PayEx hosted environment.
*   PayEx will redirect the payer's browser to - or display directly in the 
    iFrame - one of two specified URLs, depending on whether the payment 
    session is followed through completely or cancelled beforehand. Please note 
    that both a successful and rejected payment reach completion, in contrast 
    to a cancelled payment.
*   When you detect that the payer reach your completeUrl , you need to do 
    a `GET` request, containing the paymentID generated in the first step, 
    to receive the state of the transaction.

### API requests

The API requests are displayed in the [invoice flow](#invoice-flow). 
The options you can choose from when creating a payment with key operation 
set to Value FinancingConsumer are listed below. 

### Screenshots

![financing-invoice-1][financing-invoice-1-png]{:width="444" :height="506"}

![financing-invoice-2][financing-invoice-2-png]{:width="447" :height="641"}

#### Options before posting a payment

All valid options when posting a payment with operation equal to 
FinancingConsumer, are described in the technical reference 
for [financing consumer][technical-reference-financing-consumer].

{:.table .table-striped}
| **POST Request** |	**Sweden** ![Swedish flag][se-png] |	**Norway** ![Norwegian flag][no-png] |	**FInland** ![Finish flag][fi-png] |
| **Operation** |	FinancingConsumer	| FinancingConsumer |	FinancingConsumer |
| **Intent** |	Authorization |	Authorization |	Authorization |
| **Currency** |	SEK |	NOK |	EUR |
| **InvoiceType** |	PayExFinancingSE |	PayExFinancingNO |	PayExFinancingFI |

*   An invoice payment is always two-phased based - you create an Authorize 
    transaction, that is followed by a Capture or Cancel request.
*   **Defining CallbackURL**: When implementing a scenario, it is optional 
    to set a [CallbackURL ][callback-api]in the `POST` request. 
    If callbackURL is set PayEx will send a postback request to this URL when 
    the consumer has fulfilled the payment. 
    [See the Callback API description here.][callback-api]

### Invoice flow

The sequence diagram below shows the two requests you have to send to PayEx 
to make a purchase. 
The diagram also shows in high level, the sequence of the process 
of a complete purchase.


```mermaid
sequenceDiagram
    Consumer->>Merchant: Start purchase
    Activate Merchant
    note left of Merchant: First API request 
    Merchant->>+PayEx: POST <Invoice Payments> (operation=FinancingConsumer)
    PayEx-->>-Merchant: payment resource
    Merchant-->>-Consumer: authorization page
    note left of Consumer: redirect to PayEx
    Consumer->>+PayEx: enter consumer details
    PayEx-->>-Consumer: redirect to merchant
    note left of Consumer: redirect back to Merchant
    Consumer->>Merchant: access merchant page
    Activate Merchant
    note left of Merchant: Second API request
    Merchant->>+PayEx: GET <Invoice payments>
    PayEx-->>-Merchant: payment resource
    Merchant-->>Consumer: display purchase result
    Deactivate Merchant
```

---------------------------------------------------------------

[fi-png]: /assets/img/fi.png
[financing-invoice-1-png]: /assets/img/checkout/test-purchase.png
[financing-invoice-2-png]: /assets/screenshots/invoice/redirect/iframe-verify-data.png
[no-png]: /assets/img/no.png
[se-png]: /assets/img/se.png
[callback-api]: /payments/invoice/other-features#callback
[hosted-view]: /payments/#hosted-view-implementation
[optional-features]: /payments/invoice/optional-features
[redirect]: /payments/invoice/redirect
[setup-mail]: mailto:setup.ecom@PayEx.com
