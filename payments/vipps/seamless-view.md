---
title: Swedbank Pay Payments Vipps Seamless View
sidebar:
  navigation:
  - title: Vipps Payments
    items:
    - url: /payments/vipps
      title: Introduction
    - url: /payments/vipps/redirect
      title: Redirect
    - url: /payments/vipps/seamless-view
      title: Seamless View
    - url: /payments/vipps/after-payment
      title: After Payment
    - url: /payments/vipps/other-features
      title: Other Features
---


{% include jumbotron.html body="The **Seamless View** scenario gives your
customers the opportunity to pay with Vipps directly within your webshop." %}

## Introduction

Vipps is a two-phase payment instrument supported by the major Norwegian banks.
In the Seamless View scenario, Swedbank Pay receives a mobile number (MSISDN)
from the payer through Swedbank Pay Payments. Swedbank Pay performs a payment
that the payer must confirm through the Vipps mobile app.

![steps of the vipps purchase flow][vipps-purchase-flow]{:width="1200px" :height="500px"}

## Purchase flow

The sequence diagram below shows the two requests you have to send to
Swedbank Pay to make a purchase.
The links will take you directly to the API description for the specific
request.

```mermaid
sequenceDiagram
    Browser->>Merchant: start purchase (pay with VIPPS)
    activate Merchant
    Merchant->>-SwedbankPay: POST /psp/vipps/payments ①
    activate SwedbankPay
    note left of Merchant: First API request
    SwedbankPay-->>-Merchant: rel: view-payment ②
    activate Merchant
    Merchant-->>-Browser: authorization page
    activate Browser
    note left of Browser: Open iframe ③
    Browser->>Browser: Enter mobile number ④
    Browser-->>-SwedbankPay: Passing data for authorization
    activate SwedbankPay

    SwedbankPay-->>-Vipps.API: POST <rel:create-auhtorization> ⑤
    activate Vipps.API
    Vipps.API-->>-SwedbankPay: response
    activate SwedbankPay
    SwedbankPay-->>-Browser: Authorization response (State=AwaitingActivity) ⑥
    activate Browser
    note left of Browser: check your phone

    Vipps.API-->>Vipps_App: Confirm Payment UI
    activate Vipps_App
    note left of Vipps.API: Dialogue with Vipps ⑦
    Vipps_App-->>Vipps_App: Confirmation Dialogue
    Vipps_App-->>-Vipps.API: Confirmation
    activate Vipps.API
    Vipps.API-->>-SwedbankPay: make payment
    activate SwedbankPay
    SwedbankPay-->>SwedbankPay: execute payment
    SwedbankPay-->>-Vipps.API: response
    activate Vipps.API
    Vipps.API-->>-SwedbankPay: authorize result
    activate SwedbankPay
    SwedbankPay-->>-Browser: Display authorize result
```

### Explainations

* ① When the payer starts the purchase process, you make a `POST` request
  towards Swedbank Pay with the collected Purchase information.
* ② `rel: view-payment` is a value in one of the operations, sent as a response
  from Swedbank Pay to the Merchant.
* ③ `Open iframe` creates the Swedbank Pay hosted iframe.
* ④ The consumer UI page displays the payment window as content inside of the
  `iframe`. The consumer can insert mobile information for authorization.
* ⑤ A `POST` request is sent to the Vipps API with the mobile number for
  authorization.
* ⑥ The response will contain the state of the transaction. It will normally be
  `AwaitingActivity` in this phase of the payment, meaning we are awaiting a
  response from Vipps.
* ⑦ Swedbank Pay handles the dialogue with Vipps and the consumer confirms the
  purchase in the Vipps app.

### Payment Url

{% include payment-url.md when="selecting Vipps as payment instrument" %}

## Seamless View Back End

When properly set up in your merchant/webshop site and the payer starts the
purchase process, you need to make a `POST` request towards Swedbank Pay with
your Purchase information. This will generate a payment object with a unique
`paymentID`. You will receive a response in which you can find the **JavaScript source** in the `view-payment` operation.

### Intent

* **Authorization (two-phase)**: The intent of a Vipps purchase is always
  `Authorization`. The amount will be reserved but not charged.
  You will later (i.e. if a physical product, when you are ready to ship the
  purchased products) have to make a [Capture][captures] or
  [Cancel][cancellations] request.

### Operations

The API requests are displayed in the purchase flow above.
You can [create a Vipps `payment`][create-payment] with the [purchase][purchase] `operation`

### Purchase

A `Purchase` payment is a straightforward way to charge the card of the payer.
It is followed up by posting a capture, cancellation or reversal transaction.

An example of an abbreviated `POST` request is provided below. Each individual
Property of the JSON document is described in the following section.
An example of an expanded `POST` request is available in the
[other features section][purchase].

{% include alert-risk-indicator.md %}

{:.code-header}
**Request**

```http
POST /psp/vipps/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
   "payment": {
       "operation": "Purchase",
       "intent": "Authorization",
       "currency": "NOK",
       "prices": [
            {
               "type": "Vipps",
               "amount": 1500,
               "vatAmount": 0
            }
        ],
       "description": "Vipps Test",
       "payerReference": "ABtimestamp",
       "userAgent": "Mozilla/5.0",
       "language": "nb-NO",
       "urls": {
           "hostUrls": ["https://example.com", "https://example.net"],
           "completeUrl": "http://example.com/payment-completed",
           "cancelUrl": "http://example.com/payment-canceled",
           "paymentUrl": "http://example.com/perform-payment",
           "callbackUrl": "http://example.com/payment-callback",
           "logoUrl": "https://example.com/path/to/logo.png",
           "termsOfServiceUrl": "https://example.com/terms.pdf"

        },
       "payeeInfo": {
           "payeeId": "{{ page.merchant_id }}"
           "payeeReference": "payeeReference",
           "payeeName": "Merchant1",
           "productCategory": "A123",
           "orderReference": "or-12456",
           "subsite": "MySubsite"
            },
       "prefillInfo": {
        "msisdn": "+4798765432"
        }
    }
}
```

{:.table .table-striped}
| Required | Property                          | Type          | Description                                                                                                                                                                                                                                                                                        |
| :------: | :-------------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `payment`                         | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └➔&nbsp;`operation`               | `string`      | The [`purchase`][purchase] operation is used in our example. Take a look at the [create `payment` section][create-payment] for a full example of the [Purchase][purchase] `operation`.                                                                                                             |
|  ✔︎︎︎︎︎  | └➔&nbsp;`intent`                  | `string`      | `Authorization`. Reserves the amount, and is followed by a [cancellation][cancellations] or [capture][captures] of funds.<br> <br> `AutoCapture`. A one phase option that enable capture of funds automatically after authorization.                                                               |
|  ✔︎︎︎︎︎  | └➔&nbsp;`currency`                | `string`      | NOK                                                                                                                                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └➔&nbsp;`prices`                  | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`type`                   | `string`      | Use the Vipps value. [See the Prices resource and prices object types for more information][price-resource].                                                                                                                                                                                       |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`amount`                 | `integer`     | Amount is entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 NOK 5000 = 50.00 NOK.                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`vatAmount`              | `integer`     | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                                                                                                                 |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`             | `string(40)`  | A textual description max 40 characters of the purchase.                                                                                                                                                                                                                                           |
|          | └➔&nbsp;`payerReference`          | `string`      | The reference to the payer (consumer/end user) from the merchant system. E.g mobile number, customer number etc.                                                                                                                                                                                   |
|          | └➔&nbsp;`generatePaymentToken`    | `boolean`     | `true` or `false`. Set this to `true` if you want to create a paymentToken for future use as One Click.                                                                                                                                                                                            |
|          | └➔&nbsp;`generateRecurrenceToken` | `boolean`     | `true` or `false`. Set this to `true` if you want to create a recurrenceToken for future use Recurring purchases (subscription payments).                                                                                                                                                          |
|  ✔︎︎︎︎︎  | └➔&nbsp;`userAgent`               | `string`      | The user agent reference of the consumer's browser - [see user agent definition][user-agent-definition]                                                                                                                                                                                            |
|  ✔︎︎︎︎︎  | └➔&nbsp;`language`                | `string`      | nb-NO or en-US.                                                                                                                                                                                                                                                                                    |
|  ✔︎︎︎︎︎  | └➔&nbsp;`urls`                    | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                             |
|          | └─➔&nbsp;`hostUrls`               | `array`       | The array of URLs valid for embedding of Swedbank Pay Hosted Views. If not supplied, view-operation will not be available.                                                                                                                                                                         |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`completeUrl`            | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further. |
|          | └─➔&nbsp;`cancelUrl`              | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only cancelUrl or `paymentUrl` can be used, not both.                                                                                              |
|          | └─➔&nbsp;`paymentUrl`             | `string`      | The URI that Swedbank Pay will redirect back to when the view-operation needs to be loaded, to inspect and act on the current status of the payment. Only used in Seamless Views. If both `cancelUrl` and `paymentUrl` is sent, the `paymentUrl` will used.                                        |
|          | └─➔&nbsp;`callbackUrl`            | `string`      | The URL that Swedbank Pay will perform an HTTP POST against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                              |
|          | └─➔&nbsp;`logoUrl`                | `string`      | The URL that will be used for showing the customer logo. Must be a picture with maximum 50px height and 400px width. Require https.                                                                                                                                                                |
|          | └─➔&nbsp;`termsOfServiceUrl`      | `string`      | A URL that contains your terms and conditions for the payment, to be linked on the payment page. Require https.                                                                                                                                                                                    |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeInfo`               | `object`      | The `payeeInfo` contains information about the payee.                                                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeId`                | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeReference`         | `string(50*)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.                                                                                                           |
|          | └─➔&nbsp;`payeeName`              | `string`      | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                                            |
|          | └─➔&nbsp;`productCategory`        | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                     |
|          | └─➔&nbsp;`orderReference`         | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                            |
|          | └➔&nbsp;`prefillInfo`             | `object`      | An object that holds prefill information that can be inserted on the payment page.                                                                                                                                                                                                                 |
|          | └─➔&nbsp;`msisdn`                 | `string`      | Number will be prefilled on payment page, if valid. Only Norwegian phone numbers are supported. The country code prefix is +47                                                                                                                                                                     |
|          | └─➔&nbsp;`subsite`                | `String(40)`  | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                                                                        |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
   "payment": {
       "id": "/psp/vipps/payments/{{ page.payment_id }}",
       "number": 72100003079,
       "created": "2018-09-05T14:18:44.4259255Z",
       "instrument": "Vipps",
       "operation": "Purchase",
       "intent": "Authorization",
       "state": "Ready",
       "currency": "NOK",
       "prices": {
           "id": "/psp/vipps/payments/{{ page.payment_id }}/prices"
        },
       "amount": 0,
       "description": "Vipps Test",
       "payerReference": "AB1536157124",
       "initiatingSystemUserAgent": "PostmanRuntime/7.2.0",
       "userAgent": "Mozilla/5.0 weeeeee",
       "language": "nb-NO",
       "urls": {
           "id": "/psp/vipps/payments/{{ page.payment_id }}/urls"
        },
       "payeeInfo": {
           "id": "/psp/vipps/payments/{{ page.payment_id }}/payeeinfo"
        },
       "metadata": {
           "id": "/psp/vipps/payments/{{ page.payment_id }}/metadata"
        }
    },
   "operations": [
        {
           "method": "PATCH",
           "href": "{{ page.api_url }}/psp/vipps/payments/{{ page.payment_id }}",
           "rel": "update-payment-abort"
        },
        {
           "method": "GET",
           "href": "{{ page.front_end_url }}/vipps/payments/authorize/{{ page.payment_token }}",
           "rel": "redirect-authorization"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/vipps/core/scripts/client/px.vipps.client.js?token={{ page.payment_token }}&Culture=sv-SE",
            "rel": "view-payment",
            "contentType": "application/javascript"
        }
    ]
}
```

The key information in the response is the `view-payment` operation. You
will need to embed its `href` in a `<script>` element. The script will enable
loading the payment page in an `iframe` in our next step.

## Seamless View Front End

You need to embed the script source on your site to create a hosted-view in an
`iframe`; so that she can enter the required information in a secure Swedbank
Pay hosted environment. A simplified integration has these following steps:

1. Create a container that will contain the Seamless View iframe: `<div
   id="swedbank-pay-seamless-view-page">`.
2. Create a `<script>` source within the container. Embed the `href` value
   obtained in the `POST` request in the `<script>` element. Example:

```html
    <script id="payment-page-script" src="https://ecom.dev.payex.com/vipps/core/ scripts/client/px.vipps.client.js"></script>
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
          <script id="payment-page-script" src="https://ecom.dev.payex.com/vipps/core/scripts/client/px.vipps.client.js"></script>
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
    payex.hostedView.vipps({
        // The container specifies which id the script will look for to host the
        // iframe component.
        container: "swedbank-pay-seamless-view-page"
    }).open();
</script>
```

This is how the payment might look like:

![Vipps mobile Payments]
[Vipps-screenshot-1]{:width="426px" :height="632px"}
![Vipps Payments][Vipps-screenshot-2]{:width="427px" :height="694px"}

## Authorization Transaction

Use the mobile number from the consumer to create an authorization transaction.

{:.code-header}
**Request**

```http
POST /psp/vipps/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "transaction": {
    "msisdn": "+4798765432"
  }
}
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/vipps/payments/{{ page.payment_id }}",
    "authorization": {
        "vippsTransactionId": "5619328800",
        "msisdn": "+4798765432",
        "id": "/psp/vipps/payments/{{ page.payment_id }}/authorizations/",
    "transaction": {
        "id": "/psp/vipps/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
        "created": "2016-09-14T01:01:01.01Z",
        "updated": "2016-09-14T01:01:01.03Z",
        "type": "Authorization",
        "state": "AwaitingActivity",
        "number": 1234567890,
        "amount": 1000,
        "vatAmount": 250,
        "description": "Test transaction",
        "payeeReference": "AH123456",
        "failedReason": "",
        "isOperational": true,
        "operations": []
    }
}
```

{:.table .table-striped}
| Property                     | Type      | Description                                                                                                                                                                                                  |
| :--------------------------- | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                    | `string`  | The relative URI of the payment this transaction belongs to.                                                                                                                                                 |
| `authorization`              | `object`  | The authorization object.                                                                                                                                                                                    |
| └➔&nbsp;`vippsTransactionId` | `string`  | The ID of the Vipps transaction.                                                                                                                                                                             |
| └➔&nbsp;`msisdn`             | `string`  | The mobile number of the consumer.  Only Norwegian phone numbers are supported. The country code prefix is +47                                                                                               |
| └➔&nbsp;`id`                 | `string`  | The relative URI of the current `authorization` resource.                                                                                                                                                    |
| `transaction`                | `object`  | The transaction object.                                                                                                                                                                                      |
| └➔&nbsp;`id`                 | `string`  | The relative URI of the current `transaction` resource.                                                                                                                                                      |
| └➔&nbsp;`created`            | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └➔&nbsp;`updated`            | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └➔&nbsp;`type`               | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └➔&nbsp;`state`              | `string`  | `Initialized`, `AwaitingActivity`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                          |
| └➔&nbsp;`number`             | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead. |
| └➔&nbsp;`amount`             | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 NOK.                                                                                     |
| └➔&nbsp;`vatAmount`          | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                           |
| └➔&nbsp;`description`        | `string`  | A human readable description of maximum 40 characters of the transaction.                                                                                                                                    |
| └➔&nbsp;`payeeReference`     | `string`  | A unique reference for the transaction.                                                                                                                                                                      |
| └➔&nbsp;`failedReason`       | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                    |
| └➔&nbsp;`isOperational`      | `bool`    | `true` if the transaction is operational; otherwise `false`.                                                                                                                                                 |
| └➔&nbsp;`operations`         | `array`   | The array of operations that are possible to perform on the transaction in its current state.                                                                                                                |

{% include iterator.html
        prev_href="redirect"
        prev_title="Back: Redirect"
        next_href="after-payment"
        next_title="Next: After payments" %}

[abort]: /payments/vipps/after-payment#abort
[callback]: /payments/vipps/other-features#callback
[callbackurl]: /payments/vipps/other-features#callback
[cancellations]: /payments/vipps/after-payment#cancellations
[captures]: /payments/vipps/after-payment#captures
[create-payment]: /payments/vipps/other-features#create-payment
[hosted-view]: /payments/vipps/seamless-view
[payee-reference]: /payments/vipps/other-features#payeereference
[price-resource]: /payments/vipps/other-features#prices
[purchase]: /payments/vipps/other-features#purchase
[reference-redirect]: /payments/vipps/redirect
[reversal]: /payments/vipps/after-payment#reversals
[user-agent-definition]: https://en.wikipedia.org/wiki/User_agent
[Vipps_flow_PaymentPages.png]: /assets/img/vipps-flow-paymentpages.png
[Vipps-screenshot-1]: /assets/img/checkout/vipps-hosted-payment.png
[Vipps-screenshot-2]: /assets/img/checkout/vipps-hosted-payment-no-paymenturl.png
[vipps-purchase-flow]: /assets/img/payments/vipps-purchase-flow.png
