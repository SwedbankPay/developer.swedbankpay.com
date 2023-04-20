---
title: Seamless View
redirect_from: /payments/swish/seamless-view
description: |
  The **Seamless View** scenario gives your
  customers the opportunity to pay with Swish directly
  within your webshop. This gives the payer a
  frictionless experience as we are handling the
  payment in the implemented `iframe` on your page.
menu_order: 800
---

## Swish Seamless View Integration Flow

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
    dialog is completed, and you will have to make a `GET` request to check
    the payment status.

## Step 1: Create A Purchase

A `Purchase` payment is a straightforward way to charge the card of the payer.
You need to make a `POST` request towards Swedbank Pay as shown below to create
a purchase. An example of an expanded `POST` request is available in the
[other features section][purchase]. This will generate a payment object with a unique
`paymentID`. You will receive a **JavaScript source** in response.

{% include payment-url.md when="selecting Swish as payment instrument" %}

{% include alert-gdpr-disclaimer.md %}

## Seamless View Request

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
            "cancelUrl": "https://example.com/payment-cancelled",
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

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                        | Type          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :--------------: | :--------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | {% f payment, 0 %}                    | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | {% f operation %}          | `string`      | {% include fields/operation.md resource="payment" %}                                                                                                                                                                                                                                                                                                 |
| {% icon check %} | {% f intent %}             | `string`      | `AutoCapture`. A one phase option that enable capture of funds.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| {% icon check %} | {% f currency %}           | `string`      | `SEK`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | {% f prices %}             | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | {% f type, 2 %}              | `string`      | {% include fields/prices-type.md kind="CreditCard" %} |
| {% icon check %} | {% f amount, 2 %}            | `integer`     | {% include fields/amount.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| {% icon check %} | {% f vatAmount, 2 %}         | `integer`     | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|                  | {% f paymentAgeLimit %}    | `integer`     | Positive number sets required age limit to fulfill the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| {% icon check %} | {% f description %}        | `string(40)`  | {% include fields/description.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| {% icon check %} | {% f userAgent %}          | `string`      | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| {% icon check %} | {% f language %}           | `string`      | {% include fields/language.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| {% icon check %} | {% f urls %}               | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| {% icon check %} | {% f hostUrls, 2 %}          | `array`       | The array of URLs valid for embedding of Swedbank Pay Seamless Views. If not supplied, view-operation will not be available.                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f completeUrl, 2 %}       | `string`      | {% include fields/complete-url.md resource="payment" %}                                                                                                                                                                                                                                                                        |
|                  | {% f cancelUrl, 2 %}         | `string`      | The URL to redirect the payer to if the payment is cancelled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only cancelUrl or `paymentUrl` can be used, not both.                                                                                                                                                                                                                                                                                                                                                                     |
|                  | {% f paymentUrl, 2 %}        | `string`      | {% include fields/payment-url.md %}                                                                                                                                                                                                                                                          |
|                  | {% f callbackUrl, 2 %}       | `string`      | {% include fields/callback-url.md resource="payment" %}                                                                                                                                                                                                                                                                                                                                                                                                                     |
|                  | {% f logoUrl, 2 %}           | `string`      | {% include fields/logo-url.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|                  | {% f termsOfServiceUrl, 2 %} | `string`      | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| {% icon check %} | {% f payeeInfo %}          | `object`      | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | {% f payeeId, 2 %}           | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | {% f payeeReference, 2 %}    | `string` | {% include fields/payee-reference.md %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|                  | {% f payeeName, 2 %}         | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f productCategory, 2 %}   | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                                                                            |
|                  | {% f orderReference, 2 %}    | `string(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                  | {% f payer %}              | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | {% f payerReference, 2 %}    | `string`     | {% include fields/payer-reference.md %}                                                                                                                                                                                                                                                           |
|                  | {% f prefillInfo %}        | `object`      | An object that holds prefill information that can be inserted on the payment page.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|                  | {% f msisdn, 2 %}            | `string`      | Number will be prefilled on payment page, if valid. The mobile number must have a country code prefix and be 8 to 15 digits in length.                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|                  | {% f subsite, 2 %}           | `string(40)`  | {% include fields/subsite.md %}                                                                                                                                                                                                                                                                                                                                                                                                               |
|                  | {% f swish %}              | `object`      | An object that holds different scenarios for Swish payments.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|                  | {% f enableEcomOnly, 2 %}    | `boolean`     | `true` if to only enable Swish on browser-based transactions.; otherwise `false` to also enable Swish transactions via mobile app.                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|          | {% f paymentRestrictedToAgeLimit, 2 %}             | `integer`     | Positive number that sets the required age  needed to fulfill the payment. To use this feature it has to be configured in the contract.                                                                                                                                                            |
|                 | {% f paymentRestrictedToSocialSecurityNumber, 2 %} | `string`      | When provided, the payment will be restricted to a specific social security number to make sure its the same logged in customer who is also the payer. Format: yyyyMMddxxxx. To use this feature it has to be configured in the contract.                                                                                                                             |
{% endcapture %}
{% include accordion-table.html content=table %}

## Seamless View Response

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

{% include alert-nested-iframe-unsupported.md %}

## Step 2: Display The Payment Window

You need to embed the script source on your site to create a Seamless View in an
`iframe`; so that the payer can enter the required information in a secure Swedbank
Pay hosted environment. A simplified integration has these following steps:

1.  Create a container that will contain the Seamless View iframe: `<div
    id="swedbank-pay-seamless-view-page">`.
2.  Create a `<script>` source within the container. Embed the `href` value
    obtained in the `POST` request in the `<script>` element. Example:

```html
<script id="payment-page-script" src="https://ecom.externalintegration.payex.com/swish/core/scripts/client/px.swish.client.js"></script>
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

## Load The Seamless View

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

## How It Looks

![screenshot of the seamless view swish payment page][seamless-view-img]{:height="215px" width="475px"}

## Seamless View Sequence Diagram

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

[callback]: /old-implementations/payment-instruments-v1/swish/features/core/callback
[purchase]: /old-implementations/payment-instruments-v1/swish/features/technical-reference/create-payment
[seamless-view-img]: /assets/img/checkout/swish-seamless-view.png
