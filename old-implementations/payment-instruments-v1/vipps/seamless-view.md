---
title: Seamless View
redirect_from: /payments/vipps/seamless-view
description: |
  **Seamless View** scenario gives your
  customers the opportunity to pay with Vipps directly within your webshop.
  In the Seamless View scenario, Swedbank Pay receives a mobile number (MSISDN)
  from the payer through Swedbank Pay Payments. Swedbank Pay performs a payment
  that the payer must confirm through the Vipps mobile app.
menu_order: 1000
---

![steps of the vipps purchase flow][vipps-purchase-flow]{:width="1200px" :height="500px"}

## Step 1: Create A Purchase

When properly set up in your merchant/webshop site and the payer starts the
purchase process, you need to make a `POST` request towards Swedbank Pay with
your Purchase information. This will generate a payment object with a unique
`paymentID`. An example of an abbreviated `POST` request is provided below. You
will receive a response in which you can find the **JavaScript source** in the
`view-payment` operation.

{% include payment-url.md when="selecting Vipps as payment instrument" %}

{% include alert-risk-indicator.md %}

{% include alert-gdpr-disclaimer.md %}

## Seamless View Request

{:.code-view-header}
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
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "paymentUrl": "https://example.com/perform-payment",
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/path/to/logo.png",
            "termsOfServiceUrl": "https://example.com/terms.pdf"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "payeeReference",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite"
        },
        "payer": {
            "payerReference": "AB1234",

        },
        "prefillInfo": {
            "msisdn": "+4798765432"
        }
    }
}
```

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                             | Type          | Description                                                                                                                                                                                                                                                                                        |
| :--------------: | :-------------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f payment, 0 %}                         | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                              |
| {% icon check %} | {% f operation %}               | `string`      | {% include fields/operation.md resource="payment" %}                                                                                                             |
| {% icon check %} | {% f intent %}                  | `string`      | `Authorization`. Reserves the amount, and is followed by a [cancellation](/old-implementations/payment-instruments-v1/vipps/features/core/cancel) or [capture](/old-implementations/payment-instruments-v1/vipps/capture) of funds.                                                          |
| {% icon check %} | {% f currency %}                | `string`      | NOK                                                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f prices %}                  | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                              |
| {% icon check %} | {% f type, 2 %}                   | `string`      | {% include fields/prices-type.md kind="Vipps" %} |
| {% icon check %} | {% f amount, 2 %}                 | `integer`     | {% include fields/amount.md currency="NOK" %}                                                                                                                                                                                                                                           |
| {% icon check %} | {% f vatAmount, 2 %}              | `integer`     | {% include fields/vat-amount.md currency="NOK" %}                                                                                                                                                                                                                                        |
| {% icon check %} | {% f description %}             | `string(40)`  | {% include fields/description.md %}                                                                                                                                                                                                                       |
|                  | {% f generatePaymentToken %}    | `boolean`     | `true` or `false`. Set this to `true` if you want to create a paymentToken for future use as One Click.                                                                                                                                                                                            |
|                  | {% f generateRecurrenceToken %} | `boolean`     | `true` or `false`. Set this to `true` if you want to create a recurrenceToken for future use Recurring purchases (subscription payments).                                                                                                                                                          |
| {% icon check %} | {% f userAgent %}               | `string`      | {% include fields/user-agent.md %}                                                                                                                                                                                                                               |
| {% icon check %} | {% f language %}                | `string`      | {% include fields/language.md %}                                                                                                                                                                                                                                   |
| {% icon check %} | {% f urls %}                    | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                             |
| {% icon check %} | {% f hostUrls, 2 %}               | `array`       | The array of URLs valid for embedding of Swedbank Pay Seamless Views. If not supplied, view-operation will not be available.                                                                                                                                                                         |
| {% icon check %} | {% f completeUrl, 2 %}            | `string`      | {% include fields/complete-url.md resource="payment" %}  |
|                  | {% f cancelUrl, 2 %}              | `string`      | The URL to redirect the payer to if the payment is cancelled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only cancelUrl or `paymentUrl` can be used, not both.                                                                                              |
|                  | {% f paymentUrl, 2 %}             | `string`      | {% include fields/payment-url.md %}                                        |
|                  | {% f callbackUrl, 2 %}            | `string`      | {% include fields/callback-url.md resource="payment" %}                                                                                                                                              |
|                  | {% f logoUrl, 2 %}                | `string`      | {% include fields/logo-url.md %}                                                                                                                                                                |
|                  | {% f termsOfServiceUrl, 2 %}      | `string`      | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                               |
| {% icon check %} | {% f payeeInfo %}               | `object`      | {% include fields/payee-info.md %}                                                                                                                                                                                                                                              |
| {% icon check %} | {% f payeeId, 2 %}                | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                              |
| {% icon check %} | {% f payeeReference, 2 %}         | `string` | {% include fields/payee-reference.md %}                                                                                                                                                                                                                   |
|                  | {% f payeeName, 2 %}              | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                            |
|                  | {% f productCategory, 2 %}        | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                     |
|                  | {% f orderReference, 2 %}         | `string(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                            |
|                  | {% f subsite, 2 %}                | `string(40)`  | {% include fields/subsite.md %}                                                                                                                                        |
|                  | {% f payer %}                   | `string`      | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | {% f payerReference, 2 %}         | `string`      | {% include fields/payer-reference.md %}                                                                                                                                                                                                                                                           |
|                  | {% f prefillInfo %}             | `object`      | An object that holds prefill information that can be inserted on the payment page.                                                                                                                                                                                                                 |
|                  | {% f msisdn, 2 %}                 | `string`      | Number will be prefilled on payment page, if valid. Only Norwegian phone numbers are supported. The country code prefix is +47                                                                                                                                                                     |
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
        "id": "/psp/vipps/payments/{{ page.payment_id }}",
        "number": 72100003079,
        "created": "2018-09-05T14:18:44.4259255Z",
        "instrument": "Vipps",
        "operation": "Purchase",
        "intent": "Authorization",
        "state": "Ready",
        "currency": "NOK",
        "amount": 0,
        "description": "Vipps Test",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0 weeeeee",
        "language": "nb-NO",
        "prices": { "id": "/psp/vipps/payments/{{ page.payment_id }}/prices" },
        "urls": { "id": "/psp/vipps/payments/{{ page.payment_id }}/urls" },
        "payeeInfo": { "id": "/psp/vipps/payments/{{ page.payment_id }}/payeeinfo" },
        "payers": { "id": "/psp/vipps/payments/{{ page.payment_id }}/payers" },
        "metadata": { "id": "/psp/vipps/payments/{{ page.payment_id }}/metadata" }
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
            "rel": "view-authorization",
            "contentType": "application/javascript"
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

{% include alert-nested-iframe-unsupported.md %}

## Step 2: Display The Payment Window

You need to embed the script source on your site to create a Seamless View in an
`iframe`; so that the payer can enter the required information in a secure
Swedbank Pay hosted environment. A simplified integration has these following
steps:

1.  Create a container that will contain the Seamless View iframe: `<div
    id="swedbank-pay-seamless-view-page">`.
2.  Create a `<script>` source within the container. Embed the `href` value
    obtained in the `POST` request in the `<script>` element. Example:

```html
    <script id="payment-page-script" src="https://ecom.externalintegration.payex.com/vipps/core/ scripts/client/px.vipps.client.js"></script>
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
          <script id="payment-page-script" src="https://ecom.dev.payex.com/vipps/core/scripts/client/px.vipps.client.js"></script>
        </div>
    </body>
</html>
```

## Load The Seamless View

Lastly, initiate the Seamless View with a JavaScript call to open the `iframe`
embedded on your website.

{:.code-view-header}
**JavaScript**

```html
<script language="javascript">
    payex.hostedView.vipps({
        // The container specifies which id the script will look for to host the
        // iframe component.
        container: "swedbank-pay-seamless-view-page"
    }).open();
</script>
```

This is what the result should look like:

{:.text-center}
![Vipps seamless view][vipps-screenshot-1]{:width="475px" :height="150px"}

## Vipps Seamless View Sequence Diagram

The sequence diagram below shows the two requests you have to send to
Swedbank Pay to make a purchase.
The links will take you directly to the API description for the specific
request.

```mermaid
sequenceDiagram
    activate Merchant
    Merchant->>-SwedbankPay: POST /psp/vipps/payments
    activate SwedbankPay
    note left of Merchant: First API request
    SwedbankPay-->>-Merchant: Payment response with rel: view-payment
    activate Merchant
    Merchant->>-SwedbankPay: script init of iFrame
    activate SwedbankPay
    SwedbankPay-->>-Merchant: Display Payment Page
    activate Merchant
    Merchant->>Merchant: Enter mobile number
    Merchant ->>- SwedbankPay: Mobile number

    activate SwedbankPay
    SwedbankPay->>+Vipps_API: POST <rel:create-auhtorization>
    activate Vipps_API
    Vipps_API-->>+SwedbankPay: Response
    activate SwedbankPay
    SwedbankPay-->>-Merchant: Display to instructions page

    Vipps_API-->>-Vipps_App: Confirm Payment UI
    activate Vipps_App
    Vipps_App-->>Vipps_App: Confirmation Dialog
    Vipps_App-->>-Vipps_API: Confirmation

    activate Vipps_API
    Vipps_API->>-SwedbankPay: Make payment
    activate SwedbankPay
    SwedbankPay-->>-SwedbankPay: Execute payment
    activate SwedbankPay
    SwedbankPay-->>-Vipps_API: Make Payment Response

        alt Callback
        activate SwedbankPay
        SwedbankPay-->>-Vipps_API: Callback response
        activate SwedbankPay
        SwedbankPay->>-Merchant: Transaction Callback
        end

    activate Merchant
    Merchant->>- SwedbankPay: GET <Vipps payment>
    activate  SwedbankPay
    SwedbankPay-->>-Merchant: Payment response
    activate Merchant
    Merchant-->>-Merchant: Display payment Status
```

1.  When the payer starts the purchase process, you make a `POST` request
   towards Swedbank Pay with the collected Purchase information.
2.  `rel: view-payment` is a value in one of the operations, sent as a response
   from Swedbank Pay to the Merchant.
3.  `Open iframe` creates the Swedbank Pay Seamless View.
     The Seamless View displays the payment page as content inside of the
   `iframe`. The payer can enter their mobile phone number for authorization.
4.  A `POST` request is sent to the Vipps API with the mobile number for
   authorization.
5.  The response will contain the state of the transaction. It will normally be
   `AwaitingActivity` in this phase of the payment, meaning we are awaiting a
   response from Vipps.
6.  Swedbank Pay handles the dialog with Vipps and the payer confirms the
   purchase in the Vipps app.

{% include iterator.html
        prev_href="redirect"
        prev_title="Redirect"
        next_href="capture"
        next_title="Capture" %}

[vipps-purchase-flow]: /assets/img/payments/vipps-purchase-flow.png
[vipps-screenshot-1]: /assets/img/payments/vipps-seamless-view.png
