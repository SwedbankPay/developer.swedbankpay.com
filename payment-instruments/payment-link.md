---
title: Payment Link
redirect_from: /payments/payment-link/
estimated_read: 5
description: |
  The implementation sequence for this scenario is a variant of the purchase
  sequence in a Hosted Payment Pages redirect scenario.
  The payer is not redirected to the payment pages directly but will instead
  receive a payment link via mail/SMS.
  When the payer clicks on the link a payment window opens.
menu_order: 900
---

### Introduction

*   The Payment Link can be implemented for Card, MobilePay Online, Vipps and Swish
    payments, using the Redirect platform and seamless view.  

*   When the payer starts the purchase process in your merchant/webshop
    site, you need to make a POST request towards Swedbank Pay with your
    purchase information. You receive a Payment Link (same as redirect URL) in
    response.

*   You have to distribute the Payment Link to the customer through your order
    system, using channels like e-mail or SMS.
    *   NOTE: When sending information in e-mail/SMS, it is strongly
        recommended that you add information about your terms and conditions,
        including purchase information and price. **See recommendations in the
        next paragraph.**

*   When the payer clicks on the Payment Link, the Swedbank Pay payment page
    will open, letting the payer enter the payment details (varying depending
    on payment instrument) in a secure Swedbank Pay hosted environment. When
    paying with a card and if required, Swedbank Pay will handle 3D-secure
    verification.

*   After completion, Swedbank Pay will redirect the browser back to your
    merchant/webshop site.

*   If CallbackURL is set the merchant system will receive a callback from
    Swedbank Pay, enabling you to make a GET request towards Swedbank Pay with
    the paymentID received in the first step, which will return the purchase
    result.

### Recommendations regarding Payment Link in E-mail/SMS

When you as a merchant sends an e-mail or SMS to the payer about the Payment
Link, it is recommended to include contextual information that helps the payer
understand what will happen when clicking on the Payment Link. We recommend that
you include following information:

*   The name of the merchant/shop that initiates the payment
*   An understandable product description, describing what kind of service the
    payer will pay for.
*   Some order-id (or similar) that exists in the merchant's order system.
*   The price and currency.
*   Details about shipping method and expected delivery (if physical goods will
    be sent  to the payer).
*   Directions to (a link to a page) the merchant's terms and conditions (such
    as return policy) and information of how the payer can contact the
    merchant.
*   Details informing the payer that Terms & Conditions are considered as
    accepted and signed when clicking on the Payment Link.

### Recommendations about receipts

We recommend that you send an e-mail or SMS confirmation with a receipt to the
payer when the payment has been fulfilled.

### API requests

The API-requests depend on which payment instrument you are using when
implementing the Payment Link scenario, see purchase flow. One-phase payment
instruments will not implement capture or cancellation. The options available
when creating a payment with operation set to `Purchase` are listed below. The
general REST based API model is described WHEREEEEE?

### Screenshots

When clicking the payment link, the payer will be directed to a payment page
similar to the examples below, where payment information can be entered.
