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
    - url: /payments/card/after-payment
      title: After Payment
    - url: /payments/card/other-features
      title: Other Features
---

{% include alert-review-section.md %}

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

{% include risk-indicator.md %}

{:.code-header}
**Request**

```http
POST /psp/creditcard/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "SEK",
        "prices": [{
                "type": "CreditCard",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Purchase",
        "generatePaymentToken": false,
        "generateRecurrenceToken": false,
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "hostUrls": ["http://example.com"],
            "completeUrl": "http://example.com/payment-completed",
            "cancelUrl": "http://example.com/payment-canceled",
            "paymentUrl": "http://example.com/perform-payment",
            "callbackUrl": "http://example.com/payment-callback",
            "logoUrl": "http://example.com/payment-logo.png",
            "termsOfServiceUrl": "http://example.com/payment-terms.pdf",
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchantId }}"
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or123",
        },
        "riskIndicator": {
            "deliveryEmailAddress": "test@example.com",
            "deliveryTimeFrameindicator": "01",
            "preOrderDate": "19801231",
            "preOrderPurchaseIndicator": "01",
            "shipIndicator": "01",
            "giftCardPurchase": false,
            "reOrderPurchaseIndicator": "01",
            "pickUpAddress": {
                "name": "Leo",
                "streetAddress": "Gata 535",
                "coAddress": "street 55",
                "city": "Stockholm",
                "zipCode": "55560",
                "countryCode": "SE"
            }
        }
    },
    "creditCard": {
        "rejectCreditCards": false,
        "rejectDebitCards": false,
        "rejectConsumerCards": false,
        "rejectCorporateCards": false,
        "no3DSecure": false,
    }
}
```

{:.table .table-striped}
| Required | Property                              | Type          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :------: | :------------------------------------ | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|  ✔︎︎︎︎︎  | `payment`                             | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └➔&nbsp;`operation`                   | `string`      | The operation that the `payment` is supposed to perform. The [`purchase`][purchase] operation is used in our example. Take a look at the [create card `payment` section][create-payment] for a full examples of the following `operation` options: [Purchase][purchase], [Recur][recur], [Payout][payout], [Verify][verify]                                                                                                                                                                                                                                               |
|  ✔︎︎︎︎︎  | └➔&nbsp;`intent`                      | `string`      | `Authorization`. Reserves the amount, and is followed by a [cancellation][cancel] or [capture][capture] of funds.<br> <br> `AutoCapture`. A one phase option that enable capture of funds automatically after authorization.                                                                                                                                                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └➔&nbsp;`currency`                    | `string`      | NOK, SEK, DKK, USD or EUR.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └➔&nbsp;`prices`                      | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`type`                       | `string`      | Use the generic type CreditCard if you want to enable all card brands supported by merchant contract. Use card brands like Visa (for card type Visa), MasterCard (for card type Mastercard) and others if you want to specify different amount for each card brand. If you want to use more than one amount you must have one instance in the prices node for each card brand. You will not be allowed to both specify card brands and CreditCard at the same time in this field. [See the Prices resource and prices object types for more information][price-resource]. |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`amount`                     | `integer`     | Amount is entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 SEK 5000 = 50.00 SEK.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`vatAmount`                  | `integer`     | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                                                                                                                                                                                                                                                                                                                                                                                        |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`                 | `string(40)`  | A textual description max 40 characters of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|          | └➔&nbsp;`payerReference`              | `string`      | The reference to the payer (consumer/end user) from the merchant system. E.g mobile number, customer number etc.                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | └➔&nbsp;`generatePaymentToken`        | `boolean`     | `true` or `false`. Set this to `true` if you want to create a paymentToken for future use as One Click.                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|          | └➔&nbsp;`generateRecurrenceToken`     | `boolean`     | `true` or `false`. Set this to `true` if you want to create a recurrenceToken for future use Recurring purchases (subscription payments).                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|  ✔︎︎︎︎︎  | └➔&nbsp;`userAgent`                   | `string`      | The user agent reference of the consumer's browser - [see user agent definition][user-agent-definition]                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|  ✔︎︎︎︎︎  | └➔&nbsp;`language`                    | `string`      | nb-NO, sv-SE or en-US.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|  ✔︎︎︎︎︎  | └➔&nbsp;`urls`                        | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|          | └─➔&nbsp;`hostUrls`                   | `array`       | The array of URLs valid for embedding of Swedbank Pay Hosted Views. If not supplied, view-operation will not be available.                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`completeUrl`                | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further.                                                                                                                                                                                                                                                                        |
|          | └─➔&nbsp;`cancelUrl`                  | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only cancelUrl or `paymentUrl` can be used, not both.                                                                                                                                                                                                                                                                                                                                                                     |
|          | └─➔&nbsp;`paymentUrl`                 | `string`      | The URI that Swedbank Pay will redirect back to when the view-operation needs to be loaded, to inspect and act on the current status of the payment. Only used in Seamless Views. If both `cancelUrl` and `paymentUrl` is sent, the `paymentUrl` will used.                                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`callbackUrl`                | `string`      | The URL that Swedbank Pay will perform an HTTP POST against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                                                                                                                                                                                                                                                                                                     |
|          | └─➔&nbsp;`logoUrl`                    | `string`      | The URL that will be used for showing the customer logo. Must be a picture with maximum 50px height and 400px width. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|          | └─➔&nbsp;`termsOfServiceUrl`          | `string`      | A URL that contains your terms and conditions for the payment, to be linked on the payment page. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeInfo`                   | `object`      | The `payeeInfo` contains information about the payee.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeId`                    | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeReference`             | `string(50*)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.                                                                                                                                                                                                                                                                                                                                                                                  |
|          | └─➔&nbsp;`payeeName`                  | `string`      | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|          | └─➔&nbsp;`productCategory`            | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                                                                            |
|          | └─➔&nbsp;`orderReference`             | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|          | └─➔&nbsp;`subsite`                    | `String(40)`  | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └➔&nbsp;`riskIndicator`               | `array`       | This **optional** array consist of information that helps verifying the payer. Providing these fields decreases the likelyhood of having to promt for 3-D Secure authenticaiton of the payer when they are authenticating the purchacse.                                                                                                                                                                                                                                                                                                                                  |
|          | └─➔&nbsp;`deliveryEmailAdress`        | `string`      | For electronic delivery, the email address to which the merchandise was delivered. Providing this field when appropriate decreases the likelyhood of a 3-D Secure authentication for the payer.                                                                                                                                                                                                                                                                                                                                                                           |
|          | └─➔&nbsp;`deliveryTimeFrameIndicator` | `string`      | Indicates the merchandise delivery timeframe. <br>`01` (Electronic Delivery) <br>`02` (Same day shipping) <br>`03` (Overnight shipping) <br>`04` (Two-day or more shipping)                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`preOrderDate`               | `string`      | For a pre-ordered purchase. The expected date that the merchandise will be available. Format: `YYYYMMDD`                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|          | └─➔&nbsp;`preOrderPurchaseIndicator`  | `string`      | Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br>`01` (Merchandise available) <br>`02` (Future availability)                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`shipIndicator`              | `string`      | Indicates shipping method chosen for the transaction. <br>`01` (Ship to cardholder's billing address) <br>`02` (Ship to another verified address on file with merchant)<br>`03` (Ship to address that is different than cardholder's billing address)<br>`04` (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)<br>`05` (Digital goods, includes online services, electronic giftcards and redemption codes) <br>`06` (Travel and Event tickets, not shipped) <br>`07` (Other, e.g. gaming, digital service)          |
|          | └─➔&nbsp;`giftCardPurchase`           | `bool`        | `true` if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|          | └─➔&nbsp;`reOrderPurchaseIndicator`   | `string`      | Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br>`01` (Merchandise available) <br>`02` (Future availability)                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └➔&nbsp;`pickUpAddress`               | `object`      | If `shipIndicator` set to `04`, then prefill this with the payers `pickUpAddress` of the purchase to decrease the risk factor of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                            |
|          | └─➔&nbsp;`name`                       | `string`      | If `shipIndicator` set to `04`, then prefill this with the payers `name` of the purchase to decrease the risk factor of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|          | └─➔&nbsp;`streetAddress`              | `string`      | If `shipIndicator` set to `04`, then prefill this with the payers `streetAddress` of the purchase to decrease the risk factor of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                            |
|          | └─➔&nbsp;`coAddress`                  | `string`      | If `shipIndicator` set to `04`, then prefill this with the payers `coAddress` of the purchase to decrease the risk factor of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                                |
|          | └─➔&nbsp;`city`                       | `string`      | If `shipIndicator` set to `04`, then prefill this with the payers `city` of the purchase to decrease the risk factor of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|          | └─➔&nbsp;`zipCode`                    | `string`      | If `shipIndicator` set to `04`, then prefill this with the payers `zipCode` of the purchase to decrease the risk factor of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|          | └─➔&nbsp;`countryCode`                | `string`      | If `shipIndicator` set to `04`, then prefill this with the payers `countryCode` of the purchase to decrease the risk factor of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                              |
|          | └➔&nbsp;`creditCard`                  | `object`      | An object that holds different scenarios for card payments.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`rejectDebitCards`           | `boolean`     | `true` if debit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          | └─➔&nbsp;`rejectCreditCards`          | `boolean`     | `true` if credit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                        |
|          | └─➔&nbsp;`rejectConsumerCards`        | `boolean`     | `true` if consumer cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | └─➔&nbsp;`rejectCorporateCards`       | `boolean`     | `true` if corporate cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                     |
|          | └─➔&nbsp;`no3DSecure`                 | `boolean`     | `true` if 3-D Secure should be disabled for this payment in the case a stored card is used; otherwise `false` per default. To use this feature it has to be enabled on the contract with Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                    |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
      "id": "/psp/creditcard/payments/{{ page.paymentId }}",
      "number": 1234567890,
      "instrument": "CreditCard",
      "created": "2016-09-14T13:21:29.3182115Z",
      "updated": "2016-09-14T13:21:57.6627579Z",
      "state": "Ready",
      "operation": "Purchase",
      "intent": "Authorization",
      "currency": "SEK",
      "amount": 1500,
      "remainingCaptureAmount": 1500,
      "remainingCancellationAmount": 1500,
      "remainingReversalAmount": 0,
      "description": "Test Purchase",
      "payerReference": "AB1234",
      "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
      "userAgent": "Mozilla/5.0...",
      "language": "sv-SE",
      "prices": { "id": "/psp/creditcard/payments/{{ page.paymentId }}/prices" },
      "transactions": { "id": "/psp/creditcard/payments/{{ page.paymentId }}/transactions" },
      "authorizations": { "id": "/psp/creditcard/payments/{{ page.paymentId }}/authorizations" },
      "captures": { "id": "/psp/creditcard/payments/{{ page.paymentId }}/captures" },
      "reversals": { "id": "/psp/creditcard/payments/{{ page.paymentId }}/reversals" },
      "cancellations": { "id": "/psp/creditcard/payments/{{ page.paymentId }}/cancellations" },
      "urls" : { "id": "/psp/creditcard/payments/{{ page.paymentId }}/urls" },
      "payeeInfo" : { "id": "/psp/creditcard/payments/{{ page.paymentId }}/payeeInfo" },
      "settings": { "id": "/psp/creditcard/payments/{{ page.paymentId }}/settings" }
    },
    "operations": [
      {
        "href": "{{ page.apiUrl }}/psp/creditcard/payments/{{ page.paymentId }}",
        "rel": "update-payment-abort",
        "method": "PATCH",
        "contentType": "application/json"
      },
      {
        "href": "{{ page.frontEndUrl }}/creditcard/payments/authorize/123456123412341234123456789012",
        "rel": "redirect-authorization",
        "method": "GET",
        "contentType": "text/html"
      },
      {
        "method": "GET",
        "href": "https://ecom.dev.payex.com/creditcard/core/scripts/client/px.creditcard.client.js?token=123456123412341234123456789012",
        "rel": "view-authorization",
        "contentType": "application/javascript"
      }
    ]
}
```

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
    "id": "/psp/creditcard/payments/{{ page.paymentId }}",
    "instrument": "creditcard",
}
```

{:.table .table-striped}
| Property     | Type     | Description                                                                                     |
| :----------- | :------- | :---------------------------------------------------------------------------------------------- |
| `id`         | `string` | The relative URI to the payment.                                                                |
| `instrument` | `string` | `Creditcard`                                                                                    |

### `onPaymentCompleted`

This event triggers when a payment has completed successfully.
The `onPaymentCompleted` event is raised with the following event argument
object:

{:.code-header}
**`onPaymentCompleted` event object**

```js
{
    "id": "/psp/creditcard/payments/{{ page.paymentId }}",
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
    "id": "/psp/creditcard/payments/{{ page.paymentId }}",
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
    "id": "/psp/creditcard/payments/{{ page.paymentId }}",
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
    "messageId": "{{ page.transactionId }}",
    "details": "Descriptive text of the error"
}
```

{:.table .table-striped}
| Property    | Type     | Description                                                                               |
| :---------- | :------- | :---------------------------------------------------------------------------------------- |
| `origin`    | `string` | `creditcard`, identifies the system that originated the error.                            |
| `messageId` | `string` | A unique identifier for the message.                                                      |
| `details`   | `string` | A human readable and descriptive text of the error.                                       |


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
