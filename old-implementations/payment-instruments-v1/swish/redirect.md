---
title: Redirect
redirect_from: /payments/swish/redirect
description: |
  Swish is a one-phase payment instrument supported by the
  major Swedish banks. **Swish Payments Redirect** is where Swedbank
  Pay performs a payment that the payer confirms in the Swish mobile app.
  The payer initiates the payment by supplying the Swish registered mobile
  number (msisdn), connected to the Swish app.
menu_order: 700
---

## Introduction

*   When the payer starts the purchase process, you make a `POST` request
    towards Swedbank Pay with the collected Purchase information. This will
    generate a payment object with a unique `paymentID`. You either receive a
    Redirect URL to a hosted page or a JavaScript source in response.
*   You need to redirect the payer to the payment page to enter the Swish
    registered mobile number.
    This triggers the initiation of a sales transaction.
*   Swedbank Pay handles the dialog with Swish and the payer confirms the
    purchase in the Swish app.
*   Swedbank Pay will redirect the payer's browser to - or display directly in
    the iFrame - one of two specified URLs, depending on whether the payment
    session is followed through completely or cancelled beforehand.
    Please note that both a successful and rejected payment reach completion,
    in contrast to a cancelled payment.

The payer is redirected to Swedbank Pay hosted pages and prompted
to insert their phone number to initiate the sales transaction.

Swish is a one-phase payment instrument that is based on sales transactions
**not** involving `capture` or `cancellation` operations.

{:.text-center}
![Paying with Swish using Swedbank Pay][swish-redirect-image]{:width="475px" height="400px"}

{% include alert-callback-url.md %}

## Step 1: Create A Purchase

All valid options when posting in a payment with operation equal to `Purchase`.
The `Purchase` example shown below.

{% include alert-gdpr-disclaimer.md %}

## Redirect Request

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
        "prices": [
            {
                "type": "Swish",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "hostUrls": [ "https://example.com" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png",
            "termsOfServiceUrl": "https://example.com/terms.pdf"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "ref-123456",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456",
            "subsite": "MySubsite"
        },
        "payer": {
            "payerReference": "AB1234",
        },
        "prefillInfo": {
            "msisdn": "+46739000001"
        }
    },
    "swish": {
        "enableEcomOnly": false,
        "paymentRestrictedToAgeLimit": 18,
        "paymentRestrictedToSocialSecurityNumber": "{{ page.consumer_ssn_se }}"
    }
}
```

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                        | Type          | Description                                                                                                                                                                                                                                                                                        |
| :--------------: | :--------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f payment, 0 %}                    | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                              |
| {% icon check %} | {% f operation %}          | `string`      | The operation that the `payment` is supposed to perform. The `Purchase` operation is used in our example.                                                                                                                                                                              |
| {% icon check %} | {% f intent %}             | `string`      | `Sale`.                                                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f currency %}           | `string`      | `SEK`.                                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f prices %}             | `object`      | The `prices` array lists the prices related to a specific payment.                                                                                                                                                                                                                                 |
| {% icon check %} | {% f type, 2 %}              | `string`      | `Swish`.                                                                                                                                                                                                                                                                                           |
| {% icon check %} | {% f amount, 2 %}            | `integer`     | {% include fields/amount.md %}                                                                                                                                                                                                                                                          |
| {% icon check %} | {% f vatAmount, 2 %}         | `integer`     | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                                       |
| {% icon check %} | {% f description %}        | `string(40)`  | {% include fields/description.md %}                                                                                                                                                                                                                       |
|                  | {% f paymentAgeLimit, 2 %}   | `integer`     | Positive number sets required age limit to fulfill the payment.                                                                                                                                                                                                                                    |
| {% icon check %} | {% f userAgent %}          | `string`      | {% include fields/user-agent.md %}                                                                                                                                                                                                                               |
| {% icon check %} | {% f language %}           | `string`      | {% include fields/language.md %}                                                                                                                                                                                                                                   |
| {% icon check %} | {% f urls %}               | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                             |
| {% icon check %} | {% f completeUrl, 2 %}       | `string`      | {% include fields/complete-url.md resource="payment" %}  |
|                  | {% f cancelUrl, 2 %}         | `string`      | The URL to redirect the payer to if the payment is cancelled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only cancelUrl or `paymentUrl` can be used, not both.                                                                                              |
|                  | {% f callbackUrl, 2 %}       | `string`      | {% include fields/callback-url.md resource="payment" %}                                                                                                                                          |
|                  | {% f logoUrl, 2 %}           | `string`      | {% include fields/logo-url.md %}                                                                                                                                                                |
|                  | {% f termsOfServiceUrl, 2 %} | `string`      | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                               |
| {% icon check %} | {% f payeeInfo %}          | `object`      | {% include fields/payee-info.md %}                                                                                                                                                                                                                                              |
| {% icon check %} | {% f payeeId, 2 %}           | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                              |
| {% icon check %} | {% f payeeReference, 2 %}    | `string` | {% include fields/payee-reference.md %}                                                                                                                                                                                                                   |
|                  | {% f payeeName, 2 %}         | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                            |
|                  | {% f productCategory, 2 %}   | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                     |
|                  | {% f orderReference, 2 %}    | `string(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                            |
|                  | {% f subsite, 2 %}           | `string(40)`  | {% include fields/subsite.md %}                                                                                                                                        |
|                  | {% f payer %}              | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | {% f payerReference, 2 %}    | `string`     | {% include fields/payer-reference.md %}                                                                                                                                                                                                                                                           |
|                  | {% f prefillInfo %}        | `object`      | An object holding information which, when available, will be prefilled on the payment page.                                                                                                                                                                                                        |
|                  | {% f msisdn, 2 %}            | `string`      | Number will be prefilled on payment page, if valid. The mobile number must have a country code prefix and be 8 to 15 digits in length.                                                                                                                                                             |
|                  | {% f swish %}              | `object`      | An object that holds different scenarios for Swish payments.                                                                                                                                                                                                                                       |
|                  | {% f enableEcomOnly, 2 %}    | `boolean`     | `true` if to only enable Swish on browser based transactions.; otherwise `false` to also enable Swish transactions via in-app payments.                                                                                                                                                            |
|          | {% f paymentRestrictedToAgeLimit, 2 %}             | `integer`     | Positive number that sets the required age  needed to fulfill the payment. To use this feature it has to be configured in the contract.                                                                                                                                                            |
|                 | {% f paymentRestrictedToSocialSecurityNumber, 2 %} | `string`      | When provided, the payment will be restricted to a specific social security number to make sure its the same logged in customer who is also the payer. Format: yyyyMMddxxxx. To use this feature it has to be configured in the contract.                                                                                                                             |
{% endcapture %}
{% include accordion-table.html content=table %}

## Redirect Response

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
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "prices": { "id": "/psp/swish/payments/{{ page.payment_id }}/prices" },
        "transactions": { "id": "/psp/swish/payments/{{ page.payment_id }}/transactions" },
        "captures": { "id": "/psp/swish/payments/{{ page.payment_id }}/captures" },
        "reversals": { "id": "/psp/swish/payments/{{ page.payment_id }}/reversals" },
        "cancellations": { "id": "/psp/swish/payments/{{ page.payment_id }}/cancellations" },
        "urls": { "id": "/psp/swish/payments/{{ page.payment_id }}/urls" },
        "payeeInfo": { "id": "/psp/swish/payments/{{ page.payment_id }}/payeeInfo" },
        "payers": { "id": "/psp/swish/payments/{{ page.payment_id }}/payers" },
        "settings": { "id": "/psp/swish/payments/{{ page.payment_id }}/settings" }
    },
    "operations": [
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/swish/payments/{{ page.payment_id }}/sales",
            "rel": "create-sale"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/swish/payments/authorize/{{ page.payment_token }}",
            "rel": "redirect-sale",
        },
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/swish/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort"
        },
    ]
}
```

## Redirect Sequence Diagram

The sequence diagram below shows the requests you have to send to Swedbank Pay
to make a purchase. The Callback response is a simplified example
in this flow. Go to the [Callback][callback-url] section to view the complete flow.

```mermaid
sequenceDiagram
    activate Browser
    Browser->>-Merchant: Start purchase
    activate Merchant
    Merchant->>-SwedbankPay: POST <Swish create payment> (operation=PURCHASE)
    activate SwedbankPay
    note left of Merchant: First API request
    SwedbankPay-->>-Merchant: Payment resource
    activate Merchant
    Merchant-->>-Browser: Response with redirectUrl
    activate Browser
    Browser->>-SwedbankPay: Redirect to Payment page
    note left of SwedbankPay: Redirect to Swedbank Pay
    activate Browser
    Browser->>-SwedbankPay: Enter mobile number
    activate Merchant
    Merchant->>-SwedbankPay: POST <Sale transaction>
    activate SwedbankPay
    SwedbankPay-->>-Merchant: Transaction Resource
    activate SwedbankPay
    SwedbankPay--x-Browser: Tell payer to open Swish app
    Swish_API->>Swish_App: Ask for payment confirmation
    activate Swish_App
    Swish_App-->>-Swish_API: Payer confirms payment
    activate Swish_API

        alt Callback
        Swish_API-->>-SwedbankPay: Payment status
        activate SwedbankPay
        SwedbankPay-->>-Swish_API: Callback response
        activate Swish_API
        SwedbankPay-->-Merchant: Transaction callback
        end

    activate SwedbankPay
    SwedbankPay->>-Browser: Redirect to merchant
    activate Browser
    Browser-->>-Merchant: Redirect
    activate Merchant
    Merchant->>-SwedbankPay: GET <Swish payment>
    activate SwedbankPay
    SwedbankPay-->>-Merchant: Payment response
    activate Merchant
    Merchant-->>-Browser: Payment Status
```

{% include iterator.html prev_href="direct" prev_title="Direct"
next_href="seamless-view" next_title="Seamless View" %}

[callback-url]: /old-implementations/payment-instruments-v1/swish/features/core/callback
[swish-redirect-image]: /assets/img/payments/swish-redirect-number-input-en.png
