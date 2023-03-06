---
title: Seamless View
redirect_from: /payments/mobile-pay/seamless-view
description: |
  **Seamless View** scenario gives your payers the opportunity to pay with
  MobilePay directly from within your webshop. In the Seamless view scenario,
  Swedbank Pay receives a mobile number (MSISDN) from the payer through
  Swedbank Pay Payments. Swedbank Pay performs a payment that the payer then
  must confirm through the MobilePay mobile app.
menu_order: 700
---
## Step 1: Create A purchase

When properly set up in your merchant/webshop site and the payer starts the
purchase process, you need to make a `POST` request towards Swedbank Pay with
your Purchase information. This will generate a payment object with a unique
`paymentID`. An example of an abbreviated `POST` request is provided below. You
will receive a response in which you can find the **JavaScript source** in the
`view-payment` operation.

{% include alert-gdpr-disclaimer.md %}

## Seamless View Request

{:.code-view-header}
**Request**

```http
POST /psp/mobilepay/payments HTTP/1.1
Host: {{ page.api_host }}
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
                "vatAmount": 0,
            }
        ],
        "description": "MobilePay Test",
        "userAgent": "Mozilla/5.0",
        "language": "da-DK",
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
            "msisdn": "+4598765432"
        }
    },
    "mobilepay": {
        "shoplogoUrl": "https://example.com/shoplogourl.png"
    }
}

```

{% capture table %}
{:.table .table-striped .mb-5}
| Required         | Field                           | Data type    | Description                                                                                                                                                                                                                                               |
| :--------------- | :------------------------------ | :----------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f payment, 0 %}                       | `object`     | The payment object.                                                                                                                                                                                                                                       |
| {% icon check %} | {% f operation %}             | `string`     | `Purchase`                                                                                                                                                                                                                                                |
| {% icon check %} | {% f intent %}                | `string`     | `Authorization`                                                                                                                                                                                                                                           |
| {% icon check %} | {% f currency %}              | `string`     | `NOK`, `SEK`, `DKK`, `USD` or `EUR`.                                                                                                                                                                                                                      |
| {% icon check %} | {% f prices %}                | `object`     | The prices object.                                                                                                                                                                                                                                        |
| {% icon check %} | {% f type, 2 %}                 | `string`     | {% include fields/prices-type.md kind="MobilePay" %} |
| {% icon check %} | {% f amount, 2 %}               | `integer`    | {% include fields/amount.md currency="DKK" %}                                                                                                                                                                                                  |
| {% icon check %} | {% f vatAmount, 2 %}            | `integer`    | {% include fields/vat-amount.md currency="DKK" %}                                                                                                                                                                                               |
|                  | {% f feeAmount, 2 %}            | `integer`    | If the amount given includes Fee, this may be displayed for the user in the payment page (redirect only).                                                                                                                                                 |
| {% icon check %} | {% f description %}           | `string(40)` | {% include fields/description.md %}                                                                                                                                                                         |
| {% icon check %} | {% f userAgent %}             | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                         |
| {% icon check %} | {% f language %}              | `string`     | {% include fields/language.md %}                                                                                                                                                                                      |
| {% icon check %} | {% f urls %}                  | `object`     | The URLs object containing the urls used for this payment.                                                                                                                                                                                                |
| {% icon check %} | {% f hosturls %}              | `array`      | The array of URLs valid for embedding of Swedbank Pay Seamless Views. If not supplied, view-operation will not be available.                                                                                                                                                                                                |
| {% icon check %} | {% f completeUrl, 2 %}          | `string`     | {% include fields/complete-url.md resource="payment" %} |
| {% icon check %} | {% f cancelUrl, 2 %}            | `string`     | The URL that Swedbank Pay will redirect back to when the user presses the cancel button in the payment page.                                                                                                                                              |
|                  | {% f paymentUrl, 2 %}           | `string`     | {% include fields/payment-url.md %}                                        |
|                  | {% f callbackUrl, 2 %}          | `string`     | {% include fields/callback-url.md resource="payment" %}                                                                                         |
| {% icon check %} | {% f termsOfServiceUrl, 2 %}    | `string`     | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                      |
| {% icon check %} | {% f payeeInfo %}             | `object`     | This object contains the identificators of the payee of this payment.                                                                                                                                                                                     |
| {% icon check %} | {% f payeeId, 2 %}              | `string`     | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                     |
| {% icon check %} | {% f payeeReference, 2 %}       | `string` | {% include fields/payee-reference.md %}                                                                                                                                                                     |
|                  | {% f payeeName, 2 %}            | `string`     | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                               |
|                  | {% f productCategory, 2 %}      | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                            |
|                  | {% f orderReference, 2 %}       | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                   |
|                  | {% f subsite, 2 %}              | `string(40)` | {% include fields/subsite.md %}                                                                                                                                                                                                                |
|                  | {% f payer %}                 | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | {% f payerReference, 2 %}       | `string`     | {% include fields/payer-reference.md %}                                                                                                                                                                                                                                                           |
|                  | {% f prefillInfo %}           | `object`     | An object that holds prefill information that can be inserted on the payment page.                                                                                                                                                                        |
|                  | {% f msisdn, 2 %}               | `string`     | Number will be prefilled on MobilePays page, if valid. Only Danish and Finnish phone numbers are supported. The country code prefix is +45 and +358 respectively.                                                                                          |
|                  | {% f mobilepay.shoplogoUrl %} | `string`     | URI to logo that will be visible at MobilePay Online. For it to display correctly in the MobilePay app, the image must be 250x250 pixels, a png or jpg served over a secure connection using https, and be publicly available. This URI will override the value configured in the contract setup.                            |
{% endcapture %}
{% include accordion-table.html content=table %}

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/mobilepay/payments/{{ page.payment_id }}",
        "number": 72100003079,
        "created": "2018-09-05T14:18:44.4259255Z",
        "instrument": "MobilePay",
        "operation": "Purchase",
        "intent": "Authorization",
        "state": "Ready",
        "currency": "DKK",
        "amount": 0,
        "description": "MobilePay Test",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0",
        "language": "da-DK",
        "prices": { "id": "/psp/mobilepay/payments/{{ page.payment_id }}/prices" },
        "urls": { "id": "/psp/mobilepay/payments/{{ page.payment_id }}/urls" },
        "payeeInfo": { "id": "/psp/mobilepay/payments/{{ page.payment_id }}/payeeinfo" },
        "payers": { "id": "/psp/mobilepay/payments/{{ page.payment_id }}/payers" }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/mobilepay/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/mobilepay/core/scripts/client/px.mobilepay.client.js?token={{ page.payment_token }}&Culture=da-DK",
            "rel": "view-authorization",
            "contentType": "application/javascript"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/mobilepay/core/scripts/client/px.mobilepay.client.js?token={{ page.payment_token }}&Culture=da-DK",
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

## Step 2: Display  the payment window

You need to embed the script source on your site to create a Seamless View in an
`iframe` so that the payer can enter the required information in a secure
Swedbank Pay hosted environment. A simplified integration has these following
steps:

1.  Create a container that will contain the Seamless View iframe: `<div
    id="swedbank-pay-seamless-view-page">`.
2.  Create a `<script>` source within the container. Embed the `href` value
    obtained in the `POST` request in the `<script>` element. Example:

```html
    <script id="payment-page-script" src="https://ecom.externalintegration.payex.com/mobilepay/core/ scripts/client/px.mobilepay.client.js"></script>
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
          <script id="payment-page-script" src="https://ecom.dev.payex.com/mobilepay/core/scripts/client/px.mobilepay.client.js"></script>
        </div>
    </body>
</html>
```

Lastly, initiate the Seamless View with a JavaScript call to open the `iframe`
embedded on your website.

{:.code-view-header}
**JavaScript**

```js
<script language="javascript">
    payex.hostedView.mobilepay({
        // The container specifies which id the script will look for to host the
        // iframe component.
        container: "swedbank-pay-seamless-view-page"
    }).open();
</script>
```

## MobilePay Online Seamless View flow

The sequence diagram below shows the two requests you have to send to
Swedbank Pay to make a purchase.
The links will take you directly to the API description for the specific
request.

```mermaid
sequenceDiagram
    participant Merchant
    participant SwedbankPay as Swedbank Pay
    participant MobilePayApp as MobilePay App
    participant MobilePayApi as MobilePay API

    activate Merchant
    Merchant->>-SwedbankPay: POST /psp/mobilepay/payments
    activate SwedbankPay
    note left of Merchant: First API request
    SwedbankPay-->>-Merchant: Payment response with rel: view-payment
    activate Merchant
    Merchant->>-SwedbankPay: Script init of iFrame
    activate SwedbankPay
    SwedbankPay-->>-Merchant: Display Payment Page
    activate Merchant
    Merchant->>Merchant: Init payment
    Merchant->>-SwedbankPay: Init request

    activate SwedbankPay
    SwedbankPay->>+MobilePayApi: POST <rel:create-authorization>
    activate MobilePayApi
    MobilePayApi-->>+SwedbankPay: Response
    activate SwedbankPay
    SwedbankPay-->>-Merchant: Display instructions page

    MobilePayApi-->>-MobilePayApp: Confirm Payment UI
    activate MobilePayApp
    MobilePayApp-->>MobilePayApp: Confirmation Dialog
    MobilePayApp-->>-MobilePayApi: Confirmation

    activate MobilePayApi
    MobilePayApi->>-SwedbankPay: Authorize Payment
    activate SwedbankPay
    SwedbankPay-->>-SwedbankPay: Process Payment
    activate SwedbankPay
    SwedbankPay-->>-MobilePayApi: Process Payment Response
    activate MobilePayApi
    MobilePayApi-->>-MobilePayApp: Transaction Status

    activate Merchant
    Merchant->>- SwedbankPay: GET <MobilePay payment>
    activate  SwedbankPay
    SwedbankPay-->>-Merchant: Payment response
    activate Merchant
    Merchant-->>-Merchant: Display payment Status
```

1.  When the payer starts the purchase process, you make a `POST` request
    towards Swedbank Pay with the collected Purchase information.
2.  `rel: view-payment` is a value in one of the operations, sent as a response
    from Swedbank Pay to the Merchant.
3.  `Open iFrame` creates the Swedbank Pay Seamless View.
    The Seamless View displays the payment page as content inside of the
    `iFrame`.
4.  A `POST` request is sent to the MobilePay API with
    the mobile number (optional) for authorization.
5.  Swedbank Pay handles the dialog with MobilePay and the payer confirms the
    purchase in the MobilePay app.
6.  After the purchase has been authorized, the payer will be redirected back
    to the merchant, where the status can be checked to ensure the payment was
    successful.

{% include iterator.html
        prev_href="redirect"
        prev_title="Redirect"
        next_href="after-payment"
        next_title="After Payment" %}
