---
title: Swedbank Pay Checkout Payment
sidebar:
  navigation:
  - title: Checkout
    items:
    - url: /checkout/
      title: Introduction
    - url: /checkout/payment
      title: Payment
    - url: /checkout/after-payment
      title: After Payment
    - url: /checkout/other-features
      title: Other Features
---

{% include alert.html type="warning"
                      icon="warning"
                      header="Site under development"
                      body="The Developer Portal is under construction and should not be used to integrate against Swedbank Pay's APIs yet." %}

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
most properties are optional. However, the more information that is provided,
the easier the identification process becomes for the payer.
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
| ✔︎︎︎︎︎ | **Property**             | **Type**     |  **Description** |
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
| **Property**             | **Type**     |  **Description** |
| `token`              | `string` | A session token used to initiate Checkout UI.
| `operations`         | `array`  | The array of operation objects to choose from, described in detail in the table below.
| └➔&nbsp;`rel`             | `string`     | The relational name of the operation, used as a programmatic identifier to find the correct operation given the current state of the application.
| └➔&nbsp;`method`             | `string`     | The HTTP method to use when performing the operation.
| └➔&nbsp;`contentType`             | `string`     | The HTTP content type of the target URI. Indicates what sort of resource is to be found at the URI, how it is expected to be used and behave.
| └➔&nbsp;`href`             | `string`     | The target URI of the operation.

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


![Consumer UI][consumer-image]

As you can see, the payer's information is pre-filled as provided by the
initial `POST`. When the payer completes the checkin, the events
`onConsumerIdentified` and `onShippingDetailsAvailable` will be raised with
the following argument objects:

{:.code-header}
**Consumer Identified Event Argument Object**

```JS
{
    "actionType": "OnConsumerIdentified",
    "consumerProfileRef": "7d5788219e5bc43350e75ac633e0480ab30ad20f96797a12b96e54da869714c4"
}
```

{:.code-header}
**Shipping Details Available Event Argument Object**

```JS
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
above. 
**Notice** that the `orderItems`property object is optional. If the `POST` request has `orderItems` in the `paymentorder`, remember to include `orderItems` in the [capture operation][capture-operation].
[See the technical reference for more details][payment-order].

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
        "generateRecurrenceToken": true
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
            "payeeReference": "AB832",
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
        ],
        "riskIndicator" : {
            "deliveryEmailAddress" : "string",              
            "deliveryTimeFrameindicator" : "01",   
            "preOrderDate" : "YYYYMMDD",                    
            "preOrderPurchaseIndicator" : "01",          
            "shipIndicator" : "01",        
            "giftCardPurchase" : "false",               
            "reOrderPurchaseIndicator" : "01",           
            "pickUpAddress" : {                            
                "name" : "companyname",                    
                "streetAddress" : "string",                 
                "coAddress" : "string",                   
                "city" : "string",
                "zipCode" : "string",
                "countryCode" : "string"
            }
        },
    }
}
```

{:.table .table-striped}
| ✔︎︎︎︎︎ | **Property**                     | **Type**         |  **Description** |
| ✔︎︎︎︎︎ | `paymentorder`               | `object`     | The payment order object.
| ✔︎︎︎︎︎ | `operation`                  | `string`     | The operation that the payment order is supposed to perform.
| ✔︎︎︎︎︎ | └➔&nbsp;`currency`           | `string`      | The currency of the payment.
| ✔︎︎︎︎︎ | └➔&nbsp;`amount`             | `integer`     | The amount including VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.
| ✔︎︎︎︎︎ | └➔&nbsp;`vatAmount`          | `integer`     | The amount of VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.
| ✔︎︎︎︎︎ | └➔&nbsp;`description`        | `string`      | The description of the payment order.
| ✔︎︎︎︎︎ | └➔&nbsp;`userAgent`          | `string`      | The user agent of the payer.
| ✔︎︎︎︎︎ | └➔&nbsp;`language`           | `string`      | The language of the payer.
| ✔︎︎︎︎︎ | └➔&nbsp;`generateRecurrenceToken`           | `string`      | Token for recurring payments.
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
|   | └➔&nbsp;`riskIndicator`           | `array`       | This **optional** array consist of information that helps verifying the payer. 
|  | └─➔&nbsp;`deliveryEmailAdress`           | `string`      | For electronic delivery, the email address to which the merchandise was delivered.
|  | └─➔&nbsp;`deliveryTimeFrameIndicator`           | `string`      | Indicates the merchandise delivery timeframe. <br>01 (Electronic Delivery) <br>02 (Same day shipping) <br>03 (Overnight shipping) <br>04 (Two-day or more shipping)
|  | └─➔&nbsp;`preOrderDate`           | `string`      | For a pre-ordered purchase. The expected date that the merchandise will be available. <br>FORMAT: "YYYYMMDD"
|  | └─➔&nbsp;`preOrderPurchaseIndicator`           | `string`      | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date. <br>01 (Merchandise available) <br>02 (Future availability)
|  | └─➔&nbsp;`shipIndicator`           | `string`      | Indicates shipping method chosen for the transaction. <br> 01 (Ship to cardholder's billing address) <br>02 (Ship to another verified address on file with merchant)<br>03 (Ship to address that is different than cardholder's billing address)<br> 04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)<br> 05 (Digital goods, includes online services, electronic giftcards and redemption codes) <br>06 (Travel and Event tickets, not shipped) <br>07 (Other, e.g. gaming, digital service)
|  | └─➔&nbsp;`giftCardPurchase`           | `boolean`      | true if this is a purchase of a gift card.
|  | └─➔&nbsp;`reOrderPurchaseIndicator`           | `string`      | Indicates whether Cardholder is placing an order for merchandise with a future availability or release date. <br>01 (Merchandise available) <br>02 (Future availability)
|  | └➔&nbsp;`pickUpAddress`           | `object`      | If shipIndicator set to 4, then prefil this.
|  | └─➔&nbsp;`name`           | `string`      | If shipIndicator set to 4, then prefil this.
|  | └─➔&nbsp;`streetAddress`           | `string`      | If shipIndicator set to 4, then prefil this.
|  | └─➔&nbsp;`coAddress`           | `string`      | If shipIndicator set to 4, then prefil this.
|  | └─➔&nbsp;`city`           | `string`      | If shipIndicator set to 4, then prefil this.
|  | └─➔&nbsp;`zipCode`           | `string`      | If shipIndicator set to 4, then prefil this.
|  | └─➔&nbsp;`countryCode`           | `string`      | If shipIndicator set to 4, then prefil this.


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
| **Property**       | **Type**     |  **Description** |
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

![1551693185782-957.png]

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


[1551693185782-957.png]: /assets/img/1551693185782-957.png
{:width="458px" :height="629px"}
[consumer-image]: /assets/img/Consumer.PNG

[payment-order]: #
[initiate-consumer-session]: #
[view-consumer-identification]: #
[capture-operation]: /checkout/after-payment/#capture
[msisdn]: https://en.wikipedia.org/wiki/MSISDN
[payee-reference]: #
[consumer-events]: #
[payment-order-operations]: #

