---
title: Swedbank Pay Checkout Other Features
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

{% include settlement-reconciliation.md %}

{% include payment-link.md %}

{% include one-click-payments.md %}

{% include recurring-card-payments.md %}

## Payment order

#### Purchase Payment Orders

The `Purchase` operation is used in all common purchase scenarios. 

{:.code-header}
**Purchase**
```js
{    
    "paymentorder": {
        "operation": "Purchase"
    {
}
```

#### Verify Payment Orders

The `Verify` operation lets you post verifications to confirm the validity of **credit card information**, without reserving or charging any amount. This option is mainly used to initiate a recurring payment scenario where the card will be charged at a later date. The request body is equivalent to a `Purchase` order with credit card as the selected item. A [payment token][payment-orders-resource] will be generated automatically, rendering the parameter `generateRecurrenceToken` unnecessary for this operation. 

{:.code-header}
**Verify**

```js
{    
    "paymentorder": {
        "operation": "Verify"
    {
}
```

#### Enabling recurring credit card payments

If you want to enable subsequent recurring - server-to-server - payments for credit card, you need to create a recurrence token. This token will be utilized after the initial payment order.  


**Recurrence Token**

* When initiating a `Purchase` payment order, you need to make sure that the attribute `generateRecurrenceToken` is set to `true`. This recurrence token will stored in the[ authorization transaction][authorization-transaction] sub-resource on the underlying credit card payment resource.
* When initiating a `Verify` payment order, a recurrence token will be generated automatically. This recurrence token is stored in the [verification][verification-transaction]  sub-resource on the underlying credit card payment resource.

You can view the current payment resource, containg the recurrence token and other payment instrument properties, by [expanding][expanding the sub-resource [`currentpayment`][current-payment] when doing a `GET` `request` on the `paymentorders`resource.

{:.code-header}
**Request**

```http
GET /psp/paymentorders/<paymentorderId>?$expand=currentpayment HTTP/1.1
Host: api.payex.com
```

#### Creating recurring credit card payments

When you have a `recurrenceToken` token safely tucked away, you can use this token in a subsequent `Recur` payment order. This will be a server-to-server affair, as we have tied all necessary payment instrument details related to the recurrence token during the initial payment order.

{:.code-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Recur",
    "recurrenceToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
    "currency": "SEK",
    "amount": 1000,
    "vatAmount": 250,
    "description": "Test Purchase",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "urls": {
      "callbackUrl": "https://example.com/callback"
    },
    "payeeInfo": {
      "payeeId": "12345678-1234-1234-1234-123456789012",
      "payeeReference": "CD1234",
      "payeeName": "Merchant1",
      "productCategory": "A123",
      "orderReference": "or-12456",
      "subsite": "Subsite1"
    },
    "orderItems": [
      {
        "reference": "P1",
        "name": "Product1",
        "type": "PRODUCT",
        "class": "ProductGroup1",
        "itemUrl": "https://example.com/shop/id=123",
        "imageUrl": "https://example.com/product1.jpg",
        "description": "Product 1 description",
        "discountDescription": "Volume discount",
        "quantity": 4,
        "quantityUnit": "pcs",
        "unitPrice": 300,
        "discountPrice": 200,
        "vatPercent": 2500,
        "amount": 1000,
        "vatAmount": 250
      }
    ],
    "metadata": {
      "key1": "value1",
      "key2": 2,
      "key3": 3.1,
      "key4": false
    }
  }
}
```

#### Disable payment menu when only one instrument exist

{:.code-header}
**Request**

```js
{    
    "paymentorder": {
        "disablePaymentMenu": true
    {
}
```

##### example disablePaymentMenu = true

![example disablePaymentMenu = true][image_disabled_payment_menu]{:width="463" :height="553"}

##### example disablePaymentMenu = false
![example disablePaymentMenu = false][image_enabled_payment_menu]{:width="464" :height="607"}


## Sub-resources

The `paymentOrders` resource utilize several sub-resources, relating to underlying [payments][payment-orders-resource-payments], [the current payment active][current-payment], [payers][payment-orders-resource-payers] and [URLs][payment-resource-urls].  
Common sub-resources like [payeeinfo][payment-resource-payeeinfo], that are structurally identical for both payments and payments orders, are described in the [Payment Resources][payment-resource] section. 

### Payments Resource

A payment order is able to hold more than one payment object, _even though a successful payment order only harbour one successful payment_. This is necessary as the consumer might select and initate a payment option that is not followed through successfully. I.e. if the consumer cancels an invoice payment, a cancel transaction will still be tied to that particular invoice payment resource. This payment resource will continue to exist, even if the consumer successfully should finish the purchase with a credit card payment instead.

{:.code-header}
**Request**

```http
GET /psp/paymentorders<paymentorderId>/payments HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "payments": {
        "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments",
        "paymentList" : [
            {
                "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
                "instrument" : "CreditCard",
                "Created": "2016-09-14T13:21:29.3182115Z"
            },
            {   
                "id": "/psp/invoice/payments/5adc265f-f87f-4313-577e-08d3dca1a26d",
                "instrument" : "Invoice",
                "Created": "2016-09-14T13:21:29.3182115Z"
            }
        ]
    }
}
```

{:.table .table-striped}
| **Property** | **Type** | **Description**
| *paymentorder* | object | The payment order object.
|payments.id | string | The relative URI of the current `payments` resource.
|payments.paymentList | string |The array of payment objects.
|payments.paymentList[] | string | The payment object.

### Current Payment Resource

The `currentpayment` resource displays the payment that are active within the payment order container.

{:.code-header}
**Request**

```http
GET /psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/currentpayment HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "menuElementName": "creditcard",
    "payment": {
        "recurrenceToken": "5adc265f-f87f-4313-577e-08d3dca1a26c",
        "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
        "number": 1234567890,
        "instrument": "CreditCard",
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "operation": "Purchase|Verify|Recur",
        "intent": "Authorization",
        "state": "Ready|Pending|Failed|Aborted",
        "currency": "NOK|SEK|...",
        "amount": 1500,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "prices": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/prices" },
        "transactions": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions" },
        "authorizations": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/authorizations" },
        "captures": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/captures" },
        "cancellations": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/cancellations" },
        "reversals": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals" },
        "verifications": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/verifications" },
        "urls" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
        "payeeInfo" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
        "metadata" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/metadata" },
        "settings": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" }
    },
    "operations": []
}
```

{:.table .table-striped}
| **Property** | **Type** | **Description**
| paymentorder | object | The payment order object.
| paymentorder.menuElementName | string | `creditcard`, `invoice`, etc. The name of the selected menu element.
| paymentorder.payment | object | The payment object.
| payment.recurrenceToken | string | The created recurrenceToken, if `operation : Verify` or `generateRecurrenceToken : true` was used.
| payment.id | string | The relative URI to the payment.
| payment.number | integer | The payment `number`, useful when there's need to reference the payment in human communication. Not usable for programmatic identification of the payment, for that `id` should be used instead.
| payment.instrument | string | The payment instrument used.
| payment.created | string | The ISO-8601 date of when the payment was created.
| payment.updated | string | The ISO-8601 date of when the payment was updated.
| payment.operation | string | `Purchase`, `payout`, `Verify` or `recur. `The type of the initiated payment.
| payment.intent | string | The intent of the payment.
| payment.state | string | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment. This field is only for status display purposes.
| payment.currency | string | The currency of the payment.
| payment.prices.amount | integer | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 NOK`, `5000` = `50.00 SEK`.
| payment.prices.remainingCaptureAmount | integer | The available amount to capture.
| payment.prices.remainingCancelAmount | integer | The available amount to cancel.
| payment.prices.remainingReversalAmount | integer | The available amount to reverse.
| payment.description | string(40) | A textual description of maximum 40 characters of the purchase.
| payment.payerReference | string | The reference to the consumer from the merchant system, like mobile number, customer number etc.
| payment.userAgent | string | The [user agent] string of the consumer's browser.
| payment.language | string | `nb-NO`, `sv-SE` or `en-US`

### URLs Resource

The `urls` resource contains the URIs related to a payment order, including where the consumer gets redirected when going forward with or cancelling a payment session, as well as the callback URI that is used to inform the payee (merchant) of changes or updates made to underlying payments or transaction.

{:.code-header}
Request

```http
GET /psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls/ HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json
```

{:.code-header}
Response

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": "/psp/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "urls": {
        "id": "/psp/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls",
        "hostUrls": [ "http://test-dummy.net", "http://test-dummy2.net" ],
        "completeUrl": "http://example.com/payment-complete",
        "cancelUrl": "http://example.com/payment-canceled",
        "paymentUrl": "http://example.com/perform-payment",
        "callbackUrl": "http://api.example.com/payment-callback",
        "logoUrl": "http://merchant.com/path/to/logo.png",
        "termsOfServiceUrl": "http://merchant.com/path/to/tems"
    }
}
```

{:.table .table-striped}
| **Property** | **Data Type** | **Description**
| paymentorder | string | The URI to the payment order the resource belong to.
| paymentorder.urls.id | string | The relative URI to the current resource.
| paymentorder.urls.hostsUrl | string | An array of the whitelisted URIs that are allowed as parents to a Hosted View, typically the URI of the web shop or similar that will embed a Hosted View within it.
| paymentorder.urls.completeUrl | string | The URI that PayEx will redirect back to when the payment page is completed.
| paymentorder.urls.cancelUrl | string | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. If both cancelUrl and paymentUrl is sent, the paymentUrl will used.
| paymentorder.urls.paymentUrl | string | The URI that PayEx will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. Only used in hosted views. If both cancelUrl and paymentUrl is sent, the paymentUrl will used.
| paymentorder.urls.callbackUrl | string | The URI that PayEx will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][callback-reference] for details.
| paymentorder.urls.logoUrl | string | The URI that will be used for showing the customer logo. Must be a picture with at most 50px height and 400px width.
| paymentorder.urls.termsOfServiceUrl | string | A URI that contains your terms and conditions for the payment, to be linked on the payment page.

### Payer Resource

The `payer` resource contains payer information related to the payment order.
The information is retrieved via a consumer profile token
(`consumerProfileRef`), from the [Consumers resource][consumer-reference]
during login/checkin.

{:.code-header}
**Request**

```http
GET /psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers/ HTTP/1.1
Host: api.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "payer" : {
        "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payer",
        "reference": "reference to payer",                
        "email": "email",                                
        "msisdn": "msisdn",                              
        "shippingAddress": {                             
            "addressee": "firstName + lastName",
            "coAddress": "coAddress",
            "streetAddress": "streetAddress",
            "zipCode": "zipCode",
            "city": "city",
            "countryCode": "countryCode"
        }
    }
}
```

{:.table .table-striped}
| **Property** | **Data Type** | **Description**
| paymentorder | string | The URI to the payment order the payer object belongs to.
| payer | object | The payer object.
| payer.id | string | The relative URI to the current `payer` resource.
| payer.email | string | Payer's registered email address.
| payer.msisdn | string | Payer'registered mobile phone number.
| payer.shippingAdress.addresse | object | The shipping address object related to the payer.
| payer.shippingAdress.coAddress | string | Payer' s C/o address, if applicable. 
| payer.shippingAdress.streetAddress | string | Payer's street address
| payer.shippingAdress.zipCode | string | Payer's zip code
| payer.shippingAdress.city | string | Payer's city of residence
| payer.shippingAdress.countryCode | string | Country Code for country of residence.

### Payment Menu Events

During operation in the Payment Menu, several events can occur. They are described below.

#### On Payment Menu Instrument Selected

This event triggers when a user actively changes payment instrument in the Payment Menu. The `onPaymentMenuInstrumentSelected` event is raised with the following event argument object: 

{:.code-header}
**On Payment Menu Instrument Selected**

```js
{
    "name": "menu identifier",
    "instrument": "creditcard | vipps | swish | invoice",
}
```

{:.table .table-striped}
| **Property** | **Type** | **Description**
| name | string | The name and identifier of specific instrument instances - i.e. if you deploy more than one type of credit card payments, they would be distinguished by `name`.
| instrument | string | `Creditcard`, `vipps`, `swish`, `invoice`. The instrument selected by the user.

#### On Payment created

This event triggers when a user has selected a payment instrument and actively attempts to perform a payment. The `onPaymentCreate` event is raised with the following event argument object: 

{:.code-header}
On Payment Created

```js
{
    "id": "/psp/creditcard/payments/653b1f5d-8e6c-4cce-d42d-08d58e414c69",
    "instrument": "creditcard | vipps | swish | invoice",
}
```

{:.table .table-striped}
| **Property** | **Type** | **Description**
| id | string | The relative URI to the payment.
| instrument | string | `Creditcard`, `vipps`, `swish`, `invoice`. The instrument selected when initiating the payment.

#### On Payment Completed

This event triggers when a payment has completed successfully. The `onPaymentCompleted` event is raised with the following event argument object:

{:.code-header}
On Payment Completed

```js
{
    "id": "/psp/creditcard/payments/653b1f5d-8e6c-4cce-d42d-08d58e414c69",
    "redirectUrl": "https://en.wikipedia.org/wiki/Success"
}
```

{:.table .table-striped}
| **Property** | **Type** | **Description**
| id | string | The relative URI to the payment.
| redirectUrl | string | The URI the user will be redirect to after a completed payment.  

#### On Payment Canceled

This event triggers when the user cancels the payment. The `onPaymentCanceled` event is raised with the following event argument object:

{:.code-header}
**On Payment Canceled**

```js
{
    "id": "/psp/creditcard/payments/653b1f5d-8e6c-4cce-d42d-08d58e414c69",
    "redirectUrl": "https://en.wikipedia.org/wiki/Canceled"
}
```

{:.table .table-striped}
| **Property** | **Type** | **Description**
| id | string | The relative URI to the payment.
| redirectUrl | string | The URI the user will be redirect to after a canceled payment.  

#### On Payment Failed

This event triggers when a payment has failed, disabling further attempts to perform a payment. The `onPaymentFailed` event is raised with the following event argument object:

{:.code-header}
**On Payment Failed**

```js
{
    "id": "/psp/creditcard/payments/653b1f5d-8e6c-4cce-d42d-08d58e414c69",
    "redirectUrl": "https://en.wikipedia.org/wiki/Failed"
}
```

{:.table .table-striped}
| **Property** | **Type** | **Description**
| id | string | The relative URI to the payment.
| redirectUrl | string | The URI the user will be redirect to after a failed payment.

#### On Payment Terms of Service

This event triggers when the user clicks on the "Display terms and conditions" link. The `Y | ` event is raised with the following event argument object:

{:.code-header}
**On Payment Terms of Service**
```js
{
    "origin": "owner | merchant",
    "OpenUrl": "https://example.org/terms.html"
}
```

{:.table .table-striped}
| **Property** | **Type** | **Description**
| origin | string | `owner`, `merchant`. The value is always `merchant` unless PayEx hosts the view. 
| OpenUrl | string | The URI containing Terms of Service and conditions.

### On Error

This event triggers during terminal errors or if the configuration fails validation. The `onError` event will be raised with the following event argument object:

{:.code-header}
On Error
```js
{
    "origin": "consumer | paymentmenu | creditcard | invoice | ...",
    "messageId": "<unique message ID>",
    "details": "Descriptive text of the error"
}
```


{:.table .table-striped}
| **Property** | **Type** | **Description**
| origin | string | `consumer`, `paymentmenu`, `creditcard`, identifies the system that originated the error.
| messageId | string | A unique identifier for the message.
| details | string | A human readable and descriptive text of the error.

## Operations

When a payment order resource is created and during its lifetime, it will have a set of operations that can be performed on it. The state of the payment order resource, what the access token is authorized to do, the chosen payment instrument and its transactional states, etc. determine the available operations before the initial purchase. A list of possible operations and their explanation is given below.

{:.code-header}
**Operations**

```js
{
    "paymentOrder": {
        "id": "/psp/paymentorders/8bf85423-841d-4fb8-d754-08d6d398f0c5",
    }
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/8bf85423-841d-4fb8-d754-08d6d398f0c5",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/8bf85423-841d-4fb8-d754-08d6d398f0c5",
            "rel": "update-paymentorder-updateorder",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/eb6932c2e24113377ecd88da343a10566b31f59265c665203b1287277224ef60",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token=eb6932c2e24113377ecd88da343a10566b31f59265c665203b1287277224ef60&culture=nb-NO",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
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
            "rel": "create-paymentorder-cancel",
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
| **Property** | **Description**
| href | The target URI to perform the operation against.
| rel | The name of the relation the operation has to the current resource.
| method | The HTTP method to use when performing the operation.
| contentType | The HTTP content type of the resource referenced in the `href` property.

The operations should be performed as described in each response and not as described here in the documentation. Always use the `href` and `method` as specified in the response by finding the appropriate operation based on its `rel` value. The only thing that should be hard coded in the client is the value of the `rel` and the request that will be sent in the HTTP body of the request for the given operation.

**Operations**

{:.table .table-striped}
| **Operation** | **Description**
| update-paymentorder-abort | [Aborts][abort] the payment order before any financial transactions are performed.
| update-paymentorder-updateorder | [Updates the order][update-order] with a change in the `amount` and/or `vatAmount`.
| redirect-paymentorder | Contains the URI that is used to redirect the consumer to the PayEx Payment Pages containing the Payment Menu.
| view-paymentorder | Contains the JavaScript `href` that is used to embed the Payment Menu UI directly on the webshop/merchant site.
| create-paymentorder-capture | The second part of a two-phase transaction where the authorized amount is sent from the payer to the payee. It is possible to do a part-capture on a subset of the authorized amount. Several captures on the same payment are possible, up to the total authorization amount.
| create-paymentorder-cancellation | Used to cancel authorized and not yet captured transactions. If a cancellation is performed after doing a part-capture, it will only affect the not yet captured authorization amount.
| create-paymentorder-reversal | Used to reverse a payment. It is only possible to reverse a payment that has been captured and not yet reversed.

### View Payment Order

The `view-paymentorder` operation contains the URI of the JavaScript that needs to be set as a `script` element's `src` attribute, either client-side through JavaScript or server-side in HTML as shown below.

```html
<!DOCTYPE html>
<html>
    <head>
        <title>PayEx Checkout is Awesome!</title>
    </head>
    <body>
        <div id="checkout"></div>
        <script src="https://ecom.payex.com/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token=38540e86bd78e885fba2ef054ef9792512b1c9c5975cbd6fd450ef9aa15b1844&culture=nb-NO"></script>
        <script language="javascript">
            payex.hostedView.paymentMenu({
                container: 'checkout',
                culture: 'nb-NO',
                onPaymentCompleted: function(paymentCompletedEvent) {
                    console.log(paymentCompletedEvent);
                },
                onPaymentFailed: function(paymentFailedEvent) {
                    console.log(paymentFailedEvent);
                },
                onPaymentCreated: function(paymentCreatedEvent) {
                    console.log(paymentCreatedEvent);
                },
                onPaymentToS: function(paymentToSEvent) {
                    console.log(paymentToSEvent);
                },
                onPaymentMenuInstrumentSelected: function(paymentMenuInstrumentSelectedEvent) {
                    console.log(paymentMenuInstrumentSelectedEvent);
                },
                onError: function(error) {
                    console.error(error);
                },
            }).open();
        </script>
    </body>
</html>
```

### Update Order

Change amount and vat amount on a payment order. If you implement `updateorder` **you need to `refresh()`** the [Payment Menu front end][payment-menu] so the new amount is shown to the end customer.

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

{:.code-header}
**Response**
```http
Response
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": {
        "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
        "created": "2018-09-14T13:21:29.3182115Z",
        "updated": "2018-09-14T13:21:57.6627579Z",
        "operation": "Purchase",
        "state": "Ready",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 0,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
        "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeinfo" },
        "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
        "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
        "orderItems" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/orderItems" },
        "metadata": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/metadata" },
        "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
        "currentPayment": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/currentpayment" }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/479a7a2b-3b20-4302-fa84-08d676d15bc0",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/4b0baaf8fdb5a56b5bdd78a8dd9e63e42e93ec79e5d0c0b5cc40f79cf43c9428",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token=4b0baaf8fdb5a56b5bdd78a8dd9e63e42e93ec79e5d0c0b5cc40f79cf43c9428&culture=nb-NO",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
        } 
    ]   
}
```

The response given when changing a payment order is equivalent to a `GET` 
request towards the `paymentorders` resource, [as displayed above][payment-orders-resource]. 
Remember to call .refresh() on the Payment Menu in JavaScript

### Capture

Capture can only be done on a payment with a successful authorized transaction. 
It is possible to do a part-capture where you only capture a smaller amount than the authorized amount. 
You can later do more captures on the same payment up to the total authorization amount.

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
        "payeeReference": "AB832",
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
| **Property** | **Type** | **Required** | **Description**
| transaction.description | string | Y | The description of the capture transaction.
| transaction.amount | integer | Y | The amount including VAT in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `5000` equals `50.00 NOK`.
| transaction.vatAmount | integer | Y | The amount of VAT in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `5000` equals `50.00 NOK`.
| transaction.payeeReference | string(30) | Y | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.
| transaction.orderItems | array | N | The array of items being purchased with the order. Used to print on invoices if the payer chooses to pay with invoice, among other things. [See Order Items for details][order-items].

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
| **Property** | **Data Type** | **Description**
| payment | string | The relative URI of the payment this capture transaction belongs to.
| capture.id | string | The relative URI of the created capture transaction.
| capture.transaction | object | The object representation of the generic [`transaction resource`][authorization-transaction].

Checkout should now be complete, the payment should be secure and everyone should be happy. But, sometimes you also need to implement the cancellation and reversal operations described below.

### Abort

To abort a payment order, perform the `update-paymentorder-abort``` operation that is returned in the payment order response. You need to include the following HTTP body:

{:.code-header}
**Request**

```http
PATCH /psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "Abort",
    "abortReason": "CancelledByConsumer"
  }
}
```

{:.code-header}
**Response**

```http
Response
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": {
        "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c",
        "created": "2018-09-14T13:21:29.3182115Z",
        "updated": "2018-09-14T13:21:57.6627579Z",
        "operation": "Purchase",
        "state": "Ready",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 0,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
        "payeeInfo" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeinfo" },
        "settings": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" },
        "payers": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payers" },
        "orderItems" : { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/orderItems" },
        "metadata": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/metadata" },
        "payments": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/payments" },
        "currentPayment": { "id": "/psp/paymentorders/5adc265f-f87f-4313-577e-08d3dca1a26c/currentpayment" }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.externalintegration.payex.com/psp/paymentorders/479a7a2b-3b20-4302-fa84-08d676d15bc0",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/4b0baaf8fdb5a56b5bdd78a8dd9e63e42e93ec79e5d0c0b5cc40f79cf43c9428",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token=4b0baaf8fdb5a56b5bdd78a8dd9e63e42e93ec79e5d0c0b5cc40f79cf43c9428&culture=nb-NO",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
        } 
    ]   
}
```

The response given when aborting a payment order is equivalent to a `GET` request towards the `paymentorders` resource, [as displayed above][payment-orders], with its `state` set to `Aborted`.

### Cancel

If we want to cancel up to the total authorized (not captured) amount, we need to perform `create-paymentorder-cancel` against the accompanying `href` returned in the `operations` list. See the abbreviated request and response below:

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

{:.code-header}
**Request Properties**

{:.table .table-striped}
| **Property** | **Type** | **Required** | **Description**
| transaction.payeeReference | string(30) | Y | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.
| transaction.description | string | Y | A textual description of why the transaction is cancelled.

If the cancellation request succeeds, the response should be similar to the example below:

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
| **Property** | **Data Type** | **Description**
| payment | string | The relative URI of the payment this capture transaction belongs to.
| cancellation.id | string | The relative URI of the created capture transaction.
| cancellation.transaction | object | The object representation of the generic [`transaction resource`][authorization-transaction].

#### Reversal

If we want to reverse a previously captured amount, we need to perform 
`create-paymentorder-reversal` against the accompanying href returned 
in the `operations` list. 
See the abbreviated request and response below:

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
| **Property** | **Type** | **Required** | **Description**
| transaction.amount | integer | Y | The amount including VAT in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `5000` equals `50.00 NOK`.
| transaction.vatAmount | integer | Y | The amount of VAT in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `5000` equals `50.00 NOK`.
| transaction.payeeReference | string(30) | Y | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference for details.
| transaction.description | string | Y | Textual description of why the transaction is reversed.

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
| **Property** | **Data Type** | **Description**
| payment | string | The relative URI of the payment this reversal transaction belongs to.
| reversal.id | string | The relative URI of the created reversal transaction.
| reversal.transaction | object | The object representation of the generic [`transaction resource`][authorization-transaction].

[abort]: #
[authorization-transaction]: #
[callback-reference]: #
[consumer-reference]: #
[current-payment]: #
[expanding]: #
[image_disabled_payment_menu]: /assets/img/checkout/test_purchase.PNG
[image_enabled_payment_menu]: /assets/img/checkout/payment_menu.PNG
[order-items]: #
[payee-reference]: #
[payment-menu]: #
[payment-orders-resource-payers]: #
[payment-orders-resource-payments]: #
[payment-orders-resource]: #
[payment-orders]: #
[payment-resource-payeeinfo]: #
[payment-resource-urls]: #
[payment-resource]: #
[update-order]: #
[user-agent]: https://en.wikipedia.org/wiki/User_agent
[verification-transaction]: #
