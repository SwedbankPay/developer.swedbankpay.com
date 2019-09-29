---
title: Swedbank Pay Checkout
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

{% include jumbotron.html body="**Swedbank Pay Checkout** is a complete reimagination
of the checkout experience, integrating seamlessly into the merchant website
through highly customizable and flexible components.

Visit our [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop)
and try out Swedbank Pay Checkout for yourself!" %}

Swedbank Pay Checkout allows your customers to be identified with Swedbank Pay,
enabling existing Swedbank Pay Checkout users to pay with their favorite payment
methods in just a few simple steps.

## Prerequisites

To start integrating Swedbank Pay Checkout, you need the following:

* [HTTPS][https] enabled web server
* Agreement that includes Swedbank Pay Checkout
* Obtained credentials (merchant Access Token) from Swedbank Pay through
  Swedbank Pay Admin. Please observe that Swedbank Pay Checkout encompass
  both the **`consumer`** and **`paymentmenu`** scope.

## Introduction

To get started with Swedbank Pay Checkout, you should learn about its different
components and how they work together. Swedbank Pay Checkout consists of two related,
but disconnected concepts: **Checkin** and **Payment Menu**. Checkin identifies
the consumer in our Consumer API and Payment Menu completes the payment with
our Payment Menu API. Connect the two concepts and you have Swedbank Pay Checkout.

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay

    activate Payer
        rect rgba(238, 112, 35, 0.05)
            note left of Payer: Checkin

            Payer ->> Merchant: Start Checkin
            activate Merchant
                Merchant ->> SwedbankPay: POST /psp/consumers
                activate SwedbankPay
                    SwedbankPay -->> Merchant: rel:view-consumer-identification
                deactivate SwedbankPay
                Merchant -->> Payer: Show Checkin (Consumer Hosted View)

            deactivate Merchant
            Payer ->> Payer: Initiate Consumer Hosted View (open iframe)
            Payer ->> SwedbankPay: Show Consumer UI page in iframe
            activate SwedbankPay
                SwedbankPay ->> Payer: Consumer identification process
                SwedbankPay -->> Payer: show consumer completed iframe
            deactivate SwedbankPay
            Payer ->> Payer: onConsumerIdentified (consumerProfileRef)
        end

        rect rgba(138,205,195,0.1)
            note left of Payer: Payment Menu
            Payer ->> Merchant: Prepare Payment Menu
            activate Merchant
                Merchant ->> SwedbankPay: POST /psp/paymentorders (paymentUrl, consumerProfileRef)
                activate SwedbankPay
                    SwedbankPay -->> Merchant: rel:view-paymentorder
                deactivate SwedbankPay
                Merchant -->> Payer: Display Payment Menu
            deactivate Merchant
            Payer ->> Payer: Initiate Payment Menu Hosted View (open iframe)
            SwedbankPay -->> Payer: Show Payment UI page in iframe
            activate SwedbankPay
                Payer ->> SwedbankPay: Pay
                opt consumer perform payment out of iframe
                    SwedbankPay ->> Merchant: POST Payment Callback
                    SwedbankPay -->> Payer: Redirect to Payment URL
                    Payer ->> Merchant: Prepare payment Menu
                    Payer ->> Payer: Initiate Payment Menu Hosted View (open iframe)
                    Payer ->> SwedbankPay: Show Payment UI page in iframe
                    SwedbankPay -->> Payer: Payment status
                    Payer ->> Merchant: Redirect to Payment Complete URL
                    activate Merchant
                        Merchant ->> SwedbankPay: GET /psp/paymentorders/<paymentOrderId>
                        activate SwedbankPay
                            SwedbankPay -->> Merchant: Payment Order status
                        deactivate SwedbankPay
                    deactivate Merchant
                end
                opt consumer performes payment within iframe
                    SwedbankPay ->> Merchant: POST Payment Callback
                    SwedbankPay -->> Payer: Payment status
                    Payer ->> Merchant: Redirect to Payment Complete URL
                    activate Merchant
                        Merchant ->> SwedbankPay: GET /psp/paymentorders/<paymentOrderId>
                        activate SwedbankPay
                            SwedbankPay -->> Merchant: Payment Order status
                        deactivate SwedbankPay
                    deactivate Merchant
                end
            deactivate SwedbankPay
        end
    deactivate Payer

    rect rgba(81,43,43,0.1)
        note left of Payer: Capture
        activate Merchant
            Merchant ->> SwedbankPay: GET /psp/paymentorders/<paymentOrderId>
            activate SwedbankPay
                SwedbankPay -->> Merchant: rel:create-paymentorder-capture
            deactivate SwedbankPay
            Merchant ->> SwedbankPay: POST /psp/paymentorders/<paymentOrderId>/captures
            activate SwedbankPay
                SwedbankPay -->> Merchant: Capture status
            deactivate SwedbankPay
            note right of Merchant: Capture here only if the purchased goods don't require shipping. If shipping is required, perform capture after the goods have shipped.
        deactivate Merchant
    end
```

### Payment Url

For our hosted views solution in Checkout (using
[Payment Order][payment-order]), we have a URL property called `paymentUrl`
that will be used if the consumer is redirected out of the hosted view
(the `iframe`). The consumer is redirected out of `iframe` when selecting
payment methods Vipps or in the 3D secure verification for credit card
payments.

The URL should represent the page of where the payment hosted view was hosted
originally, such as the checkout page, shopping cart page, or similar.
Basically, `paymentUrl` should be set to the same URL as that of the page
where the JavaScript for the hosted payment view was added to in order to
initiate the payment. Please note that the `paymentUrl` must be able to invoke
the same JavaScript URL from the same Payment or Payment Order as the one that
initiated the payment originally, so it should include some sort of state
identifier in the URL. The state identifier is the ID of the order, shopping
cart or similar that has the URL of the Payment or Payment Order stored.

If `paymentUrl` is not supplied, retry of payments will not be possible in
[Payment Order][payment-order], which makes it more tedious to retry payment
as the whole process including the creation of the payment order needs to
be performed again.

With `paymentUrl` in place, the retry process becomes much more convenient for
both the integration and the payer.

## Checkin

As mentioned, Swedbank Pay Checkout consists of two parts: **Checkin** and
**Payment Menu**. In the sections that follow you'll find examples of the
HTTP requests, responses and HTML code you will need to implement in order to
complete the Swedbank Pay Checkout integration. Before Checkout you have to
Checkin. Obviously! To check in, the payer needs to be identified.

### Checkin Back End

The payer will be identified with the `consumers` resource and will be
persisted to streamline future Payment Menu processes. Payer identification
is done through the `initiate-consumer-session` operation. In the request body,
all properties are optional. The more information that is provided, the easier
the identification process becomes for the payer.
[See the technical reference for details][initiate-consumer-session].

{:.code-header}
**Request**

```http
POST /psp/consumers HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "operation": "initiate-consumer-session",
    "msisdn": "+4798765432",
    "email": "olivia.nyhuus@example.com",
    "consumerCountryCode": "NO",
    "nationalIdentifier": {
        "socialSecurityNumber": "26026708248",
        "countryCode": "NO"
    }
}
```

{:.table .table-striped}
| ✔︎︎︎︎︎ | Property             | Type     |  Description |
|:-:|:----------------------|----------|:-------------|
| ✔︎︎︎︎︎ | `operation`          | `string` | `initiate-consumer-session`, the operation to perform.
|   | `msisdn`              | `string` | The [MSISDN][msisdn] (mobile phone number) of the payer. Format Sweden: `+46707777777`. Format Norway: `+4799999999`.
|   | `email`               | `string` | The e-mail address of the payer.
|   | `consumerCountryCode` | `string` | Consumers country of residence. Used by the consumerUi for validation on all input fields.
|   | `nationalIdentifier`  | `object` | The object containing information about the national identifier of the consumer.
|   | └➔ `socialSecurityNumber` | `string` | The social security number of the payer. Format: Norway `DDMMYYXXXXX`, Sweden: `YYYYMMDDXXXX`.
|   | └➔ `countryCode`          | `string` | The country code, denoting the origin of the issued social security number. Required if `nationalIdentifier.socialSecurityNumber` is set.

When the request has been sent, a response containing an array of operations that can be acted upon will be returned.

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "token": "7e380fbb3196ea76cc45814c1d99d59b66db918ce2131b61f585645eff364871",
    "operations": [
        {
            "rel": "view-consumer-identification",
            "method": "GET",
            "contentType": "application/javascript",
            "href": "https://ecom.externalintegration.payex.com/consumers/core/scripts/client/px.consumer.client.js?token=7e380fbb3196ea76cc45814c1d99d59b66db918ce2131b61f585645eff364871",
        }
    ]
}
```

{:.table .table-striped}
| Property             | Type     |  Description |
|:---------------------|----------|:-------------|
| `token`              | `string` | A session token used to initiate Checkout UI.
| `operations`         | `array`  | The array of operation objects to choose from, described in detail in the table below.

**`operations` Object Properties**

{:.table .table-striped}
| Property      | Type     |  Description |
|:--------------|----------|:-------------|
| `rel`         | `string` | The relational name of the operation, used as a programmatic identifier to find the correct operation given the current state of the application.
| `method`      | `string` | The HTTP method to use when performing the operation.
| `contentType` | `string` | The HTTP content type of the target URI. Indicates what sort of resource is to be found at the URI, how it is expected to be used and behave.
| `href`        | `string` | The target URI of the operation.

### Checkin Front End

The response from the `POST` of consumer information contains a few operations.
The combination of `rel`, `method` and `contentType` should give you a clue how
the operation should be performed. The `view-consumer-identification` operation
and its `application/javascript` content type gives us a clue that the
operation is meant to be embedded in a `<script>` element in an HTML document.
[See the technical reference for details][view-consumer-identification].

{:.code-header}
**HTML**

```html
<!DOCTYPE html>
<html>
    <head>
        <title>Swedbank Pay Checkout is Awesome!</title>
    </head>
    <body>
        <div id="checkin"></div>
        <div id="payment-menu"></div>
        <script src="https://ecom.externalintegration.payex.com/consumers/core/scripts/client/px.consumer.client.js?token=7e380fbb3196ea76cc45814c1d99d59b66db918ce2131b61f585645eff364871"></script>
        <script language="javascript">
            payex.hostedView.consumer({
                container: "checkin",
                onConsumerIdentified: function(consumerIdentifiedEvent) {
                    // consumerIdentifiedEvent.consumerProfileRef contains the reference
                    // to the identified consumer which we need to pass on to the
                    // Payment Order to initialize a personalized Payment Menu.
                    console.log(consumerIdentifiedEvent);
                },
                onShippingDetailsAvailable: function(shippingDetailsAvailableEvent) {
                    console.log(shippingDetailsAvailableEvent);
                }
            }).open();
        </script>
    </body>
</html>
```

Note that the `<script>` element is added after the `<div>` container the
Checkin will be hosted in. When this is set up, something along the
following should appear:


[[image:Consumer.PNG||alt="Consumer UI"]]

As you can see, the payer's information is pre-filled as provided by the
initial `POST`. When the payer completes the checkin, the events
`onConsumerIdentified` and `onShippingDetailsAvailable` will be raised with
the following argument objects:

{:.code-header}
**Consumer Identified Event Argument Object**

```json
{
    "actionType": "OnConsumerIdentified",
    "consumerProfileRef": "7d5788219e5bc43350e75ac633e0480ab30ad20f96797a12b96e54da869714c4"
}
```

{:.code-header}
**Shipping Details Available Event Argument Object**

```json
{
    "actionType": "OnShippingDetailsAvailable",
    "url": "https://api.externalintegration.payex.com/psp/consumers/<consumerProfileRef>/shipping-details"
}
```

With a `consumerProfileRef` safely tucked into our pocket, the Checkin is
complete and we can move on to checkout.

## Payment Menu

Payment Menu begins where checkin left off, in much the same way that the
checkin process progressed.

### Payment Menu Back End

We start by performing a `POST` request towards the `paymentorder` resource
with the `consumerProfileRef` we obtained in the checkin process described
above. [See the technical reference for details][payment-order].

{:.code-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "NOK",
        "amount": 15610,
        "vatAmount": 3122,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls": {
            "hostUrls": ["https://example.com", "https://example.net"],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "paymentUrl": "https://example.com/perform-payment",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditoons.pdf"
        },
        "payeeInfo": {
            "payeeId": "12345678-1234-1234-1234-123456789012",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference" : "or-123456"
        },
        "payer": {
            "consumerProfileRef": "7d5788219e5bc43350e75ac633e0480ab30ad20f96797a12b96e54da869714c4"
        },
        "orderItems": [
            {
                "reference": "P1",
                "name": "Product1",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "itemUrl": "https://example.com/products/123",
                "imageUrl": "https://example.com/product123.jpg",
                "description": "Product 1 description",
                "discountDescription": "Volume discount",
                "quantity": 4,
                "quantityUnit": "pcs",
                "unitPrice": 300,
                "discountPrice": 200,
                "vatPercent": 2500,
                "amount": 1000,
                "vatAmount": 250
            },
            {
                "reference": "P2",
                "name": "Product2",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "description": "Product 2 description",
                "quantity": 1,
                "quantityUnit": "pcs",
                "unitPrice": 500,
                "vatPercent": 2500,
                "amount": 500,
                "vatAmount": 125
            }
        ]
    }
}
```

{:.table .table-striped}
| ✔︎︎︎︎︎ | Property                     | Type         |  Description |
|:-:|:-----------------------------|--------------|:-------------|
| ✔︎︎︎︎︎ | `paymentorder`               | `object`     | The payment order object.
| ✔︎︎︎︎︎ | `operation`                  | `string`     | The operation that the payment order is supposed to perform.
| ✔︎︎︎︎︎ | └➔&nbsp;`currency`           | `string`      | The currency of the payment.
| ✔︎︎︎︎︎ | └➔&nbsp;`amount`             | `integer`     | The amount including VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.
| ✔︎︎︎︎︎ | └➔&nbsp;`vatAmount`          | `integer`     | The amount of VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.
| ✔︎︎︎︎︎ | └➔&nbsp;`description`        | `string`      | The description of the payment order.
| ✔︎︎︎︎︎ | └➔&nbsp;`userAgent`          | `string`      | The user agent of the payer.
| ✔︎︎︎︎︎ | └➔&nbsp;`language`           | `string`      | The language of the payer.
| ✔︎︎︎︎︎ | └➔&nbsp;`urls`               | `object`      | The `urls` object, containing the URLs relevant for the payment order.
| ✔︎︎︎︎︎ | └─➔&nbsp;`hostUrls`          | `array`       | The array of URIs valid for embedding of Swedbank Pay Hosted Views.
| ✔︎︎︎︎︎ | └─➔&nbsp;`completeUrl`       | `string`      | The URI to redirect the payer to once the payment is completed.
|   | └─➔&nbsp;`cancelUrl`         | `string`       | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only `cancelUrl` or `paymentUrl` can be used, not both.
|   | └─➔&nbsp;`paymentUrl`        | `string`       | The URI that Swedbank Pay will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted views. Can not be used simultaneously with `cancelUrl`; only `cancelUrl` or `paymentUrl` can be used, not both.
| ✔︎︎︎︎︎ | └─➔&nbsp;`callbackUrl`       | `string`       | The URI to the API endpoint receiving `POST` requests on transaction activity related to the payment order.
| ✔︎︎︎︎︎ | └─➔&nbsp;`termsOfServiceUrl` | `string`       | The URI to the terms of service document the payer must accept in order to complete the payment. Requires `https`.
| ✔︎︎︎︎︎ | └➔&nbsp;`payeeInfo`           | `string`      | The `payeeInfo` object, containing information about the payee.
| ✔︎︎︎︎︎ | └─➔&nbsp;`payeeId`           | `string`       | The ID of the payee, usually the merchant ID.
| ✔︎︎︎︎︎ | └─➔&nbsp;`payeeReference`    | `string(30)`   | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.
|   | └─➔&nbsp;`payeeName`           | `string`     | The name of the payee, usually the name of the merchant.
|   | └─➔&nbsp;`productCategory`     | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.
|   | └─➔&nbsp;`orderReference`      | `string(50)`  | The order reference should reflect the order reference found in the merchant's systems.
|   | └➔&nbsp;`payer`                | `object`      | The `payer` object containing information about the payer relevant for the payment order.
| ︎︎︎  | └─➔&nbsp;`consumerProfileRef`  | `string`      | The consumer profile reference as obtained through [initiating a consumer session][initiate-consumer-session].
|   | └➔&nbsp;`orderItems`           | `array`       | The array of items being purchased with the order. Used to print on invoices if the payer chooses to pay with invoice, among other things
| ✔︎︎︎︎︎ | └─➔&nbsp;`reference`           | `string`       | A reference that identifies the order item.
| ✔︎︎︎︎︎ | └─➔&nbsp;`name`                | `string`       | The name of the order item.
| ✔︎︎︎︎︎ | └─➔&nbsp;`type`                | `string`       | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item.
| ✔︎︎︎︎︎ | └─➔&nbsp;`class`               | `string`       | The classification of the order item. Can be used for assigning the order item to a specific product category, for instance. Swedbank Pay has no use for this value itself, but it's useful for some payment instruments and integrations.
| ︎︎︎  | └─➔&nbsp;`itemUrl`             | `string`       | The URL to a page that contains a human readable description of the order item, or similar.
| ︎︎︎  | └─➔&nbsp;`imageUrl`            | `string`       | The URL to an image of the order item.
| ︎︎︎  | └─➔&nbsp;`description`         | `string`       | The human readable description of the order item.
| ︎︎︎  | └─➔&nbsp;`discountDescription` | `string`       | The human readable description of the possible discount.
| ✔︎︎︎︎︎ | └─➔&nbsp;`quantity`            | `integer`      | The quantity of order items being purchased.
| ✔︎︎︎︎︎ | └─➔&nbsp;`quantityUnit`        | `string`       | The unit of the quantity, such as `pcs`, `grams`, or similar.
| ✔︎︎︎︎︎ | └─➔&nbsp;`unitPrice`           | `integer`      | The price per unit of order item.
| ︎︎︎  | └─➔&nbsp;`discountPrice`       | `integer`       | If the order item is purchased at a discounted price, this property should contain that price.
| ✔︎︎︎︎︎ | └─➔&nbsp;`vatPercent`          | `integer`      | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.
| ✔︎︎︎︎︎ | └─➔&nbsp;`amount`              | `integer`      | The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `500`0 equals `50.00 NOK`.
| ✔︎︎︎︎︎ | └─➔&nbsp;`vatAmount`           | `integer`      | The total amount of VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `500`0 equals `50.00 NOK`.

The response back should look something like this (abbreviated for brevity):

{:.code-header}
**Response**

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
    "paymentorder": {
      "id": "/psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4"
    },
    "operations": [
        {
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token=38540e86bd78e885fba2ef054ef9792512b1c9c5975cbd6fd450ef9aa15b1844&culture=nb-NO",
            "rel": "view-paymentorder",
            "method": "GET",
            "contentType": "application/javascript"
        }
    ]
}
```

{:.table .table-striped}
| Property       | Type     |  Description |
|:---------------|----------|:-------------|
| `paymentorder` | `object` | The payment order object.|
| └➔&nbsp;`id`   | `string` | The relative URI to the payment order.|
| `operations`   | `array`  | The array of possible operations to perform, given the state of the payment order.

The `paymentorder` object is abbreviated since it's just the `id` and
`operations` we are interested in. Store the `id` of the Payment Order
in your system to look up status on the completed payment later.

Then find the `view-paymentorder` operation and embed its `href` a `<script>`.
That script will then load the hosted view for the Payment Menu. We will look
into how to hook that up next.

### Payment Menu Front End

To load the payment menu from the JavaScript URL obtained in the back end API
response, it needs to be set as a `script` element's `src` attribute. You can
cause a page reload and do this with static HTML or you can avoid the page
refresh by invoking the POST to create the payment order through Ajax and then
create the script element with JavaScript, all inside the event handler for
`onConsumerIdentified`.
[See the technical reference for details][consumer-events].

You also can [customize the styling][payment-menu-styling] of the Payment Menu
by adding style properties to the JavaScript function call.

{:.code-header}
**HTML**

```html
<!DOCTYPE html>
<html>
    <head>
        <title>Swedbank Pay Checkout is Awesome!</title>
    </head>
    <body>
        <div id="checkin"></div>
        <div id="payment-menu"></div>
        <script src="https://ecom.externalintegration.payex.com/consumers/core/scripts/client/px.consumer.client.js?token=7e380fbb3196ea76cc45814c1d99d59b66db918ce2131b61f585645eff364871"></script>
        <script language="javascript">
                payex.hostedView.consumer({
                    container: 'checkin',
                    culture: 'nb-NO',
                    onConsumerIdentified: function(consumerIdentifiedEvent) {
                        // When the consumer is identified, we need to perform an AJAX request
                        // to our server to forward the consumerProfileRef in a server-to-server
                        // POST request to the Payment Orders resource in order to initialize
                        // the Payment Menu.
                        var request = new XMLHttpRequest();
                        request.addEventListener('load', function() {
                            response = JSON.parse(this.responseText);

                            var script = document.createElement('script');
                            // This assumses the operations from the response of the POST of the
                            // payment order is returned verbatim from the server to the Ajax:
                            var operation = response.operations.find(function(o) { o.rel === 'view-paymentorder' });
                            script.setAttribute('src', operation.href);
                            script.onload = function() {
                                // When the 'view-paymentorder' script is loaded, we can initialize the
                                // Payment Menu inside our 'payment-menu' container.
                                payex.hostedView.paymentMenu({
                                    container: 'payment-menu',
                                    culture: 'nb-NO'
                                }).open();
                            };
                            // Append the Payment Menu script to the <head>
                            var head = document.getElementsByTagName('head')[0];
                            head.appendChild(script);
                        });
                        // This example just performs the POST request of the Consumer Identified
                        // Event Argument to the same URL as the current one.
                        request.open('POST', window.location.href, true);
                        request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');
                        // In this example, we send the entire Consumer Identified Event Argument
                        // Object as JSON to the server, as it contains the consumerProfileRef.
                        request.send(JSON.stringify(consumerIdentifiedEvent));
                    }
                }).open();
        </script>
    </body>
</html>
```

This should bring up the Payment Menu in a hosted view, looking something like this:

[[image:1551693185782-957.png||width="458" height="629"]]

When the consumer completes the payment, the Payment Menu script will be
signaled and a full redirect to the `completeUrl` sent in with the
Payment Order will be performed. When the `completeUrl` on your server is hit,
you can inspect the status on the stored `paymentorder.id` on the server, and
perform capture – unless the goods are sent physically to the payer; then you
should await capture until after the goods have been sent.

You may open and close the payment menu using `.open()` and `.close()`
functions. You can also invoke `.refresh()` to
[update the Payment Menu][payment-order-operations] after any changes to the
order.

## Operations

When a payment order is created and especially after the payment is complete on
the consumer's end, you need to implement the relevant order management
operations in your order system. Most payment methods are two-phase payments –
in which a successful paymentorder will result in an authorized transaction –
that must be followed up by a capture or cancellation transaction in a later
stage. One-phase payments like Swish are settled directly without the option to
capture or cancel. For a full list of the available operations, see the
[techincal reference][payment-order-operations].

{:.table .table-striped}
| Operation                          | Description |
|:-----------------------------------|:------------|
| `update-paymentorder-updateorder`  | [Updates the order][#update-order] with a change in the `amount` and/or `vatAmount`.
| `create-paymentorder-capture`      | The second part of a two-phase transaction where the authorized amount is sent from the payer to the payee. It is possible to do a part-capture on a subset of the authorized amount. Several captures on the same payment are possible, up to the total authorization amount.
| `create-paymentorder-cancellation` | Used to cancel authorized and not yet captured transactions. If a cancellation is performed after doing a part-capture, it will only affect the not yet captured authorization amount.
| `create-paymentorder-reversal`     | Used to reverse a payment. It is only possible to reverse a payment that has been captured and not yet reversed.

To identify the operations that are available we need to do a `GET` request against the URL of `paymentorder.id`:

{:.code-header}
**Request**

```http
GET /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4 HTTP/1.1
Authorization: Bearer <MerchantToken>
```

The (abbreviated) response containing an `updateorder`, `capture`,
`cancellation`, and `reversal` operation should look similar to the response
below:

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentOrder": {
        "id": "/psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4",
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4",
            "rel": "update-paymentorder-updateorder",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/captures",
            "rel": "create-paymentorder-capture",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/cancellations",
            "rel": "create-paymentorder-cancellation",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/reversals",
            "rel": "create-paymentorder-reversal",
            "contentType": "application/json"
        }
    ]
}
```

{:.table .table-striped}
| Property       | Type     |  Description |
|:---------------|----------|:-------------|
| `paymentorder` | `object` | The payment order object.
| └➔&nbsp;`id`  | `string`  | The relative URI to the payment order.
| `operations`   | `array`  | The array of possible operations to perform, given the state of the payment order.

### Update Order

Change amount and vat amount on a payment order. If you implement `updateorder`
**you need to `refresh()`** the [Payment Menu front end][#payment-menu-front-end]
so the new amount is shown to the end customer.

{:.code-header}
**Request**

```http
PATCH /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4 HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "paymentorder": {
        "operation": "UpdateOrder",
        "amount": 2500,
        "vatAmount": 120
    }
}
```

**Response**

The response given when changing a payment order is equivalent to a `POST`
or `GET` request towards the `paymentorders` resource,
[as displayed above][#payment-menu-back-end]. Remember to call `.refresh()`
on the Payment Menu in JavaScript after updating the Payment Order.

### Capture

Capture can only be done on a payment with a successful authorized transaction.
It is possible to do a part-capture where you only capture a smaller amount
than the authorized amount. You can later do more captures on the same payment
up to the total authorization amount.

To capture the authorized payment, we need to perform
`create-paymentorder-capture` against the accompanying href returned in the
`operations` list. See the abbreviated request and response below:

{:.code-header}
**Request**

```http
POST /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/captures HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "transaction": {
        "description": "Capturing the authorized payment",
        "amount": 15610,
        "vatAmount": 3122,
        "payeeReference": "AB832"
        "orderItems": [
             {
                "reference": "P1",
                "name": "Product1",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "itemUrl": "https://www.example.com/shop/id=666",
                "imageUrl": "https://www.example.com/product1.jpg",
                "description": "Product 1 description",
                "discountDescription": "Volume discount",
                "quantity": 4,
                "quantityUnit": "pcs",
                "unitPrice": 300,
                "discountPrice": 200,
                "vatPercent": 2500,
                "amount": 1000,
                "vatAmount": 250
            },
            {
                "reference": "P2",
                "name": "Product2",
                "type": "SERVICE",
                "class": "ProductGroup1",
                "description": "Product 2 description",
                "quantity": 1,
                "quantityUnit": "pcs",
                "unitPrice": 500,
                "vatPercent": 2500,
                "amount": 500,
                "vatAmount": 125
            }
        ],
    }
}
```

{:.table .table-striped}
| ✔︎︎︎︎︎ | Property                     | Type         |  Description |
|:-:|:-----------------------------|--------------|:-------------|
| ✔︎︎︎︎︎ | `transaction`                | `object`     | The transaction object.
| ✔︎︎︎︎︎ | └➔&nbsp;`description`        | `string`     | The description of the capture transaction.
| ✔︎︎︎︎︎ | └➔&nbsp;`amount`             | `integer`    | The amount including VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.
| ✔︎︎︎︎︎ | └➔&nbsp;`vatAmount`          | `integer`    | The amount of VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.
| ✔︎︎︎︎︎ | └➔&nbsp;`payeeReference`     | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.
|   | └➔&nbsp;`orderItems`           | `array`       | The array of items being purchased with the order. Used to print on invoices if the payer chooses to pay with invoice, among other things. Optional in `capture` requests if already sent with the initial creation of the Payment Order.
| ✔︎︎︎︎︎ | └─➔&nbsp;`reference`           | `string`       | A reference that identifies the order item.
| ✔︎︎︎︎︎ | └─➔&nbsp;`name`                | `string`       | The name of the order item.
| ✔︎︎︎︎︎ | └─➔&nbsp;`type`                | `string`       | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item.
| ✔︎︎︎︎︎ | └─➔&nbsp;`class`               | `string`       | The classification of the order item. Can be used for assigning the order item to a specific product category, for instance. Swedbank Pay has no use for this value itself, but it's useful for some payment instruments and integrations.
| ︎︎︎  | └─➔&nbsp;`itemUrl`             | `string`       | The URL to a page that contains a human readable description of the order item, or similar.
| ︎︎︎  | └─➔&nbsp;`imageUrl`            | `string`       | The URL to an image of the order item.
| ︎︎︎  | └─➔&nbsp;`description`         | `string`       | The human readable description of the order item.
| ︎︎︎  | └─➔&nbsp;`discountDescription` | `string`       | The human readable description of the possible discount.
| ✔︎︎︎︎︎ | └─➔&nbsp;`quantity`            | `integer`      | The quantity of order items being purchased.
| ✔︎︎︎︎︎ | └─➔&nbsp;`quantityUnit`        | `string`       | The unit of the quantity, such as `pcs`, `grams`, or similar.
| ✔︎︎︎︎︎ | └─➔&nbsp;`unitPrice`           | `integer`      | The price per unit of order item.
| ︎︎︎  | └─➔&nbsp;`discountPrice`       | `integer`       | If the order item is purchased at a discounted price, this property should contain that price.
| ✔︎︎︎︎︎ | └─➔&nbsp;`vatPercent`          | `integer`      | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.
| ✔︎︎︎︎︎ | └─➔&nbsp;`amount`              | `integer`      | The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `500`0 equals `50.00 NOK`.
| ✔︎︎︎︎︎ | └─➔&nbsp;`vatAmount`           | `integer`      | The total amount of VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `500`0 equals `50.00 NOK`.

If the capture succeeds, it should respond with something like the following:

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251",
    "capture": {
        "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/captures/af43be30-8dfa-4458-2222-08d5df73b9f1",
        "transaction": {
            "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/transactions/af43be30-8dfa-4458-2222-08d5df73b9f1",
            "type": "Capture",
            "state": "Completed",
            "amount": 15610,
            "vatAmount": 3122,
            "description": "Capturing the authorized payment",
            "payeeReference": "AB832",
        }
    }
}
```

{:.table .table-striped}
| Property                  | Type      |  Description |
|:--------------------------|-----------|:-------------|
| `payment`                 | `string`  | The relative URI of the payment this capture transaction belongs to.
| `capture`                 | `object`  | The capture object, containing the information about the capture transaction.
| └➔&nbsp;`id`              | `string`  | The relative URI of the created capture transaction.
| └➔&nbsp;`transaction`     | `object`  | The transaction object, containing information about the current transaction.
| └─➔&nbsp;`id`             | `string`  | The relative URI of the current `transaction` resource.
| └─➔&nbsp;`created`        | `string`  | The ISO-8601 date and time of when the transaction was created.
| └─➔&nbsp;`updated`        | `string`  | The ISO-8601 date and time of when the transaction was created.
| └─➔&nbsp;`type`           | `string`  | Indicates the transaction type.
| └─➔&nbsp;`state`          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.
| └─➔&nbsp;`number`         | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead.
| └─➔&nbsp;`amount`         | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 SEK.
| └─➔&nbsp;`vatAmount`      | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.
| └─➔&nbsp;`description`    | `string`  | A human readable description of maximum 40 characters of the transaction.
| └─➔&nbsp;`payeeReference` | `string`  | A unique reference for the transaction. See [`payeeReference`][payee-reference] for details.

**Et voilà!** Checkout should now be complete, the payment should be secure and
everyone should be happy. But, sometimes you also need to implement the
cancellation and reversal operations described below.

### Cancel

If we want to cancel up to the total authorized (not captured) amount, we need
to perform `create-paymentorder-cancel` against the accompanying href returned
in the `operations` list. See the abbreviated request and response below:

{:.code-header}
**Request**

```http
POST /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/cancellations HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "transaction": {
        "payeeReference": "ABC123",
        "description": "Cancelling parts of the total amount"
    }
}
```

{:.table .table-striped}
| ✔︎︎︎︎︎ | Property                     | Type         |  Description |
|:-:|:-----------------------------|--------------|:-------------|
| ✔︎︎︎︎︎ | `transaction`                | `object`     | The transaction object.
| ✔︎︎︎︎︎ | └➔&nbsp;`payeeReference`     | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.
| ✔︎︎︎︎︎ | └➔&nbsp;`description`        | `string`     | A textual description of why the transaction is cancelled.

If the cancellation request succeeds, the response should be similar to the
example below:

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251",
    "cancellation": {
        "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/cancellations/af43be30-8dfa-4458-2222-08d5df73b9f1",
        "transaction": {
            "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/transactions/af43be30-8dfa-4458-2222-08d5df73b9f1",
            "type": "Cancel",
            "state": "Completed",
            "amount": 5610,
            "vatAmount": 1122,
            "description": "Cancelling parts of the authorized payment",
            "payeeReference": "AB832",
        }
    }
}
```

{:.table .table-striped}
| Property              | Type     |  Description |
|:----------------------|----------|:-------------|
| `payment`             | `string` | The relative URI of the payment this cancellation transaction belongs to.
| `cancellation`        | `object` | The cancellation object, containing information about the cancellation transaction.
| └➔&nbsp;`id`          | `string` | The relative URI of the cancellation transaction.
| └➔&nbsp;`transaction`     | `object`  | The transaction object, containing information about the current transaction.
| └─➔&nbsp;`id`             | `string`  | The relative URI of the current `transaction` resource.
| └─➔&nbsp;`created`        | `string`  | The ISO-8601 date and time of when the transaction was created.
| └─➔&nbsp;`updated`        | `string`  | The ISO-8601 date and time of when the transaction was created.
| └─➔&nbsp;`type`           | `string`  | Indicates the transaction type.
| └─➔&nbsp;`state`          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.
| └─➔&nbsp;`number`         | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead.
| └─➔&nbsp;`amount`         | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 SEK.
| └─➔&nbsp;`vatAmount`      | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.
| └─➔&nbsp;`description`    | `string`  | A human readable description of maximum 40 characters of the transaction.
| └─➔&nbsp;`payeeReference` | `string`  | A unique reference for the transaction. See [`payeeReference`][payee-reference] for details.

### Reversal

If we want to reverse a previously captured amount, we need to perform
`create-paymentorder-reversal` against the accompanying href returned in the
`operations` list. See the abbreviated request and response below:

{:.code-header}
**Request**

```http
POST /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/reversals HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "transaction": {
        "amount": 15610,
        "vatAmount": 3122,
        "payeeReference": "ABC123",
        "description": "description for transaction"
    }
}
```

{:.table .table-striped}
| ✔︎︎︎︎︎ | Property                     | Type         |  Description |
|:-:|:-----------------------------|--------------|:-------------|
| ✔︎︎︎︎︎ | `transaction`                | `object`     | The transaction object.
| ✔︎︎︎︎︎ | └➔&nbsp;`amount`             | `integer`    | The amount including VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.
| ✔︎︎︎︎︎ | └➔&nbsp;`vatAmount`          | `integer`    | The amount of VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.
| ✔︎︎︎︎︎ | └➔&nbsp;`payeeReference`     | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.
| ✔︎︎︎︎︎ | └➔&nbsp;`description`        | `string`     | Textual description of why the transaction is reversed.

If the reversal request succeeds, the response should be similar to the example below:

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251",
    "reversals": {
        "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/cancellations/af43be30-8dfa-4458-2222-08d5df73b9f1",
        "transaction": {
            "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/transactions/af43be30-8dfa-4458-2222-08d5df73b9f1",
            "type": "Reversal",
            "state": "Completed",
            "amount": 5610,
            "vatAmount": 1122,
            "description": "Reversing the capture amount",
            "payeeReference": "ABC987",
        }
    }
}
```

{:.table .table-striped}
| Property                  | Type     |  Description |
|:--------------------------|----------|:-------------|
| `payment`                 | `string` | The relative URI of the payment this reversal transaction belongs to.
| `reversals`               | `object` | The reversal object, containing information about the reversal transaction.
| └➔&nbsp;`id`              | `string` | The relative URI of the reversal transaction.
| └➔&nbsp;`transaction`     | `object`  | The transaction object, containing information about the current transaction.
| └─➔&nbsp;`id`             | `string`  | The relative URI of the current `transaction` resource.
| └─➔&nbsp;`created`        | `string`  | The ISO-8601 date and time of when the transaction was created.
| └─➔&nbsp;`updated`        | `string`  | The ISO-8601 date and time of when the transaction was created.
| └─➔&nbsp;`type`           | `string`  | Indicates the transaction type.
| └─➔&nbsp;`state`          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.
| └─➔&nbsp;`number`         | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead.
| └─➔&nbsp;`amount`         | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 SEK.
| └─➔&nbsp;`vatAmount`      | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.
| └─➔&nbsp;`description`    | `string`  | A human readable description of maximum 40 characters of the transaction.
| └─➔&nbsp;`payeeReference` | `string`  | A unique reference for the transaction. See [`payeeReference`][payee-reference] for details.


## Best Practices

A completed integration against Swedbank Pay Checkout standard setup should
adhere to a set of best practice criteria in order to successfully go
through Swedbank Pay' integration validation procedure.

### Must Haves

* The Checkin and Payment Menu components (the two `<iframe>` elements) must be
  separate (one must not replace the other).
* The Checkin must be completed before any shipping details are finalized, as
  the Checkin component provides shipping address via the
  `onShippingDetailsAvailable` event.
* A button in the webshop or merchant web site needs to exist that allows the
  user to not perform Checkin ("Shop anonymously"). See
  [guest payments][guest-payments] for details.
* If a browser refresh is performed after the payer has checked in, the payment
  menu must be shown even though `onConsumerIdentified` is not invoked.
* The `consumerProfileRef` returned in the response from the `POST` request to
  the `consumers` resource must be included in the `POST` request to the
  `paymentorders` resource.
* When the contents of the shopping cart changes or anything else that affects
  the amount occurs, the `paymentorder` must be updated and the Payment Menu
  must be `refresh`ed.
* Features not described on this page must not be used, although they are
  available in the API. Flags that can be turned to `true` must be kept
  `false` as described in this standard setup documentation.
* When the payer is checked in, he or she must be identified appropriately in
  the Payment Menu (stored credit cards must be visible for the credit card
  payment instrument, for instance).
* `orderReference` must be sent as a part of the `POST` request to
  `paymentorders` and must represent the order ID of the webshop or merchant
  website.
* The integration needs to handle both one and two phase purchases correctly.
* All of the operations `Cancel`, `Capture` and `Reversal` must be implemented.
* The [transaction callback][callback must be handled appropriately.
* [Proplems][/#problems] that may occur in Swedbank Pay' API must be handled
  appropriately.
* Your integration must be resilient to change. Properties, operations,
  headers, etc., that aren't understood in any response **must be ignored**.
  Failing due to a something occurring in a response that your implementation
  haven't seen before is a major malfunction of your integration and must be
  fixed.

  [https]: /#connection-and-protocol
  [payment-order]: #
  [initiate-consumer-session]: #
  [view-consumer-identification]: #
  [msisdn]: https://en.wikipedia.org/wiki/MSISDN
  [payee-reference]: #
  [consumer-events]: #
  [payment-menu-styling]: #
  [payment-order-operations]: #
  [transactions]: #
  [guest-payments]: #
  [callback]: #
