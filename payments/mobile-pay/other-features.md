---
title: Swedbank Pay Payments Mobile Pay Other Features
sidebar:
  navigation:
  - title: MobilePay Payments
    items:
    - url: /payments/mobile-pay
      title: Introduction
    - url: /payments/mobile-pay/redirect
      title: Redirect
    - url: /payments/mobile-pay/after-payment
      title: After Payment
    - url: /payments/mobile-pay/other-features
      title: Other Features
---

{% include alert-development-section.md %}

## Payment Resource

### Create Payment

To create a Mobile Pay payment, you perform an HTTP `POST` against the
`/psp/mobilepay/payments` resource. Please read the [general
information][general-http-info] on how to compose a valid HTTP request before
proceeding.

An example of a payment creation request is provided below. Each individual
Property of the JSON document is described in the following section. Use the
[expand][technical-reference-expand] request parameter to get a response that
includes one or more expanded sub-resources inlined.

{:.code-header}
**Request**

```http
POST /psp/mobilepay/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "DKK",
        "prices": [
            {
                "type": "Visa",
                "amount": 1500,
                "vatAmount": 0,
                "FeeAmount": 5
            },
            {
                "type": "MasterCard",
                "amount": 1500,
                "vatAmount": 0,
                "FeeAmount": 10
            }
        ],
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "userAgent": "Mozilla/5.0...",
        "language": "da-DK",
        "urls": {
            "hostUrls": ["https://example.com", "https://example.net"],
            "completeUrl": "http://example.com/payment-completed",
            "cancelUrl": "http://example.com/payment-canceled",
            "callbackUrl": "http://example.com/payment-callback"
        },
        "payeeInfo": {
            "payeeId": "12345678-1234-1234-1234-123456789012",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite"
        },
        "prefillInfo": {
            "msisdn": "+4522222222"
        }
    },
    "mobilepay": {
        "shoplogoUrl": "https://example.com/shop-logo.png"
    }
}
```

{:.table .table-striped}
| Required | Property                        | Data type    | Description                                                                                                                                                                                                                                               |
| :------- | :------------------------------ | :----------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ✔︎︎︎︎︎   | `payment`                       | `object`     | The payment object.                                                                                                                                                                                                                                       |
| ✔︎︎︎︎︎   | └➔&nbsp;`operation`             | `string`     | `Purchase`                                                                                                                                                                                                                                                |
| ✔︎︎︎︎︎   | └➔&nbsp;`intent`                | `string`     | `Authorization`                                                                                                                                                                                                                                           |
| ✔︎︎︎︎︎   | └➔&nbsp;`currency`              | `string`     | `NOK`, `SEK`, `DKK`, `USD` or `EUR`.                                                                                                                                                                                                                      |
| ✔︎︎︎︎︎   | └➔&nbsp;`prices`                | `object`     | The prices object.                                                                                                                                                                                                                                        |
| ✔︎︎︎︎︎   | └─➔&nbsp;`type`                 | `string`     | `Visa` (for card type Visa), `MC` (for card type Mastercard)                                                                                                                                                                                              |
| ✔︎︎︎︎︎   | └─➔&nbsp;`amount`               | `integer`    | Amount is entered in the lowest momentary units of the selected currency. E.g. 10000 = 100.00 DKK, 5000 = 50.00 DKK.                                                                                                                                      |
| ✔︎︎︎︎︎   | └─➔&nbsp;`vatAmount`            | `integer`    | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                                                                        |
|          | └─➔&nbsp;`feeAmount`            | `integer`    | If the amount given includes Fee, this may be displayed for the user in the payment page (redirect only).                                                                                                                                                 |
| ✔︎︎︎︎︎   | └➔&nbsp;`description`           | `string(40)` | A textual description max 40 characters of the purchase.                                                                                                                                                                                                  |
|          | └➔&nbsp;`payerReference`        | `string`     | The reference to the payer (consumer/end-user) from the merchant system, like mobile number, customer number etc.                                                                                                                                         |
| ✔︎︎︎︎︎   | └➔&nbsp;`userAgent`             | `string`     | The user agent reference of the consumer's browser - [see user agent definition][user-agent]                                                                                                                                                              |
| ✔︎︎︎︎︎   | └➔&nbsp;`language`              | `string`     | `nb-NO`, `sv-SE` or `en-US`.                                                                                                                                                                                                                              |
| ✔︎︎︎︎︎   | └➔&nbsp;`urls`                  | `object`     | The URLs object containing the urls used for this payment.                                                                                                                                                                                                |
| ✔︎︎︎︎︎   | └─➔&nbsp;`completeUrl`          | `string`     | The URI that Swedbank Pay will redirect back to when the payment page is completed. This does not indicate a successful payment, only that it has reached a completion state. A `GET` request needs to be performed on the payment to inspect it further. |
| ✔︎︎︎︎︎   | └─➔&nbsp;`cancelUrl`            | `string`     | The URI that Swedbank Pay will redirect back to when the user presses the cancel button in the payment page.                                                                                                                                              |
|          | └─➔&nbsp;`callbackUrl`          | `string`     | The URI that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][callback-reference] for details.                                                                                         |
| ✔︎︎︎︎︎   | └➔&nbsp;`payeeInfo`             | `object`     | This object contains the identificators of the payee of this payment.                                                                                                                                                                                     |
| ✔︎︎︎︎︎   | └─➔&nbsp;`payeeId`              | `string`     | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                     |
| ✔︎︎︎︎︎   | └─➔&nbsp;`payeeReference`       | `string(50)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation.. See [[`payeeReference`>>doc:Main.ecommerce.technical-reference.WebHome                                             |  | anchor="HPayeeReference"]] for details. |
|          | └─➔&nbsp;`payeeName`            | `string`     | The payee name (like merchant name) that will be displayed to consumer when redirected to Swedbank Pay.                                                                                                                                                   |
|          | └─➔&nbsp;`productCategory`      | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                            |
|          | └─➔&nbsp;`orderReference`       | `String(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                   |
|          | └─➔&nbsp;`subsite`              | `String(40)` | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                               |
|          | └➔&nbsp;`prefillInfo.msisdn`    | `string`     | umber will be prefilled on payment page, if valid.                                                                                                                                                                                                        |
|          | └➔&nbsp;`mobilepay.shoplogoUrl` | `string`     | URI to logo that will be visible at MobilePay                                                                                                                                                                                                             |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "prices": {
            "id": "/psp/mobilepay/payments/{{ page.paymentId }}/prices"
        },
        "id": "/psp/mobilepay/payments/{{ page.paymentId }}",
        "number": 75100000121,
        "created": "2018-09-11T10:58:27.4236127Z",
        "updated": "2018-09-11T10:58:30.8254419Z",
        "instrument": "MobilePay",
        "operation": "Purchase",
        "intent": "Authorization",
        "state": "Ready",
        "currency": "DKK",
        "amount": 3000,
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "initiatingSystemUserAgent": "PostmanRuntime/7.2.0",
        "userAgent": "Mozilla/5.0",
        "language": "da-DK",
        "transactions": {
            "id": "/psp/mobilepay/payments/{{ page.paymentId }}/transactions"
        },
        "urls": {
            "id": "/psp/mobilepay/payments/{{ page.paymentId }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/mobilepay/payments/{{ page.paymentId }}/payeeinfo"
        }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://{{ page.apiUrl }}/psp/mobilepay/payments/{{ page.paymentId }}",
            "rel": "update-payment-abort"
        },
        {
            "method": "GET",
            "href": "https://{{ page.frontEndUrl }}/mobilepay/payments/authorize/{{ page.transactionId }}",
            "rel": "redirect-authorization"
        }
    ]
}
```

| Property                                     | Data type    | Description                                                                                                                                                                                      |
| :------------------------------------------- | :----------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                                    | `object`     | The payment object contains information about the retrieved payment.                                                                                                                             |
| └➔&nbsp;`id`                                 | `string`     | The relative URI to the payment.                                                                                                                                                                 |
| └➔&nbsp;`number`                             | `integer`    | The payment `number`, useful when there's need to reference the payment in human communication. Not usable for programmatic identification of the payment, for that `id` should be used instead. |
| └➔&nbsp;`created`                            | `string`     | The ISO-8601 date of when the payment was created.                                                                                                                                               |
| └➔&nbsp;`updated`                            | `string`     | The ISO-8601 date of when the payment was updated.                                                                                                                                               |
| └➔&nbsp;`instrument`                         | `string`     | The instrument used                                                                                                                                                                              |
| └➔&nbsp;`operation`                          | `string`     | Purchase                                                                                                                                                                                         |
| └➔&nbsp;`intent`                             | `string`     | The intent sent in on request                                                                                                                                                                    |
| └➔&nbsp;`state`                              | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment. This field is only for status display purposes.                                                                   |
| └➔&nbsp;`currency`                           | `string`     | The currency used                                                                                                                                                                                |
| └➔&nbsp;`prices.amount`                      | `integer`    | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 DKK`, `5000` = `50.00 DKK`.                                                                     |
| └➔&nbsp;`prices.remainingCaptureAmount`      | `integer`    | The amount available for capture. Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 DKK`, `5000` = `50.00 DKK`.                                   |
| └➔&nbsp;`prices.remainingCancellationAmount` | `integer`    | The amount available for cancellation. Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 DKK`, `5000` = `50.00 DKK`.                              |
| └➔&nbsp;`prices.remainingReversalAmount`     | `integer`    | The amount available for reversal. Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 DKK`, `5000` = `50.00 DKK`.                                  |
| └➔&nbsp;`description`                        | `string(40)` | A textual description of maximum 40 characters of the purchase.                                                                                                                                  |
| └➔&nbsp;`payerReference`                     | `string`     | The reference to the payer (consumer/end-user) from the merchant system, like mobile number, customer number etc.                                                                                |
| └➔&nbsp;`initiatingSystemUserAgent`          | `string`     | The system user agent used                                                                                                                                                                       |
| └➔&nbsp;`userAgent`                          | `string`     | The [user agent][user-agent] string of the consumer's browser.                                                                                                                                   |
| └➔&nbsp;`language`                           | `string`     | `nb-NO`, `sv-SE` or `en-US`                                                                                                                                                                      |
| └➔&nbsp;`urls`                               | `string`     | The URI to the `urls` resource where all URIs related to the payment can be retrieved.                                                                                                           |
| └➔&nbsp;`payeeInfo`                          | `string`     | The URI to the `payeeinfo` resource where the information about the payee of the payment can be retrieved.                                                                                       |

## Purchase

Posting a payment (operation `purchase`) returns the options of aborting the
payment altogether or creating an authorization transaction through the
`redirect-authorization` hyperlink.
Use the expand request parameter to get a response that includes one or more
expanded sub-resources inlined.

```json
{
    "payment": {
        "operation": "Purchase"
    }
}
```

## Operations

When a payment resource is created and during its lifetime, it will have a set
of operations that can be performed on it.
Which operations are available will vary depending on the state of the payment
resource, what the access token is authorized to do, etc.
A list of possible operations and their explanation is given below.

```json
{
    "payment": {},
    "operations": [
        {
            "href": "http://{{ page.apiUrl }}/psp/mobilepay/payments/{{ page.paymentId }}",
            "rel": "update-payment-abort",
            "method": "PATCH"
        },
        {
            "href": "https://{{ page.frontEndUrl }}/mobilepay/payments/authorize/{{ page.paymentId }}",
            "rel": "redirect-authorization",
            "method": "GET"
        },
        {
            "href": "https://{{ page.apiUrl }}/psp/mobilepay/payments/{{ page.paymentId }}/captures",
            "rel": "create-capture",
            "method": "POST"
        },
        {
            "href": "https://{{ page.apiUrl }}/psp/mobilepay/payments/{{ page.paymentId }}/cancellations",
            "rel": "create-cancellation",
            "method": "POST"
        },
        {
            "href": "https://{{ page.apiUrl }}/psp/mobilepay/payments/{{ page.paymentId }}/reversals",
            "rel": "create-reversal",
            "method": "POST"
        },
    ]
}
```

{:.table .table-striped}
| Property | Description                                                         |
| :------- | :------------------------------------------------------------------ |
| `href`   | The target URI to perform the operation against.                    |
| `rel`    | The name of the relation the operation has to the current resource. |
| `method` | The HTTP method to use when performing the operation.               |

The operations should be performed as described in each response and not as
described here in the documentation.
Always use the `href` and `method` as specified in the response by finding the
appropriate operation based on its `rel` value.
The only thing that should be hard coded in the client is the value of
the `rel` and the request that will be sent in the HTTP body of the
request for the given operation.

{:.table .table-striped}
| Operation                | Description                                                                  |
| :----------------------- | :--------------------------------------------------------------------------- |
| `update-payment-abort`   | [Aborts][abort] the payment before any financial transactions are performed. |
| `create-authorization`   | Create an [authorization][authorization-transaction] transaction.            |
| `redirect-authorization` | Used to redirect the consumer to the mobilepay authorization UI.             |
| `create-capture`         | Creates a [capture][capture-transaction] transaction.                        |
| `create-cancellation`    | Creates a [cancellation][cancellation-transaction] transaction.              |
| `create-reversal`        | Creates a [reversal][reversal-transaction] transaction.                      |

## MobilePay transactions

All MobilePay specific transactions are described below.

## Authorizations

The `authorizations` resource contains information about the authorization transactions made on a specific payment.

{% include transaction-response.md payment-instrument="mobile-pay"
    transaction="authorization"%}

You can return a specific autorization transaction by adding the transaction id
to the `GET`request.

{:.code-header}
**Request**

```http
GET /psp/mobilepay/payments/{{ page.paymentId }}/authorizations/ HTTP/1.1
Host: {{ page.apiUrl }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/mobilepay/payments/{{ page.paymentId }}",
    "authorization": {
        "id": "/psp/mobilepay/payments/{{ page.paymentId }}/authorizations/{{ page.transactionId }}",
        "paymentToken": "{{ page.paymentToken }}",
        "maskedPan": "123456xxxxxx1234",
        "expireDate": "mm/yyyy",
        "panToken": "{{ page.transactionId }}",
        "cardBrand": "Visa",
        "cardType": "Credit Card",
        "issuingBank": "UTL MAESTRO",
        "countryCode": "999",
        "acquirerTransactionType": "3DSECURE",
        "acquirerStan": "39736",
        "acquirerTerminalId": "39",
        "acquirerTransactionTime": "2017-08-29T13:42:18Z",
        "authenticationStatus": "Y",
        "transaction": {
            "id": "/psp/mobilepay/payments/{{ page.paymentId }}/transactions/{{ page.transactionId }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Authorization",
            "state": "Completed",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456",
            "failedReason": "",
            "isOperational": false,
            "operations": [{
                "href": "{{ page.apiUrl }}/psp/mobilepay/payments/{{ page.paymentId }}",
                "rel": "edit-authorization",
                "method": "PATCH"
            }]
        }
    }
}
```

{:.table .table-striped}
| Property                          | Type      | Description                                                                                                                                                                                                  |
| :-------------------------------- | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                         | `string`  | The relative URI of the payment this authorization transaction resource belongs to.                                                                                                                          |
| `authorization`                   | `string`  | The current authorization transaction resource.                                                                                                                                                              |
| └➔&nbsp;`id`                      | `string`  | The relative URI of the current authorization transaction resource.                                                                                                                                          |
| └➔&nbsp;`paymentToken`            | `string`  | The payment token created for the card used in the authorization.                                                                                                                                            |
| └➔&nbsp;`maskedPan`               | `string`  | The masked PAN number of the card.                                                                                                                                                                           |
| └➔&nbsp;`expireDate`              | `string`  | The month and year of when the card expires.                                                                                                                                                                 |
| └➔&nbsp;`panToken`                | `string`  | The token representing the specific PAN of the card.                                                                                                                                                         |
| └➔&nbsp;`cardBrand`               | `string`  | `Visa`, `MC`, etc. The brand of the card.                                                                                                                                                                    |
| └➔&nbsp;`cardType`                | `string`  | `Credit Card` or `Debit Card`. Indicates the type of card used for the authorization.                                                                                                                        |
| └➔&nbsp;`issuingBank`             | `string`  | The name of the bank that issued the card used for the authorization.                                                                                                                                        |
| └➔&nbsp;`countryCode`             | `string`  | The country the card is issued in.                                                                                                                                                                           |
| └➔&nbsp;`acquirerTransactionType` | `string`  | `3DSECURE` or `SSL`. Indicates the transaction type of the acquirer.                                                                                                                                         |
| └➔&nbsp;`acquirerStan`            | `string`  | The System Trace Audit Number assigned by the acquirer to uniquely identify the transaction.                                                                                                                 |
| └➔&nbsp;`acquirerTerminalId`      | `string`  | The ID of the acquirer terminal.                                                                                                                                                                             |
| └➔&nbsp;`acquirerTransactionTime` | `string`  | The ISO-8601 date and time of the acquirer transaction.                                                                                                                                                      |
| └➔&nbsp;`authenticationStatus`    | `string`  | `Y`, `A`, `U` or `N`. Indicates the status of the authentication.                                                                                                                                            |
| └➔&nbsp;`transaction`             | `object`  | The object representation of the generic transaction resource.                                                                                                                                               |
| └─➔&nbsp;`id`                     | `string`  | The relative URI of the current `transaction` resource.                                                                                                                                                      |
| └─➔&nbsp;`created`                | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`updated`                | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`type`                   | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └─➔&nbsp;`state`                  | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| └─➔&nbsp;`number`                 | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead. |
| └─➔&nbsp;`amount`                 | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 SEK.                                                                                     |
| └─➔&nbsp;`vatAmount`              | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                           |
| └─➔&nbsp;`description`            | `string`  | A human readable description of maximum 40 characters of the transaction.                                                                                                                                    |
| └─➔&nbsp;`payeeReference`         | `string`  | A unique reference for the transaction.                                                                                                                                                                      |
| └─➔&nbsp;`failedReason`           | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                    |
| └─➔&nbsp;`isOperational`          | `bool`    | `true` if the transaction is operational; otherwise `false`.                                                                                                                                                 |
| └─➔&nbsp;`operations`             | `array`   | The array of operations that are possible to perform on the transaction in its current state.                                                                                                                |

### Create authorization transaction

The authorization transaction is initiated by redirecting the end-user/consumer
to the hyperlink returned in the `redirect-authorization` request.

## Captures

The `captures` resource lists the capture transactions (one or more) on a
specific payment.

{% include transaction-response.md payment-instrument="mobile-pay"
    transaction="capture" %}

### Create capture transaction

A `capture` transaction - to withdraw money from the payer's mobilepay - can be
created after a completed authorization by performing the `create-capture`
operation.

{:.code-header}
**Request**

```http
POST /psp/mobilepay/payments/{{ page.paymentId }}/captures HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "amount": 1000,
        "vatAmount": 250,
        "payeeReference": 1234,
        "description" : "description for transaction"
    }
}
```

{:.table .table-striped}
| Required | Property                 | Type         | Description                                                                                                               |
| :------- | :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------ |
| ✔︎︎︎︎︎   | `transaction`            | `object`     | The currenct capture object.                                                                                              |
| ✔︎︎︎︎︎   | └➔&nbsp;`amount`         | `integer`    | Amount Entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 DKK`, `5000` = `50.00 DKK`. |
| ✔︎︎︎︎︎   | └➔&nbsp;`vatAmount`      | `integer`    | Amount Entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 DKK`, `5000` = `50.00 DKK`. |
| ✔︎︎︎︎︎   | └➔&nbsp;`description`    | `string`     | A textual description of the capture transaction.                                                                         |
| ✔︎︎︎︎︎   | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the capture transaction. See [`payeeReference`][payeeReference] for details.                       |

The `capture` resource contains information about the capture transaction made
against a mobilepay payment.
You can return a specific capture transaction by adding the transaction id to
the `GET` request.

{% include transaction-response.md payment-instrument="mobile-pay"
    transaction="capture"%}

## Cancellations

The `cancellations` resource lists the cancellation transactions on a specific
payment.

{% include transaction-response.md payment-instrument="mobile-pay"
    transaction="cancellation" %}

### Create cancellation transaction

Perform the `create-cancel` operation to cancel a previously created payment.
You can only cancel a payment - or part of payment - not yet captured.

{:.code-header}
**Request**

```http
POST /psp/mobilepay/payments/{{ page.paymentId }}/cancellations HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "description": "Test Cancellation",
        "payeeReference": "ABC123"
    }
}
```

{:.table .table-striped}
| Required | Property                 | Type         | Description                                                                                              |
| :------: | :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `transaction`            | `object`     | The current cancellation.                                                                                |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`    | `string`     | A textual description of the reason for the cancellation.                                                |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the cancellation transaction. See [`payeeReference`][payeeReference] for details. |

The `cancel` resource contains information about a cancellation transaction
made against a payment.
You can return a specific cancellation transaction by adding the transaction id
to the `GET` request.

{% include transaction-response.md payment-instrument="mobile-pay"
    transaction="cancellation"%}

## Reversals

The `reversals` resource lists the reversal transactions (one or more) on a
specific payment.

{% include transaction-response.md payment-instrument="mobile-pay"
    transaction="reversal" %}

### Create reversal transaction

The `create-reversal` operation reverses a previously created and captured
payment.

{:.code-header}
**Request**

```http
POST /psp/mobilepay/payments/{{ page.paymentId }}/reversals HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "amount": 1000,
        "vatAmount": 0,
        "description" : "Test Reversal",
        "payeeReference": "DEF456"
    }
}
```

{:.table .table-striped}
| Required | Property                 | Type         | Description                                                                                                               |
| :------: | :----------------------- | :----------- |
|    ✔︎    | `transaction`            | `object`     | The current reversal transaction object                                                                                   |
|    ✔︎    | └➔&nbsp;`amount`         | `integer`    | Amount Entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 DKK`, `5000` = `50.00 DKK`. |
|    ✔︎    | └➔&nbsp;`vatAmount`      | `integer`    | Amount Entered in the lowest momentary units of the selected currency. E.g. `10000` = `100.00 DKK`, `5000` = `50.00 DKK`. |
|    ✔︎    | └➔&nbsp;`description`    | `string`     | A textual description of the capture                                                                                      |
|    ✔︎    | └➔&nbsp;`payeeReference` | `string(50)` | A unique reference for the reversal transaction. See [`payeeReference`][payeeReference] for details.                      |

The `reversal` resource contains information about a reversal transaction made
against a payment.
You can return a specific reversal transaction by adding the transaction id to
the `GET` request.

{% include transaction-response.md payment-instrument="mobile-pay"
    transaction="reversal"%}

## Capture Sequence

Capture can only be perfomed on a payment with a successfully authorized
transaction.
It is possible to do a part-capture where you only capture a smaller amount
than the authorized amount.
You can later do more captures on the same payment up to the total
authorization amount.

```mermaid
sequenceDiagram
  Merchant->>PayEx: POST <creditcard capture>
  Activate Merchant
  Activate PayEx
  PayEx-->>Merchant: transaction resource
  Deactivate PayEx
  Deactivate Merchant
```

## Cancel Sequence

Cancel can only be done on a authorized transaction.
If you do cancel after doing a part-capture you will cancel the difference
between the captured amount and the authorized amount.

```mermaid
sequenceDiagram
  Merchant->>PayEx: POST <creditcard cancellation>
  Activate Merchant
  Activate PayEx
  PayEx-->>Merchant: transaction resource
  Deactivate PayEx
  Deactivate Merchant
```

## Reversal Sequence

Reversal can only be done on a payment where there are some captured amount
not yet reversed.

```mermaid
sequenceDiagram
  Merchant->>PayEx: POST <creditcard reversal>
  Activate Merchant
  Activate PayEx
  PayEx-->>Merchant: transaction resource
  Deactivate PayEx
  Deactivate Merchant
```

### Abort a payment

To abort a payment, perform the `update-payment-abort` operation that is
returned in the payment request. You need to include the following HTTP body:

{:.code-header}
**Request**

```http
PATCH /psp/creditcard/payments/{{ page.paymentId }} HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "payment": {
    "operation": "Abort",
    "abortReason": "CancelledByConsumer"
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
        "id": "/psp/creditcard/payments/{{ page.paymentId }}",
        "number": 70100130293,
        "created": "2019-01-09T13:11:28.371179Z",
        "updated": "2019-01-09T13:11:46.5949967Z",
        "instrument": "CreditCard",
        "operation": "Purchase",
        "intent": "AutoCapture",
        "state": "Aborted",
        "currency": "DKK",
        "prices": {
            "id": "/psp/creditcard/payments/{{ page.paymentId }}/prices"
        },
        "amount": 0,
        "description": "creditcard Test",
        "payerReference": "100500",
        "initiatingSystemUserAgent": "PostmanRuntime/7.1.1",
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "urls": {
            "id": "/psp/creditcard/payments/{{ page.paymentId }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/creditcard/payments/{{ page.paymentId }}/payeeinfo"
        },
        "metadata": {
            "id": "/psp/creditcard/payments/{{ page.paymentId }}/metadata"
        }
    },
    "operations": []
}
```

The response will be the `payment` resource with its `state` set to `Aborted`.

{% include settlement-reconciliation.md %}

{% include one-click-payments.md %}

{% include payment-link.md %}

{% include recurring-card-payments.md %}

{% include callback-reference.md payment-instrument="mobilepay" %}

{% include transactions-reference.md payment-instrument="mobilepay" %}

## Prices

{% include prices.md payment-instrument="mobilepay" %}

## Payee reference

{% include payee-info.md %}

{% include iterator.html prev_href="after-payment"
                         prev_title="Back: After Payment" %}

[abort]: #abort-a-payment
[authorization-transaction]: #authorizations
[callback-reference]: #callback
[cancel]: #cancellations
[cancellation-transaction]: #cancellations
[capture-transaction]: #captures
[capture]: #captures
[payeeReference]: #payee-reference
[reversal-transaction]: #reversals
[transaction-resource]: #transactions
[user-agent]: https://en.wikipedia.org/wiki/User_agent
