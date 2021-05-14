{% assign show_3d_secure = include.show_3d_secure | default: true %}
{% assign show_authorization = include.show_authorization | default: true %}

### Introduction

The Payment Link is available for payment instruments listed below, using
the Redirect platform and Swedbank Pay hosted payment page.

*   [Card][card]
*   [MobilePay Online][mobilepay]
*   [Swish][swish]
*   [Vipps][vipps]
*   [Trustly][trustly]

When the payer starts the purchase process in your merchant or webshop site, you
need to make a `POST` request towards Swedbank Pay with your *Purchase*
information. You receive a Payment Link (same as redirect URL) in response.

You have to distribute the Payment Link to the payer through your order
system, using channels like e-mail or SMS.

{% include alert.html type="informative" icon="info" body="When sending
information in e-mail/SMS, it is strongly recommended that you add information
about your terms and conditions, including purchase information and price. **See
recommendations in the next section.**" %}

When the payer clicks on the Payment Link, the Swedbank Pay payment page will
open, letting him or her enter the payment details (varying depending on
payment instrument) in a secure Swedbank Pay hosted environment.
{% if show_3d_secure %}
When paying with card and if required, Swedbank Pay will handle 3-D
Secure authentication.
{% endif %}

After completion, Swedbank Pay will redirect the browser back to your
merchant/webshop site.

If [`callbackURL`][technical-reference-callback] is set the merchant system
will receive a callback from Swedbank Pay, enabling you to make a `GET` request
towards Swedbank Pay with the `id` of the payment received in the first step,
which will return the purchase result.

### E-mail And SMS Recommendations

When you as a merchant sends an e-mail or SMS to the payer about the Payment
Link, it is recommended to include contextual information which helps him or her
understand what will happen when clicking the Payment Link. We recommend that
you include the following:

*   The name of the merchant/shop initiating the payment
*   An understandable product description, describing what kind of service the
    payer will pay for.
*   Some order-id (or similar) that exists in the merchant's order system.
*   The price and currency.
*   Details about shipping method and expected delivery (if physical goods will
    be sent to the payer).
*   A link to a page with the merchant's terms and conditions (such
    as return policy) and information about how the payer can contact the
    merchant.
*   Details informing that the payer accepts the Terms & Conditions when
    clicking on the Payment Link.

### Receipt Recommendations

We recommend that you send an e-mail or SMS confirmation to the payer with a
receipt when the payment has been fulfilled.

### API Requests

The API requests depend on the payment instrument you are using when
implementing the Payment Link scenario, see [purchase flow][purchase-flow].
One-phase payment instruments will not implement `capture`, `cancellation` or
`reversal`.
The options you can choose from when creating a payment with key `operation`
set to `Purchase` are listed below.

### Screenshots

When clicking the payment link, the payer will be directed to a payment
page similar to the examples below, where payment information can be entered.

{:.text-center}
![screenshot of the redirect card payment page][card-payment]{:height="620px" width="475px"}

### Options

All valid options when posting a payment with operation `Purchase`, are
described in each payment instrument's respective API reference. Please see the
general sequence diagrams for more information about one-phase (e.g.
[Swish][swish] and [Trustly][trustly]) and two-phase (e.g. [Card][card],
[MobilePay Online][mobilepay] and [Vipps][vipps]) payments.

{% if show_authorization %}

#### Authorization

When using two-phase payment instruments you reserve the amount with an
authorization, and you will have to specify that the _intent_ of the _purchase_
is `Authorize`. The amount will be reserved but not charged. You have to make a
`Capture` or `Cancel` request later (i.e. when you are ready to ship the
purchased products).

{% endif %}

#### Capture

Capture can only be performed on a payment with a successfully authorized
transaction. It is possible to do a part-capture where you only capture a
smaller amount than the authorized amount. You can do more captures on the
same payment up to the total authorization amount later.

If you want the credit card to be charged right away, you will have to specify
that the _intent_ of the purchase is `AutoCapture`. The card will be charged and
you don't need to do any more financial operations to this purchase.

#### Cancel

Cancel can only be done on an authorized transaction. If you cancel after
doing a part-capture you will cancel the difference between the captured amount
and the authorized amount.

#### Reversal

Reversal can only be done on a payment where there are some captured amount not
yet reversed.

#### General

When implementing the Payment Link scenario, it is optional to set a
[`callbackURL`][technical-reference-callback] in the `POST` request. If
callbackURL is set Swedbank Pay will send a request to this URL when the
payer has completed the payment. [See the Callback API description
here][technical-reference-callback].

### Purchase flow

The sequence diagrams display the high level process of the purchase, from
generating a Payment Link to receiving a Callback.
{% if show_3d_secure %}
This in a generalized flow as
well as a specific 3-D Secure enabled credit card scenario.
{% endif %}

{% include alert.html type="informative" icon="info" body="
Please note that the the callback may come either before, after or in the
same moment as the payer is redirected to the status page at the
merchant site when the purchase is fulfilled. Don't rely on the callback being
timed at any specific moment." %}

{% if show_3d_secure %}
When dealing with card payments, 3-D Secure authentication of the
cardholder is an essential topic.
There are three alternative outcomes of a card payment:

*   3-D Secure enabled - by default, 3-D Secure should be enabled,
    and Swedbank Pay will check if the card is enrolled with 3-D Secure.
    This depends on the issuer of the card.
    If the card is not enrolled with 3-D Secure,
    no authentication of the cardholder is done.
*   Card supports 3-D Secure - if the card is enrolled with 3-D Secure,
    Swedbank Pay will redirect the cardholder to the authentication mechanism
    that is decided by the issuing bank.
    Normally this will be done using BankID or Mobile BankID.
{% endif %}

```mermaid
sequenceDiagram
    activate Payer
    Payer->>-MerchantOrderSystem: payer starts purchase
    activate MerchantOrderSystem
    MerchantOrderSystem->>-Merchant: start purchase process
    activate Merchant
    Merchant->>-SwedbankPay: POST [payment] (operation=PURCHASE)
    activate SwedbankPay
    note left of Merchant: First API request
    SwedbankPay-->>-Merchant: payment resource with payment URL
    activate Merchant
    Merchant-->>-MerchantOrderSystem: Payment URL sent to order system
    activate MerchantOrderSystem
    MerchantOrderSystem-->>-Payer: Distribute Payment URL through e-mail/SMS
    activate Payer
    note left of Payer: Payment Link in e-mail/SMS
    Payer->>-SwedbankPay: Open link and enter payment information
    activate SwedbankPay

    {% if show_3d_secure %}
        opt Card supports 3-D Secure
        SwedbankPay-->>-Payer: redirect to IssuingBank
        activate Payer
        Payer->>IssuingBank: 3-D Secure authentication process
        Payer->>-SwedbankPay: access authentication page
        activate SwedbankPay
        end
    {% endif %}

    SwedbankPay-->>-Payer: redirect to merchant site
    activate Payer
    note left of SwedbankPay: redirect back to merchant
    Payer->>-Merchant: access merchant page
    activate Merchant
    Merchant->>-SwedbankPay: GET [payment]
    activate SwedbankPay
    note left of Merchant: Second API request
    SwedbankPay-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Payer: display purchase result
```

#### Options after posting a payment

*   If the payment enable a two-phase flow (`Authorize`),
    you will need to implement the `Capture` and `Cancel` requests.
*   It is possible to "abort" the validity of the Payment Link.
    [See the Abort description here][abort].
*   For reversals, you will need to implement the `Reversal` request.
*   When implementing the Payment Link scenario, it is optional to set a
    `callbackURL` in the `POST` request.
    If `callbackURL` is set Swedbank Pay will send a postback request to this
    URL when the payer has completed the payment.
    [See the Callback API description here][technical-reference-callback].

[abort]: /payment-instruments/card/features/core/abort-reference
[card-payment]: /assets/img/payments/card-payment.png
[card]: /payment-instruments/card
[mobilepay]: /payment-instruments/mobile-pay
[purchase-flow]: /payment-instruments/card/features/core/purchase
[swish]: /payment-instruments/swish
[technical-reference-callback]: /payment-instruments/card/features/technical-reference/callback
[vipps]: /payment-instruments/vipps
[trustly]: /payment-instruments/trustly
