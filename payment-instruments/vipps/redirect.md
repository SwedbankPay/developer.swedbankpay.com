---
title: Redirect
redirect_from: /payments/vipps/redirect
estimated_read: 9
description: |
  **Vipps** is a two-phase
  payment instrument supported by the major Norwegian banks. In the redirect
  scenario, Swedbank Pay receives a mobile number (msisdn)
  from the payer through Swedbank Pay Payments. Swedbank Pay performs a payment
  that the payer must confirm through the Vipps mobile app.
menu_order: 700
---

## Introduction

*   When the payer starts the purchase process, you make a `POST` request
    towards Swedbank Pay with the collected `Purchase` information.
*   This will generate a payment object with a unique `paymentID`.
*   You will receive a Redirect URL to a hosted page.
*   You need to [redirect][reference-redirect] the payer to the Redirect payment
    where the payer must push the payment button.
    This triggers a `POST` towards Swedbank Pay.
*   The payer is redirected to a Vipps payment page to enter the mobile number.
*   Swedbank Pay handles the dialogue with Vipps and the payer confirms the
    purchase in the Vipps app.
*   To receive the state of the transaction you need to do a `GET`
    request containing the `paymentID` generated in the first step.

You redirect the payer to collect the payer's mobile number.

![steps of the vipps purchase flow][vipps-purchase-flow]{:width="1200px" :height="500px"}

## Step 1: Create a Purchase

{% include alert-callback-url.md api_resource="vipps"
callback_href="/payments/vipps/other-features#callback" %}

{% include alert-gdpr-disclaimer.md %}

A `Purchase` payment is a straightforward way to charge the the payer. Below
you will see the `POST` request you will need to send to collect the purchase
information.

{:.code-view-header}
**Request**

```http
POST /psp/vipps/payments HTTP/1.1
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
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls": {
            "hostUrls": [ "https://example.net" ],
            "completeUrl": "https://example.net/payment-completed",
            "cancelUrl": "https://example.net/payment-canceled",
            "callbackUrl": "https://example.net/payment-callback",
            "logoUrl": "https://example.net/payment-logo.png",
            "termsOfServiceUrl": "https://example.net/payment-terms.pdf",
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123"
        },
        "prefillInfo": {
            "msisdn": "+4792345678"
        }
    }
}
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/vipps/payments/{{ page.payment_id }}",
        "number": 1234567890,
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "instrument": "Vipps",
        "operation": "Purchase",
        "intent": "Authorization",
        "state": "Ready",
        "currency": "NOK",
        "amount": 0,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "prices": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/prices"
        },
        "transactions": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/transactions"
        },
        "authorizations": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/authorizations"
        },
        "reversals": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/reversals"
        },
        "cancellations": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/cancellations"
        },
        "urls": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/payeeInfo"
        },
        "settings": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/settings"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/vipps/payments/{{ page.transaction_id }}",
            "rel": "update-payment-abort"
        },
        {
            "method": "GET",
            "href": "{{ page.api_url }}/vipps/payments/authorize/8fb05a835f2fc227dc7bca9abaf649b919ba8a572deb448bff543dd5806dacb7",
            "rel": "redirect-authorization"
        }
    ]
}
```

{:.table .table-striped}
|     Required     | Field                      | Type          | Description                                                                                                                                                                                                                                                                                        |
| :--------------: | :------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `payment`                  | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`operation`        | `string`      | The operation that the `payment` is supposed to perform. The [`Purchase`][purchase] operation is used in our example.                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`intent`           | `string`      | `Authorization`. Reserves the amount, and is followed by a [cancellation][cancel] or [capture][capture] of funds.<br> <br>                                                                                                                                                                         |
| {% icon check %} | └➔&nbsp;`currency`         | `string`      | NOK                                                                                                                                                                                                                                                                                                |
| {% icon check %} | └➔&nbsp;`prices`           | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`type`            | `string`      |                                                                                                                                                                                                                                                                                                    |
| {% icon check %} | └─➔&nbsp;`amount`          | `integer`     | {% include field-description-amount.md currency="NOK" %}                                                                                                                                                                                                                                           |
| {% icon check %} | └─➔&nbsp;`vatAmount`       | `integer`     | {% include field-description-vatamount.md currency="NOK" %}                                                                                                                                                                                                                                        |
| {% icon check %} | └➔&nbsp;`description`      | `string(40)`  | {% include field-description-description.md documentation_section="vipps" %}                                                                                                                                                                                                                       |
|                  | └➔&nbsp;`payerReference`   | `string`      | {% include field-description-payer-reference.md documentation_section="vipps" %}                                                                                                                                                                                   |
| {% icon check %} | └➔&nbsp;`userAgent`        | `string`      | The [`User-Agent` string][user-agent] of the payer's web browser.                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`language`         | `string`      | {% include field-description-language.md api_resource="vipps" %}                                                                                                                                                                                                                                   |
| {% icon check %} | └➔&nbsp;`urls`             | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                             |
| {% icon check %} | └─➔&nbsp;`completeUrl`     | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further. See [`completeUrl`][completeurl] for details. |
|                  | └─➔&nbsp;`cancelUrl`       | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only cancelUrl or `paymentUrl` can be used, not both.                                                                                              |
|                  | └─➔&nbsp;`callbackUrl`     | `string`      | The URL that Swedbank Pay will perform an HTTP POST against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`payeeInfo`        | `object`      | {% include field-description-payeeinfo.md documentation_section="vipps" %}                                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`payeeId`         | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`payeeReference`  | `string(50*)` | {% include field-description-payee-reference.md documentation_section="vipps" %}                                                                                                                                                                                                                   |
|                  | └─➔&nbsp;`payeeName`       | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                            |
|                  | └─➔&nbsp;`productCategory` | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                     |
|                  | └─➔&nbsp;`orderReference`  | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                            |
|                  | └─➔&nbsp;`subsite`         | `String(40)`  | {% include field-description-subsite.md %}                                                                                                                                        |

## Step 2: Authorization

To create an authorization in the redirect flow, simply perform an HTTP redirect
of the payer towards the URL in the `href` of the `redirect-authorization`
operation found in the list of `operations` in the response from the creation of
the payment.

Once the payment is successfully authorized, the payer is returned to either the
`completeUrl` or the `cancelUrl`; depending on the action performed.
On the page as well as in the `callbackUrl` you need to perform an HTTP `GET`
request towards the `id` of the payment to inspect its status.

## Step 3: Get the transaction state

The `GET`request below will give you the transaction state of the payment.
The `paymentId` used below was provided in the fist step when creating a
purchase.

{:.code-view-header}
**Request**

```http
GET /psp/vipps/payments/{{ page.payment_id }}/ HTTP/1.1
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
        "id": "/psp/vipps/payments/{{ page.payment_id }}",
        "number": 1234567890,
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "state": "Ready",
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "NOK",
        "amount": 1500,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "prices": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/prices"
        },
        "payeeInfo": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/payeeInfo"
        },
        "urls": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/urls"
        },
        "transactions": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/transactions"
        },
        "authorizations": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/authorizations"
        },
        "captures": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/captures"
        },
        "reversals": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/reversals"
        },
        "cancellations": {
            "id": "/psp/vipps/payments/{{ page.payment_id }}/cancellations"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/vipps/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/vipps/core/scripts/client/px.vipps.client.js?token={{ page.payment_token }}&operation=authorize",
            "rel": "view-authorization",
            "contentType": "application/javascript"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/vipps/core/scripts/client/px.vipps.client.js?token={{ page.payment_token }}&operation=authorize",
            "rel": "view-payment",
            "contentType": "application/javascript"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/vipps/payments/authorize/{{ page.transaction_id }}",
            "rel": "redirect-authorization",
            "contentType": "text/html"
        },
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/vipps/payments/{{ page.payment_id }}/captures",
            "rel": "create-capture",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.api_url }}/psp/vipps/{{ page.payment_id }}/paid",
            "rel": "paid-payment",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.api_url }}/psp/vipps/{{ page.payment_id }}/failed",
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
| └➔&nbsp;`description`    | `string(40)` | {% include field-description-description.md documentation_section="vipps" %}                                                                                                                                                                                                                                                                               |
| └➔&nbsp;`payerReference` | `string`     | {% include field-description-payer-reference.md documentation_section="vipps" %}                                                                                                                                                                                                                          |
| └➔&nbsp;`userAgent`      | `string`     | The [user agent][user-agent] string of the payer's browser.                                                                                                                                                                                                                                                                                             |
| └➔&nbsp;`language`       | `string`     | {% include field-description-language.md api_resource="vipps" %}                                                                                                                                                                                                                                                                                           |
| └➔&nbsp;`urls`           | `string`     | The URI to the  urls  resource where all URIs related to the payment can be retrieved.                                                                                                                                                                                                                                                                     |
| └➔&nbsp;`payeeInfo`      | `string`     | {% include field-description-payeeinfo.md documentation_section="vipps" %}                                                                                                                                                                                                                                                 |
| `operations`             | `array`      | The array of possible operations to perform                                                                                                                                                                                                                                                                                                                |
| └─➔&nbsp;`method`        | `string`     | The HTTP method to use when performing the operation.                                                                                                                                                                                                                                                                                                      |
| └─➔&nbsp;`href`          | `string`     | The target URI to perform the operation against.                                                                                                                                                                                                                                                                                                           |
| └─➔&nbsp;`rel`           | `string`     | The name of the relation the operation has to the current resource.                                                                                                                                                                                                                                                                                        |

## Vipps Redirect integration flow

The sequence diagram below shows the two requests you have to send to
Swedbank Pay to make a purchase.
The links will take you directly to the API description for the specific
request.

```mermaid
sequenceDiagram
    participant Browser
    participant Merchant
    participant SwedbankPay as Swedbank Pay
    participant VippsApi as Vipps API
    participant VippsApp as Vipps App

    Browser->>Merchant: Start purchase (pay with Vipps)
    activate Browser
    activate Merchant
    Merchant->>SwedbankPay: POST <Create  Vipps payment>
    activate SwedbankPay
    note left of Merchant: First API request
    SwedbankPay-->>Merchant: Payment resource
    deactivate SwedbankPay
    Merchant-->>Browser: Redirect to payment page
    deactivate Merchant

    note left of Browser: Redirect to Swedbank Pay
    Browser->>SwedbankPay: Redirect
    activate SwedbankPay
    SwedbankPay-->>VippsApi: Initialize Vipps payment
    activate VippsApi
    VippsApi-->>SwedbankPay: Response
    activate SwedbankPay
    SwedbankPay-->>-Browser: Display payment page
    activate Browser
    Browser->>Browser: Enter mobile number
    SwedbankPay-->>Browser: Authorization response (State=Pending)
    note left of Browser: Check your phone

    VippsApi-->>VippsApp: Confirm Payment UI
    activate VippsApp
    VippsApp-->>VippsApp: Confirmation dialogue
    VippsApp-->>VippsApi: Confirmation
    deactivate VippsApp

    VippsApi-->>SwedbankPay: Make payment
    activate SwedbankPay
    SwedbankPay-->>SwedbankPay: Execute payment
    SwedbankPay-->>VippsApi: Response
    deactivate SwedbankPay
    deactivate VippsApi

    SwedbankPay-->>SwedbankPay: Authorize result
    SwedbankPay-->>Browser: Authorize result
    deactivate SwedbankPay

    Browser-->>Merchant: Redirect to merchant
    activate Merchant
    note left of Browser: Redirect to merchant

        alt Callback
        activate SwedbankPay
        SwedbankPay-->>-VippsApi: Callback response
        SwedbankPay->>-Merchant: Transaction callback
        end

    activate SwedbankPay
    Merchant-->>SwedbankPay: GET <payment.id>
    note left of Merchant: Second API request
    SwedbankPay-->>Merchant: Payment resource
    Merchant-->>Browser: Display purchase result
    deactivate SwedbankPay
    deactivate Merchant
    deactivate Browser
```

You will later (i.e. if a physical product, when you are ready to ship the
purchased products) have to make a [Capture][capture] or
[Cancel][cancel] request.

{% include iterator.html prev_href="./"
                         prev_title="Introduction"
                         next_href="seamless-view"
                         next_title="Seamless view" %}

[callback]: /payment-instruments/vipps/other-features#callback
[cancel]: /payment-instruments/vipps/after-payment#cancellations
[completeurl]: /payment-instruments/vipps/other-features#completeurl
[capture]: /payment-instruments/vipps/after-payment#captures
[payee-reference]: /payment-instruments/vipps/other-features#payee-reference
[purchase]: /payment-instruments/vipps/other-features#purchase
[reference-redirect]: /payment-instruments/vipps/redirect
[seamless-view]: /payment-instruments/vipps/seamless-view
[user-agent]: https://en.wikipedia.org/wiki/User_agent
[vipps-payments]: /payment-instruments/vipps/other-features
[vipps-purchase-flow]: /assets/img/payments/vipps-purchase-flow.png
