---
title: Swedbank Pay Payments Swish Redirect
sidebar:
  navigation:
  - title: Swish Payments
    items:
    - url: /payments/swish
      title: Introduction
    - url: /payments/swish/redirect
      title: Redirect
    - url: /payments/swish/seamless-view
      title: Seamless View
    - url: /payments/swish/after-payment
      title: After Payment
    - url: /payments/swish/other-features
      title: Other Features
---

{% include alert-development-section.md %}

{% include jumbotron.html body="**Swish Payments Redirect** is where Swedbank
Pay performs a payment that the payer confirms using her Swish mobile app.
The consumer initiates the payment by supplying the
Swish registered mobile number (msisdn), connected to the Swish app." %}

## Introduction

* When the payer starts the purchase process, through a mobile device that hosts
  the her Swish app, you make a `POST` request towards Swedbank Pay with the
  collected Purchase information. This will generate a payment object with a
  unique paymentID. You either receive a Redirect URL to a hosted page or a
  JavaScript source in response.
* You need to [redirect][redirect] the payer to the Redirect payment.
  The payment flow is identified as m-commerce, as the purchase is
  initiated from the device that hosts the Swish app.
* Swedbank Pay handles the dialogue with Swish and the consumer confirms the
  purchase in the Swish app directly.
* Please note that both a successful and rejected payment reach completion,
  in contrast to a cancelled payment.
* If CallbackURL is set you will receive a payment callback when the Swish
  dialogue is completed. You need to do a `GET` request, containing the
  paymentID generated in the first step, to receive the state of the
  transaction.

![Consumer paying with Swish using Swedbank Pay]
[swish-redirect-image]{:width="467px" height="364px"}

{% include alert.html type="success" icon="link" body="**Defining
`callbackUrl`**: When implementing a scenario, it is optional to set a
`callbackUrl` in the `POST` request. If `callbackUrl` is set Swedbank Pay will
send a `POST` request to this URL when the consumer has fulfilled the payment.
[See the Callback API description for more
information](/payments/card/other-features#callback)." %}

## Purchase flow

The sequence diagram below shows the requests you have to send to Swedbank Pay
to make a purchase.
The links will take you directly to the API description for the specific
request.

```mermaid
sequenceDiagram
  activate Browser
  Browser->>-Merchant: start purchase
  activate Merchant
  Merchant->>-SwedbankPay: POST <Swish create payment> (operation=PURCHASE)
  activate SwedbankPay
  note left of Merchant: First API request
  SwedbankPay-->>-Merchant: payment resource
  activate Merchant
  Merchant-->>-Browser: redirect to payments page
  activate Browser
  note left of SwedbankPay: redirect to Swedbank Pay (If Redirect scenario)
  Browser->>-SwedbankPay: enter mobile number
  activate SwedbankPay
  SwedbankPay--x-Browser: Tell consumer to open Swish app
  Swish_API->>Swish_App: Ask for payment confirmation
  activate Swish_App
  Swish_App-->>-Swish_API: Consumer confirms payment
  activate Swish_API
  opt Callback
  Swish_API-->>-SwedbankPay: Payment status
  activate SwedbankPay
  SwedbankPay-->>-Swish_API: Callback response
  activate Swish_API
  SwedbankPay--x-Merchant: Transaction callback
  end
  SwedbankPay-->>Browser: Redirect to merchant (If Redirect scenario)
  activate Browser
  
  Browser-->>-Merchant: Redirect
  activate Merchant
  Merchant->>-SwedbankPay: GET <Swish payment>
  activate SwedbankPay
  SwedbankPay-->>-Merchant: Payment response
  activate Merchant
  Merchant-->>-Browser: Payment Status  
```

## API Requests

The API requests are displayed in the [purchase flow](#purchase-flow-3). Swish
is a one-phase payment instrument that is based on sales transactions not involving
capture or cancellation operations. The options you can choose from when
creating a payment with key operation set to Value Purchase are listed below.

{:.code-header}
**Request**

```http
POST /psp/swish/payments HTTP/1.1
Host: api.payex.com
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
        }],
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "hostUrls": ["https://example.com", "https://example.net"],
            "paymentUrl": "http://example.com/perform-payment",
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png",
            "termsOfServiceUrl": "https://example.com/terms.pdf"
        },
        "payeeInfo": {
            "payeeId": "bbb33dc5-f44e-4af6-afc0-27fb5fa2f63a",
            "payeeReference": "ref-123456",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456",
            "subsite": "MySubsite"
        },
        "prefillInfo": {
            "msisdn": "+46739000001"
        },
        "swish": {
            "ecomOnlyEnabled": false
        }
    }
}

```

{:.table .table-striped}
| Required | Property                              | Type          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :------: | :------------------------------------ | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|  ✔︎︎︎︎︎  | `payment`                             | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └➔&nbsp;`operation`                   | `string`      | The operation that the `payment` is supposed to perform. The [`purchase`][purchase] operation is used in our example.                                                                                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └➔&nbsp;`intent`                      | `string`      | `Authorization`. Reserves the amount. A one phase option that enable capture of funds automatically after authorization.                                                                                                                                                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └➔&nbsp;`currency`                    | `string`      | SEK                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └➔&nbsp;`prices`                      | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`type`                       | `string`      | Swish |
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
|  ✔︎︎︎︎︎  | └─➔&nbsp;`completeUrl`                | `string`      | The URL that Swedbank Pay will redirect back to when the payment page is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
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
|          | └─➔&nbsp;`orderReference`             | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
|          | └─➔&nbsp;`prefillInfo.msisdn`             | `String(50)`  | Number will be prefilled on payment page, if valid. We support international phone numbers defined with country code prefix. ex +45.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|          | └─➔&nbsp;`ecomOnlyEnabled`             | `boolean`  | If true you trigger the redirect payment scenario by default.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/swish/payments/20dfbcb9-587a-4ce9-e63e-08d519f1802f",
        "number": 992308,
        "created": "2017-10-23T08:38:57.2248733Z",
        "instrument": "Swish",
        "operation": "Purchase",
        "intent": "Sale",
        "state": "Ready",
        "currency": "SEK",
        "amount": 0,
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "initiatingSystemUserAgent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls": {
            "id": "/psp/swish/payments/20dfbcb9-587a-4ce9-e63e-08d519f1802f/urls"
    },
        "payeeInfo": {
            "id": "/psp/swish/payments/20dfbcb9-587a-4ce9-e63e-08d519f1802f/payeeinfo"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "http://localhost:18496/psp/swish/payments/20dfbcb9-587a-4ce9-e63e-08d519f1802f",
            "rel": "update-payment-abort"
        },
        {
            "method": "POST",
            "href": "http://localhost:18496/psp/swish/payments/20dfbcb9-587a-4ce9-e63e-08d519f1802f/sales",
            "rel": "create-sale"
        }
    ]
}

```

[swish-redirect-image]: /assets/screenshots/swish/redirect-view/view/windows-small-window.png
[callback-url]: /payments/swish/other-fetures#callback
[hosted-view]: /payments/swish/seamless-view
[payex-admin-portal]: https://admin.payex.com/psp/login/
[redirect]: /payments/swish/redirect
[technical-reference-callback]: /payments/swish/other-fetures#callback
