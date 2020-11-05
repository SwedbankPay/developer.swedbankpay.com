---
title: Direct
redirect_from: /payments/swish/direct
estimated_read: 17
description: |
  Swish is a one-phase payment instrument supported by the major Swedish banks.
  In the Direct scenario, Swedbank Pay receives the Swish registered mobile 
  number directly from the merchant UI. Swedbank Pay performs a payment that
  the payer confirms using her Swish mobile app.
menu_order: 600
---

## Payment Flow

*   When the payer starts the purchase process, you make a `POST` request
    towards Swedbank Pay with the collected Purchase information.
*   The next step is to collect the payer's Swish registered mobile number
    and make a `POST` request towards Swedbank Pay to create a sales
    transaction.
*   Swedbank Pay will handle the dialogue with Swish and the payer will have
    to confirm the purchase in the Swish app.
*   If `callbackURL` is set, you will receive a payment callback when the Swish
    dialogue is completed.
*   Make a `GET` request to check the payment status.

{% include alert.html type="informative" icon="report_problem"
body="Swish is a one-phase payment instrument that is based on sales
transactions not involving `capture` or `cancellation` operations." %}

{% include alert-callback-url.md api_resource="swish" %}

## Step 1: Create a Purchase

A `Purchase` payment is created by performing the following request.

{% include alert-gdpr-disclaimer.md %}

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
        "payerReference": "AB1234",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "hostUrls": [ "https://example.com" ],
            "paymentUrl": "https://example.com/perform-payment",
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
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

{:.table .table-striped}
|     Required     | Field                        | Type          | Description                                                                                                                                                                                                                                                                                        |
| :--------------: | :--------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `payment`                    | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`operation`          | `string`      | The operation that the `payment` is supposed to perform. The [`Purchase`][purchase] operation is used in our example.                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`intent`             | `string`      | `Authorization`.                                                                                                                                                                                                                                                                                   |
| {% icon check %} | └➔&nbsp;`currency`           | `string`      | SEK.                                                                                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`prices`             | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`type`              | `string`      | Swish                                                                                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`amount`            | `integer`     | {% include field-description-amount.md %}                                                                                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`vatAmount`         | `integer`     | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                                       |  |
| {% icon check %} | └➔&nbsp;`description`        | `string(40)`  | {% include field-description-description.md documentation_section="swish" %}                                                                                                                                                                                                                       |
|                  | └➔&nbsp;`payerReference`     | `string`      | {% include field-description-payer-reference.md documentation_section="swish" %}                                                                                                                                                                                   |
|                  | └➔&nbsp;`payeeName`          | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                                                      |
| {% icon check %} | └➔&nbsp;`userAgent`          | `string`      | The [`User-Agent` string][user-agent] of the payer's web browser.                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`language`           | `string`      | {% include field-description-language.md api_resource="swish" %}                                                                                                                                                                                                                                   |
| {% icon check %} | └➔&nbsp;`urls`               | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                             |
| {% icon check %} | └─➔&nbsp;`completeUrl`       | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further. See [`completeUrl`][completeurl] for details. |
|                  | └─➔&nbsp;`cancelUrl`         | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only cancelUrl or `paymentUrl` can be used, not both.                                                                                              |
|                  | └─➔&nbsp;`callbackUrl`       | `string`      | The URL that Swedbank Pay will perform an HTTP POST against every time a transaction is created on the payment. See [callback][callback-url] for details.                                                                                                                                          |
|                  | └─➔&nbsp;`logoUrl`           | `string`      | {% include field-description-logourl.md documentation_section="swish" %}                                                                                                                                                                |
|                  | └─➔&nbsp;`termsOfServiceUrl` | `string`      | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`payeenInfo`         | `object`      | {% include field-description-payeeinfo.md documentation_section="swish" %}                                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`payeeId`           | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`payeeReference`    | `string(50*)` | {% include field-description-payee-reference.md documentation_section="swish" %}                                                                                                                                                                                                                   |
|                  | └─➔&nbsp;`payeeName`         | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                            |
|                  | └─➔&nbsp;`productCategory`   | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                     |
|                  | └─➔&nbsp;`orderReference`    | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                            |
|                  | └─➔&nbsp;`subsite`           | `String(40)`  | {% include field-description-subsite.md %}                                                                                                                                        |
|                  | └➔&nbsp;`prefillInfo`        | `object`      | An object holding information which, when available, will be prefilled on the payment page.                                                                                                                                                                                                        |
|                  | └─➔&nbsp;`msisdn`            | `String`      | Number will be prefilled on payment page, if valid. The mobile number must have a country code prefix and be 8 to 15 digits in length.                                                                                                                                                             |
|                  | └➔&nbsp;`swish`              | `object`      | An object that holds different scenarios for Swish payments.                                                                                                                                                                                                                                       |
|                  | └─➔&nbsp;`enableEcomOnly`    | `boolean`     | `true` if to only enable Swish on web based transactions.; otherwise `false` to also enable Swish transactions via in-app payments                                                                                                                                                                 |
|          | └─➔&nbsp;`paymentRestrictedToAgeLimit`             | `integer`     | Positive number that sets the required age  needed to fulfill the payment. To use this feature it has to be configured in the contract.                                                                                                                                                            |
|                 | └─➔&nbsp;`paymentRestrictedToSocialSecurityNumber` | `string`      | When provided, the payment will be restricted to a specific social security number to make sure its the same logged in customer who is also the payer. Format: yyyyMMddxxxx. To use this feature it has to be configured in the contract.                                                                                                                             |

{:.code-view-header}
**Response**

```http
POST /psp/swish/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "id": "/psp/swish/payments/{{ page.payment_id }}",
        "number": 992308,
        "created": "2017-10-23T08:38:57.2248733Z",
        "instrument": "Swish",
        "operation": "Purchase",
        "intent": "Sale",
        "state": "Ready",
        "currency": "SEK",
        "amount": 0,
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "initiatingSystemUserAgent": "Mozilla/5.0",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "id": "/psp/swish/payments/{{ page.payment_id }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/swish/payments/{{ page.payment_id }}/payeeinfo"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/swish/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort"
        },
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/swish/payments/{{ page.payment_id }}/sales",
            "rel": "create-sale"
        }
    ]
}
```

## Step 2a: Create E-Commerce Sale Transaction

This operation creates an e-commerce sales transaction in the Direct payment
scenario. This is managed either by sending a `POST` request as seen below, or
by directing the payer to the hosted payment pages. Note that the `msisdn`
value (the payer's mobile number) is required in this request.

{:.code-view-header}
**Request**

```http
POST /psp/swish/payments/{{ page.payment_id }}/sales HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "msisdn": "+46739000001"
    }
}

```

{:.table .table-striped}
| Field            | Type     | Required                                                                                          |
| :--------------- | :------- | :------------------------------------------------------------------------------------------------ |
| `transaction`    | `object` | The `transaction` object contains information about the specific transaction.                     |
| └➔&nbsp;`msisdn` | `string` | The payer's mobile number. It must have a country code prefix and be 8 to 15 digits in length. |

{% include transaction-response.md api_resource="swish"
documentation_section="swish" transaction="sale" %}

## E-Commerce Purchase Flow

The sequence diagram below shows the two requests you have to send to
Swedbank Pay to make a purchase. The Callback response is a simplified example
in this flow. Go to the [Callback][callback-url] section to view the complete flow.

```mermaid
sequenceDiagram
    activate Browser
    Browser->>-Merchant: Start purchase
    activate Merchant
    Merchant->>-SwedbankPay: POST <Swish payment> (operation=PURCHASE)
    activate  SwedbankPay
    note left of Merchant: First API request
    SwedbankPay-->>-Merchant: Payment resource
    activate Merchant

    Merchant->>- SwedbankPay: POST <Sales Transaction> (operation=create-sale)
    activate  SwedbankPay
    SwedbankPay-->>-Merchant: Transactions resource
    activate Merchant
    note left of Merchant: POST containing MSISDN
    Merchant->>-Browser: Tell payer to open Swish app
    Swish_API->>Swish_App: Ask for payment confirmation
    activate Swish_App
    Swish_App-->>-Swish_API: Payer confirms payment

        alt Callback
        activate SwedbankPay
        SwedbankPay-->>-Swish_API: Callback response
        activate SwedbankPay
        SwedbankPay->>-Merchant: Transaction Callback
        end

    activate Merchant
    Merchant->>- SwedbankPay: GET <Swish payment>
    activate  SwedbankPay
    SwedbankPay-->>-Merchant: Payment response
    activate Merchant
    Merchant->>-Browser: Payment Status
```

## Step 2b: Create M-Commerce Sale Transaction

This operation creates an m-commerce sales transaction in the Direct payment
scenario. This is managed either by sending a `POST` request as seen below, or
by directing the payer to the hosted payment pages. Note that the `msisdn`
value (the payer's mobile number) is left out in this request. The
`redirect-app-swish` operation is only present in the m-commerce flow response.

{:.code-view-header}
**Request**

```http
POST /psp/swish/payments/{{ page.payment_id }}/sales HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
    }
}
```

{:.table .table-striped}
| Field         | Type     | Required                                                             |
| :------------ | :------- | :------------------------------------------------------------------- |
| `transaction` | `object` | The  `transaction` object is empty for m-commerce sale transactions. |

{% include transaction-response.md api_resource="swish"
documentation_section="swish" transaction="sale" mcom=true %}

## Step 3: Get the payment status

{:.code-view-header}
**Request**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
        "number": 1234567890,
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "state": "Ready",
        "operation": "Purchase",
        "intent": "Authorization",
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
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/prices"
        },
        "payeeInfo": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/payeeInfo"
        },
        "urls": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/urls"
        },
        "transactions": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions"
        },
        "captures": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/captures"
        },
        "reversals": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/reversals"
        },
        "cancellations": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/cancellations"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort",
            "contentType": "application/json"
        },
        {
            "method": "POST",
            "href": "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}/captures",
            "rel": "create-capture",
            "contentType": "application/json"
        }
    ]
}
```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                                                                                                                                                                |
| :----------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                | `object`     | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md %}                                                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`number`         | `integer`    | The payment  number , useful when there's need to reference the payment in human communication. Not usable for programmatic identification of the payment, for that  id  should be used instead.                                                                                                                                                           |
| └➔&nbsp;`created`        | `string`     | The ISO-8601 date of when the payment was created.                                                                                                                                                                                                                                                                                                         |
| └➔&nbsp;`updated`        | `string`     | The ISO-8601 date of when the payment was updated.                                                                                                                                                                                                                                                                                                         |
| └➔&nbsp;`state`          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment, not the state of any transactions performed on the payment. To find the state of the payment's transactions (such as a successful authorization), see the `transactions` resource or the different specialized type-specific resources such as `authorizations` or `sales`. |
| └➔&nbsp;`prices`         | `object`     | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                      |
| └➔&nbsp;`prices.id`      | `string`     | {% include field-description-id.md resource="prices" %}                                                                                                                                                                                                                                                                                                    |
| └➔&nbsp;`description`    | `string(40)` | {% include field-description-description.md documentation_section="swish" %}                                                                                                                                                                                                                                                                               |
| └➔&nbsp;`payerReference` | `string`     | {% include field-description-payer-reference.md documentation_section="swish" %}                                                                                                                                                                                                                          |
| └➔&nbsp;`userAgent`      | `string`     | The [user agent][user-agent] string of the payer's browser.                                                                                                                                                                                                                                                                                             |
| └➔&nbsp;`language`       | `string`     | {% include field-description-language.md api_resource="swish" %}                                                                                                                                                                                                                                                                                           |
| └➔&nbsp;`urls`           | `string`     | The URI to the  urls  resource where all URIs related to the payment can be retrieved.                                                                                                                                                                                                                                                                     |
| └➔&nbsp;`payeeInfo`      | `string`     | The URI to the  payeeinfo  resource where the information about the payee of the payment can be retrieved.                                                                                                                                                                                                                                                 |
| `operations`             | `array`      | The array of possible operations to perform                                                                                                                                                                                                                                                                                                                |
| └─➔&nbsp;`method`        | `string`     | The HTTP method to use when performing the operation.                                                                                                                                                                                                                                                                                                      |
| └─➔&nbsp;`href`          | `string`     | The target URI to perform the operation against.                                                                                                                                                                                                                                                                                                           |
| └─➔&nbsp;`rel`           | `string`     | The name of the relation the operation has to the current resource.                                                                                                                                                                                                                                                                                        |

## M-Commerce Purchase Flow

The sequence diagram below shows the three requests you have to send to
Swedbank Pay to make a purchase. The Callback response is a simplified example
in this flow. Go to the [Callback][callback-url] section to view the complete flow.

```mermaid
sequenceDiagram
    activate Browser
    Browser->>-Merchant: Start purchase
    activate Merchant
    Merchant->>-SwedbankPay: POST <Swish payment> (operation=PURCHASE)
    activate  SwedbankPay
    note left of Merchant: First API request
    SwedbankPay-->>-Merchant: Payment resource
    activate Merchant
    Merchant->>- SwedbankPay: POST <Sales Transaction> (operation=create-sale)
    activate  SwedbankPay
    SwedbankPay-->>-Merchant: Transaction resource
    activate Merchant
    note left of Merchant: POST containing MSISDN
    Merchant-->>-Browser: Tell payer to open Swish app
    Swish_API->>Swish_App: Ask for payment confirmation
    activate Swish_App
    Swish_App-->>-Swish_API: Payer confirms payment
    activate Swish_API
    Swish_API->>-Swish_App: Start redirect
    activate Swish_App
    Swish_App-->>-Browser: Redirect

        alt Callback
        activate SwedbankPay
        SwedbankPay-->>-Swish_API: Callback response
        activate SwedbankPay
        SwedbankPay->>-Merchant: Transaction Callback
        end

    activate Merchant
    Merchant->>- SwedbankPay: GET <Swish Payment>
    activate  SwedbankPay
    SwedbankPay-->>-Merchant: Payment response
    activate Merchant
    Merchant-->>-Browser: Payment Status
```

{% include iterator.html prev_href="./" prev_title="Introduction"
next_href="redirect" next_title="Redirect" %}

[completeurl]: /payment-instruments/swish/other-features#completeurl
[swish-redirect-view]: /assets/screenshots/swish/redirect-view/view/windows-small-window.png
[callback-url]: /payment-instruments/swish/other-features#callback
[redirect]: /payment-instruments/swish/redirect
[user-agent]: https://en.wikipedia.org/wiki/User_agent
[payee-reference]: /payment-instruments/swish/other-features#payee-reference
[purchase]: /payment-instruments/swish/direct#m-commerce-purchase-flow
[sales-transaction]: /payment-instruments/swish/other-features#sales
