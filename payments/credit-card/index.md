---
title: Swedbank Pay Payments Credit Card Introduction
sidebar:
  navigation:
  - title: Credit Card Payments
    items:
    - url: /payments/credit-card/
      title: Introduction
    - url: /payments/credit-card/redirect
      title: Redirect
    - url: /payments/credit-card/seamless-view
      title: Seamless View
    - url: /payments/credit-card/direct
      title: Direct
    - url: /payments/credit-card/after-payment
      title: After Payment
    - url: /payments/credit-card/other-features
      title: Other Features
---

{% comment %}
TODO: This page needs serious clean-up.
{% endcomment %}

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

{% include jumbotron.html body="**Credit Card Payments** is the most popular,
versatile and global way to initate a transaction with a customer. Choose
between our **Seamless View**, **Redirect**, or **Direct** integration options." %}

* When properly set up in your merchant/webshop site and the payer starts the
purchase process, you need to make a `POST` request towards Swedbank Pay with
your Purchase information. This will generate a payment object with a unique
`paymentID`. You either receive a Redirect URL to a Swedbank Pay hosted
page(Redirect integration) or a JavaScript source in
response(Seamless View integration).
* You need to [redirect][redirect] the payer's browser to that specified URL,
or embed the script source on your site to create a Hosted View in an iFrame;
so that she can enter the credit card details in a secure Swedbank Pay hosted
environment.
* Swedbank Pay will handle 3D-secure authentication when this is required.
* Swedbank Pay will redirect the payer's browser to - or display directly in
the iFrame - one of two specified URLs, depending on whether the payment session
 is followed through completely or cancelled beforehand. Please note that both a
  successful and rejected payment reach completion, in contrast to a cancelled
  payment.
* When you detect that the payer reach your `completeUrl` , you need to do a
`GET` request, containing the `paymentID` generated in the first step, to
receive the state of the transaction.

## Screenshots

You will redirect the payer to Swedbank Pay hosted pages to collect the credit
card information.

![Screnshot-1]

## API Requests

The API requests are displayed in the [purchase flow](#purchase-flow).
You can [create a card `payment`][create-payment] with following `operation`
options:

* [Purchase][purchase]
* [Recur][recur]
* [Payout][payout]
* [Verify][verify]

Our `payment` example below uses the [`purchase`][purchase] value.

### Type of authorization - Intent

The intent of the payment identifies how and when the charge will be
effectuated. This determine the type of transaction used during the payment
process.

* **PreAuthorization**: A purchase with `PreAuthorization` intent is handled in
a similar manner as the ordinary authorization procedure. The notable difference
 is that the funds are put on hold for 30 days (for an ordinary authorization
the funds are reserved for 7 days). Also, with a `PreAuthorization`, the
captured amount can be higher than the preauthorized amount. The amount captured
 should not be higher than 20% of the original amount, due to card brand rules.
 You complete the purchase by
[finalizing the transaction][finalizing-the-transaction].
* **Authorization (two-phase)**: If you want the credit card to reserve the
amount, you will have to specify that the intent of the purchase is
Authorization. The amount will be reserved but not charged. You will later
(i.e. when you are ready to ship the purchased products) have to make a
[Capture][capture] or [Cancel][cancel] request.
* **AutoCapture (one-phase)**:  If you want the credit card to be charged right
away, you will have to specify that the intent of the purchase is `AutoCapture`.
 The credit card will be charged automatically after authorization and you don't
  need to do any more financial operations to this purchase.

### Purchase flow

The sequence diagram below shows a high level description of a complete
purchase, and the requests you have to send to Swedbank Pay. The links will
take you directly to the corresponding API description.

When dealing with credit card payments, 3D-Secure authentication of the
cardholder is an essential topic. There are three alternative outcome of a
credit card payment:

* 3D-Secure enabled - by default, 3D-secure should be enabled, and Swedbank Pay
* will check if the card is enrolled with 3D-secure. This depends on the issuer
* of the card. If the card is not enrolled with 3D-Secure, no authentication of
* the cardholder is done.
* Card supports 3D-Secure - if the card is enrolled with 3D-Secure, Swedbank Pay
* will redirect the cardholder to the autentication mechanism that is decided
* by the issuing bank. Normally this will be done using BankID or Mobile
* BankID.

```mermaid
sequenceDiagram
    Consumer->>+Merchant: start purchase
    Merchant->>+PayEx: POST [operation=PURCHASE](payments/credit-card/payments)
    Note left of Merchant: First API Request
    PayEx-->>-Merchant: payment resource
    Merchant-->>-Consumer: authorization page
    note left of Consumer: redirect to PayEx (If Redirect scenario)

    Consumer->>+Merchant: access merchant page
    Merchant->>+PayEx: GET [payments/credit-card/payments](payments/credit-card/payments)
    note left of Merchant: Second API request
    PayEx-->>-Merchant: payment resource
    Merchant-->>-Consumer: display purchase result
```

```mermaid
sequenceDiagram
  Consumer->>+Merchant: start purchase
  Merchant->>+PayEx: POST [operation=PURCHASE](payments/credit-card/payments)
  note left of Consumer: First API request
  PayEx-->Merchant: payment resource
  deactivate PayEx
  Merchant-->>Consumer: authorization page
  deactivate Merchant

  Consumer->>+PayEx: access authorization page
  note left of Consumer: redirect to PayEx\n(If Redirect scenario)
  PayEx-->>Consumer: display purchase information
  deactivate PayEx

  Consumer->>Consumer: input creditcard information
  Consumer->>+PayEx: submit creditcard information
  
  opt Card supports 3-D Secure
    PayEx-->>Consumer: redirect to IssuingBank
    deactivate PayEx
    Consumer->>IssuingBank: 3-D Secure authentication process
    Consumer->>+PayEx: access authentication page
  end
  
  PayEx-->>Consumer: redirect to merchant
  deactivate PayEx
  note left of Consumer: redirect back to merchant\n(If Redirect scenario)
  
  Consumer->>+Merchant: access merchant page
  Merchant->>+PayEx: GET [payments/credit-card/payments](payments/credit-card/payments)
  note left of Merchant: Second API request
  PayEx-->>Merchant: payment resource
  deactivate PayEx
  Merchant-->>Consumer: display purchase result
  deactivate Merchant

  opt Callback is set
    PayEx->>PayEx: Payment is updated
    activate PayEx
    PayEx->>Merchant: send [Callback request](callback-request)
    deactivate PayEx
  end
```

{% include iterator.html  next_href="redirect" next_title="Next: Redirect" %}

[Screnshot-1]: /assets/img/creditcard-image-1.png
{:height="711px" width="400px"}
[finalizing-the-transaction]: /payments/credit-card/after-payment
[cancel]: /payments/credit-card/after-payment/#cancellations
[capture]: /payments/credit-card/after-payment/#Capture
[redirect]: /payments/credit-card/redirect
[create-payment]: /payments/credit-card/other-features/#create-payment
[purchase]: /payments/credit-card/other-features/#purchase
[recur]: /payments/credit-card/other-features/#recur
[payout]: /payments/credit-card/other-features/#payout
[verify]: /payments/credit-card/other-features/#verify
