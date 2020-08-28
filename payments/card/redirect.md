---
title: Swedbank Pay Card Payments – Redirect
sidebar:
  navigation:
  - title: Card Payments
    items:
    - url: /payments/card/
      title: Introduction
    - url: /payments/card/redirect
      title: Redirect
    - url: /payments/card/seamless-view
      title: Seamless View
    - url: /payments/card/direct
      title: Direct
    - url: /payments/card/capture
      title: Capture
    - url: /payments/card/mobile-card-payments
      title: Mobile Card Payments
    - url: /payments/card/after-payment
      title: After Payment
    - url: /payments/card/other-features
      title: Other Features
---

{% include jumbotron.html body="Redirect is the simplest integration that
lets Swedbank Pay handle the payments, while
you handle your core activities. When ready to pay, the consumer will be
redirected to a secure Swedbank Pay hosted site. Finally, the consumer will be
redirected back to your website after the payment process." %}

When properly set up in your merchant/webshop site and the payer starts the
purchase process, you need to make a POST request towards Swedbank Pay with
your Purchase information. This will generate a payment object with a unique
`paymentID`. You will receive a **redirect URL** to a Swedbank Pay payment
page.

## Step 1: Create a Purchase

A `Purchase` payment is a straightforward way to charge the card of the payer.
It is followed up by posting a capture, cancellation or reversal transaction.

An example of an abbreviated `POST` request is provided below.
Each individual field of the JSON document is described in the following section.
An example of an expanded `POST` request is available in the
[other features section][purchase].

{% include alert-callback-url.md api_resource="creditcard" %}

{% include alert-risk-indicator.md %}

{% include card-purchase.md %}

When you receive the redirect url from Swedbank Pay, you redirect the
payer there to complete the payment. This ensures that card details and other
personal information is entered in a secure environment. Swedbank Pay handles
all authentication during this phase.

After an attempted payment, Swedbank Pay will redirect the Payer to one of two
specified URLs: `completeUrl` or `cancelUrl`.

If the payer cancel at any point, the payer will be redirected to the
`cancelUrl`. If the payment is followed through completely the payer will
reach the `completeUrl`.

{% include alert.html type="informative" icon="info" body="Important: Both
successful and rejected payments are labeled as `completed`." %}

This means that when you reach this point, you need to make sure that the
payment has gone through before you let the payer know that the payment was
successful. You do this by doing a `GET` request. This request has to include the
payment Id generated from the initial `POST` request, so that you can receive the
state of the transaction.

If you have chosen Seamless View, the `completeUrl` and `cancelUrl` will display
directly inside the iframe.

This is how the payment window might look:

![screenshot of the redirect card payment page][card-payment]{:height="500px" width="425px"}

Transactions in the currency SEK might look like this, with a debit/credit
selection available:

![screenshot of the swedish redirect card payment page][swedish-card-payment]{:height="600px" width="500px"}

### Purchase flow

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay

    activate Payer
    Payer->>-Merchant: start purchase
    activate Merchant
    Merchant->>-SwedbankPay: POST /psp/creditcard/payments
    activate SwedbankPay
    note left of Payer: First API request
    SwedbankPay-->>-Merchant: rel: redirect-authorization ①
    activate Merchant
    Merchant-->>-Payer: Redirect to authorization page
    activate Payer
    Payer->>-SwedbankPay: Access authorization page
    activate SwedbankPay
    note left of Payer: redirect to SwedbankPay ②
    SwedbankPay-->>-Payer: Display purchase information
    activate Payer
    Payer->>Payer: Input creditcard information ③
    Payer->>-SwedbankPay: Submit creditcard information

        opt If 3-D Secure required
        note left of Payer: Authentication Challenge ④
        SwedbankPay-->>Payer: Redirect to IssuingBank
        activate Payer
        Payer->>-IssuingBank: 3-D Secure authentication process
        activate IssuingBank
        IssuingBank-->>-Payer: 3-D Secure authentication process response
        activate Payer
        Payer->>-SwedbankPay: Access authentication page
        activate SwedbankPay
        end

    SwedbankPay-->>-Payer: Redirect to CompleteUrl ⑤
    activate Payer
    Payer->>-Merchant: Access CompleteUrl

        alt Callback is set
        activate SwedbankPay
        SwedbankPay->>SwedbankPay: Payment is updated
        SwedbankPay->>-Merchant: POST Payment Callback
        end

    activate Merchant
    Merchant->>-SwedbankPay: GET <payment.id> ⑥
    activate SwedbankPay
    note left of Payer: Second API request
    SwedbankPay-->>-Merchant: Payment result
    activate Merchant
    Merchant-->>-Payer: Display purchase result
```

### Explanations

*   ① `rel: redirect-authorization` is the name of one of the operations, sent as
  a response from Swedbank Pay to the Merchant. The href in this operation is
  the **redirect URL** to a Swedbank Pay payment page.
*   ② The consumer is being redirected to a secure Swedbank Pay hosted page
*   ③ The payment window is presented and the consumer can insert card information
  for authorization.
*   ④ If needed the consumer must go through an authorization challenge to verify
  the identity.
*   ⑤ The Payer reaches the CompleteUrl which you defined in the initial POST
  request. Please note that both a successful and rejected payment reach
  completion, in contrast to a cancelled payment.
*   ⑥ Send a GET request with the `paymentId` to check the state of the
  transaction. Click the link for [a complete list of payment and transaction
  states][payment-transaction-states].

### 3-D Secure

{% include card-general.md %}

Swedbank Pay will handle 3-D Secure authentication when this is required.
When dealing with card payments, 3-D Secure authentication of the
cardholder is an essential topic. There are two alternative outcomes of a credit
card payment:

1.  3-D Secure enabled - by default, 3-D Secure should be enabled, and Swedbank
   Pay will check if the card is enrolled with 3-D Secure. This depends on the
   issuer of the card. If the card is not enrolled with 3-D Secure, no
   authentication of the cardholder is done.
2.  Card supports 3-D Secure - if the card is enrolled with 3-D Secure, Swedbank
   Pay will redirect the cardholder to the autentication mechanism that is
   decided by the issuing bank. Normally this will be done using BankID or
   Mobile BankID.

{% include iterator.html prev_href="./" prev_title="Back: Introduction"
next_href="seamless-view" next_title="Next: Seamless View" %}

[abort]: /payments/card/other-features#abort
[callback]: /payments/card/other-features#callback
[cancel]: /payments/card/after-payment#cancellations
[capture]: /payments/card/capture
[create-payment]: /payments/card/other-features#create-payment
[expansion]: /home/technical-information#expansion
[payee-reference]: /payments/card/other-features#payee-reference
[payout]: /payments/card/other-features#payout
[purchase]: /payments/card/other-features#purchase
[price-resource]: /payments/card/other-features#prices
[recur]: /payments/card/other-features#recur
[reversal]: /payments/card/after-payment#reversals
[card-payment]: /assets/img/payments/card-payment.png
[swedish-card-payment]: /assets/img/payments/swedish-card-payment.png
[verify]: /payments/card/other-features#verify
[user-agent]: https://en.wikipedia.org/wiki/User_agent
[payment-transaction-states]: /payments/card/other-features#payment-and-transaction-states
