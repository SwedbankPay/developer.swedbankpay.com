---
title: Redirect
redirect_from: /payments/mobile-pay/redirect
estimated_read: 8
description: |
  **MobilePay Online** is a two-phase payment instrument which can be
  implemented by the supported redirect scenario.
  Swedbank Pay receives the MobilePay Online's details from the payer through
  Swedbank Pay Payments.
  The payment will then be performed by Swedbank Pay and confirmed by the payer
  through the MobilePay app.
menu_order: 600
---

## MobilePay Online redirect integration flow

*   When you have prepared your merchant/webshop site, you make a `POST` request
    towards Swedbank Pay with your Purchase information.
*   You will receive a Redirect URL, leading to a secure Swedbank Pay hosted
    environment, in response.
*   You need to redirect the browser of the payer to that URL so
    that he or she may enter their MobilePay details.
*   When the payment is completed, Swedbank Pay will redirect the browser back
    to your merchant/webshop site.
*   Finally you need to make a `GET` request towards Swedbank Pay with the
    `paymentID` received in the first step, which will return the purchase
    result.

{:.text-center}
![screenshot of the Swedbank Pay landing page][swedbankpay-landing-page]{:height="425px" width="475px"}

{:.text-center}
![mobilepay enter number][mobilepay-screenshot-1]{:height="700px" width="475px"}

{:.text-center}
![mobilepay approve payment][mobilepay-screenshot-2]{:height="600px" width="600px"}

{% include alert.html type="success" icon="link" body="**Defining
`callbackUrl`**: When implementing a scenario, it is strongly recommended to set
a `callbackUrl` in the `POST` request. If `callbackUrl` is set, Swedbank Pay
will send a `POST` request to this URL when the payer has fulfilled the
payment." %}

## Step 1: Create a Purchase

When the payer starts the purchase process, you make a `POST` request towards
Swedbank Pay with the collected Purchase information. This will generate a
payment with a unique `id`. See the `POST`request example below.

{% include alert-gdpr-disclaimer.md %}

{:.code-view-header}
**Request**

```http
POST /psp/mobilepay/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "DKK",
        "prices": [
            {
                "type": "MobilePay",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "da-DK",
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "callbackUrl": "https://example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/payment-terms.pdf"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite"
        },
        "payer": {
            "payerReference": "AB1234",
        },
        "prefillInfo": {
            "msisdn": "+4598765432"
        }
    },
    "mobilepay": {
        "shoplogoUrl": "https://example.com/shop-logo.png"
    }
}
```

{:.table .table-striped}
| Required         | Field                           | Data type    | Description                                                                                                                                                                                                                                               |
| :--------------- | :------------------------------ | :----------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `payment`                       | `object`     | The payment object.                                                                                                                                                                                                                                       |
| {% icon check %} | └➔&nbsp;`operation`             | `string`     | `Purchase`                                                                                                                                                                                                                                                |
| {% icon check %} | └➔&nbsp;`intent`                | `string`     | `Authorization`                                                                                                                                                                                                                                           |
| {% icon check %} | └➔&nbsp;`currency`              | `string`     | `NOK`, `SEK`, `DKK`, `USD` or `EUR`.                                                                                                                                                                                                                      |
| {% icon check %} | └➔&nbsp;`prices`                | `object`     | The prices object.                                                                                                                                                                                                                                        |
| {% icon check %} | └─➔&nbsp;`type`                 | `string`     | `MobilePay` (for supporting all card types configured at Swedbank Pay). If you need to specify what card brands you want to support you may specify this by sending in the card brand, e.g `Dankort` (for card type Dankort), `Visa` (for card type Visa), `MasterCard` (for card type Mastercard),                                                                                                                                                           |
| {% icon check %} | └─➔&nbsp;`amount`               | `integer`    | {% include field-description-amount.md currency="DKK" %}                                                                                                                                                                                                  |
| {% icon check %} | └─➔&nbsp;`vatAmount`            | `integer`    | {% include field-description-vatamount.md currency="DKK" %}                                                                                                                                                                                               |
|                  | └─➔&nbsp;`feeAmount`            | `integer`    | If the amount given includes Fee, this may be displayed for the user in the payment page (redirect only).                                                                                                                                                 |
| {% icon check %} | └➔&nbsp;`description`           | `string(40)` | {% include field-description-description.md %}                                                                                                                                                                         |
| {% icon check %} | └➔&nbsp;`userAgent`             | `string`     | The [`User-Agent` string][user-agent] of the payer's web browser.                                                                                                                                                                                      |
| {% icon check %} | └➔&nbsp;`language`              | `string`     | {% include field-description-language.md %}                                                                                                                                                                                      |
| {% icon check %} | └➔&nbsp;`urls`                  | `object`     | The URLs object containing the urls used for this payment.                                                                                                                                                                                                |
| {% icon check %} | └─➔&nbsp;`completeUrl`          | `string`     | The URI that Swedbank Pay will redirect back to when the payment page is completed. This does not indicate a successful payment, only that it has reached a completion state. A `GET` request needs to be performed on the payment to inspect it further. See [`completeUrl`][complete-url] for details.  |
| {% icon check %} | └─➔&nbsp;`cancelUrl`            | `string`     | The URI that Swedbank Pay will redirect back to when the user presses the cancel button in the payment page.                                                                                                                                              |
|                  | └─➔&nbsp;`callbackUrl`          | `string`     | The URI that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                         |
| {% icon check %} | └─➔&nbsp;`termsOfServiceUrl`    | `string`     | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                      |
| {% icon check %} | └➔&nbsp;`payeeInfo`             | `object`     | This object contains the identificators of the payee of this payment.                                                                                                                                                                                     |
| {% icon check %} | └─➔&nbsp;`payeeId`              | `string`     | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                     |
| {% icon check %} | └─➔&nbsp;`payeeReference`       | `string(50)` | {% include field-description-payee-reference.md %}                                                                                                                                                                     |
|                  | └─➔&nbsp;`payeeName`            | `string`     | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                   |
|                  | └─➔&nbsp;`productCategory`      | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                            |
|                  | └─➔&nbsp;`orderReference`       | `String(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                   |
|                  | └─➔&nbsp;`subsite`              | `String(40)` | {% include field-description-subsite.md %}                                                                                               |
|                  | └➔&nbsp;`payer`                 | `string`     | The `payer` object, containing information about the payer.                                                                     |
|                  | └─➔&nbsp;`payerReference`       | `string`     | {% include field-description-payer-reference.md %}                                                                     |
|                  | └➔&nbsp;`prefillInfo`           | `object`     | An object that holds prefill information that can be inserted on the payment page.                                                                                                                                                                        |
|                  | └─➔&nbsp;`msisdn`               | `string`     | Number will be prefilled on MobilePay's page, if valid. Only Danish and Finnish phone numbers are supported. The country code prefix is +45 and +358 respectivly.                                                                                          |
| {% icon check %} | └➔&nbsp;`mobilepay.shoplogoUrl` | `string`     | URI to logo that will be visible at MobilePay Online. For it to display correctly in the MobilePay app, the image must be 250x250 pixels, a png or jpg served over a secure connection using https, and be publicly available.                                                                                                                                                                                                              |

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "prices": {
            "id": "/psp/mobilepay/payments/{{ page.payment_id }}/prices"
        },
        "id": "/psp/mobilepay/payments/{{ page.payment_id }}",
        "number": 75100000121,
        "created": "2018-09-11T10:58:27.4236127Z",
        "updated": "2018-09-11T10:58:30.8254419Z",
        "instrument": "MobilePay",
        "operation": "Purchase",
        "intent": "Authorization",
        "state": "Ready",
        "currency": "DKK",
        "amount": 0,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "PostmanRuntime/7.2.0",
        "userAgent": "Mozilla/5.0",
        "language": "da-DK",
        "transactions": {
            "id": "/psp/mobilepay/payments/{{ page.payment_id }}/transactions"
        },
        "urls": {
            "id": "/psp/mobilepay/payments/{{ page.payment_id }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/mobilepay/payments/{{ page.payment_id }}/payeeinfo"
        },
        "payers": {
            "id": "/psp/mobilepay/payments/{{ page.payment_id }}/payers"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/mobilepay/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/mobilepay/payments/authorize/{{ page.transaction_id }}",
            "rel": "redirect-authorization"
        }
    ]
}
```

## Step 2: Get the transaction status

Finally you need to make a `GET` request towards Swedbank Pay with the `id` of
the payment received in the first step, which will return the purchase result.

{:.code-view-header}
**Request**

```http
GET /psp/mobilepay/payments/{{ page.payment_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/mobilepay/payments/{{ page.payment_id }}",
        "number": 1234567890,
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "state": "Ready",
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "DKK",
        "amount": 1500,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "da-DK",
        "prices": {
            "id": "/psp/mobilepay/payments/{{ page.payment_id }}/prices"
        },
        "payeeInfo": {
            "id": "/psp/mobilepay/payments/{{ page.payment_id }}/payeeInfo"
        },
        "payers": {
            "id": "/psp/mobilepay/payments/{{ page.payment_id }}/payers"
        }
        "urls": {
            "id": "/psp/mobilepay/payments/{{ page.payment_id }}/urls"
        },
        "transactions": {
            "id": "/psp/mobilepay/payments/{{ page.payment_id }}/transactions"
        },
        "authorizations": {
            "id": "/psp/mobilepay/payments/{{ page.payment_id }}/authorizations"
        },
        "captures": {
            "id": "/psp/mobilepay/payments/{{ page.payment_id }}/captures"
        },
        "reversals": {
            "id": "/psp/mobilepay/payments/{{ page.payment_id }}/reversals"
        },
        "cancellations": {
            "id": "/psp/mobilepay/payments/{{ page.payment_id }}/cancellations"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/mobilepay/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/mobilepay/core/scripts/client/px.mobilepay.client.js?token={{ page.payment_token }}&operation=authorize",
            "rel": "view-authorization",
            "contentType": "application/javascript"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/mobilepay/payments/authorize/{{ page.transaction_id }}",
            "rel": "redirect-authorization",
            "contentType": "text/html"
        },
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/mobilepay/payments/{{ page.payment_id }}/captures",
            "rel": "create-capture",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.api_url }}/psp/mobilepay/{{ page.payment_id }}/paid",
            "rel": "paid-payment",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.api_url }}/psp/mobilepay/{{ page.payment_id }}/failed",
            "rel": "failed-payment",
            "contentType": "application/problem+json"
        }
    ]
}
```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                                                                                                                                                                |
| :----------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                | `object`     | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md %}                                                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`number`         | `integer`    | The payment  number , useful when there's need to reference the payment in human communication. Not usable for programmatic identification of the payment, for that  id  should be used instead.                                                                                                                                                           |
| └➔&nbsp;`created`        | `string`     | The ISO-8601 date of when the payment was created.                                                                                                                                                                                                                                                                                                         |
| └➔&nbsp;`updated`        | `string`     | The ISO-8601 date of when the payment was updated.                                                                                                                                                                                                                                                                                                         |
| └➔&nbsp;`state`          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment, not the state of any transactions performed on the payment. To find the state of the payment's transactions (such as a successful authorization), see the `transactions` resource or the different specialized type-specific resources such as `authorizations` or `sales`. |
| └➔&nbsp;`prices`         | `object`     | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`prices.id`      | `string`     | {% include field-description-id.md resource="prices" %}                                                                                                                                                                                                                                                                                                    |
| └➔&nbsp;`description`    | `string(40)` | {% include field-description-description.md %}                                                                                                                                                                                                                                                                          |
| └➔&nbsp;`userAgent`      | `string`     | The [user agent][user-agent] string of the payer's browser.                                                                                                                                                                                                                                                                                             |
| └➔&nbsp;`language`       | `string`     | {% include field-description-language.md api_resource="mobile-pay" %}                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`urls`           | `string`     | The URI to the  urls  resource where all URIs related to the payment can be retrieved.                                                                                                                                                                                                                                                                     |
| └➔&nbsp;`payeeInfo`      | `string`     | {% include field-description-payeeinfo.md %}                                                                                                                                                                                                                                                 |
| └➔&nbsp;`payers`         | `string`     | The URI to the `payer` resource where the information about the payer can be retrieved.                                                        |
| `operations`             | `array`      | The array of possible operations to perform                                                                                                                                                                                                                                                                                                                |
| └─➔&nbsp;`method`        | `string`     | The HTTP method to use when performing the operation.                                                                                                                                                                                                                                                                                                      |
| └─➔&nbsp;`href`          | `string`     | The target URI to perform the operation against.                                                                                                                                                                                                                                                                                                           |
| └─➔&nbsp;`rel`           | `string`     | The name of the relation the operation has to the current resource.                                                                                                                                                                                                                                                                                        |

## Purchase flow

The sequence diagram below shows the two requests you have to send to
Swedbank Pay to make a purchase.
The diagram also shows in high level, the sequence of the process of a
complete purchase.

```mermaid
sequenceDiagram
  participant Payer
  participant Merchant
  participant SwedbankPay as Swedbank Pay
  participant MobilePay_API as MobilePay API
  participant MobilePay_App as MobilePay App

  Payer->>Merchant: start purchase (pay with MobilePay)
  activate Merchant

  Merchant->>SwedbankPay: POST <Create MobilePay Online payment>
  note left of Merchant: First API request
  activate SwedbankPay
  SwedbankPay-->>Merchant: payment resource
  deactivate SwedbankPay
  SwedbankPay -->> SwedbankPay: Create payment
  Merchant-->>Payer: Redirect to payment page
  note left of Payer: redirect to MobilePay
  Payer-->>SwedbankPay: enter mobile number
  activate SwedbankPay

  SwedbankPay-->>MobilePay_API: Initialize MobilePay Online payment
  activate MobilePay_API
  MobilePay_API-->>SwedbankPay: response
  SwedbankPay-->>Payer: Authorization response (State=Pending)
  note left of Payer: check your phone
  deactivate Merchant

  MobilePay_API-->>MobilePay_App: Confirm Payment UI
  MobilePay_App-->>MobilePay_App: Confirmation Dialogue
  MobilePay_App-->>MobilePay_API: Confirmation
  MobilePay_API-->>SwedbankPay: make payment
  activate SwedbankPay
  SwedbankPay-->>SwedbankPay: execute payment
  SwedbankPay-->>MobilePay_API: response
  deactivate SwedbankPay
  deactivate MobilePay_API
  SwedbankPay-->>SwedbankPay: authorize result
  SwedbankPay-->>Payer: authorize result
  Payer-->>Merchant: Redirect to merchant
  note left of Payer: Redirect to merchant
  activate Merchant
  SwedbankPay-->>Merchant: Payment Callback
  Merchant-->>SwedbankPay: GET <MobilePay payments>
  note left of Merchant: Second API request
  SwedbankPay-->>Merchant: Payment resource
  deactivate SwedbankPay
  Merchant-->>Payer: Display authorize result
  deactivate Merchant
```

{% include iterator.html prev_href="index"
                         prev_title="Back: Introduction"
                         next_href="seamless-view"
                         next_title="Seamless View" %}

[callback]: /payment-instruments/mobile-pay/features/technical-reference/callback
[complete-url]: /payment-instruments/mobile-pay/features/technical-reference/complete-url
[mobilepay-screenshot-1]: /assets/img/payments/mobilepay-redirect-en.png
[mobilepay-screenshot-2]: /assets/img/payments/mobilepay-approve-en.png
[mobilepay-cancel]: /payment-instruments/mobile-pay/features/core/cancel
[mobilepay-capture]: /payment-instruments/mobile-pay/after-payment#capture
[payee-reference]: /payment-instruments/mobile-pay/features/technical-reference/payee-reference
[user-agent]:  https://en.wikipedia.org/wiki/User_agent
[swedbankpay-landing-page]: /assets/img/payments/sbp-mobilepaylandingpage-en.png
[technical-reference-callback]: /payment-instruments/mobile-pay/features/technical-reference/callback
