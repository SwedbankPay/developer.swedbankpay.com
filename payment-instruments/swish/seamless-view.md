---
title: Seamless View
redirect_from: /payments/swish/seamless-view
estimated_read: 10
description: |
  The **Seamless View** scenario gives your
  customers the opportunity to pay with Swish directly
  within your webshop. This gives the payer a
  frictionless experience as we are handling the
  payment in the implemented `iframe` on your page.
menu_order: 800
---

## Swish Seamless View integration flow

1.  When the payer starts the purchase process, you make a `POST` request
   towards Swedbank Pay with the collected Purchase information.
   `view-sales` is a `rel` value in one of the operations, sent as a response
   from Swedbank Pay to the Merchant.
2.  `Open iframe` creates the Swedbank Pay hosted iframe.
3.  `Show payer UI page in iframe` displays the payment window as content
    inside of the iframe. The payer can insert mobile information for
    authorization.
4.  `Event: OnPaymentComplete` is when the payment is complete. Please note that
    both a successful and rejected payment reach completion, in contrast to a
    cancelled payment.
5.  To get the transaction result, you need to follow up with a `GET` request
    using the `paymentID` received in the first step.
6.  If CallbackURL is set you will receive a payment callback when the Swish
    dialogue is completed, and you will have to make a `GET` request to check
    the payment status.

![screenshot of the seamless view swish payment page][seamless-view-img]{:height="215px" width="475px"}

## Step 1: Create a Purchase

A `Purchase` payment is a straightforward way to charge the card of the payer.
You need to make a `POST` request towards Swedbank Pay as shown below to create
a purchase. An example of an expanded `POST` request is available in the
[other features section][purchase]. This will generate a payment object with a unique
`paymentID`. You will receive a **JavaScript source** in response.

{% include payment-url.md when="selecting Swish as payment instrument" %}

{% include alert-gdpr-disclaimer.md %}

{:.code-view-header}
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
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "hostUrls": [ "https://example.com" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "paymentUrl": "https://example.com/perform-payment",
            "callbackUrl": "https://example.com/payment-callback",
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
        "payer": {
            "payerReference": "AB1234",
        },
        "prefillInfo": {
            "msisdn": "+46987654321"
        }
    },
    "swish": {
        "enableEcomOnly": false,
        "paymentRestrictedToAgeLimit": 18,
        "paymentRestrictedToSocialSecurityNumber": "{{ page.consumer_ssn_se }}"
    }
}
```

{:.table .table-striped}
|     Required     | Field                        | Type          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :--------------: | :--------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | `payment`                    | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | └➔&nbsp;`operation`          | `string`      | The operation that the `payment` is supposed to perform. The [`Purchase`][purchase] operation is used in our example. Take a look at the [create swish `payment` section][create-payment] for a full examples of the following `operation` options: [Purchase][purchase].                                                                                                                                                                                                                                                                                                 |
| {% icon check %} | └➔&nbsp;`intent`             | `string`      | `AutoCapture`. A one phase option that enable capture of funds.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| {% icon check %} | └➔&nbsp;`currency`           | `string`      | `SEK`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | └➔&nbsp;`prices`             | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | └─➔&nbsp;`type`              | `string`      | Use the generic type CreditCard if you want to enable all card brands supported by merchant contract. Use card brands like Visa (for card type Visa), MasterCard (for card type Mastercard) and others if you want to specify different amount for each card brand. If you want to use more than one amount you must have one instance in the prices node for each card brand. You will not be allowed to both specify card brands and CreditCard at the same time in this field. [See the Prices resource and prices object types for more information][price-resource]. |
| {% icon check %} | └─➔&nbsp;`amount`            | `integer`     | {% include field-description-amount.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| {% icon check %} | └─➔&nbsp;`vatAmount`         | `integer`     | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|                  | └➔&nbsp;`paymentAgeLimit`    | `integer`     | Positive number sets requried age limit to fulfill the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| {% icon check %} | └➔&nbsp;`description`        | `string(40)`  | {% include field-description-description.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`userAgent`          | `string`      | The [`User-Agent` string][user-agent] of the payer's web browser.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| {% icon check %} | └➔&nbsp;`language`           | `string`      | {% include field-description-language.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| {% icon check %} | └➔&nbsp;`urls`               | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| {% icon check %} | └─➔&nbsp;`hostUrls`          | `array`       | The array of URLs valid for embedding of Swedbank Pay Seamless Views. If not supplied, view-operation will not be available.                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| {% icon check %} | └─➔&nbsp;`completeUrl`       | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further. See [`completeUrl`][complete-url] for details.                                                                                                                                                                                                                                                                        |
|                  | └─➔&nbsp;`cancelUrl`         | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only cancelUrl or `paymentUrl` can be used, not both.                                                                                                                                                                                                                                                                                                                                                                     |
|                  | └─➔&nbsp;`paymentUrl`        | `string`      | The URI that Swedbank Pay will redirect back to when the view-operation needs to be loaded, to inspect and act on the current status of the payment. Only used in Seamless Views. If both `cancelUrl` and `paymentUrl` is sent, the `paymentUrl` will used. See [`paymentUrl`][paymenturl] for details.                                                                                                                                                                                                                                                          |
|                  | └─➔&nbsp;`callbackUrl`       | `string`      | The URL that Swedbank Pay will perform an HTTP POST against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                                                                                                                                                                                                                                                                                                     |
|                  | └─➔&nbsp;`logoUrl`           | `string`      | {% include field-description-logourl.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|                  | └─➔&nbsp;`termsOfServiceUrl` | `string`      | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| {% icon check %} | └➔&nbsp;`payeeInfo`          | `object`      | {% include field-description-payeeinfo.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | └─➔&nbsp;`payeeId`           | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | └─➔&nbsp;`payeeReference`    | `string(50*)` | {% include field-description-payee-reference.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|                  | └─➔&nbsp;`payeeName`         | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | └─➔&nbsp;`productCategory`   | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                                                                            |
|                  | └─➔&nbsp;`orderReference`    | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | └➔&nbsp;`payer`              | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | └─➔&nbsp;`payerReference`    | `string`     | {% include field-description-payer-reference.md %}                                                                                                                                                                                                                                                           |
|                  | └➔&nbsp;`prefillInfo`        | `object`      | An object that holds prefill information that can be inserted on the payment page.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|                  | └─➔&nbsp;`msisdn`            | `string`      | Number will be prefilled on payment page, if valid. The mobile number must have a country code prefix and be 8 to 15 digits in length.                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|                  | └─➔&nbsp;`subsite`           | `String(40)`  | {% include field-description-subsite.md %}                                                                                                                                                                                                                                                                                                                                                                                                               |
|                  | └➔&nbsp;`swish`              | `object`      | An object that holds different scenarios for Swish payments.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|                  | └─➔&nbsp;`enableEcomOnly`    | `boolean`     | `true` if to only enable Swish on browser-based transactions.; otherwise `false` to also enable Swish transactions via mobile app.                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|          | └─➔&nbsp;`paymentRestrictedToAgeLimit`             | `integer`     | Positive number that sets the required age  needed to fulfill the payment. To use this feature it has to be configured in the contract.                                                                                                                                                            |
|                 | └─➔&nbsp;`paymentRestrictedToSocialSecurityNumber` | `string`      | When provided, the payment will be restricted to a specific social security number to make sure its the same logged in customer who is also the payer. Format: yyyyMMddxxxx. To use this feature it has to be configured in the contract.                                                                                                                             |

{:.code-view-header}
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
      "amount": 0,
      "remainingCaptureAmount": 1500,
      "remainingCancellationAmount": 1500,
      "remainingReversalAmount": 0,
      "description": "Test Purchase",
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
      "payers": { "id": "/psp/trustly/payments/{{ page.payment_id }}/payers" },
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
        "rel": "view-payment",
        "contentType": "application/javascript"
      }
    ]
}
```

The key information in the response is the `view-sales` operation. You will need
to embed its `href` in a `<script>` element. The script will enable loading the
payment page in an `iframe` in our next step.

## Step 2: Display the Payment Window

You need to embed the script source on your site to create a Seamless View in an
`iframe`; so that the payer can enter the required information in a secure Swedbank
Pay hosted environment. A simplified integration has these following steps:

1.  Create a container that will contain the Seamless View iframe: `<div
    id="swedbank-pay-seamless-view-page">`.
2.  Create a `<script>` source within the container. Embed the `href` value
    obtained in the `POST` request in the `<script>` element. Example:

```html
<script id="payment-page-script" src="https://ecom.dev.payex.com/swish/core/scripts/client/px.swish.client.js"></script>
```

The previous two steps gives this HTML:

{:.code-view-header}
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

{:.code-view-header}
**HTML**

```html
<script language="javascript">
    payex.hostedView.swish({
        // The container specifies which id the script will look for to host the
        // iframe component.
        container: "swedbank-pay-seamless-view-page"
    }).open();
</script>
```

## Seamless View Purchase flow

The sequence diagram below shows the requests you have to send to Swedbank Pay
to make a purchase. The Callback response is a simplified example
in this flow. Go to the [Callback][callback] section to view the complete flow.

```mermaid
sequenceDiagram
    activate Browser
    Browser->>-Merchant: Start Purchase
    activate Merchant
    Merchant->>-SwedbankPay: POST <Swish create payment> (operation=PURCHASE)
    activate SwedbankPay
    note left of Merchant: First API request
    SwedbankPay-->>-Merchant: Payment Response with rel:view-payment
    activate Merchant
    Merchant->>Merchant: Build html with view-payment script
    Merchant-->>-SwedbankPay: Init iFrame
    activate SwedbankPay
    SwedbankPay->>-SwedbankPay: Enter mobile number
    activate SwedbankPay
    SwedbankPay->>-Merchant: Tell payer to open Swish app
    Swish_API->>Swish_App: Ask for payment confirmation
    activate Swish_App
    Swish_App-->>-Swish_API: Payer confirms payment

        alt Callback
        activate SwedbankPay
        SwedbankPay-->>Swish_API: Callback response
        SwedbankPay->>-Merchant: Transaction callback
        end

    activate Merchant
    Merchant->>-SwedbankPay: GET <Swish payment>
    activate SwedbankPay
    SwedbankPay-->>-Merchant: Payment response
    activate Merchant
    Merchant->>-Browser: Payment Status
```

{% include iterator.html prev_href="redirect" prev_title="Redirect"
next_href="after-payment" next_title="After Payment" %}

[callback]: /payment-instruments/swish/features/technical-reference/callback
[complete-url]: /payment-instruments/swish/features/technical-reference/complete-url
[create-payment]: /payment-instruments/swish/features/technical-reference/create-payment
[payee-reference]: /payment-instruments/swish/features/technical-reference/payee-reference
[paymenturl]: /payment-instruments/swish/features/technical-reference/payment-url
[price-resource]: /payment-instruments/swish/features/technical-reference/prices
[purchase]: /payment-instruments/swish/features/technical-reference/create-payment
[sales-transaction]: /payment-instruments/swish/after-payment#sales
[seamless-view-img]: /assets/img/checkout/swish-seamless-view.png
[swish-payments]: /payment-instruments/swish/after-payment#payment-resource
[user-agent]: https://en.wikipedia.org/wiki/User_agent
