---
title: Swedbank Pay Payments Invoice Direct
sidebar:
  navigation:
  - title: Invoice Payments
    items:
    - url: /payments/invoice
      title: Introduction
    - url: /payments/invoice/redirect
      title: Redirect
    - url: /payments/invoice/seamless-view
      title: Seamless View
    - url: /payments/invoice/direct
      title: Direct
    - url: /payments/invoice/after-payment
      title: After Payment
    - url: /payments/invoice/other-features
      title: Other Features
---

{% include alert.html type="neutral" icon="report_problem" header="Disclaimer"
body="Direct Invoice is about to be phased out. This section is only for
merchants that currently have a contract with this integration." %}

{% include jumbotron.html body="**Direct** is a payment service where Swedbank
Pay helps improve cashflow by purchasing merchant invoices. Swedbank Pay
receives invoice data, which is used to produce and distribute invoices to the
consumer/end-user" %}

## Introduction

1. Collect all purchase information and send it in a `POST` request to Swedbank
   Pay.
1. Include personal information (SSN and postal code) and send it to Swedbank
   Pay.
1. Make a new `POST` request towards Swedbank Pay to retrieve the name and
   address of the customer.
1. Create an authorization transaction by calculating the final price / amount.
1. Make a third `POST` request with consumer data as input.
1. Send a  `GET` request with the `paymentID` to get the authorization result
1. Make a Capture by creating a `POST` request

  **By making a Capture, Swedbank Pay will generate
  the invoice to the consumer and the order is ready for shipping.**

## Options before posting a payment

All valid options when posting a payment with operation equal to
`FinancingConsumer`, are described in
[other features][financing-consumer].

{:.table .table-striped}
|               | Norway ![Norwegian flag][no-png] | Finland ![Finish flag][fi-png] | Sweden ![Swedish flag][se-png] |
| :------------ | :------------------------------- | :----------------------------- | :----------------------------- |
| `operation`   | `FinancingConsumer`              | `FinancingConsumer`            | `FinancingConsumer`            |
| `currency`    | `NOK`                            | `EUR`                          | `SEK`                          |
| `invoiceType` | `PayExFinancingNO`               | `PayExFinancingFI`             | `PayExFinancingSE`             |

* An invoice payment is always two-phased based - you create an Authorize
  transaction, that is followed by a `Capture` or `Cancel` request.

{% include alert-callback-url.md payment_instrument="invoice" %}

{% include alert.html type="neutral" icon="info" body="
Note that the invoice will not be created/distributed before you have
made a `capture` request." %}.

The `Capture` , `Cancel`, `Reversal` opions are
described in [other features][other-features].
The links will take you directly to the API description for the specific request.

The sequence diagram below shows a high level description of the invoice
process, including the four requests you have to send to Swedbank Pay to create
an authorize transaction for Sweden (SE) and Norway (NO). Note that for Finland
(FI) the process is different as the Merchant needs to send a `POST` request
with the `approvedLegalAddress` (SNN and postal number).

## Invoice flow (SE and NO)

```mermaid
sequenceDiagram
    Consumer->>Merchant: Start purchase (collect SSN and postal number)
    activate Merchant
    note left of Merchant: First API request
    Merchant->>-Swedbank Pay: POST <Invoice Payments> (operation=FinancingConsumer)
    activate Swedbank Pay
    Swedbank Pay-->>-Merchant: payment resource
    activate Merchant
    note left of Merchant: Second API request
    Merchant-->>-Swedbank Pay: POST <approvedLegalAddress> (SNN and postal number)
    activate Swedbank Pay
    Swedbank Pay-->>Swedbank Pay: Update payment with consumer delivery address
    Swedbank Pay-->>-Merchant: Approved legaladdress information
    activate Merchant
    Merchant-->>-Consumer: Display all details and final price
    activate Consumer
    Consumer->>Consumer: Input email and mobile number
    Consumer->>-Merchant: Confirm purchase
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
    Merchant-->>-Consumer: Display result
```

## Invoice Flow (FI)

```mermaid
sequenceDiagram
    Consumer->>Merchant: start purchase
    activate Merchant
    note left of Merchant: First API request
    Merchant->>-Swedbank Pay: POST <Invoice Payments> (operation=FinancingConsumer)
    activate Swedbank Pay
    Swedbank Pay-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Consumer: Display All detail and final price
    activate Consumer
    Consumer-->>Consumer: Input consumer data
    Consumer->>-Merchant: Confirm purchase
    activate Merchant
    note left of Merchant: Second API request
    Merchant->>-Swedbank Pay: POST <Invoice autorizations> (Transaction Activity=FinancingConsumer)
    activate Swedbank Pay
    Swedbank Pay->>-Merchant: Transaction result
    activate Merchant
    note left of Merchant: Third API request
    Merchant->>-Swedbank Pay: GET <Invoice payments>
    activate Swedbank Pay
    Swedbank Pay-->>-Merchant: payment resource
    activate Merchant
    Merchant-->>-Consumer: Display result
```

## API Requests

The API requests are displayed in the [purchase flow](#purchase-flow).
You can complete the invoice payment with following `operation`
options:

* [Financing Consumer][financing-consumer]
* [Recur][recur]
* [Verify][verify]

Our `payment` example below uses the [`FinancingConsumer`][financing-consumer] value.

### Financing Consumer

{:.code-header}
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
        "payerReference": "SomeReference",
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
        }
    },
    "invoice": {
        "invoiceType": "PayExFinancingSe"
    }
}
```

{:.table .table-striped}
| Required | Field                             | Type          | Description                                                                                                                                                                                                                                                                                                            |
| :------: | :-------------------------------- | :------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `payment`                         | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                  |
|  ✔︎︎︎︎︎  | └➔&nbsp;`operation`               | `string`      | The operation that the `payment` is supposed to perform. The [`FinancingConsumer`][financing-consumer] operation is used in our example. Take a look at the Other Features section for a full examples of the following `operation` options: [FinancingConsumer][financing-consumer], [Recur][recur], [Verify][verify] |
|  ✔︎︎︎︎︎  | └➔&nbsp;`intent`                  | `string`      | `Authorization` is the only intent option for invoice. Reserves the amount, and is followed by a [cancellation][cancel] or [capture][capture] of funds.                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └➔&nbsp;`currency`                | `string`      | NOK, SEK, DKK, USD or EUR.                                                                                                                                                                                                                                                                                             |
|  ✔︎︎︎︎︎  | └➔&nbsp;`prices`                  | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                  |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`type`                   | `string`      | Use the `Invoice` type here                                                                                                                                                                                                                                                                                            |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`amount`                 | `integer`     | {% include field-description-amount.md %}                                                                                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`vatAmount`              | `integer`     | {% include field-description-vatamount.md %}                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`             | `string(40)`  | A textual description max 40 characters of the purchase.                                                                                                                                                                                                                                                               |
|          | └➔&nbsp;`payerReference`          | `string`      | The reference to the payer (consumer/end user) from the merchant system. E.g mobile number, customer number etc.                                                                                                                                                                                                       |
|          | └➔&nbsp;`generateRecurrenceToken` | `boolean`     | `true` or `false`. Set this to `true` if you want to create a recurrenceToken for future use Recurring purchases (subscription payments).                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └➔&nbsp;`userAgent`               | `string`      | The user agent reference of the consumer's browser - [see user agent definition][user-agent-definition]                                                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └➔&nbsp;`language`                | `string`      | `nb-NO`, `sv-SE` or `en-US`.                                                                                                                                                                                                                                                                                           |
|  ✔︎︎︎︎︎  | └➔&nbsp;`urls`                    | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                                                 |
|          | └─➔&nbsp;`hostUrl`                | `array`       | The array of URLs valid for embedding of Swedbank Pay Hosted Views. If not supplied, view-operation will not be available.                                                                                                                                                                                             |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`completeUrl`            | `string`      | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment to inspect it further.                     |
|          | └─➔&nbsp;`cancelUrl`              | `string`      | The URI to redirect the payer to if the payment is canceled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only `cancelUrl` or `paymentUrl` can be used, not both.                                                                                                                |
|          | └─➔&nbsp;`callbackUrl`            | `string`      | The URL that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][callback] for details.                                                                                                                                                                |
|          | └─➔&nbsp;`logoUrl`                | `string`      | The URL that will be used for showing the customer logo. Must be a picture with maximum 50px height and 400px width. Require https.                                                                                                                                                                                    |
|          | └─➔&nbsp;`termsOfServiceUrl`      | `string`      | A URL that contains your terms and conditions for the payment, to be linked on the payment page. Require https.                                                                                                                                                                                                        |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeInfo`               | `object`      | The `payeeInfo` contains information about the payee.                                                                                                                                                                                                                                                                  |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeId`                | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                  |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeReference`         | `string(30*)` | A unique reference from the merchant system, which is used as a receipt/invoice number in Invoice Payments. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [`payeeReference`][payee-reference] for details.                                                              |
|          | └─➔&nbsp;`payeeName`              | `string`      | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                                                                                |
|          | └─➔&nbsp;`productCategory`        | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                         |
|          | └─➔&nbsp;`orderReference`         | `String(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                |
|          | └─➔&nbsp;`subsite`                | `String(40)`  | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                                                                                            |

{:.code-header}
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
        "amount": 1500,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "payerReference": "AB1234",
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
| └➔&nbsp;`description`    | `string(40)` | A textual description of maximum 40 characters of the purchase.                                                                                                                                                                                                                                                                                            |
| └➔&nbsp;`payerReference` | `string`     | The reference to the payer (consumer/end-user) from the merchant system, like e-mail address, mobile number, customer number etc.                                                                                                                                                                                                                          |
| └➔&nbsp;`userAgent`      | `string`     | The [user agent][user-agent-definition] string of the consumer's browser.                                                                                                                                                                                                                                                                                  |
| └➔&nbsp;`language`       | `string`     | `nb-NO` , `sv-SE`  or  `en-US`                                                                                                                                                                                                                                                                                                                             |
| └➔&nbsp;`urls`           | `string`     | The URI to the  urls  resource where all URIs related to the payment can be retrieved.                                                                                                                                                                                                                                                                     |
| └➔&nbsp;`payeeInfo`      | `string`     | The URI to the  payeeinfo  resource where the information about the payee of the payment can be retrieved.                                                                                                                                                                                                                                                 |
| `operations`             | `array`      | The array of possible operations to perform                                                                                                                                                                                                                                                                                                                |
| └─➔&nbsp;`method`        | `string`     | The HTTP method to use when performing the operation.                                                                                                                                                                                                                                                                                                      |
| └─➔&nbsp;`href`          | `string`     | The target URI to perform the operation against.                                                                                                                                                                                                                                                                                                           |
| └─➔&nbsp;`rel`           | `string`     | The name of the relation the operation has to the current resource.                                                                                                                                                                                                                                                                                        |

### Operations

The operations should be performed as described in each response and not as
described here in the documentation.
Always use the `href` and `method` as specified in the response by finding
the appropriate operation based on its `rel` value.
The only thing that should be hard coded in the client is the value of
the `rel` and the request that will be sent in the HTTP body of the request
for the given operation.

{:.table .table-striped}
| Operation                | Description                                                                                                               |
| :----------------------- | :------------------------------------------------------------------------------------------------------------------------ |
| `update-payment-abort`   | [Aborts][abort] the payment order before any financial transactions are performed.                                        |
| `redirect-authorization` | Contains the URI that is used to redirect the consumer to the Swedbank Pay Payments containing the card authorization UI. |
| `view-authorization`     | Contains the JavaScript `href` that is used to embed  the card authorization UI directly on the webshop/merchant site     |
| `create-capture`         | Creates a `capture` transaction in order to charge the reserved funds from the consumer.                                  |
| `create-cancellation`    | Creates a `cancellation` transaction that cancels a created, but not yet captured payment.                                |

If a `GET` method is used from payment UI  with a `paymentToken`, the following
operations can be returned, depending on state of the payment and the last
transaction.

```js
"operations": [
    {
        "href": "https://example.com/cancelUrl",
        "rel": "redirect-merchant-cancel",
        "method": "GET"
    },
    {
        "href": "https://example.com/completeUrl",
        "rel": "redirect-merchant-complete",
        "method": "GET"
    },
    {
        "href": "https://example.com/cancelUrl",
        "rel": "redirect-merchant-cancel",
        "method": "GET"
    },
    {
        "href": "https://example.com/completeUrl",
        "rel": "redirect-merchant-complete",
        "method": "GET"
    }
]
```

{% include iterator.html prev_href="seamless-view" prev_title="Back: Seamless View"
next_href="after-payment" next_title="Next: After Payment" %}

[abort]: /payments/invoice/other-features#abort
[callback]: /payments/invoice/other-features#callback
[cancel]: /payments/invoice/after-payment#cancellations
[capture]: /payments/invoice/after-payment#capture
[fi-png]: /assets/img/fi.png
[financing-consumer]: /payments/invoice/other-features#financing-consumer
[financing-invoice-1-png]: /assets/img/checkout/test-purchase.png
[financing-invoice-2-png]: /assets/screenshots/invoice/redirect-view/iframe-verify-data.png
[no-png]: /assets/img/no.png
[other-features]: /payments/invoice/other-features
[payee-reference]: /payments/invoice/other-features#payee-info
[recur]: /payments/invoice/other-features#recur
[redirect]: /payments/invoice/redirect
[se-png]: /assets/img/se.png
[setup-mail]: mailto:setup.ecom@PayEx.com
[user-agent-definition]: https://en.wikipedia.org/wiki/User_agent
[verify]: /payments/invoice/other-features#verify
