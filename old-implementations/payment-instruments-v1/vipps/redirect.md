---
title: Redirect
redirect_from: /payments/vipps/redirect
description: |
  **Vipps** is a two-phase
  payment instrument supported by the major Norwegian banks. In the redirect
  scenario, Swedbank Pay receives a mobile number (msisdn)
  from the payer through Swedbank Pay Payments. Swedbank Pay performs a payment
  that the payer must confirm through the Vipps mobile app.
menu_order: 900
---

{% assign cancel_url="/old-implementations/payment-instruments-v1/invoice/after-payment#cancellations" %}
{% assign capture_url="/old-implementations/payment-instruments-v1/invoice/capture" %}

## Introduction

*   When the payer starts the purchase process, you make a `POST` request
    towards Swedbank Pay with the collected `Purchase` information.
*   This will generate a payment object with a unique `paymentID`.
*   You will receive a Redirect URL to a hosted page.
*   You need to [redirect][reference-redirect] the payer to the Redirect payment
    where the payer must push the payment button.
    This triggers a `POST` towards Swedbank Pay.
*   The payer is redirected to a Vipps payment page to enter the mobile number.
*   Swedbank Pay handles the dialog with Vipps and the payer confirms the
    purchase in the Vipps app.
*   To receive the state of the transaction you need to do a `GET`
    request containing the `paymentID` generated in the first step.

You redirect the payer to collect the payer's mobile number.

![steps of the vipps purchase flow][vipps-purchase-flow]{:width="1200px" :height="500px"}

## Step 1: Create A Purchase

{% include alert-callback-url.md %}

{% include alert-gdpr-disclaimer.md %}

A `Purchase` payment is a straightforward way to charge the the payer. Below
you will see the `POST` request you will need to send to collect the purchase
information.

## Redirect Request

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
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls": {
            "hostUrls": [ "https://example.net" ],
            "completeUrl": "https://example.net/payment-completed",
            "cancelUrl": "https://example.net/payment-cancelled",
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
        "payer": {
            "payerReference": "AB1234",
        },
        "prefillInfo": {
            "msisdn": "+4792345678"
        }
    }
}
```

## Redirect Response

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
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "prices": { "id": "/psp/vipps/payments/{{ page.payment_id }}/prices" },
        "transactions": { "id": "/psp/vipps/payments/{{ page.payment_id }}/transactions" },
        "authorizations": { "id": "/psp/vipps/payments/{{ page.payment_id }}/authorizations" },
        "reversals": { "id": "/psp/vipps/payments/{{ page.payment_id }}/reversals" },
        "cancellations": { "id": "/psp/vipps/payments/{{ page.payment_id }}/cancellations" },
        "urls": { "id": "/psp/vipps/payments/{{ page.payment_id }}/urls" },
        "payeeInfo": { "id": "/psp/vipps/payments/{{ page.payment_id }}/payeeInfo" },
        "payers": { "id": "/psp/vipps/payments/{{ page.payment_id }}/payers" },
        "settings": { "id": "/psp/vipps/payments/{{ page.payment_id }}/settings" }
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

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                      | Type          | Description                                                                                                                                                                                                                                                                                        |
| :--------------: | :------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f payment, 0 %}                  | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                              |
| {% icon check %} | {% f operation %}        | `string`      | The operation that the `payment` is supposed to perform. The `Purchase` operation is used in our example.                                                                                                                                                                              |
| {% icon check %} | {% f intent %}           | `string`      | `Authorization` is the only intent option for invoice. Reserves the amount, and is followed by a [cancellation]({{ cancel_url }}) or [capture]({{ capture_url }}) of funds.                                                                          |
| {% icon check %} | {% f currency %}         | `string`      | NOK                                                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f prices %}           | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                              |
| {% icon check %} | {% f type, 2 %}            | `string`      | {% include fields/prices-type.md kind="Vipps" %}                                                                                                                                                                                                                                                                                                   |
| {% icon check %} | {% f amount, 2 %}          | `integer`     | {% include fields/amount.md currency="NOK" %}                                                                                                                                                                                                                                           |
| {% icon check %} | {% f vatAmount, 2 %}       | `integer`     | {% include fields/vat-amount.md currency="NOK" %}                                                                                                                                                                                                                                        |
| {% icon check %} | {% f description %}      | `string(40)`  | {% include fields/description.md %}                                                                                                                                                                                                                       |
| {% icon check %} | {% f userAgent %}        | `string`      | {% include fields/user-agent.md %}                                                                                                                                                                                                                               |
| {% icon check %} | {% f language %}         | `string`      | {% include fields/language.md %}                                                                                                                                                                                                                                   |
| {% icon check %} | {% f urls %}             | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                             |
| {% icon check %} | {% f completeUrl, 2 %}     | `string`      | {% include fields/complete-url.md resource="payment" %} |
|                  | {% f cancelUrl, 2 %}       | `string`      | The URL to redirect the payer to if the payment is cancelled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only cancelUrl or `paymentUrl` can be used, not both.                                                                                              |
|                  | {% f callbackUrl, 2 %}     | `string`      | {% include fields/callback-url.md resource="payment" %}                                                                                                                                              |
| {% icon check %} | {% f payeeInfo %}        | `object`      | {% include fields/payee-info.md %}                                                                                                                                                                                                                                              |
| {% icon check %} | {% f payeeId, 2 %}         | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                              |
| {% icon check %} | {% f payeeReference, 2 %}  | `string` | {% include fields/payee-reference.md %}                                                                                                                                                                                                                   |
|                  | {% f payeeName, 2 %}       | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                            |
|                  | {% f productCategory, 2 %} | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                     |
|                  | {% f orderReference, 2 %}  | `string(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                            |
|                  | {% f subsite, 2 %}         | `string(40)`  | {% include fields/subsite.md %}                                                                                                                                        |
|                  | {% f payer %}             | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | {% f payerReference, 2 %}   | `string`     | {% include fields/payer-reference.md %}                                                                                                                                                                                                                                                           |
|                  | {% f prefillInfo %}             | `object`      | An object that holds prefill information that can be inserted on the payment page.                                                                                                                                                                                                                 |
|                  | {% f msisdn, 2 %}                 | `string`      | Number will be prefilled on payment page, if valid. Only Norwegian phone numbers are supported. The country code prefix is +47                                                                                                                                                                     |
{% endcapture %}
{% include accordion-table.html content=table %}

## Step 2: Authorization

To create an authorization in the redirect flow, simply perform an HTTP redirect
of the payer towards the URL in the `href` of the `redirect-authorization`
operation found in the list of `operations` in the response from the creation of
the payment.

Once the payment is successfully authorized, the payer is returned to either the
`completeUrl` or the `cancelUrl`; depending on the action performed.
On the page as well as in the `callbackUrl` you need to perform an HTTP `GET`
request towards the `id` of the payment to inspect its status.

## Step 3: Get The Transaction State

The `GET`request below will give you the transaction state of the payment.
The `paymentId` used below was provided in the fist step when creating a
purchase.

## GET Transaction State Request

{:.code-view-header}
**Request**

```http
GET /psp/vipps/payments/{{ page.payment_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

## GET Transaction State Response

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
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "prices": { "id": "/psp/vipps/payments/{{ page.payment_id }}/prices" },
        "payeeInfo": { "id": "/psp/vipps/payments/{{ page.payment_id }}/payeeInfo" },
        "payers": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/payers" },
        "urls": { "id": "/psp/vipps/payments/{{ page.payment_id }}/urls" },
        "transactions": { "id": "/psp/vipps/payments/{{ page.payment_id }}/transactions" },
        "authorizations": { "id": "/psp/vipps/payments/{{ page.payment_id }}/authorizations" },
        "captures": { "id": "/psp/vipps/payments/{{ page.payment_id }}/captures" },
        "reversals": { "id": "/psp/vipps/payments/{{ page.payment_id }}/reversals" },
        "cancellations": { "id": "/psp/vipps/payments/{{ page.payment_id }}/cancellations" }
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

{% capture table %}
{:.table .table-striped .mb-5}
| Field                  | Type         | Description                                                                                                                                                                                                                                                                                                                                                |
| :--------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}     | `object`     | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                      |
| {% f id %}             | `string`     | {% include fields/id.md %}                                                                                                                                                                                                                                                                                                                      |
| {% f number %}         | `integer`    | {% include fields/number.md resource="payment" %}                                                                                                                                                           |
| {% f created %}        | `string`     | The ISO-8601 date of when the payment was created.                                                                                                                                                                                                                                                                                                         |
| {% f updated %}        | `string`     | The ISO-8601 date of when the payment was updated.                                                                                                                                                                                                                                                                                                         |
| {% f state %}          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment, not the state of any transactions performed on the payment. To find the state of the payment's transactions (such as a successful authorization), see the `transactions` resource or the different specialized type-specific resources such as `authorizations` or `sales`. |
| {% f prices %}         | `object`     | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                      |
| {% f prices.id %}      | `string`     | {% include fields/id.md resource="prices" %}                                                                                                                                                                                                                                                                                                    |
| {% f description %}    | `string(40)` | {% include fields/description.md %}                                                                                                                                                                                                                                                                               |
| {% f payers %}         | `string`     | The URL to the `payer` resource where the information about the payer can be retrieved.                                                        |
| {% f userAgent %}      | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                                             |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                                                                                                                                                           |
| {% f urls %}           | `string`     | The URL to the  urls  resource where all URLs related to the payment can be retrieved.                                                                                                                                                                                                                                                                     |
| {% f payeeInfo %}      | `string`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                 |
| {% f operations, 0 %}  | `array`      | {% include fields/operations.md resource="payment" %}                                                                                                                                                                                                                                                                                                                |
| {% f method, 2 %}      | `string`     | The HTTP method to use when performing the operation.                                                                                                                                                                                                                                                                                                      |
| {% f href, 2 %}        | `string`     | The target URL to perform the operation against.                                                                                                                                                                                                                                                                                                           |
| {% f rel, 2 %}         | `string`     | The name of the relation the operation has to the current resource.                                                                                                                                                                                                                                                                                        |
{% endcapture %}
{% include accordion-table.html content=table %}

## Vipps Redirect Sequence Diagram

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
    VippsApp-->>VippsApp: Confirmation dialog
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

[cancel]: /old-implementations/payment-instruments-v1/vipps/features/core/cancel
[capture]: /old-implementations/payment-instruments-v1/vipps/capture
[reference-redirect]: /old-implementations/payment-instruments-v1/vipps/redirect
[vipps-purchase-flow]: /assets/img/payments/vipps-purchase-flow.png
