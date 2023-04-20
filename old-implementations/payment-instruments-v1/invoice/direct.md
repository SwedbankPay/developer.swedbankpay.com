---
title: Direct
redirect_from: /payments/invoice/direct
description: |
  **Direct** is a payment service where Swedbank
  Pay helps improve cashflow by purchasing merchant invoices. Swedbank Pay
  receives invoice data, which is used to produce and distribute invoices to the
  payer.
menu_order: 700
---

{% assign financing_consumer_url="/old-implementations/payment-instruments-v1/invoice/features/technical-reference/financing-consumer" %}
{% assign cancel_url="/old-implementations/payment-instruments-v1/invoice/after-payment#cancellations" %}
{% assign capture_url="/old-implementations/payment-instruments-v1/invoice/capture" %}

{% include alert.html type="warning" icon="report_problem" body="**Disclaimer**:
Direct Invoice is about to be phased out. This section is only for merchants
who currently have a contract with this integration." %}

## Invoice Direct Implementation Flow

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

## Step 1: Create A Purchase

Our `payment` example below uses the [`FinancingConsumer`]({{
financing_consumer_url }}) value.

{% include alert-gdpr-disclaimer.md %}

## Financing Consumer Request

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
        "generatePaymentToken": false,
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
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

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                             | Type          | Description                                                                                                                                                                                                                                                                                                            |
| :--------------: | :-------------------------------- | :------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %}︎︎︎︎︎ | {% f payment, 0 %}                         | `object`      | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                  |
| {% icon check %}︎︎︎︎︎ | {% f operation %}               | `string`      | The operation that the `payment` is supposed to perform. The [`FinancingConsumer`]({{ financing_consumer_url }}) operation is used in our example. |
| {% icon check %}︎︎︎︎︎ | {% f intent %}                  | `string`      | `Authorization` is the only intent option for invoice. Reserves the amount, and is followed by a [cancellation]({{ cancel_url }}) or [capture]({{ capture_url }}) of funds.                                                                                                                                                                |
| {% icon check %}︎︎︎︎︎ | {% f currency %}                | `string`      | NOK, SEK, DKK, USD or EUR.                                                                                                                                                                                                                                                                                             |
| {% icon check %}︎︎︎︎︎ | {% f prices %}                  | `object`      | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                  |
| {% icon check %}︎︎︎︎︎ | {% f type, 2 %}                   | `string`      | {% include fields/prices-type.md kind="Invoice" %}                                                                                                                                                                                                                                                                                            |
| {% icon check %}︎︎︎︎︎ | {% f amount, 2 %}                 | `integer`     | {% include fields/amount.md %}                                                                                                                                                                                                                                                                              |
| {% icon check %}︎︎︎︎︎ | {% f vatAmount, 2 %}              | `integer`     | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                                                           |
| {% icon check %}︎︎︎︎︎ | {% f description %}             | `string(40)`  | {% include fields/description.md %}                                                                                                                                                                                                                                         |
| {% icon check %}︎︎︎︎︎ | {% f userAgent %}               | `string`      | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                   |
| {% icon check %}︎︎︎︎︎ | {% f language %}                | `string`      | {% include fields/language.md %}                                                                                                                                                                                                                                                     |
| {% icon check %}︎︎︎︎︎ | {% f urls %}                    | `object`      | The `urls` resource lists urls that redirects users to relevant sites.                                                                                                                                                                                                                                                 |
|                  | {% f hostUrl, 2 %}                | `array`       | The array of URLs valid for embedding of Swedbank Pay Seamless Views. If not supplied, view-operation will not be available.                                                                                                                                                                                             |
| {% icon check %}︎︎︎︎︎ | {% f completeUrl, 2 %}            | `string`      | {% include fields/complete-url.md resource="payment" %}                     |
|                  | {% f cancelUrl, 2 %}              | `string`      | The URL to redirect the payer to if the payment is cancelled. Only used in redirect scenarios. Can not be used simultaneously with `paymentUrl`; only `cancelUrl` or `paymentUrl` can be used, not both.                                                                                                                |
|                  | {% f callbackUrl, 2 %}            | `string`      | {% include fields/callback-url.md resource="payment" %}                                                                                                                                                                |
|                  | {% f logoUrl, 2 %}                | `string`      | {% include fields/logo-url.md %}                                                        |
|                  | {% f termsOfServiceUrl, 2 %}      | `string`      | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                                                   |
| {% icon check %}︎︎︎︎︎ | {% f payeeInfo %}               | `object`      | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                                  |
| {% icon check %}︎︎︎︎︎ | {% f payeeId, 2 %}                | `string`      | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                                                  |
| {% icon check %}︎︎︎︎︎ | {% f payeeReference, 2 %}         | `string` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                                                               |
|                  | {% f payeeName, 2 %}              | `string`      | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                                                                |
|                  | {% f productCategory, 2 %}        | `string`      | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                         |
|                  | {% f orderReference, 2 %}         | `string(50)`  | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                |
|                  | {% f subsite, 2 %}                | `string(40)`  | {% include fields/subsite.md %}                                                                                                                                                            |
|                  | {% f payer %}                   | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | {% f payerReference, 2 %}         | `string`     | {% include fields/payer-reference.md %}                                                                                                                                                                                                                                                           |
{% endcapture %}
{% include accordion-table.html content=table %}

## Financing Consumer Response

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
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
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

{% capture table %}
{:.table .table-striped .mb-5}
| Field                  | Type         | Description                                                                                                                                                                                                                                                                                                                                                |
| :--------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}     | `object`     | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                      |
| {% f id %}             | `string`     | {% include fields/id.md %}                                                                                                                                                                                                                                                                                                                      |
| {% f number %}         | `integer`    | {% include fields/number.md resource="payment" %} |
| {% f created %}        | `string`     | The ISO-8601 date of when the payment was created.                                                                                                                                                                                                                                                                                                         |
| {% f updated %}        | `string`     | The ISO-8601 date of when the payment was updated.                                                                                                                                                                                                                                                                                                         |
| {% f state %}          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment, not the state of any transactions performed on the payment. To find the state of the payment's transactions (such as a successful authorization), see the `transactions` resource or the different specialized type-specific resources such as `authorizations` or `sales`. |
| {% f prices %}         | `object`     | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                      |
| {% f id, 2 %}          | `string`     | {% include fields/id.md resource="prices" %}                                                                                                                                                                                                                                                                                                    |
| {% f description %}    | `string(40)` | {% include fields/description.md %}                                                                                                                                                                                                                                                                             |
| {% f userAgent %}      | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                                       |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                                                                                                                                                         |
| {% f urls %}           | `string`     | The URL to the  urls  resource where all URLs related to the payment can be retrieved.                                                                                                                                                                                                                                                                     |
| {% f payeeInfo %}      | `string`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                 |
| {% f payers %}         | `string`     | The URL to the `payer` resource where the information about the payer can be retrieved.                                                        |
| {% f operations, 0 %}  | `array`      | {% include fields/operations.md resource="payment" %}                                                                                                                                                                                                                                                                                                                |
| {% f method, 2 %}      | `string`     | The HTTP method to use when performing the operation.                                                                                                                                                                                                                                                                                                      |
| {% f href, 2 %}        | `string`     | The target URL to perform the operation against.                                                                                                                                                                                                                                                                                                           |
| {% f rel, 2 %}         | `string`     | The name of the relation the operation has to the current resource.                                                                                                                                                                                                                                                                                        |
{% endcapture %}
{% include accordion-table.html content=table %}

## Step 2: Get `approvedLegalAddress` Confirmation

Retrieve the payer's legal address, which is needed to do the next step.

## Approved Legal Address Request

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

## Approved Legal Address Response

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

## Step 3: Complete The Payment

Add the legal address in your complete request.

## Complete Request

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

## Complete Response

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

## Invoice Flow

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

## Options After Posting A Purchase Payment

Head over to [Capture][capture] to complete the Invoice Direct integration.

{% include iterator.html prev_href="seamless-view" prev_title="Seamless View"
next_href="capture" next_title="Capture" %}

[capture]: /old-implementations/payment-instruments-v1/invoice/capture
[features]: /old-implementations/payment-instruments-v1/invoice/features
