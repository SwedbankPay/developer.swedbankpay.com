---
title: Swedbank Pay Trustly Payments
sidebar:
  navigation:
  - title: Trustly Payments
    items:
    - url: /payments/trustly
      title: Introduction
    - url: /payments/trustly/redirect
      title: Redirect
    - url: /payments/trustly/seamless-view
      title: Seamless View
    - url: /payments/trustly/after-payment
      title: After Payment
    - url: /payments/trustly/other-features
      title: Other Features
---

{% include jumbotron.html body="**Trustly Payments** is one of the easiest
                                payment service where Swedbank Pay helps improve
                                cashflow through direct bank payments. Choose
                                between our **Redirect** and
                                **Seamless view** integration options." %}

{% include alert.html type="informative"
                      icon="cached"
                      body="**Redirect** is the easiest way to direct bank Invoice
                      Payments. Redirect will take your consumer to a Swedbank
                      Pay hosted payment page where they can perform a secure
                      transaction. The consumer will be redirected back to your
                      website after the completion of the payment." %}

{% include alert.html type="informative"
                      icon="branding_watermark"
                      body="**Seamless View** is our solution for a payment
                      experience that is integrated directly on your website.
                      The payment process will be executed in an `iframe` on
                      your page." %}

### Important steps before you launch Swedbank Pay Invoice Payments at your website

Prior to launching Trustly Payments at your site, make sure that
you have done the following:

1. Make sure that the payment option is displayed with a Trustly logo.

## API Requests

The API requests are displayed in the sales flow below.

## Languages

The displayed languages that we currently support is English (`en-us`), Norwegian (`nb-no`), Swedish (`sv-se`), and Finish (`fi-fi`).

## Trustly flow

This is an example of the Redirect scenario. For other integrations, take a
look at the respective sections. The sequence diagram below shows the two
requests you have to send to Swedbank Pay to make a purchase. The diagram also
shows the steps in a [sale][sale] process.

The Trustly integration uses the Deposit call by performing a payment. After
SwedbankPay perform a `Deposit` call https://trustly.com/en/developer/api#/deposit, the end-user will be presented with the returned IFrame URL in order to perform
the payment with their prefered bank. Once the user has completed the payment,
SwedbankPay will receive a notification asynchronously from Trustly, hence why
the UI will initiate polling toward our back-end. The payment status after being
redirect to `completeUrl` will then indicate if the payment was successful or
not, or if the payment is still in progress.

```plantuml
@startuml
Actor EndUser
Participant Merchant
Participant PSP.UI
Participant PSP.Payment
Participant Trustly
EndUser -> Merchant: start purchase
Activate Merchant
Merchant->PSP.Payment: POST [[/psp/trustly/payments]]
Activate PSP.Payment
PSP.Payment->PSP.Payment: create payment
PSP.Payment-->Merchant: payment response \nwith operation [redirect-sale]
Deactivate PSP.Payment
Merchant --> EndUser: redirect to [redirect-sale]
Deactivate Merchant
EndUser -> PSP.UI: GET [[https://ecom.payex.com/psp/ \n /trustly/payments/sales/<paymentToken>]]
Activate PSP.UI
PSP.UI->PSP.Payment: GET [ /psp/trustly/payments/<paymentId>]]
Activate PSP.Payment
PSP.Payment --> PSP.UI: payment response \nwith operation [create-sale]
Deactivate PSP.Payment
PSP.UI --> EndUser: display [view-trustly-consumer-information]
Deactivate PSP.UI
EndUser -> EndUser: input firstname
EndUser -> EndUser: input lastname
EndUser -> PSP.UI: submit consumer-information
Activate PSP.UI
PSP.UI->PSP.Payment: POST [[ /psp/trustly/payments/<paymentId>/sales]]\n(with consumer-information)
Activate PSP.Payment
PSP.Payment->PSP.Payment: create sale (activity=PrepareSale)
PSP.Payment -> Trustly: POST deposit
Activate Trustly
Trustly --> PSP.Payment: Redirect URL
Deactivate Trustly
PSP.Payment-->PSP.UI: sale response \nwith operation [redirect-trustly]
Deactivate PSP.Payment
PSP.UI --> EndUser: display [redirect-trustly]
Deactivate PSP.UI
EndUser -> Trustly: complete Trustly payment
Activate Trustly
Trustly -> PSP.Payment: POST [[psp/trustly/payments/notifications]]\nwith pending
Trustly -> PSP.UI: REDIRECT [[/psp/trustly/core/payments/sales/<paymentToken>]]\nOR PaymentUrl if provided
Deactivate Trustly
Activate PSP.UI
loop ~30 seconds or until payment is complete / failed
    PSP.UI->PSP.Payment: GET [[/psp/trustly/payments/<paymentId>]]
    Activate PSP.Payment
    PSP.Payment --> PSP.UI: payment response
    Deactivate PSP.Payment
end
PSP.UI --> EndUser: redirect completeUrl
Deactivate PSP.UI
Trustly -> PSP.Payment: POST [[psp/trustly/payments/notifications]]\nwith credit or cancel
Activate PSP.Payment
PSP.Payment -> PSP.Payment: complete / abort sale
PSP.Payment -> Merchant: POST callbackUrl payment status
Deactivate PSP.Payment
@enduml
```

{% include iterator.html next_href="redirect" next_title="Next: Redirect" %}

[after-payment]: /payments/trustly/after-payment
[callback-api]: /payments/trustly/other-features#callback
[financing-consumer]: /payments/trustly/other-features#financing-consumer
[no-png]: /assets/img/flag-norway.png
[optional-features]: /payments/trustly/optional-features
[recur]: /payments/trustly/other-features#recur
[redirect]: /payments/trustly/redirect
[purchase]: /payments/trustly/other-features#create-payment
[se-png]: /assets/img/flag-sweden.png
[setup-mail-finland]: mailto:verkkokauppa.setup@swedbankpay.fi
[setup-mail-norway]: mailto:ehandelsetup@swedbankpay.no
[setup-mail-sweden]: mailto:ehandelsetup@swedbankpay.se
[verify]: /payments/trustly/other-features#verify
