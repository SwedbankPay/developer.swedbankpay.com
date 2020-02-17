---
title: Swedbank Pay Payments Swish Seamless View
sidebar:
  navigation:
  - title: Swish Payments
    items:
    - url: /payments/swish
      title: Introduction
    - url: /payments/swish/direct
      title: Direct
    - url: /payments/swish/redirect
      title: Redirect
    - url: /payments/swish/seamless-view
      title: Seamless View
    - url: /payments/swish/after-payment
      title: After Payment
    - url: /payments/swish/other-features
      title: Other Features
---


{% include jumbotron.html body="The **Seamless View** scenario gives your
                          customers the opportunity to pay with Swish directly
                          within your webshop." %}

## Introduction

The Seamless View integration provide you with the Swish payment solution
directly on your website. This gives the consumer a frictionless experience as
we are handling the payment in the implemented `iframe` on your page (see
example below).

![screenshot of the seamless view swish payment
page][seamless-view-img]{:height="250px" width="660px"}

## Purchase flow

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay

    activate Payer
    Payer->>-Merchant: start purchase
    activate Merchant
    note left of Payer: First API request
    Merchant->>-SwedbankPay: POST /psp/swish/payments ①
    activate SwedbankPay
    SwedbankPay-->>-Merchant: rel: view-sales ②
    activate Merchant
    Merchant-->>-Payer: confirmation page
    activate Payer
    note left of Payer: Open iframe ③
    Payer->>Payer: Input mobile number
    Payer->>-SwedbankPay: Show Consumer UI page in iframe - Authorization ④
    activate SwedbankPay
        opt Card supports 3-D Secure
        SwedbankPay-->>-Payer: redirect to IssuingBank
        activate Payer
        Payer->>IssuingBank: 3-D Secure authentication process
        activate IssuingBank
        IssuingBank->>-Payer: 3-D Secure authentication process
        Payer->>-SwedbankPay: access authentication page
        end
    SwedbankPay-->>Merchant: Event: OnPaymentComplete ⑤
    activate Merchant
    note left of Merchant: Second API request.
    Merchant->>-SwedbankPay: GET <payment.id> ⑥
    activate SwedbankPay
    SwedbankPay-->>-Merchant: rel: view-sales
    activate Merchant
    Merchant-->>-Payer: display purchase result
    activate Payer

        opt Callback is set ⑦
        activate SwedbankPay
        SwedbankPay->>SwedbankPay: Payment is updated
        SwedbankPay->>-Merchant: POST Payment Callback
        end
```

### Explainations

* ① When the payer starts the purchase process, you make a `POST` request
  towards Swedbank Pay with the collected Purchase information.
* ② `view-sales` is a `rel` value in one of the operations, sent as a response
  from Swedbank Pay to the Merchant.
* ③ `Open iframe` creates the Swedbank Pay hosted iframe.
* ④ `Show Consumer UI page in iframe` displays the payment window as content
  inside of the iframe. The consumer can insert mobile information for
  authorization.
* ⑤ `Event: OnPaymentComplete` is when er payment is complete. Please note that
  both a successful and rejected payment reach completion, in contrast to a
  cancelled payment.
* ⑥ To get the transaction result, you need to follow up with a `GET` request
  using the `paymentID` received in the first step.
* ⑦ If CallbackURL is set you will receive a payment callback when the Swish
  dialogue is completed, and you will have to make a `GET` request to check the
  payment status.

### Payment Url

{% include payment-url.md
when="at the 3-D Secure verification for Card Payments" %}

## Seamless View Back End

When properly set up in your merchant/webshop site and the payer starts the
purchase process, you need to make a POST request towards Swedbank Pay with your
Sales information. This will generate a payment object with a unique
`paymentID`. You will receive a **JavaScript source** in response.

### Intent

{% include intent.md swish-authorization=true %}

### Operations

The API requests are displayed in the purchase flow above.
You can [create a Swish `payment`][create-payment] with the [purchase][purchase] `operation`

### Purchase

A `Purchase` payment is a straightforward way to charge the card of the payer.
It is followed up by posting a capture, cancellation or reversal transaction.

An example of an abbreviated `POST` request is provided below. Each individual
Property of the JSON document is described in the following section.
An example of an expanded `POST` request is available in the
[other features section][purchase].

{:.code-header}
**Request**

```http
POST /psp/swish/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Sale",
        "currency": "SEK",
        "prices": [{
                "type": "Swish",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Purchase",
        "generatePaymentToken": false,
        "generateRecurrenceToken": false,
        "payerReference": "AB1234",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "hostUrls": ["http://example.com"],
            "completeUrl": "http://example.com/payment-completed",
            "cancelUrl": "http://example.com/payment-canceled",
            "paymentUrl": "http://example.com/perform-payment",
            "callbackUrl": "http://example.com/payment-callback",
            "logoUrl": "https://example.com/payment-logo.png",
            "termsOfServiceUrl": "https://example.com/payment-terms.pdf"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or123",
            "subsite": "MySubsite"
        },
        "prefillInfo": {
            "msisdn": "+46987654321"
        }  
    },
    "swish": {
        "enableEcomOnly": false{% comment %},
        "paymentRestrictedToAgeLimit": 18,
        "paymentRestrictedToSocialSecurityNumber": "{{ page.consumer_ssn_se }}"
        {% endcomment %}
    }
}
```

{:.table .table-striped}
| Required | Property                     | Type          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :------: | :--------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|  ✔︎︎︎︎︎  | `payment`                    | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └➔&nbsp;`operation`          | `string`      | The operation that the `payment` is supposed to perform. The [`purchase`][purchase] operation is used in our example. Take a look at the [create card `payment` section][create-payment] for a full examples of the following `operation` options: [Purchase][purchase].                                                                                                                                                                                                                                                                                                  |
|  ✔︎︎︎︎︎  | └➔&nbsp;`intent`             | `string`      | `AutoCapture`. A one phase option that enable capture of funds.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|  ✔︎︎︎︎︎  | └➔&nbsp;`currency`           | `string`      | `SEK`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └➔&nbsp;`prices`             | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`type`              | `string`      | Use the generic type CreditCard if you want to enable all card brands supported by merchant contract. Use card brands like Visa (for card type Visa), MasterCard (for card type Mastercard) and others if you want to specify different amount for each card brand. If you want to use more than one amount you must have one instance in the prices node for each card brand. You will not be allowed to both specify card brands and CreditCard at the same time in this field. [See the Prices resource and prices object types for more information][price-resource]. |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`amount`            | `integer`     | Amount is entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 SEK 5000 = 50.00 SEK.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`vatAmount`         | `integer`     | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                                                                                                                                                                                                                                                                                                                                                                                        |
|          | └➔&nbsp;`paymentAgeLimit`    | `integer`     | Positive number sets requried age limit to fulfill the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`        | `string(40)`  | A textual description max 40 characters of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|          | └➔&nbsp;`payerReference`     | `string`      | The reference to the payer (consumer/end user) from the merchant system. E.g mobile number, customer number etc.                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|  ✔︎︎︎︎︎  | └➔&nbsp;`userAgent`          | `string`      | The user agent reference of the consumer's browser - [see user agent definition][user-agent-definition]                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|  ✔︎︎︎︎︎  | └➔&nbsp;`language`           | `string`      | `nb-NO`, `sv-SE` or `en-US`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └➔&nbsp;`urls`               | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|          | └─➔&nbsp;`hostUrls`          | `array`       | The array of URLs valid for embedding of Swedbank Pay Hosted Views. If not supplied, view-operation will not be available.                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`completeUrl`       | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further.                                                                                                                                                                                                                                                                        |
|          | └─➔&nbsp;`cancelUrl`         | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only cancelUrl or `paymentUrl` can be used, not both.                                                                                                                                                                                                                                                                                                                                                                     |
|          | └─➔&nbsp;`paymentUrl`        | `string`      | The URI that Swedbank Pay will redirect back to when the view-operation needs to be loaded, to inspect and act on the current status of the payment. Only used in Seamless Views. If both `cancelUrl` and `paymentUrl` is sent, the `paymentUrl` will used.                                                                                                                                                                                                                                                                                                               |
|          | └─➔&nbsp;`callbackUrl`       | `string`      | The URL that Swedbank Pay will perform an HTTP POST against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                                                                                                                                                                                                                                                                                                     |
|          | └─➔&nbsp;`logoUrl`           | `string`      | The URL that will be used for showing the customer logo. Must be a picture with maximum 50px height and 400px width. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|          | └─➔&nbsp;`termsOfServiceUrl` | `string`      | A URL that contains your terms and conditions for the payment, to be linked on the payment page. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeInfo`          | `object`      | The `payeeInfo` contains information about the payee.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeId`           | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeReference`    | `string(50*)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.                                                                                                                                                                                                                                                                                                                                                                                  |
|          | └─➔&nbsp;`payeeName`         | `string`      | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|          | └─➔&nbsp;`productCategory`   | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                                                                            |
|          | └─➔&nbsp;`orderReference`    | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|          | └➔&nbsp;`prefillInfo`        | `object`      | An object that holds prefill information that can be inserted on the payment page.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|          | └─➔&nbsp;`msisdn`            | `string`      | Number will be prefilled on payment page, if valid. The mobile number must have a country code prefix and be 8 to 15 digits in length.                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|          | └─➔&nbsp;`subsite`           | `String(40)`  | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                                                                               |
|          | └➔&nbsp;`swish`              | `object`      | An object that holds different scenarios for Swish payments.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|          | └─➔&nbsp;`enableEcomOnly`    | `boolean`     | `true` if to only enable Swish on browser-based transactions.; otherwise `false` to also enable Swish transactions via mobile app.                                                                                                                                                                                                                                                                                                                                                                                                                                        |
{% comment %}
|          | └─➔&nbsp;`paymentRestrictedToAgeLimit`             | `integer`     | Positive number that sets the required age  needed to fulfill the payment. To use this feature it has to be configured in the contract.                                                                                                                                                            |
|          | └─➔&nbsp;`paymentRestrictedToSocialSecurityNumber` | `string`      | When provided, the payment will be restricted to a specific social security number. Format: yyyyMMddxxxx. To use this feature it has to be configured in the contract.                                                                                                                             |
{% endcomment %}

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
      "id": "/psp/swish/payments/{{ page.payment_id }}",
      "number": 1234567890,
      "instrument": "Swish",
      "created": "2016-09-14T13:21:29.3182115Z",
      "updated": "2016-09-14T13:21:57.6627579Z",
      "state": "Ready",
      "operation": "Purchase",
      "intent": "Sale",
      "currency": "SEK",
      "amount": 1500,
      "remainingCaptureAmount": 1500,
      "remainingCancellationAmount": 1500,
      "remainingReversalAmount": 0,
      "description": "Test Purchase",
      "payerReference": "AB1234",
      "initiatingSystemUserAgent": "PostmanRuntime/7.20.1",
      "userAgent": "Mozilla/5.0...",
      "language": "sv-SE",
      "prices": { "id": "/psp/swish/payments/{{ page.payment_id }}/prices" },
      "transactions": { "id": "/psp/swish/payments/{{ page.payment_id }}/transactions" },
      "captures": { "id": "/psp/swish/payments/{{ page.payment_id }}/captures" },
      "reversals": { "id": "/psp/swish/payments/{{ page.payment_id }}/reversals" },
      "cancellations": { "id": "/psp/swish/payments/{{ page.payment_id }}/cancellations" },
      "urls" : { "id": "/psp/swish/payments/{{ page.payment_id }}/urls" },
      "payeeInfo" : { "id": "/psp/swish/payments/{{ page.payment_id }}/payeeInfo" },
      "settings": { "id": "/psp/swish/payments/{{ page.payment_id }}/settings" }
    },
    "operations": [
      {
        "href": "{{ page.api_url }}/psp/swish/payments/{{ page.payment_id }}",
        "rel": "update-payment-abort",
        "method": "PATCH",
        "contentType": "application/json"
      },
      {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/swish/payments/{{ page.payment_id }}/sales",
            "rel": "create-sale"
      },
      {
        "href": "{{ page.front_end_url }}/swish/payments/authorize/{{ page.payment_token }}",
        "rel": "redirect-sale",
        "method": "GET",
        "contentType": "text/html"
      },
      {
        "method": "GET",
        "href": "https://ecom.dev.payex.com/swish/core/scripts/client/px.swish.client.js?token={{ page.payment_token }}",
        "rel": "view-sales",
        "contentType": "application/javascript"
      },
      {
            "method": "GET",
            "href": "{{ page.front_end_url }}/swish/core/scripts/client/px.swish.client.js?token={{ page.payment_token }}",
            "rel": "view-sales",
            "contentType": "application/javascript"
      }
    ]
}
```

The key information in the response is the `view-sales` operation. You will need
to embed its `href` in a `<script>` element. The script will enable loading the
payment page in an `iframe` in our next step.

## Seamless View Front End

You need to embed the script source on your site to create a hosted-view in an
`iframe`; so that she can enter the required information in a secure Swedbank
Pay hosted environment. A simplified integration has these following steps:

1. Create a container that will contain the Seamless View iframe: `<div
   id="swedbank-pay-seamless-view-page">`.
2. Create a `<script>` source within the container. Embed the `href` value
   obtained in the `POST` request in the `<script>` element. Example:

```html
    <script id="payment-page-script" src="https://ecom.dev.payex.com/swish/core/ scripts/client/px.swish.client.js"></script>
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
          <script id="payment-page-script" src="https://ecom.dev.payex.com/swish/core/scripts/client/px.swish.client.js"></script>
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
    payex.hostedView.swish({
        // The container specifies which id the script will look for to host the
        // iframe component.
        container: "swedbank-pay-seamless-view-page"
    }).open();
</script>
```

[callback]: /payments/swish/other-features#callback
[create-payment]: /payments/swish/after-payment#create-payment
[payee-reference]: /payments/swish/other-features#payeereference
[price-resource]: /payments/swish/other-features#prices
[purchase]: /payments/swish/other-features#purchase
[sales-transaction]: /payments/swish/after-payment#sales
[seamless-view-img]: /assets/img/checkout/swish-seamless-view.png
[swish-payments]: /payments/swish/after-payment#payment-resource
[user-agent-definition]: https://en.wikipedia.org/wiki/User_agent
