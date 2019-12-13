---
title: Swedbank Pay Payments Vipps Redirect
sidebar:
  navigation:
  - title: Vipps Payments
    items:
    - url: /payments/vipps
      title: Introduction
    - url: /payments/vipps/redirect
      title: Redirect
    - url: /payments/vipps/seamless-view
      title: Seamless View
    - url: /payments/vipps/after-payment
      title: After Payment
    - url: /payments/vipps/other-features
      title: Other Features
---

{% include alert-development-section.md %}

>Vipps is a two-phase payment instrument supported by the major norwegian banks.
 In the redirect to Swedbank Pay Payments scenario,  Swedbank Pay
 receives a mobile number (MSISDN) from the payer through Swedbank Pay Payments.
 Swedbank Pay performs a payment that the payer must confirm through the
 Vipps mobile app.

## Introduction

* When the payer starts the purchase process, you make a `POST` request towards
  Swedbank Pay with the collected `Purchase` information.
  This will generate a payment object with a unique `paymentID`.
  You either receive a Redirect URL to a hosted page or a JavaScript source
  in response.
* You need to [redirect][reference-redirect] the payer to the Redirect payment
  page or embed the script source on you site to create a
  [Seamless View][hosted-view] in an `iFrame`; where she is prompted to enter the
  registered mobile number.
  This triggers a `POST` towards Swedbank Pay.
* Swedbank Pay handles the dialogue with Vipps and the consumer confirms the
  purchase in the Vipps app.
* If CallbackURL is set you will receive a payment callback when the Vipps
  dialogue is completed.
  You need to do a `GET` request, containing the `paymentID` generated in the
  first step, to receive the state of the transaction.

## Screenshots

You redirect the payer to Swedbank Pay hosted payment page to collect the
consumers mobile number.

![Vipps mobile Payments]
[Vipps-screenshot-1]{:width="426px" :height="632px"}
![Vipps Payments][Vipps-screenshot-2]{:width="427px" :height="694px"}

### API Requests

The API requests are displayed in the [purchase flow](#purchase-flow).
The options you can choose from when creating a payment with key `operation`
set to Value `Purchase` are listed below.

### Options before posting a payment

All valid options when posting a payment with operation equal to Purchase,
are described in [the technical reference][vipps-payments].

#### Type of authorization (Intent)

**Authorization (two-phase)**: The intent of a Vipps purchase is always
`Authorization`.
The amount will be reserved but not charged.
You will later (i.e. if a physical product, when you are ready to ship the
purchased products) have to make a [Capture][captures] or
[Cancel][cancellations] request.

#### General

**Defining CallbackURL**: When implementing a scenario, it is optional to set
a [`CallbackURL`][callbackurl] in the `POST` request.
If callbackURL is set Swedbank Pay will send a postback request to this URL
when the consumer has fulfilled the payment.

## Purchase flow

The sequence diagram below shows the two requests you have to send to
Swedbank Pay to make a purchase.
The links will take you directly to the API description for the specific
request.

```mermaid
sequenceDiagram
  Browser->>Merchant: start purchase (pay with VIPPS)
  activate Merchant

  Merchant->>Swedbank_Pay_FrontEnd: POST <Create  Vipps payment>
  note left of Merchant: First API request
  activate Swedbank_Pay_FrontEnd
  Swedbank_Pay_FrontEnd-->>Merchant: payment resource
  deactivate Swedbank_Pay_FrontEnd
  Merchant-->>Browser: Redirect to payment page
  note left of Browser:redirect to Swedbank Pay
  Browser-->>Swedbank_Pay_FrontEnd: enter mobile number
  activate Swedbank_Pay_FrontEnd

  Swedbank_Pay_FrontEnd-->>Vipps_API: Initialize Vipps payment
  activate Vipps_API
  Vipps_API-->>Swedbank_Pay_FrontEnd: response
  Swedbank_Pay_FrontEnd-->>Browser: Authorization response (State=Pending)
  note left of Browser: check your phone
  deactivate Merchant

  Vipps_API-->>Vipps_App: Confirm Payment UI
  Vipps_App-->>Vipps_App: Confirmation Dialogue
  Vipps_App-->>Vipps_API: Confirmation
  Vipps_API-->>Swedbank_Pay_BackEnd: make payment
  activate Swedbank_Pay_BackEnd
  Swedbank_Pay_BackEnd-->>Swedbank_Pay_BackEnd: execute payment
  Swedbank_Pay_BackEnd-->>Vipps_API: response
  deactivate Swedbank_Pay_BackEnd
  deactivate Vipps_API
  Swedbank_Pay_BackEnd-->>Swedbank_Pay_FrontEnd: authorize result
  Swedbank_Pay_FrontEnd-->>Browser: authorize result
  Browser-->>Merchant: Redirect to merchant
  note left of Browser: Redirect to merchant
  activate Merchant
  Swedbank_Pay_FrontEnd-->>Merchant: Payment Callback
  Merchant-->>Swedbank_Pay_FrontEnd: GET <Vipps payments>
  note left of Merchant: Second API request
  Swedbank_Pay_FrontEnd-->>Merchant: Payment resource
  deactivate Swedbank_Pay_FrontEnd
  Merchant-->>Browser: Display authorize result
  deactivate Merchant
```

{:.code-header}
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
        "payerReference": "AB1234",
        "userAgent": "Mozilla/5.0...",
        "pageStripdown": true,
        "language": "nb-NO",
        "urls": {
            "hostUrls": "http://test-dummy.net",
            "completeUrl": "http://test-dummy.net/payment-completed",
            "cancelUrl": "http://test-dummy.net/payment-canceled",
            "callbackUrl": "http://test-dummy.net/payment-callback",
            "logoUrl": "http://test-dummy.net/payment-logo.png",
            "termsOfServiceUrl": "https://test-dummy.net/payment-terms.pdf",
            "paymentUrl": "http://test-dummy.net/payment-cart"
        },
        "payeeInfo": {
            "payeeId": "12345678-1234-1234-1234-123456789012",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123"
        },
        "prefillInfo": {
            "msisdn": "+4792345678"
        }
    }
}
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json
{
    "payment": {
        "id": "/psp/vipps/payments/5adc265f-f87f-4313-577e-08d3dca1a26c",
        "number": 1234567890,
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "instrument": "Vipps",
        "operation": "Purchase",
        "intent": "Authorization",
        "state": "Ready",
        "currency": "NOK",
        "amount": 1500,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "prices": {
            "id": "/psp/vipps/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/prices"
        },
        "transactions": {
            "id": "/psp/vipps/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/transactions"
        },
        "authorizations": {
            "id": "/psp/vipps/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/authorizations"
        },
        "reversals": {
            "id": "/psp/vipps/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/reversals"
        },
        "cancellations": {
            "id": "/psp/vipps/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/cancellations"
        },
        "urls": {
            "id": "/psp/vipps/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/urls"
        },
        "payeeInfo": {
            "id": "/psp/vipps/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/payeeInfo"
        },
        "settings": {
            "id": "/psp/vipps/payments/5adc265f-f87f-4313-577e-08d3dca1a26c/settings"
        }
    },
    "operations": [
        {
            "method": "POST",
            "href": "http://localhost:15486/psp/vipps/payments/c50eef6d-a788-4ec6-64ff-08d4b16740a4/authorizations",
            "rel": "create-authorization"
        },
        {
            "method": "PATCH",
            "href": "http://localhost:15486/psp/vipps/payments/c50eef6d-a788-4ec6-64ff-08d4b16740a4",
            "rel": "update-payment-abort"
        },
        {
            "method": "GET",
            "href": "http://localhost:15487/vipps/payments/authorize/8fb05a835f2fc227dc7bca9abaf649b919ba8a572deb448bff543dd5806dacb7",
            "rel": "redirect-authorization"
        }
    ]
}
```

{% include iterator.html prev_href="./"
                         prev_title="Back: Introduction"
                         next_href="seamless-view"
                         next_title="Next: Implement Seamless view" %}

[Vipps_flow_PaymentPages.png]: /assets/img/vipps-flow-paymentpages.png
[Vipps-screenshot-1]: /assets/img/checkout/vipps-hosted-payment.png
[Vipps-screenshot-2]: /assets/img/checkout/vipps-hosted-payment-no-paymenturl.png
[callbackurl]: /payments/vipps/other-features#callback
[cancellations]: /payments/vipps/other-features#cancel-sequence
[captures]: /payments/vipps/other-features#capture-sequence
[seamless-view]: /payments/vipps/seamless-view
[reference-redirect]: /payments/vipps/redirect
[vipps-payments]: /payments/vipps/other-features
