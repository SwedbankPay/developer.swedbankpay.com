---
title: Swedbank Pay Card Payments – Seamless View
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
    - url: /payments/card/after-payment
      title: After Payment
    - url: /payments/card/other-features
      title: Other Features
---

{% include jumbotron.html body="The Seamless View purchase scenario
                          represents the opportunity to implement card payments
                          directly in your webshop." %}

## Introduction

Seamless View provides an integration of the payment process directly on your
website. This solution offers a smooth shopping experience with Swedbank Pay
payment pages seamlessly integrated in an `iframe` on your website. The costumer
does not need to leave your webpage, since we are handling the payment in the
`iframe` on your page.

![screenshot of the hosted view card payment page][hosted-view-card]{:height="250px" width="660px"}

## Purchase Flow

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay

    activate Payer
    Payer->>-Merchant: start purchase
    activate Merchant
    note left of Payer: First API request
    Merchant->>-SwedbankPay: POST /psp/creditcard/payments
    activate SwedbankPay
    SwedbankPay-->>-Merchant: rel: view-authorization ①
    activate Merchant
    Merchant-->>-Payer: authorization page
    activate Payer
    note left of Payer: Open iframe ②
    Payer->>Payer: Input creditcard information
    Payer->>-SwedbankPay: Show Consumer UI page in iframe - Authorization ③
    activate SwedbankPay
        opt Card supports 3-D Secure
        SwedbankPay-->>-Payer: redirect to IssuingBank
        activate Payer
        Payer->>IssuingBank: 3-D Secure authentication process
        activate IssuingBank
        IssuingBank->>-Payer: 3-D Secure authentication process
        Payer->>-IssuingBank: access authentication page
        end
    IssuingBank -->>+ Payer: Redirect back to paymentUrl (merchant)
    deactivate IssuingBank
    SwedbankPay-->>Merchant: Event: OnPaymentComplete ④
    activate Merchant
    note left of Merchant: Second API request.
    Merchant->>-SwedbankPay: GET <payment.id>
    activate SwedbankPay
    SwedbankPay-->>-Merchant: rel: view-payment
    activate Merchant
    Merchant-->>-Payer: display purchase result
    activate Payer

        opt Callback is set
        activate SwedbankPay
        SwedbankPay->>SwedbankPay: Payment is updated
        SwedbankPay->>-Merchant: POST Payment Callback
        end
```

### Explainations

* ① `rel: view-authorization` is a value in one of the operations, sent as a
  response from Swedbank Pay to the Merchant.
* ② `Open iframe` creates the Swedbank Pay hosted iframe.
* ③ `Show Consumer UI page in iframe` displays the payment window as content
  inside of the iframe. The consumer can insert card information for
  authorization.
* ④ `Event: OnPaymentComplete` is when er payment is complete. Please note that
  both a successful and rejected payment reach completion, in contrast to a
  cancelled payment.

### 3-D Secure

Swedbank Pay will handle 3-D Secure authentication when this is required.
When dealing with credit card payments, 3-D Secure authentication of the
cardholder is an essential topic. There are two alternative outcome of a credit
card payment:

1. 3-D Secure enabled - by default, 3-D Secure should be enabled, and Swedbank
   Pay will check if the card is enrolled with 3-D Secure. This depends on the
   issuer of the card. If the card is not enrolled with 3-D Secure, no
   authentication of the cardholder is done.
2. Card supports 3-D Secure - if the card is enrolled with 3-D Secure, Swedbank
   Pay will redirect the cardholder to the autentication mechanism that is
   decided by the issuing bank. Normally this will be done using BankID or
   Mobile BankID.

### Payment Url

{% include payment-url.md
when="at the 3-D Secure verification for Card Payments" %}

## Seamless View Back End

When properly set up in your merchant/webshop site and the payer starts the
purchase process, you need to make a POST request towards Swedbank Pay with your
Purchase information. This will generate a payment object with a unique
`paymentID`. You will receive a **JavaScript source** in response.

### Intent

{% include intent.md autocapture=true %}

### Operations

The API requests are displayed in the purchase flow above.
You can [create a card `payment`][create-payment] with following `operation`
options:

* [Purchase][purchase] (We use this value in our examples)
* [Recur][recur]
* [Payout][payout]
* [Verify][verify]

### Purchase

A `Purchase` payment is a straightforward way to charge the card of the payer.
It is followed up by posting a capture, cancellation or reversal transaction.

An example of an abbreviated `POST` request is provided below. Each individual
Property of the JSON document is described in the following section.
An example of an expanded `POST` request is available in the
[other features section][purchase].

{% include alert-risk-indicator.md %}

{% include card-purchase.md seamless_view=true %}

The key information in the response is the `view-authorization` operation. You
will need to embed its `href` in a `<script>` element. The script will enable
loading the payment page in an `iframe` in our next step.

## Seamless View Front End

You need to embed the script source on your site to create a hosted-view in an
`iframe`; so that she can enter the credit card details in a secure Swedbank Pay
hosted environment. A simplified integration has these following steps:

1. Create a container that will contain the Seamless View iframe: `<div
   id="swedbank-pay-seamless-view-page">`.
2. Create a `<script>` source within the container. Embed the `href` value
   obtained in the `POST` request in the `<script>` element. Example:

```html
    <script id="payment-page-script" src="https://ecom.dev.payex.com/creditcard/core/ scripts/client/px.creditcard.client.js"></script>
```

The previous two steps gives this HTML:

{:.code-header}
**HTML**

```html
<!DOCTYPE html>
<html>
    <head>
        <title>Swedbank Pay Seamless View is Awesome!</title>
        <!-- Here you can specify your own javascript file -->
        <script src=<YourJavaScriptFileHere>></script>
    </head>
    <body>
        <div id="swedbank-pay-seamless-view-page">
          <script id="payment-page-script" src="https://ecom.dev.payex.com/creditcard/core/scripts/client/px.creditcard.client.js"></script>
        </div>
    </body>
</html>
```

Lastly, initiate the Seamless View with a JavaScript call to open the `iframe`
embedded on your website.

{:.code-header}
**JavaScript**

```js
<script language="javascript">
    payex.hostedView.creditCard({
        // The container specifies which id the script will look for to host the
        // iframe component.
        container: "swedbank-pay-seamless-view-page"
    }).open();
</script>
```

## Seamless View Events

During operation in the seamless view, several events can occur. They are
described below.

### `onPaymentCreated`

This event triggers when a user actively attempts to perform a payment. The
`onPaymentCreated` event is raised with the following event argument object:

{:.code-header}
**`onPaymentCreated` event object**

```js
{
    "id": "/psp/creditcard/payments/{{ page.payment_id }}",
    "instrument": "creditcard",
}
```

{:.table .table-striped}
| Property     | Type     | Description                      |
| :----------- | :------- | :------------------------------- |
| `id`         | `string` | The relative URI to the payment. |
| `instrument` | `string` | `Creditcard`                     |

### `onPaymentCompleted`

This event triggers when a payment has completed successfully.
The `onPaymentCompleted` event is raised with the following event argument
object:

{:.code-header}
**`onPaymentCompleted` event object**

```js
{
    "id": "/psp/creditcard/payments/{{ page.payment_id }}",
    "redirectUrl": "https://en.wikipedia.org/wiki/Success"
}
```

{:.table .table-striped}
| Property      | Type     | Description                                                     |
| :------------ | :------- | :-------------------------------------------------------------- |
| `id`          | `string` | The relative URI to the payment.                                |
| `redirectUrl` | `string` | The URI the user will be redirect to after a completed payment. |

### `onPaymentCanceled`

This event triggers when the user cancels the payment.
The `onPaymentCanceled` event is raised with the following event argument
object:

{:.code-header}
**`onPaymentCanceled` event object**

```js
{
    "id": "/psp/creditcard/payments/{{ page.payment_id }}",
    "redirectUrl": "https://en.wikipedia.org/wiki/Canceled"
}
```

{:.table .table-striped}
| Property      | Type     | Description                                                    |
| :------------ | :------- | :------------------------------------------------------------- |
| `id`          | `string` | The relative URI to the payment.                               |
| `redirectUrl` | `string` | The URI the user will be redirect to after a canceled payment. |

### `onPaymentFailed`

This event triggers when a payment has failed, disabling further attempts to
perform a payment. The `onPaymentFailed` event is raised with the following
event argument object:

{:.code-header}
**`onPaymentFailed` event object**

```js
{
    "id": "/psp/creditcard/payments/{{ page.payment_id }}",
    "redirectUrl": "https://en.wikipedia.org/wiki/Failed"
}
```

{:.table .table-striped}
| Property      | Type     | Description                                                  |
| :------------ | :------- | :----------------------------------------------------------- |
| `id`          | `string` | The relative URI to the payment.                             |
| `redirectUrl` | `string` | The URI the user will be redirect to after a failed payment. |

### `onPaymentTermsOfService`

This event triggers when the user clicks on the "Display terms and conditions"
link. The `onPaymentTermsOfService` event is raised with the following event
argument object:

{:.code-header}
**`onPaymentTermsOfService` event object**

```js
{
    "origin": "owner",
    "openUrl": "https://example.org/terms.html"
}
```

{:.table .table-striped}
| Property  | Type     | Description                                                                             |
| :-------- | :------- | :-------------------------------------------------------------------------------------- |
| `origin`  | `string` | `owner`, `merchant`. The value is always `merchant` unless Swedbank Pay hosts the view. |
| `openUrl` | `string` | The URI containing Terms of Service and conditions.                                     |

### `onError`

This event triggers during terminal errors or if the configuration fails
validation. The `onError` event will be raised with the following event argument
object:

{:.code-header}
**`onError` event object**

```js
{
    "origin": "creditcard",
    "messageId": "{{ page.transaction_id }}",
    "details": "Descriptive text of the error"
}
```

{:.table .table-striped}
| Property    | Type     | Description                                                    |
| :---------- | :------- | :------------------------------------------------------------- |
| `origin`    | `string` | `creditcard`, identifies the system that originated the error. |
| `messageId` | `string` | A unique identifier for the message.                           |
| `details`   | `string` | A human readable and descriptive text of the error.            |

{% include iterator.html prev_href="redirect" prev_title="Redirect"
next_href="after-payment" next_title="Next: After Payment" %}

[payment-page_hosted-view.png]: /assets/screenshots/card/hosted-view/view/macos.png
[abort]: /payments/card/other-features#abort
[after-payment]: /payments/card/after-payment
[callback]: /payments/card/other-features#callback
[cancel]: /payments/card/after-payment#cancellations
[capture]: /payments/card/after-payment#Capture
[create-payment]: /payments/card/other-features#create-payment
[expansion]: /payments/card/other-features#expansion
[payee-reference]: /payments/card/other-features#payeereference
[payout]: /payments/card/other-features#payout
[purchase]: /payments/card/other-features#purchase
[price-resource]: /payments/card/other-features#prices
[recur]: /payments/card/other-features#recur
[reversal]: /payments/card/after-payment#reversals
[verify]: /payments/card/other-features#verify
[create-payment]: /payments/card/other-features#create-payment
[user-agent-definition]: https://en.wikipedia.org/wiki/User_agent
[hosted-view-card]: /assets/img/payments/hosted-view-card.png
