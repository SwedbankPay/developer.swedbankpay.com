---
title: Seamless View
redirect_from: /payments/invoice/seamless-view
description: |
  The Seamless View scenario represents the opportunity to implement Invoice
  directly in your webshop.
menu_order: 600
---

{% assign financing_consumer_url="/old-implementations/payment-instruments-v1/invoice/features/technical-reference/financing-consumer" %}
{% assign cancel_url="/old-implementations/payment-instruments-v1/invoice/after-payment#cancellations" %}
{% assign capture_url="/old-implementations/payment-instruments-v1/invoice/capture" %}

{% include alert.html type="warning" icon="report_problem" body="**Availability**:
Note that this invoice integration is no longer available in Sweden. If you are
a Swedish merchant and wish to offer invoice as a payment option, this has to be
done through our payment order implementation." %}

## Introduction

Seamless View provides an integration of the payment process directly on your
website. This solution offers a smooth shopping experience with Swedbank Pay
payment pages seamlessly integrated in an `iframe` on your website. The payer
does not need to leave your webpage, since we are handling the payment in the
`iframe` on your page.

## How It Looks

{:.text-center}
![screenshot of the invoice payment window][invoice-payment]{:height="525px" width="475px"}

{% include alert-callback-url.md %}

## Step 1: Create The Payment

{% include alert-gdpr-disclaimer.md %}

A `FinancingConsumer` payment is a straightforward way to invoice a
payer. It is followed up by posting a capture, cancellation or reversal
transaction.

An example of an abbreviated `POST` request is provided below. Each individual
field of the JSON document is described in the following section. An example of
an expanded `POST` request is available in the [other features
section]({{ financing_consumer_url }}).

When properly set up in your merchant/webshop site and the payer starts the
invoice process, you need to make a POST request towards Swedbank Pay with your
invoice information. This will generate a payment object with a unique
`paymentID`. You will receive a **JavaScript source** in response.

## Seamless View Request

{% capture request_header %}POST /psp/invoice/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "payment": {
        "operation": "FinancingConsumer",
        "intent": "Authorization",
        "currency": "SEK",
        "prices": [
            {
                "type": "Invoice",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Invoice",
        "userAgent": "Mozilla/5.0...",
        "generatePaymentToken": false,
        "paymentToken": ""
        "language": "sv-SE",
        "urls": {
            "hosturls": [
                "https://example.com"
            ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "callbackUrl": "https://example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/payment-terms.pdf"
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
    },
    "invoice": {
        "invoiceType": "PayExFinancingSe"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                             | Type          | Description                                                                                                                                                                                                                                                                                                                                    |
| :--------------: | :-------------------------------- | :------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f payment, 0 %}                         | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                          |
| {% icon check %} | {% f operation %}               | `string`      | The operation that the `payment` is supposed to perform. The [`FinancingConsumer`]({{ financing_consumer_url }}) operation is used in our example. |
| {% icon check %} | {% f intent %}                  | `string`      | `Authorization`. Reserves the amount, and is followed by a [cancellation]({{ cancel_url }}) or [capture]({{ capture_url }}) of funds.                                                                                                                                                                                                                              |
| {% icon check %} | {% f currency %}                | `string`      | NOK or SEK.                                                                                                                                                                                                                                                                                                                                    |
| {% icon check %} | {% f prices %}                  | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                          |
| {% icon check %} | {% f type, 2 %}                   | `string`      | {% include fields/prices-type.md kind="Invoice" %}                                                                                                                                                                                                                                  |
| {% icon check %} | {% f amount, 2 %}                 | `integer`     | {% include fields/amount.md %}                                                                                                                                                                                                                                                                                                      |
| {% icon check %} | {% f vatAmount, 2 %}              | `integer`     | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                                                                                   |
| {% icon check %} | {% f description %}             | `string(40)`  | {% include fields/description.md %}                                                                                                                                                                                                                                                                 |
|                  | {% f generatePaymentToken %}    | `boolean`     | `true` or `false`. Set this to `true` if you want to create a paymentToken for future use as One Click.                                                                                                                                                                                                                                        |
| {% icon check %} | {% f userAgent %}               | `string`      | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                           |
| {% icon check %} | {% f language %}                | `string`      | {% include fields/language.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f urls %}                    | `object`      | The`urls`resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                                                                           |
| {% icon check %} | {% f hostUrls, 2 %}               | `array`       | The array of valid host URLs.                                                                                                                                                                                                                   |
| {% icon check %} | {% f completeUrl, 2 %}            | `string`      | {% include fields/complete-url.md resource="payment" %} |
|                  | {% f cancelUrl, 2 %}              | `string`      | The URL to redirect the payer to if the payment is cancelled. Only used in redirect scenarios. Can not be used simultaneously with`paymentUrl`; only cancelUrl or`paymentUrl`can be used, not both.                                                                                                                                             |
|                  | {% f callbackUrl, 2 %}            | `string`      | {% include fields/callback-url.md resource="payment" %}                                                                                                                                                                                          |
|                  | {% f termsOfServiceUrl, 2 %}      | `string`      | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                                                                           |
| {% icon check %} | {% f payeeInfo %}               | `object`      | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f payeeId, 2 %}                | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                                          |
| {% icon check %} | {% f payeeReference, 2 %}         | `string(30)` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                                                                                       |
|                  | {% f payeeName, 2 %}              | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                                                                        |
|                  | {% f productCategory, 2 %}        | `string(50)`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                 |
|                  | {% f orderReference, 2 %}         | `string(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                        |
|                  | {% f payer %}                   | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | {% f payerReference, 2 %}         | `string`     | {% include fields/payer-reference.md documentation_section="invoice" %}                                                                                                                                                                                                                                                           |
| {% icon check %} | {% f invoiceType, 2 %}            | `string`      | `PayExFinancingSe`, `PayExFinancingNo` or `PayExFinancingFi` depending on which country you're doing business with Swedbank Pay in. (Other external financing partner names must be agreed upon with Swedbank Pay.)                                                                                                                            |
{% endcapture %}
{% include accordion-table.html content=table %}

## Seamless View Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": {
        "id": "/psp/invoice/payments/{{ page.payment_id }}",
        "number": 1234567890,
        "instrument": "Invoice",
        "created": "YYYY-MM-DDThh:mm:ssZ",
        "updated": "YYYY-MM-DDThh:mm:ssZ",
        "operation": "FinancingConsumer",
        "intent": "Authorization",
        "state": "Ready",
        "currency": "SEK",
        "prices": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/prices"
        },
        "amount": 0,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/payeeinfo"
        },
        "payers": {
           "id": "/psp/invoice/payments/{{ page.payment_id }}/payers"
        },
        "metadata": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/metadata"
        }
    },
    "operations": [
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/invoice/payments/{{ page.payment_id }}/approvedlegaladdress",
            "rel": "create-approved-legal-address",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/invoice/payments/{{ page.payment_id }}/authorizations",
            "rel": "create-authorization",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/invoice/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/invoice/payments/authorize/{{ page.payment_token }}",
            "rel": "redirect-authorization",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/invoice/core/scripts/client/px.invoice.client.js?{{ page.payment_token }}&operation=authorize",
            "rel": "view-authorization",
            "contentType": "application/javascript"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

The key information in the response is the `view-authorization` operation. You
will need to embed its `href` in a `<script>` element. The script will enable
loading the payment page in an `iframe` in our next step.

{% include alert-nested-iframe-unsupported.md %}

## Step 2: Display The Payment

You need to embed the script source on your site to create a Seamless View in an
`iframe`; so that the payer can enter the payment details in a secure Swedbank Pay
hosted environment. A simplified integration has these following steps:

1.  Create a container that will contain the Seamless View iframe: `<div
   id="swedbank-pay-seamless-view-page">`.
2.  Create a `<script>` source within the container. Embed the `href` value
   obtained in the `POST` request in the `<script>` element. Example:

```html
    <script id="payment-page-script" src="https://ecom.externalintegration.payex.com/invoice/core/ scripts/client/px.invoice.client.js"></script>
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
          <script id="payment-page-script" src="https://ecom.dev.payex.com/invoice/core/scripts/client/px.invoice.client.js"></script>
        </div>
    </body>
</html>
```

## Loading The JavaScript

Lastly, initiate the Seamless View with a JavaScript call to open the `iframe`
embedded on your website.

{:.code-view-header}
**HTML**

```html
<script language="javascript">
    payex.hostedView.invoice({
        // The container specifies which id the script will look for to host the
        // iframe component.
        container: "swedbank-pay-seamless-view-page"
    }).open();
</script>
```

## Purchase Flow

The sequence diagram below shows a high level description of the
invoice process.

```mermaid
sequenceDiagram
    Payer->>Merchant: Start purchase
    activate Merchant
    note left of Merchant: First API request
    Merchant->>-SwedbankPay: POST /psp/invoice/payments ①
    activate SwedbankPay
    SwedbankPay-->>-Merchant: rel: view-authorization ②
    activate Merchant
    Merchant-->>-Payer: Display all details and final price
    activate Payer
    note left of Payer: Open iframe ③
    Payer->>Payer: Input email and mobile number
    Payer->>-Merchant: Confirm purchase
    activate Merchant
    note left of Merchant: Second API request
    Merchant->>-SwedbankPay: Post psp/invoice/authorization ④
    activate SwedbankPay
    SwedbankPay-->>-Merchant: Transaction result
    activate Merchant
    note left of Merchant: Third API request
    Merchant->>-SwedbankPay: GET <payment.id> ⑤
    activate SwedbankPay
    SwedbankPay-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Payer: Display result
```

{% include alert.html type="informative" icon="info" body="
Note that the invoice will not be created/distributed before you have
made a `capture` request." %}

{% include iterator.html prev_href="/old-implementations/payment-instruments-v1/invoice/redirect" prev_title="Redirect"
next_href="/old-implementations/payment-instruments-v1/invoice/direct" next_title="Direct" %}

[invoice-payment]: /assets/img/checkout/invoice-seamless-view.png
