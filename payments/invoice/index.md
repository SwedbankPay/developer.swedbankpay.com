---
title: Swedbank Pay Payments Invoice After Payments
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

# Invoice Payments

>PayEx Invoice implements the *Financing Invoice API* and is a service where PayEx helps improve cashflow by purchasing merchant invoices.

# Financing Invoice Direct API (FI)

>PayEx Invoice (PayEx Faktura) is a payment service where PayEx helps improve cashflow by purchasing merchant invoices. PayEx receives invoice data, which is used to produce and distribute invoices to the consumer/end-user.  

## Introduction

*   To create an invoice payment, you need to collect all purchase information and make a `POST` request towards PayEx.
*   You also need to collect name, address, post number, social security number (SSN) / person number, e-mail and mobile number, and make another `POST` request towards PayEx in order to create an authorization transaction.
*   To get the authorization result, you need  to follow up with a `GET` request using the paymentID received in the first step.
*   Finally, when you are ready to ship your order, you will have to make a `POST` request to make a Capture. **At this point PayEx will generate the invoice to the consumer.**

## Important steps before you launch PayEx Faktura at your website

Prior to launching PayEx Faktura at your site, make sure that you have done the following:  

1.  Sent a merchant logo in .JPG format to [setup.ecom@payex.com](mailto:setup.ecom@payex.com). The logo will be displayed on all your invoices. Minimum accepted size is 600x200 pixels, and at least 300 DPI.
2.  Included a link to "Terms and Conditions" for PayEx Faktura.

## API requests

The API requests are displayed in the [invoice flow](#invoice-flow). The options you can choose from when creating a payment with key operation set to Value FinancingConsumer are listed [here][optional-features]. The general REST based API model is described in the [technical reference].



# Invoice flow

The sequence diagram below shows the high level description of the invoice process, including the three requests you have to send to PayEx to create an authorize transaction. **Note that the invoice will not be created/distributed before you have made a Capture request.** The Capture/Cancel/Reversal opions are described below under "Options after posting a payment". The links will take you directly to the API description for the specific request. 

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/invoice-payments/financing-invoice-direct-api-fi/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">


```mermaid
sequenceDiagram
    Consumer->>+Merchant: start purchase
    note left of Merchant: First API request 
    Merchant->>+PayEx: POST [Invoice Payments][invoice-payments] (operation=FinancingConsumer)
    PayEx-->>-Merchant: payment resource
    Merchant-->>-Consumer: Display All detail and final price
    Consumer-->>Consumer: Input consumer data
    Consumer->>Merchant: Confirm purchase
    Activate Merchant
    note left of Merchant: Second API request
    Merchant->>+PayEx: Post [Invoice autorizations][invoice-authorizations] (Transaction Activity=FinancingConsumer)
    PayEx->>-Merchant: Tranaction result
    note left of Merchant: Third API request
    Merchant->>+PayEx: GET [Invoice payments][invoice-payments]
    PayEx-->>-Merchant: payment resource
    Merchant-->>Consumer: Display result
    Deactivate Merchant
```



<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/invoice-payments/financing-invoice-direct-api-fi/WebHome?xpage=plain&amp;uml=4" style="max-width:100%">

# Financing Invoice Direct API (SE and NO)

>PayEx Invoice (PayEx Faktura) is a payment service where PayEx helps improve cashflow by purchasing merchant invoices. PayEx receives invoice data, which is used to produce and distribute invoices to the consumer/end-user.  

## Introduction

*   To create an invoice payment, you need to collect all purchase information and make a `POST` request towards PayEx.
*   You also need to collect social security number (SSN) / person number and postal number from the consumer, and make another `POST` request towards PayEx in order to retrieve the name and address from the consumer.
*   To create the authorization transaction, you need to calculate the final price / amount, and make a third `POST` request where you send in the consumer data.
*   To get the authorization result, you need  to follow up with a `GET` request using the paymentID received in the first step.
*   Finally, when you are ready to ship your order, you will have to make a `POST` request to make a Capture. **At this point PayEx will generate the invoice to the consumer.**

## Important steps before you launch PayEx Faktura at your website

Prior to launching PayEx Faktura at your site, make sure that you have done the following:  

1.  Send a merchant logo in .JPG format to [setup.ecom@PayEx.com](mailto:setup.ecom@PayEx.com). The logo will be displayed on all your invoices. Minimum accepted size is 600x200 pixels, and at least 300 DPI.
2.  Included a link to "Terms and Conditions" for PayEx Faktura.

## API requests

The API requests are displayed in the [invoice flow](#HInvoiceflow). The options you can choose from when creating a payment with key operation set to Value FinancingConsumer are listed below. The general REST based API model is described in the [technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

### Options before posting a payment


**POST Request**

{:.table .table-striped}
| **POST Request** |	Sweden ![Sweedish flag][se-png]|	Norway ![Norwegian flag][no-png]
| **Operation** |	FinancingConsumer |	FinancingConsumer |
| **Intent** | Authorization | Authorization |
| **Currency** | SEK | NOK |
| **InvoiceType** |	PayExFinancingSE |	PayExFinancingNO |


*   An invoice payment is always two-phased based - you create an Authorize transaction, that is followed by a Capture or Cancel request.
*   **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL ](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs)in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback)

# Invoice flow

The sequence diagram below shows a high level description of the invoice process, including the four requests you have to send to PayEx to create an authorize transaction. **Note that the invoice will not be created/distributed before you have made a Capture request.** The Capture/Cancel/Reversal opions are described below under "Options after posting a payment". The links will take you directly to the API description for the specific request. 

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/invoice-payments/financing-invoice-direct-api-se-no/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">

## Options after posting a payment

*   **Abort:** It is possible to abort the process, if the payment has no successful transactions. [See the PATCH payment description](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HAbort).
*   You must always follow up an Invoice Authorization with a Capture or Cancel request.
*   For reversals, you will need to implement the Reversal request.
*   **If CallbackURL is set:** Whenever changes to the payment occur a [Callback request](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback) will be posted to the [CallbackURL](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs), which was generated when the payment was created.

### Capture Sequence

[Capture](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/invoice-payments/#HCaptures) can only be done on a successfully authorized transaction. It is possible to do a part-capture where you only capture a part of the authorization amount. You can later do more captures on the same payment up to the total authorization amount.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/invoice-payments/financing-invoice-direct-api-se-no/WebHome?xpage=plain&amp;uml=2" style="max-width:100%">

### Cancel Sequence

[Cancel](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/invoice-payments/#HCancellations) can only be done on a successfully authorized transaction, not yet captured. If you do cancel after doing a part-capture you will cancel the not yet captured amount only.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/invoice-payments/financing-invoice-direct-api-se-no/WebHome?xpage=plain&amp;uml=3" style="max-width:100%">

### Reversal Sequence

[Reversals](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/invoice-payments/#HReversals) can only be done on an captured transaction where there are some captured amount not yet reversed.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/invoice-payments/financing-invoice-direct-api-se-no/WebHome?xpage=plain&amp;uml=4" style="max-width:100%">

# Financing Invoice Payment Pages

>PayEx Invoice (PayEx Faktura) is a payment service where PayEx helps improve cashflow by purchasing merchant invoices. The Redirect purchase scenario is the easiest way to implement PayEx Invoice.  

## Introduction

*   When the consumer begins the purchase process in your merchant/webshop site, you need to make a `POST` request towards PayEx with your Purchase information. This will generate a payment object with a unique paymentID. You either receive a Redirect URL to a hosted page or a JavaScript source in response.
*   You need to [redirect](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/#HRedirectimplementation) the payer to the Redirect payment page or embed the script source on you site to create a [Hosted View](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/payex-payment-instruments/#HostedViewimplementation) in an iFrame; so that she may enter her details (social security number, email address, etc.) in a secure PayEx hosted environment.
*   PayEx will redirect the payer's browser to - or display directly in  the iFrame - one of two specified URLs, depending on whether the payment session is followed through completely or cancelled beforehand. Please note that both a successful and rejected payment reach completion, in contrast to a cancelled payment.
*   When you detect that the payer reach your completeUrl , you need to do a `GET` request, containing the paymentID generated in the first step, to receive the state of the transaction.

## API requests

The API requests are displayed in the [invoice flow](#HInvoiceflow). The options you can choose from when creating a payment with key operation set to Value FinancingConsumer are listed below. The general REST based API model is described in the [technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/).

## Screenshots

![1551694661708-563.png](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/invoice-payments/financing-invoice-redirect/WebHome/1551694661708-563.png)

![1551695031437-960.png](https://developer.payex.com/xwiki/wiki/developer/download/Main/ecommerce/payex-payment-instruments/invoice-payments/financing-invoice-redirect/WebHome/1551695031437-960.png)

### Options before posting a payment

All valid options when posting a payment with operation equal to FinancingConsumer, are described in [the technical reference](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/invoice-payments/).

{:.table .table-striped}
| **POST Request** |	**Sweden** ![Swedish flag][se-png] |	**Norway** ![Norwegian flag][no-png] |	**FInland** ![Finish flag][fi-png] |
| **Operation** |	FinancingConsumer	| FinancingConsumer |	FinancingConsumer |
| **Intent** |	Authorization |	Authorization |	Authorization |
| **Currency** |	SEK |	NOK |	EUR |
| **InvoiceType** |	PayExFinancingSE |	PayExFinancingNO |	PayExFinancingFI |

*   An invoice payment is always two-phased based - you create an Authorize transaction, that is followed by a Capture or Cancel request.
*   **Defining CallbackURL**: When implementing a scenario, it is optional to set a [CallbackURL ](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/#HURLs)in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here.](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback)

## Invoice flow

The sequence diagram below shows the two requests you have to send to PayEx to make a purchase. The diagram also shows in high level, the sequence of the process of a complete purchase.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/invoice-payments/financing-invoice-redirect/WebHome?xpage=plain&amp;uml=1" style="max-width:100%">

### Options after posting a payment

*   **Abort:** It is possible to abort the process, if the payment has no successful transactions. [See the PATCH payment description](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HAbort).
*   You must always follow up an Invoice Authorization with a Capture or Cancel request.
*   For reversals, you will need to implement the Reversal request.
*   **If CallbackURL is set:** Whenever changes to the payment occur a [Callback request](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/#HCallback) will be posted to the callbackUrl, which was generated when the payment was created.

### Capture Sequence

[Capture](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/invoice-payments/#HCaptures) can only be done on a authorized transaction. It is possible to do a part-capture where you only capture a smaller amount than the authorization amount. You can later do more captures on the sam payment upto the total authorization amount.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/invoice-payments/financing-invoice-redirect/WebHome?xpage=plain&amp;uml=2" style="max-width:100%">

### Cancel Sequence

[Cancel](https://developer.payex.com/xwiki/wiki/developer/view/Main/ecommerce/technical-reference/core-payment-resources/invoice-payments/#HCancellations) can only be done on a authorized transaction. If you do cancel after doing a part-capture you will cancel the difference between the capture amount and the authorization amount.

<embed src="https://developer.payex.com/xwiki/wiki/developer/get/Main/ecommerce/payex-payment-instruments/invoice-payments/financing-invoice-redirect/WebHome?xpage=plain&amp;uml=3" style="max-width:100%">

### Reversal Sequence

[Reversal][reversals] can only be done on an captured transaction where there are some captured amount not yet reversed.

```mermaid
sequenceDiagram
    Merchant->>PayEx: Post [Invoice reversals][invoice-reversals]
    Activate Merchant
    Activate PayEx
    PayEx->>Merchant: transaction resource
    Deactivate Merchant 
    Deactivate PayEx
```



---------------------------------------------------------------

[technical-reference]: #
[callback-url]: #
[callback-api]: #
[invoice-payments]: #
[see-the-PATCH-payment-description]: /payments/credit-card/after-payment
[callback-request]: #
[invoice-captures]: #
[cancel]:#
[invoice-cancellations]: #
[invoice-reversals]: #
[reversals]: #
[setup-mail]: mailto:setup.ecom@PayEx.com
[optional-features]: /payments/invoice/optional-features
[se-png]: \assets\img\se.png
[no-png]: \assets\img\no.png
[approved-legal-address]: #
[invoice-authorization]: #
[callback-request]: #
[capture]: #
[redirect]: #
[hosted-view]: /payments/#hosted-view-implementation
[financing-invoice-1-png]: \assets\img\financing-invoice-1.png
[financing-invoice-2-png]: \assets\img\financing-invoice-2.png