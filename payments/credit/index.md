---
title: Swedbank Pay Credit Payments
sidebar:
  navigation:
  - title: Credit Payments
    items:
    - url: /payments/credit/
      title: Introduction
    - url: /payments/credit/redirect
      title: Redirect
    - url: /payments/credit/after-payment
      title: After Payment
    - url: /payments/credit/other-features
      title: Other Features
---

{% include alert-review-section.md %}

{% include jumbotron.html body="One account, one invoice, low monthy payments,
complete overview and a credit limit always at your service. That's our Credit
Payments." %}

Credit Payments is our payment instrument for part payments, currently available
in Sweden. Given that the payer passes the credit check, a credit account is
opened with the first purchase. The credit limit is set by the amount of this
purchase, rounded up to the nearest SEK 100, but a higher credit limit can be
obtained with a separate agreement and a new credit check.

All part payment purchases will be gathered on the same account and on the same
invoice. A complete overview of all the purchases is available in our Consumer
Portal. The payer is required to make monthly payments of 5 % of the total
credit used, but no lower than SEK 100. It is also possible to pay the whole
debt in full at once. The credit limit remains available as the debt gets paid,
and can be used to make other purchases.

## Purchase Flow

After a Credit Payment is created, the payer is redirected to the payment page
where Social Security Number, email address, phone number and zip code is
entered, before the payer proceeds by pushing "Next".

![screenshot of the Credit personal info input page][credit-personal-info-input]{:height="700px" width="425px"}

A lookup is performed by Swedbank Pay to retrieve the payer's legal address,
which is shown (masked) on the following page. The payer has to confirm that
this address is correct.

![screenshot of the Credit legal address confirmation page][credit-legal-address]{:height="500px" width="425px"}

After this confirmation, a credit check is performed and the account is created,
the `authorization` is done and the payer is redirected back to the merchant.

## Good To Know

### Payment Type

Credit Payments is one of the instruments using two-phase payments. The
`authorization` is done when the consumer creates the account with the first
purchase or adds another purchase to the account, and the `abort`, `cancel`,
`capture` or `reversal` is done by the merchant at a later time. Read more about
the [different operations][after-payment] and the [payment
resource][payment-resource].

### Demoshop

Unfortunately, our demoshop does not support Credit Payments at the moment.

{% include iterator.html  next_href="redirect" next_title="Next: Redirect" %}

[payment-resource]: /payments/credit/other-features#payment-resource
[after-payment]: /payments/credit/after-payment#operations
[credit-legal-address]: /assets/img/payments/credit-legal-address425x500.png
[credit-personal-info-input]: /assets/img/payments/credit-personal-info-input425x700.png