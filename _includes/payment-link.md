{% assign hide-3d-secure = include.hide-3d-secure | default: false %}

## Payment Link

{% include jumbotron.html body="The implementation sequence for this scenario
is a variant of the purchase sequence. The consumer is not redirected to the
Payments directly but will instead receive a payment link via mail/SMS.
When the consumer clicks on the link, a payment window opens." %}

### Introduction

The Payment Link can be implemented for payment instruments listed below, using the
Redirect platform and Swedbank Pay hosted payment page.

* [Credit card][payment-instruments-card-payment-pages]
* [MobilePay][payment-instruments-mobilepay-payment-pages]
* [Swish][swish]
* [Vipps][vipps]

When the consumer/end-user starts the purchase process in your merchant or
webshop site, you need to make a `POST` request towards Swedbank Pay with your
*Purchase* information. You receive a Payment Link (same as redirect URL) in
response.

You have to distribute the Payment Link to the consumer through your order
system, using channels like e-mail or SMS.

{% include alert.html type="neutral" icon="info" body="When sending information
in e-mail/SMS, it is strongly recommended that you add information about your
terms and conditions, including purchase information and price. **See
recommendations in the next section.**" %}

When the consumer clicks on the Payment Link, the Swedbank Pay payment page will
open, letting the consumer enter the payment details (varying depending on
payment instrument) in a secure Swedbank Pay hosted environment.
{% unless hide-3d-secure %}
When paying with credit card and if required, Swedbank Pay will handle 3-D
Secure authentication.
{% endunless %}

After completion, Swedbank Pay will redirect the browser back to your
merchant/webshop site.

If [`callbackURL`][technical-reference-callbackurl] is set the merchant system
will receive a callback from Swedbank Pay, enabling you to make a `GET` request
towards Swedbank Pay with the `id` of the payment received in the first step,
which will return the purchase result.

### E-mail And SMS Recommendations

When you as a merchant sends an e-mail or SMS to the consumer about the
Payment Link, it is recommended to include contextual information that help
the consumer understand what will happen when clicking on the Payment Link.
We recommend that you include following information:

* The name of the merchant/shop that initiates the payment
* An understandable product description, describing what kind of service the
  consumer will pay for.
* Some order-id (or similar) that exists in the merchant order system.
* The price and currency.
* Details about shipping method and expected delivery (if physical goods will be
  sent  to the consumer).
* Directions to (a link to a page) the merchant's terms and conditions (such as
  return policy) and information of how the consumer can contact the merchant.
* Details informing the consumer that he or she accepts the Terms & Conditions
  when clicking on the Payment Link.

### Receipt Recommendations

We recommend that you send an e-mail or SMS confirmation with a receipt to
the consumer when the payment has been fulfilled.

### API Requests

The API requests depend on the payment instrument you are using when
implementing the Payment Link scenario, see [purchase flow][purchase-flow].
One-phase payment instruments will not implement `capture`, `cancellation` or
`reversal`.
The options you can choose from when creating a payment with key `operation`
set to `Purchase` are listed below.

### Screenshots

When clicking the payment link, the consumer will be directed to a payment
page, similar to the examples below, where payment information can be entered.

![screenshot of the redirect card payment page][card-payment]{:height="500px" width="425px"}

### Options

All valid options when posting in a payment with operation `Purchase`,
are described in each payment instrument's respective API reference.
Please see the general sequence diagrams for more information about payments
in one-phase (e.g. [Swish][swish] and credit card with autocapture) and
two-phase (e.g. [Credit card][credit-card], [MobilePay][mobile-pay],
[Vipps][vipps]).

#### Authorization

When using two-phase flows you reserve the amount with an authorization, you
will have to specify that the _intent_ of the _purchase_ is `Authorize`. The
amount will be reserved but not charged. You will later (i.e. when you are ready
to ship the purchased products) have to make a `Capture` or `Cancel` request.

#### Capture

Capture can only be performed on a payment with a successfully authorized
transaction. It is possible to do a part-capture where you only capture a
smaller amount than the authorized amount. You can later do more captures on the
same payment up to the total authorization amount.

If you want the credit card to be charged right away, you will have to specify
that the _intent_ of the purchase is `AutoCapture`. The credit card will be
charged and you don't need to do any more financial operations to this purchase.

#### Cancel

Cancel can only be done on a authorized transaction. If you do cancel after
doing a part-capture you will cancel the difference between the captured amount
and the authorized amount.

#### Reversal

Reversal can only be done on a payment where there are some captured amount not
yet reversed.

#### General

When implementing the Payment Link scenario, it is optional to set a
[`callbackURL`][technical-reference-callbackurl] in the `POST` request. If
callbackURL is set Swedbank Pay will send a request to this URL when the
consumer as fulfilled the payment. [See the Callback API description
here][technical-reference-callback].

### Purchase flow

The sequence diagrams display the high level process of the purchase, from
generating a Payment Link to receiving a Callback.
{% unless hide-3d-secure %}
This in a generalized flow as
well as a specific 3-D Secure enabled credit card scenario.
{% endunless %}

{% include alert.html type="neutral" icon="info" body="
Please note that the the callback may come either before, after or in the
same moment as the consumer are being redirected to the status page at the
merchant site when the purchase is fulfilled. Don't rely on the callback being
timed at any specific moment." %}

{% unless hide-3d-secure %}
When dealing with credit card payments, 3-D Secure authentication of the
cardholder is an essential topic.
There are three alternative outcome of a credit card payment:

* 3-D Secure enabled - by default, 3-D Secure should be enabled,
  and Swedbank Pay will check if the card is enrolled with 3-D Secure.
  This depends on the issuer of the card.
  If the card is not enrolled with 3-D Secure,
  no authentication of the cardholder is done.
* Card supports 3-D Secure - if the card is enrolled with 3-D Secure,
  Swedbank Pay will redirect the cardholder to the autentication mechanism
  that is decided by the issuing bank.
  Normally this will be done using BankID or Mobile BankID.
{% endunless %}

```mermaid
sequenceDiagram
    activate Consumer
    Consumer->>-MerchantOrderSystem: consumer starts purchase
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
    MerchantOrderSystem-->>-Consumer: Distribute Payment URL through e-mail/SMS
    activate Consumer
    note left of Consumer: Payment Link in e-mail/SMS
    Consumer->>-SwedbankPay: Open link and enter payment information
    activate SwedbankPay

    {%unless hide-3d-secure %}
        opt Card supports 3-D Secure
        SwedbankPay-->>-Consumer: redirect to IssuingBank
        activate Consumer
        Consumer->>IssuingBank: 3-D Secure authentication process
        Consumer->>-SwedbankPay: access authentication page
        activate SwedbankPay
        end
    {% endunless %}

    SwedbankPay-->>-Consumer: redirect to merchant site
    activate Consumer
    note left of SwedbankPay: redirect back to merchant
    Consumer->>-Merchant: access merchant page
    activate Merchant
    Merchant->>-SwedbankPay: GET [payment]
    activate SwedbankPay
    note left of Merchant: Second API request
    SwedbankPay-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Consumer: display purchase result
```

#### Options after posting a payment

* If the payment enable a two-phase flow (`Authorize`),
  you will need to implement the `Capture` and `Cancel` requests.
* It is possible to "abort" the validity of the Payment Link.
  [See the Abort description here][abort].
* For reversals, you will need to implement the `Reversal` request.
* When implementing the Payment Link scenario, it is optional to set a
  `callbackURL` in the `POST` request.
  If `callbackURL` is set Swedbank Pay will send a postback request to this
  URL when the consumer as fulfilled the payment.
  [See the Callback API description here][technical-reference-callback].

[card-payment]: /assets/img/payments/card-payment.png
[abort]: #abort
[credit-card]: /payments/card
[mobile-pay]: /payments/mobile-pay
[payment-instruments-card-payment-pages]: /payments/card/
[payment-instruments-mobilepay-payment-pages]: /payments/mobile-pay/
[purchase-flow]: ../#purchase-flow
[swish]: /payments/swish
[technical-reference-callback]: #callback
[technical-reference-callbackurl]: #callback
[test_purchase]: /assets/img/checkout/test-purchase.png
[card-payment]: /assets/img/payments/card-payment.png
[vipps]: /payments/vipps
