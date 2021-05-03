---
title: Direct
redirect_from: /payments/invoice/direct
estimated_read: 12
description: |
  **Direct** is a payment service where Swedbank
  Pay helps improve cashflow by purchasing merchant invoices. Swedbank Pay
  receives invoice data, which is used to produce and distribute invoices to the
  payer.
menu_order: 700
---

{% include alert.html type="informative" icon="report_problem" header="Disclaimer"
body="Direct Invoice is about to be phased out. This section is only for
merchants that currently have a contract with this integration." %}

## Invoice Direct implementation flow

1.  Collect all purchase information and send it in a `POST` request to Swedbank
   Pay. Make sure to include personal information (SSN and postal code).

2.  Make a new `POST` request towards Swedbank Pay to retrieve the name and
   address of the customer to create a purchase.

3.  Create a `POST`request to retrieve the transaction status.

4.  Send a  `GET` request with the `paymentID` to get the authorization result.

5.  Make a Capture by creating a `POST` request.

*   An invoice payment is always two-phased based - you create an Authorize
transaction, that is followed by a `Capture` or `Cancel` request.
The `Capture` , `Cancel`, `Reversal` opions are
described in [features][features].

{% include alert.html type="informative" icon="info" body="
Note that the invoice will not be created/distributed before you have
made a `capture` request. By making a Capture, Swedbank Pay will generate
the invoice to the payer and the order is ready for shipping." %}

{% include alert-callback-url.md %}

The 3 most important steps in the Invoice Direct flow are shown below.

## Step 1: Create a Purchase

Our `payment` example below uses the [`FinancingConsumer`][financing-consumer] value.

{% include alert-gdpr-disclaimer.md %}

### Financing Consumer

{:.code-view-header}
**Request**

```http
POST /psp/invoice/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
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
        "description": "Test Purchase",
        "generateReccurenceToken": false,
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png",
            "termsOfServiceUrl": "https://example.com/terms.pdf"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "PR123",
            "payeeName": "Merchant1",
            "productCategory": "PC1234",
            "subsite": "MySubsite"
        },
        "payer": {
            "payerReference": "AB1234",
        }
    },
    "invoice": {
        "invoiceType": "PayExFinancingSe"
    }
}
```

{:.table .table-striped}
|     Required     | Field                             | Type          | Description                                                                                                                                                                                                                                                                                                            |
| :--------------: | :-------------------------------- | :------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %}︎︎︎︎︎ | `payment`                         | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                  |
| {% icon check %}︎︎︎︎︎ | └➔&nbsp;`operation`               | `string`      | The operation that the `payment` is supposed to perform. The [`FinancingConsumer`][financing-consumer] operation is used in our example. Take a look at the Other Features section for a full examples of the following `operation` options: [FinancingConsumer][financing-consumer], [Recur][recur], [Verify][verify] |
| {% icon check %}︎︎︎︎︎ | └➔&nbsp;`intent`                  | `string`      | `Authorization` is the only intent option for invoice. Reserves the amount, and is followed by a [cancellation][cancel] or [capture][capture] of funds.                                                                                                                                                                |
| {% icon check %}︎︎︎︎︎ | └➔&nbsp;`currency`                | `string`      | NOK, SEK, DKK, USD or EUR.                                                                                                                                                                                                                                                                                             |
| {% icon check %}︎︎︎︎︎ | └➔&nbsp;`prices`                  | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                  |
| {% icon check %}︎︎︎︎︎ | └─➔&nbsp;`type`                   | `string`      | Use the `Invoice` type here                                                                                                                                                                                                                                                                                            |
| {% icon check %}︎︎︎︎︎ | └─➔&nbsp;`amount`                 | `integer`     | {% include field-description-amount.md %}                                                                                                                                                                                                                                                                              |
| {% icon check %}︎︎︎︎︎ | └─➔&nbsp;`vatAmount`              | `integer`     | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                                                           |
| {% icon check %}︎︎︎︎︎ | └➔&nbsp;`description`             | `string(40)`  | {% include field-description-description.md %}                                                                                                                                                                                                                                         |
|                  | └➔&nbsp;`generateRecurrenceToken` | `boolean`     | `true` or `false`. Set this to `true` if you want to create a recurrenceToken for future use Recurring purchases (subscription payments).                                                                                                                                                                              |
| {% icon check %}︎︎︎︎︎ | └➔&nbsp;`userAgent`               | `string`      | The [`User-Agent` string][user-agent] of the payer's web browser.                                                                                                                                                                                                                                                   |
| {% icon check %}︎︎︎︎︎ | └➔&nbsp;`language`                | `string`      | {% include field-description-language.md %}                                                                                                                                                                                                                                                     |
| {% icon check %}︎︎︎︎︎ | └➔&nbsp;`urls`                    | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                                                 |
|                  | └─➔&nbsp;`hostUrl`                | `array`       | The array of URLs valid for embedding of Swedbank Pay Seamless Views. If not supplied, view-operation will not be available.                                                                                                                                                                                             |
| {% icon check %}︎︎︎︎︎ | └─➔&nbsp;`completeUrl`            | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further. See [`completeUrl`][complete-url] for details.                     |
|                  | └─➔&nbsp;`cancelUrl`              | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only `cancelUrl` or `paymentUrl` can be used, not both.                                                                                                                |
|                  | └─➔&nbsp;`callbackUrl`            | `string`      | The URL that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                                                |
|                  | └─➔&nbsp;`logoUrl`                | `string`      | {% include field-description-logourl.md %}                                                        |
|                  | └─➔&nbsp;`termsOfServiceUrl`      | `string`      | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                                                                                   |
| {% icon check %}︎︎︎︎︎ | └➔&nbsp;`payeeInfo`               | `object`      | {% include field-description-payeeinfo.md %}                                                                                                                                                                                                                                                                  |
| {% icon check %}︎︎︎︎︎ | └─➔&nbsp;`payeeId`                | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                  |
| {% icon check %}︎︎︎︎︎ | └─➔&nbsp;`payeeReference`         | `string(30*)` | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                                                                                                                                               |
|                  | └─➔&nbsp;`payeeName`              | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                                                |
|                  | └─➔&nbsp;`productCategory`        | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                         |
|                  | └─➔&nbsp;`orderReference`         | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                |
|                  | └─➔&nbsp;`subsite`                | `String(40)`  | {% include field-description-subsite.md %}                                                                                                                                                            |
|                  | └➔&nbsp;`payer`                   | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | └─➔&nbsp;`payerReference`         | `string`     | {% include field-description-payer-reference.md %}                                                                                                                                                                                                                                                           |

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/invoice/payments/{{ page.payment_id }}",
        "number": 1234567890,
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "state": "Ready",
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "SE",
        "amount": 0,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "prices": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/prices"
        },
        "transactions": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/transactions"
        },
        "authorizations": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/authorizations"
        },
        "captures": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/captures"
        },
        "reversals": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/reversals"
        },
        "cancellations": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/cancellations"
        },
        "payeeInfo": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/payeeInfo"
        },
        "payers": {
           "id": "/psp/trustly/payments/{{ page.payment_id }}/payers"
        },
        "urls": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/urls"
        },
        "settings": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/settings"
        },
        "approvedLegalAddress": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/approvedlegaladdress"
        },
        "maskedApprovedLegalAddress": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/maskedapprovedlegaladdress"
        }
    },
    "approvedLegalAddress": {
        "id": "/psp/invoice/payments/{{ page.payment_id }}/approvedlegaladdress"
    },
    "operations": [
        {
            "href": "{{ page.api_url }}/psp/invoice/payments/{{ page.payment_id }}/captures",
            "rel": "create-capture",
            "method": "POST"
        },
        {
            "href": "{{ page.api_url }}/psp/invoice/payments/{{ page.payment_id }}/cancellations",
            "rel": "create-cancel",
            "method": "POST"
        },
        {
            "href": "{{ page.api_url }}/psp/invoice/payments/{{ page.payment_id }}/approvedlegaladdress",
            "rel": "create-approved-legal-address",
            "method": "POST"
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
| └─➔&nbsp;`id`            | `string`     | {% include field-description-id.md resource="prices" %}                                                                                                                                                                                                                                                                                                    |
| └➔&nbsp;`description`    | `string(40)` | {% include field-description-description.md %}                                                                                                                                                                                                                                                                             |
| └➔&nbsp;`userAgent`      | `string`     | The [`User-Agent` string][user-agent] of the payer's web browser.                                                                                                                                                                                                                                                                                       |
| └➔&nbsp;`language`       | `string`     | {% include field-description-language.md %}                                                                                                                                                                                                                                                                                         |
| └➔&nbsp;`urls`           | `string`     | The URI to the  urls  resource where all URIs related to the payment can be retrieved.                                                                                                                                                                                                                                                                     |
| └➔&nbsp;`payeeInfo`      | `string`     | {% include field-description-payeeinfo.md %}                                                                                                                                                                                                                                                 |
| └➔&nbsp;`payers`         | `string`     | The URI to the `payer` resource where the information about the payer can be retrieved.                                                        |
| `operations`              | `array`      | The array of possible operations to perform                                                                                                                                                                                                                                                                                                                |
| └─➔&nbsp;`method`        | `string`     | The HTTP method to use when performing the operation.                                                                                                                                                                                                                                                                                                      |
| └─➔&nbsp;`href`          | `string`     | The target URI to perform the operation against.                                                                                                                                                                                                                                                                                                           |
| └─➔&nbsp;`rel`           | `string`     | The name of the relation the operation has to the current resource.                                                                                                                                                                                                                                                                                        |

## Step 2: Get `approvedLegalAddress` confirmation

{:.code-view-header}
**Request**

```http
POST /psp/invoice/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "addressee": {
        "socialSecurityNumber": "194810205957",
        "zipCode": "55560"
    }
}
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/invoice/payments/{{ page.payment_id }}",
    "approvedLegalAddress": {
        "id": "/psp/invoice/payments/{{ page.payment_id }}/approvedlegaladdress",
        "addressee": "Leo 6",
        "streetAddress": "Gata 535",
        "zipCode": "55560",
        "city": "Vaxholm",
        "countryCode": "SE"
    }
}
```

## Step 3: Complete a Payment

{:.code-view-header}
**Request**

```http
POST /psp/invoice/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "activity": "FinancingConsumer"
    },
    "consumer": {
        "socialSecurityNumber": "194810205957",
        "customerNumber": "123456",
        "email": "someExample@payex.com",
        "msisdn": "+46765432198",
        "ip": "127.0.0.1"
    },
    "legalAddress": {
        "addressee": "Leo 6",
        "streetAddress": "Gata 535",
        "zipCode": "55560",
        "city": "Vaxholm",
        "countryCode": "SE"
    }
}
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/invoice/payments/{{ page.payment_id }}",
    "authorization": {
        "shippingAddress": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/shippingaddress"
        },
        "legalAddress": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/legaladdress"
        },
        "id": "/psp/invoice/payments/{{ page.payment_id }}/authorizations/23fc8ea7-57b8-44bb-8313-08d7ca2e1a26",
        "transaction": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/transactions/23fc8ea7-57b8-44bb-8313-08d7ca2e1a26",
            "created": "2020-03-17T09:46:10.3506297Z",
            "updated": "2020-03-17T09:46:12.2512221Z",
            "type": "Authorization",
            "state": "Completed",
            "number": 71100537930,
            "amount": 4201,
            "vatAmount": 0,
            "description": "Books & Ink",
            "payeeReference": "1584438350",
            "isOperational": false,
            "operations": []
        }
    }
}
```

The sequence diagram below shows a high level description of the invoice
process, including the four requests you have to send to Swedbank Pay to create
an authorized transaction.

## Invoice flow

```mermaid
sequenceDiagram
    Payer->>Merchant: Start purchase (collect SSN and postal number)
    activate Merchant
    note left of Merchant: First API request
    Merchant->>-Swedbank Pay: POST <Invoice Payments> (operation=FinancingConsumer)
    activate Swedbank Pay
    Swedbank Pay-->>-Merchant: payment resource
    activate Merchant
    note left of Merchant: Second API request
    Merchant->>-Swedbank Pay: POST <approvedLegalAddress> (SNN and postal number)
    activate Swedbank Pay
    Swedbank Pay->>Swedbank Pay: Update payment with payer's delivery address
    Swedbank Pay-->>-Merchant: Approved legaladdress information
    activate Merchant
    Merchant-->>-Payer: Display all details and final price
    activate Payer
    Payer->>Payer: Input email and mobile number
    Payer->>-Merchant: Confirm purchase
    activate Merchant

    note left of Merchant: Third API request
    Merchant->>-Swedbank Pay: POST <invoice authorizations> (Transaction Activity=FinancingConsumer)
    activate Swedbank Pay
    Swedbank Pay-->>-Merchant: Transaction result
    activate Merchant
    note left of Merchant: Fourth API request
    Merchant->>-Swedbank Pay: GET <invoice payments>
    activate Swedbank Pay
    Swedbank Pay-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Payer: Display result
```

## Options after posting a purchase payment

Head over to [Capture][capture] to complete the Invoice Direct integration.

{% include iterator.html prev_href="seamless-view" prev_title="Seamless View"
next_href="capture" next_title="Capture" %}

[callback]: /payment-instruments/invoice/features/technical-reference/callback
[cancel]: /payment-instruments/invoice/after-payment#cancellations
[capture]: /payment-instruments/invoice/capture
[complete-url]: /payment-instruments/invoice/features/technical-reference/complete-url
[features]: /payment-instruments/invoice/features
[financing-consumer]: /payment-instruments/invoice/other-features#financing-consumer
[recur]: /payment-instruments/invoice/features/optional/recur
[user-agent]: https://en.wikipedia.org/wiki/User_agent
[verify]: /payment-instruments/invoice/features/optional/verify
