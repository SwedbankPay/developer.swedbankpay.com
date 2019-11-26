---
title: Swedbank Pay Payments Credit Card Redirect
sidebar:
  navigation:
  - title: Credit Card Payments
    items:
    - url: /payments/credit-card/
      title: Introduction
    - url: /payments/credit-card/redirect
      title: Redirect
    - url: /payments/credit-card/seamless-view
      title: Seamless View
    - url: /payments/credit-card/direct
      title: Direct
    - url: /payments/credit-card/after-payment
      title: After Payment
    - url: /payments/credit-card/other-features
      title: Other Features
---

{% include jumbotron.html body="The basic redirect view purchase scenario
is the most common way to implement card payments." %}

## Introduction

* When properly set up in your merchant/webshop site and the payer starts the
  purchase process, you need to make a POST request towards Swedbank Pay with 
  your Purchase information. This will generate a payment object with a unique
  `paymentID`. You will receive a **redirect URL** to a Swedbank Pay payment 
  page.
* You need to redirect the payer's browser to that specified URL so that she can
  enter the credit card details in a secure Swedbank Pay environment.
* Swedbank Pay will handle 3-D Secure authentication when this is required.
* Swedbank Pay will redirect the payer's browser to - one of two specified URLs,
  depending on whether the payment session is followed through completely or
  cancelled beforehand. Please note that both a successful and rejected payment
  reach completion, in contrast to a cancelled payment.
* When you detect that the payer reach your `completeUrl` , you need to do a
  `GET` request to receive the state of the transaction, containing the
  `paymentID` generated in the first step, to receive the state of the
  transaction.

## Screenshots

You will redirect the payer to Swedbank Pay hosted pages to collect the credit
card information.

![Screnshot-1]

## API Requests

The API requests are displayed in the [purchase flow](#purchase-flow).
You can [create a card `payment`][create-payment] with following `operation`
options:

* [Purchase][purchase]
* [Recur][recur]
* [Payout][payout]
* [Verify][verify]

Our `payment` example below uses the [`purchase`][purchase] value.

### Purchase

A `Purchase` payment is a straightforward way to charge the card of the payer.
It is followed up by posting a capture, cancellation or reversal transaction.

An example of an abbreviated `POST` request is provided below. Each individual 
Property of the JSON document is described in the following section. 
An example of an expanded `POST` request is available in the 
[other features section][purchase].

{% include alert.html type="neutral"
                      icon="info"
                      body="Please note that in order to minimize the risk 
                      for a challenge request (Strong Customer Authentication – 
                      “SCA”) on card payments, it's recommended that you add as 
                      much data as possible to the `riskIndicator` object in the request below." %}

{:.code-header}
**Request**

```http
POST /psp/creditcard/payments HTTP/1.1
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "SEK",
        "prices": [{
                "type": "CreditCard",
                "amount": 1500,
                "vatAmount": 0
            }
        ],
        "description": "Test Purchase",
        "generatePaymentToken": "false",
        "generateRecurrenceToken": "false",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "hostUrls": ["http://test-dummy.net"],
            "completeUrl": "http://test-dummy.net/payment-completed",
            "cancelUrl": "http://test-dummy.net/payment-canceled",
            "paymentUrl": "http://example.com/perform-payment",
            "callbackUrl": "http://test-dummy.net/payment-callback",
            "logoUrl": "http://test-dummy.net/payment-logo.png",
            "termsOfServiceUrl": "http://test-dummy.net/payment-terms.pdf",
        },
        "payeeInfo": {
            "payeeId": "12345678-1234-1234-1234-123456789012",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or123",
        },
        "metadata": {
            "key1": "value1",
            "key2": 2,
            "key3": 3.1,
            "key4": false
        },
        "riskIndicator": {
            "deliveryEmailAddress": "string",
            "deliveryTimeFrameindicator": "01",
            "preOrderDate": "YYYYMMDD",
            "preOrderPurchaseIndicator": "01",
            "shipIndicator": "01",
            "giftCardPurchase": "false",
            "reOrderPurchaseIndicator": "01",
            "pickUpAddress": {
                "name": "companyname",
                "streetAddress": "string",
                "coAddress": "string",
                "city": "string",
                "zipCode": "string",
                "countryCode": "string"
            }
        }
    },
    "creditCard": {
        "rejectCreditCards": false,
        "rejectDebitCards": false,
        "rejectConsumerCards": false,
        "rejectCorporateCards": false,
        "no3DSecure": false,
        "noCvc": false
    }
}
```

{:.table .table-striped}
| Required | Property                                  | Type        | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| :------: | :---------------------------------------- | :---------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | operation                                 | string      | Purchase                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|  ✔︎︎︎︎︎  | intent                                    | string      | `PreAuthorization`. Holds the funds for a certain time in contrast to reserving the amount. A preauthoriation is always followed by the [finalize][finalize] operation. <br> <br> `Authorization`. Reserves the amount, and is followed by a [cancellation][cancel] or [capture][capture] of funds.<br> <br> `AutoCapture`. A one phase option that enable capture of funds automatically after authorization.                                                                                                                                                                                                    |
|          | paymentToken                              | string      | If you put in a paymentToken here, the payment page will preload the stored payment data related to the `paymentToken` and let the consumer make a purchase without having to enter all card data. This is called a "One Click" purchase.                                                                                                                                                                                                                                                                                                                                                                         |
|  ✔︎︎︎︎︎  | currency                                  | string      | NOK, SEK, DKK, USD or EUR.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|  ✔︎︎︎︎︎  | prices.type                               | string      | Use the generic type CreditCard if you want to enable all card brands supported by merchant contract. Use card brands like Visa (for card type Visa), MasterCard (for card type Mastercard) and others if you want to specify different amount for each card brand. If you want to use more than one amount you must have one instance in the prices node for each card brand. You will not be allowed to both specify card brands and CreditCard at the same time in this field. [See the Prices resource and prices object types for more information][price-resource].                                         |
|  ✔︎︎︎︎︎  | prices.amount                             | integer     | Amount is entered in the lowest monetary units of the selected currency. E.g. 10000 = 100.00 NOK, 5000 = 50.00 SEK.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|  ✔︎︎︎︎︎  | prices.vatAmount                          | integer     | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | description                               | string(40)  | A textual description max 40 characters of the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | payerReference                            | string      | The reference to the payer (consumer/end user) from the merchant system. E.g mobile number, customer number etc.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|          | generatePaymentToken                      | boolean     | `true` or `false`. Set this to `true` if you want to create a paymentToken for future use as One Click.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|          | generateRecurrenceToken                   | boolean     | `true` or `false`. Set this to `true` if you want to create a recurrenceToken for future use Recurring purchases (subscription payments).                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|  ✔︎︎︎︎︎  | userAgent                                 | string      | The user agent reference of the consumer's browser - [see user agent definition][user-agent-definition]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|  ✔︎︎︎︎︎  | language                                  | string      | nb-NO, sv-SE or en-US.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
|          | urls.hostUrl                              | array       | The array of URLs valid for embedding of Swedbank Pay Hosted Views. If not supplied, view-operation will not be available.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|  ✔︎︎︎︎︎  | urls.completeUrl                          | string      | The URL that Swedbank Pay will redirect back to when the payment page is completed.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|          | urls.cancelUrl                            | string      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with paymentUrl; only cancelUrl or paymentUrl can be used, not both.                                                                                                                                                                                                                                                                                                                                                                                                                 |
|          | urls.paymentUrl                           | string      | The URI that Swedbank Pay will redirect back to when the view-operation needs to be loaded, to inspect and act on the current status of the payment. Only used in Seamless Views. If both cancelUrl and paymentUrl is sent, the paymentUrl will used.                                                                                                                                                                                                                                                                                                                                                             |
|          | urls.callbackUrl                          | string      | The URL that Swedbank Pay will perform an HTTP POST against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|          | urls.logoUrl                              | string      | The URL that will be used for showing the customer logo. Must be a picture with maximum 50px height and 400px width. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|          | urls.termsOfServiceUrl                    | string      | A URL that contains your terms and conditions for the payment, to be linked on the payment page. Require https.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|  ✔︎︎︎︎︎  | payeeInfo.payeeId                         | string      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|  ✔︎︎︎︎︎  | payeeInfo.payeeReference                  | string(30*) | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.                                                                                                                                                                                                                                                                                                                                                                                                                          |
|          | payeeInfo.payeeName                       | string      | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|          | payeeInfo.productCategory                 | string      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                                                                                                                                                                                                                    |
|          | payeeInfo.orderReference                  | String(50)  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|          | payeeInfo.subsite                         | String(40)  | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|          | metadata                                  | object      | The keys and values that should be associated with the payment. Can be additional identifiers and data you want to associate with the payment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|          | riskIndicator.deliveryEmailAddress        | string      | Optional (increased chance for frictionless flow if set).<br> <br> For electronic delivery, the email address to which the merchandise was delivered.                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|          | riskIndicator.deliveryTimeFrameIndicator  | string      | Optional (increased chance for frictionless flow if set).<br> <br> Indicates the merchandise delivery timeframe.<br>01 (Electronic Delivery)<br>02 (Same day shipping)<br>03 (Overnight shipping)<br>04 (Two-day or more shipping)<br>                                                                                                                                                                                                                                                                                                                                                                            |
|          | riskIndicator.preOrderDate                | string      | Optional (increased chance for frictionless flow if set).<br> <br>For a pre-ordered purchase. The expected date that the merchandise will be available.<br>FORMAT: "YYYYMMDD"                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|          | riskIndicator.preOrderPurchaseIndicator   | string      | Optional (increased chance for frictionless flow if set).<br> <br> Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.<br>01 (Merchandise available)<br>02 (Future availability)                                                                                                                                                                                                                                                                                                                                                                         |
|          | riskIndicator.shipIndicator               | string      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates shipping method chosen for the transaction.<br> 01 (Ship to cardholder's billing address)<br>02 (Ship to another verified address on file with merchant)<br>03 (Ship to address that is different than cardholder's billing address)<br>04 (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)<br>05 (Digital goods, includes online services, electronic giftcards and redemption codes)<br>06 (Travel and Event tickets, not shipped)<br>07 (Other, e.g. gaming, digital service) |
|          | riskIndicator.giftCardPurchase            | boolean     | Optional (increased chance for frictionless flow if set).<br> <br>`true` if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|          | riskIndicator.reOrderPurchaseIndicator    | string      | Optional (increased chance for frictionless flow if set).<br> <br>Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.<br>01 (Merchandise available)<br>02 (Future availability)                                                                                                                                                                                                                                                                                                                                                                          |
|          | riskIndicator.pickUpAddress               | object      | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | riskIndicator.pickUpAddress.name          | string      | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | riskIndicator.pickUpAddress.streetAddress | string      | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | riskIndicator.pickUpAddress.coAddress     | string      | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | riskIndicator.pickUpAddress.city          | string      | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | riskIndicator.pickUpAddress.zipCode       | string      | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | riskIndicator.pickUpAddress.countryCode   | string      | If shipIndicator set to 4, then prefil this.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|          | creditCard.rejectDebitCards               | boolean     | `true` if debit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|          | creditCard.rejectCreditCards              | boolean     | `true` if credit cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|          | creditCard.rejectConsumerCards            | boolean     | `true` if consumer cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|          | creditCard.rejectCorporateCards           | boolean     | `true` if corporate cards should be declined; otherwise `false` per default. Default value is set by Swedbank Pay and can be changed at your request.                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|          | creditCard.no3DSecure                     | boolean     | `true` if 3-D Secure should be disabled for this payment in the case a stored card is used; otherwise `false` per default. To use this feature it has to be enabled on the contract with Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                            |
|          | creditCard.noCvc                          | boolean     | `true` if the CVC field should be disabled for this payment in the case a stored card is used; otherwise `false` per default. To use this feature it has to be enabled on the contract with Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                                         |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payment": {
    "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
    "number": 1234567890,
    "instrument": "CreditCard",
    "created": "2016-09-14T13:21:29.3182115Z",
    "updated": "2016-09-14T13:21:57.6627579Z",
    "state": "Ready",
    "operation": "Purchase",
    "intent": "Authorization",
    "currency": "SEK",
    "amount": 1500,
    "remainingCaptureAmount": 1500,
    "remainingCancellationAmount": 1500,
    "remainingReversalAmount": 0,
    "description": "Test Purchase",
    "payerReference": "AB1234",
    "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
    "userAgent": "Mozilla/5.0...",
    "language": "sv-SE",
    "prices": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/prices" },
    "transactions": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions" },
    "authorizations": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/authorizations" },
    "captures": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/captures" },
    "reversals": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals" },
    "cancellations": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/cancellations" },
    "urls" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls" },
    "payeeInfo" : { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo" },
    "settings": { "id": "/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/settings" }
  },
  "operations": [
    {
      "href": "https://api.payex.com/psp/creditcard/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
      "rel": "update-payment-abort",
      "method": "PATCH",
      "contentType": "application/json"
    },
    {
      "href": "https://ecom.payex.com/creditcard/payments/authorize/123456123412341234123456789012",
      "rel": "redirect-authorization",
      "method": "GET",
      "contentType": "text/html"
    },
    {
      "method": "GET",
      "href": "https://ecom.dev.payex.com/creditcard/core/scripts/client/px.creditcard.client.js?token=123456123412341234123456789012",
      "rel": "view-authorization",
      "contentType": "application/javascript"
    }
  ]
}
```

## Type of authorization - Intent

The intent of the payment identifies how and when the charge will be
effectuated. This determine the type of transaction used during the payment
process.

* **PreAuthorization**: A purchase with `PreAuthorization` intent is handled in
  a similar manner as the ordinary authorization procedure. The notable 
  difference is that the funds are put on hold for 30 days (for an ordinary authorization the funds are reserved for 7 days). Also, with a 
  `PreAuthorization`, the captured amount can be higher than the preauthorized amount. The amount captured should not be higher than 20% of the original 
  amount, due to card brand rules. You complete the purchase by
  [finalizing the transaction][finalize].
* **Authorization (two-phase)**: If you want the credit card to reserve the
  amount, you will have to specify that the intent of the purchase is
  Authorization. The amount will be reserved but not charged. You will later
  (i.e. when you are ready to ship the purchased products) have to make a
  [Capture][capture] or [Cancel][cancel] request.

### General

* *No 3-D Secure and card acceptance:* There are optional paramers that can be
  used in relation to 3-D Secure and card acceptance. By default, most credit 
  card agreements with an acquirer will require that you use 3-D Secure for card holder authentication. However, if your agreement allows you to make a card 
  payment without this authentication, or that specific cards can be declined, 
  you may adjust these optional parameters when posting in the payment.
* *Defining `callbackURL`:* When implementing a scenario, it is optional to set
  a `callbackURL` in the `POST` request. If `callbackURL` is set Swedbank Pay
  will send a postback request to this URL when the consumer has fulfilled the
  payment. [See the Callback API description here][callback].

## Payment Resource

{% include payment-resource.md %}

## Purchase flow

The sequence diagram below shows a high level description of a complete
purchase, and the requests you have to send to Swedbank Pay. The links will
take you directly to the corresponding API description.

When dealing with credit card payments, 3-D Secure authentication of the
cardholder is an essential topic. There are two alternative outcome of a credit
card payment:

* 3-D Secure enabled - by default, 3-D Secure should be enabled, and Swedbank 
  Pay will check if the card is enrolled with 3-D Secure. This depends on the 
  issuer of the card. If the card is not enrolled with 3-D Secure, no 
  authentication of then cardholder is done.
* Card supports 3-D Secure - if the card is enrolled with 3-D Secure, Swedbank 
  Pay will redirect the cardholder to the autentication mechanism that is 
  decided by the issuing bank. Normally this will be done using BankID or 
  Mobile BankID.

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay

    activate Payer
    Payer->>+Merchant: start purchase
    deactivate Payer
    Merchant->>+SwedbankPay: POST /psp/creditcard/payments
    deactivate Merchant
    note left of Merchant: First API Request
    SwedbankPay-->>+Merchant: payment resource
    deactivate SwedbankPay
    Merchant-->>+Payer: authorization page
    deactivate Merchant
    note left of Payer: redirect to SwedbankPay
    Payer->>+Merchant: access merchant page
    deactivate Payer
    Merchant->>+SwedbankPay: GET /psp/creditcard/payments/<payment.id>
    deactivate Merchant
    note left of Merchant: Second API request
    SwedbankPay-->>+Merchant: rel: redirect-authorization
    deactivate SwedbankPay
    Merchant-->>-Payer: display purchase result
```

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay

  activate Payer
  Payer->>+Merchant: start purchase
  deactivate Payer
  Merchant->>+SwedbankPay: POST /psp/creditcard/payments
  deactivate Merchant
  note left of Payer: First API request
  SwedbankPay-->+Merchant: payment resource
  deactivate SwedbankPay
  Merchant-->>+Payer: authorization page
  deactivate Merchant
  Payer->>+SwedbankPay: access authorization page
  deactivate Payer
  note left of Payer: redirect to SwedbankPay
  SwedbankPay-->>+Payer: display purchase information
  deactivate SwedbankPay

  Payer->>Payer: input creditcard information
  Payer->>+SwedbankPay: submit creditcard information
  deactivate Payer
  opt Card supports 3-D Secure
    SwedbankPay-->>+Payer: redirect to IssuingBank
    deactivate SwedbankPay
    Payer->>IssuingBank: 3-D Secure authentication process
    Payer->>+SwedbankPay: access authentication page
    deactivate Payer
  end
  
  SwedbankPay-->>+Payer: redirect to merchant
  deactivate SwedbankPay
  note left of Payer: redirect back to merchant
  
  Payer->>+Merchant: access merchant page
  deactivate Payer
  Merchant->>+SwedbankPay: GET /psp/creditcard/payments/<payment.id>
  deactivate Merchant
  note left of Merchant: Second API request
  SwedbankPay-->>+Merchant: rel: redirect-authorization
  deactivate SwedbankPay
  Merchant-->>Payer: display purchase result
  deactivate Merchant

  opt Callback is set
    activate SwedbankPay
    SwedbankPay->>SwedbankPay: Payment is updated
    SwedbankPay->>Merchant: POST Payment Callback
    deactivate SwedbankPay
  end
```

### Options after posting a payment

* `Abort`: It is possible to abort the process, if the payment has no successful
  transactions. [See the PATCH payment description][abort].
* If the payment shown above is done as a two phase (`Authorization`), you will
  need to implement the [`Capture`][capture] and [`Cancel`][cancel] requests.
* For `reversals`, you will need to implement the [Reversal request][reversal].
* If you did a `PreAuthorization`, you will have to send a
  [Finalize request][finalize] to finalize the transaction.
* *If `callbackURL` is set:* Whenever changes to the payment occur a
  [Callback request][callback] will be posted to the `callbackUrl`, which was
  generated when the payment was created.

## Card Payment Pages in Mobile Apps

> The implementation sequence for this scenario is identical to the standard
  Redirect scenario, but also includes explanations of how to include this
  redirect in mobile apps or in mobile web pages.

### Screenshots for Payment Pages

You will redirect the consumer/end-user to Swedbank Pay hosted pages to collect
the credit card information.

![Merchant implemented redirect][redirect-image]{:width="407" height="627"}

## API Requests for Payment Pages

The API requests are displayed in the [purchase flow](#purchase-flow-mobile).
You can [create a card `payment`][create-payment] with following `operation`
options:

* [Purchase][purchase]
* [Recur][recur]
* [Payout][payout]
* [Verify][verify]

Our `payment` example below uses the [`purchase`][purchase] value.

### Type of authorization - Intent

The intent of the payment identifies how and when the charge will be
effectuated. This determine the type of transaction used during the payment
process.

* **PreAuthorization**: A purchase with `PreAuthorization` intent is handled
  in a similar manner as the ordinary authorization procedure. The notable
  difference is that the funds are put on hold for 30 days (for an ordinary
  authorization the funds are reserved for 7 days). Also, with a
  `PreAuthorization`, the captured amount can be higher than the preauthorized
  amount. The amount captured should not be higher than 20% of the original
  amount, due to card brand rules. You complete the purchase by
  [finalizing the transaction][finalize].
* **Authorization (two-phase)**: If you want the credit card to reserve the
  amount, you will have to specify that the intent of the purchase is
  Authorization. The amount will be reserved but not charged. You will later
  (i.e. when you are ready to ship the purchased products) have to make a
[Capture][capture] or [Cancel][cancel] request.
* **AutoCapture (one-phase)**:  If you want the credit card to be charged right
  away, you will have to specify that the intent of the purchase is 
  `AutoCapture`. The credit card will be charged automatically after 
  authorization and you don't need to do any more financial operations to this purchase.

### General

* **No 3-D Secure and card acceptance**: There are optional paramers that can be
  used in relation to 3-D Secure and card acceptance. By default, most credit 
  card agreements with an acquirer will require that you use 3-D Secure for card holder authentication. However, if your agreement allows you to make a 
  card payment without this authentication, or that specific cards can be 
  declined, you may adjust these optional parameters when posting in the 
  payment.
* **Defining `callbackURL`**: When implementing a scenario, it is optional to
  set a `callbackURL` in the `POST` request. If `callbackURL` is set Swedbank 
  Pay will send a postback request to this URL when the consumer has fulfilled 
  the payment. [See the Callback API description here][callback].

## Purchase flow mobile

The sequence diagram below shows a high level description of a complete
purchase, and the two requests you have to send to Swedbank Pay. The links will
take you directly to the corresponding API description.

When dealing with credit card payments, 3-D Secure authentication of the
cardholder is an essential topic. There are two alternative outcomes of a credit
card payment:

* 3-D Secure enabled - by default, 3-D Secure should be enabled, and Swedbank 
  Pay will check if the card is enrolled with 3-D Secure. This depends on the 
  issuer of the card. If the card is not enrolled with 3-D Secure, no 
  authentication of the cardholder is done.
* Card supports 3-D Secure - if the card is enrolled with 3-D Secure, Swedbank 
  Pay will redirect the cardholder to the autentication mechanism that is 
  decided by the issuing bank. Normally this will be done using BankID or 
  Mobile BankID.

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay

    activate Payer
    Payer->>+Merchant: start purchase
    deactivate Payer
    Merchant->>+SwedbankPay: POST /psp/creditcard/payments
    deactivate Merchant
    note left of Merchant: First API Request
    SwedbankPay-->>+Merchant: payment resource
    deactivate SwedbankPay
    Merchant-->>+Payer: authorization page
    deactivate Merchant
    note left of Payer: redirect to SwedbankPay
    Payer->>+Merchant: access merchant page
    deactivate Payer
    Merchant->>+SwedbankPay: GET /psp/creditcard/payments/<payment.id>
    deactivate Merchant
    note left of Merchant: Second API request
    SwedbankPay-->>+Merchant: rel: redirect-authorization
    deactivate SwedbankPay
    Merchant-->>-Payer: display purchase result
```

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay

  activate Payer
  Payer->>+Merchant: start purchase
  deactivate Payer
  Merchant->>+SwedbankPay: POST /psp/creditcard/payments
  deactivate Merchant
  note left of Payer: First API request
  SwedbankPay-->+Merchant: payment resource
  deactivate SwedbankPay
  Merchant-->>+Payer: authorization page
  deactivate Merchant
  Payer->>+SwedbankPay: access authorization page
  deactivate Payer
  note left of Payer: redirect to SwedbankPay
  SwedbankPay-->>+Payer: display purchase information
  deactivate SwedbankPay

  Payer->>Payer: input creditcard information
  Payer->>+SwedbankPay: submit creditcard information
  deactivate Payer
  opt Card supports 3-D Secure
    SwedbankPay-->>+Payer: redirect to IssuingBank
    deactivate SwedbankPay
    Payer->>IssuingBank: 3-D Secure authentication process
    Payer->>+SwedbankPay: access authentication page
    deactivate Payer
  end
  
  SwedbankPay-->>+Payer: redirect to merchant
  deactivate SwedbankPay
  note left of Payer: redirect back to merchant
  
  Payer->>+Merchant: access merchant page
  deactivate Payer
  Merchant->>+SwedbankPay: GET /psp/creditcard/payments/<payment.id>
  deactivate Merchant
  note left of Merchant: Second API request
  SwedbankPay-->>+Merchant: rel: redirect-authorization
  deactivate SwedbankPay
  Merchant-->>Payer: display purchase result
  deactivate Merchant

  opt Callback is set
    activate SwedbankPay
    SwedbankPay->>SwedbankPay: Payment is updated
    SwedbankPay->>Merchant: POST Payment Callback
    deactivate SwedbankPay
  end
```

{% include iterator.html prev_href="./" prev_title="Back: Introduction"
next_href="seamless-view" next_title="Next: Seamless View" %}

[abort]: /payments/credit-card/other-features/#abort
[callback]: /payments/credit-card/other-features/#callback
[cancel]: /payments/credit-card/after-payment/#cancellations
[capture]: /payments/credit-card/after-payment/#Capture
[create-payment]: /payments/credit-card/other-features/#create-payment
[expansion]: /payments/credit-card/other-features/#expansion
[finalize]: /payments/credit-card/after-payment/#finalize
[payee-reference]: /payments/credit-card/other-features/#payeereference
[payout]: /payments/credit-card/other-features/#payout
[purchase]: /payments/credit-card/other-features/#purchase
[price-resource]: /payments/credit-card/other-features/#prices
[recur]: /payments/credit-card/other-features/#recur
[redirect-image]: /assets/img/checkout/test-purchase.png
[reversal]: /payments/credit-card/after-payment/#reversals
[Screnshot-1]: /assets/img/checkout/test-purchase.png
[verify]: /payments/credit-card/other-features/#verify
[user-agent-definition]: https://en.wikipedia.org/wiki/User_agent
