---
title: Swedbank Pay Payments Swish Other Features
sidebar:
  navigation:
  - title: Swish Payments
    items:
    - url: /payments/swish
      title: Introduction
    - url: /payments/swish/direct
      title: Direct
    - url: /payments/swish/redirect
      title: Redirect
    - url: /payments/swish/seamless-view
      title: Seamless View
    - url: /payments/swish/after-payment
      title: After Payment
    - url: /payments/swish/other-features
      title: Other Features
---

{% include alert-review-section.md %}

## Payment Resource

{% include payment-resource.md payment-instrument="swish" showStatusOperations=true%}

{% include payment-transaction-states.md %}

## Create Payment

To create a Swish payment, you perform an HTTP `POST` against the
`/psp/swish/payments` resource.

An example of a payment creation request is provided below.
Each individual property of the JSON document is described in the following
section.
Use the [expand][technical-reference-expand] request parameter to get a
response that includes one or more expanded sub-resources inlined.

{:.code-header}
**Request**

```http
POST /psp/swish/payments HTTP/1.1
Host: {{ page.apiHost }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Sale",
        "currency": "SEK",
        "prices": [{
            "type": "Swish",
            "amount": 1500,
            "vatAmount": 0
        }],
        "description": "Test Purchase",
        "payerReference": "AB1234",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "hostUrls": ["https://example.com", "https://example.net"],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "callbackUrl": "https://example.com/payment-callback",
            "logoUrl": "https://example.com/logo.png",
            "termsOfServiceUrl": "https://example.com/terms.pdf"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchantId }}",
            "payeeReference": "ref-123456",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456",
            "subsite": "MySubsite"
        },
        "prefillInfo": {
            "msisdn": "+46739000001"
        },
        "swish": {
            "ecomOnlyEnabled": false
        }
    }
}
```

{:.table .table-striped}
| Required | Property                        | Type         | Description                                                                                                                                                                                                                                               |
| :------: | :------------------------------ | :----------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|    ✔︎    | `payment`                       | `object`     | The `payment`object.                                                                                                                                                                                                                                      |
|    ✔︎    | └➔&nbsp;`operation`             | `string`     | `Purchase`                                                                                                                                                                                                                                                |
|    ✔︎    | └➔&nbsp;`intent`                | `string`     | `Sale`                                                                                                                                                                                                                                                    |
|    ✔︎    | └➔&nbsp;`currency`              | `string`     | `SEK`                                                                                                                                                                                                                                                     |
|    ✔︎    | └➔&nbsp;`prices`                | `object`     | The `prices` object contains information about what is being bought in this payment.                                                                                                                                                                      |
|    ✔︎    | └─➔&nbsp;`type`                 | `string`     | `Swish`                                                                                                                                                                                                                                                   |
|    ✔︎    | └─➔&nbsp;`amount`               | `integer`    | Amount is entered in the lowest momentary units of the selected currency. E.g.`10000`=`100.00 SEK` `5000`=`50.00 SEK`                                                                                                                                     |
|    ✔︎    | └─➔&nbsp;`vatAmount`            | `integer`    | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                                                                        |
|    ✔︎    | └➔&nbsp;`description`           | `string(40)` | A textual description max 40 characters of the purchase.                                                                                                                                                                                                  |
|          | └➔&nbsp;`payerReference`        | `string`     | The reference to the payer (consumer/end-user) from the merchant system, like mobile number, customer number etc.                                                                                                                                         |
|    ✔︎    | └➔&nbsp;`userAgent`             | `string`     | The user agent reference of the consumer's browser - [see user agent definition][user-agent]                                                                                                                                                              |
|    ✔︎    | └➔&nbsp;`language`              | `string`     | `nb-NO`, `sv-SE` or `en-US`.                                                                                                                                                                                                                                    |
|    ✔︎    | └➔&nbsp;`urls`                  | `object`     | The URLS object contains information about what urls this payment should use.                                                                                                                                                                             |
|    ✔︎    | └─➔&nbsp;`hostUrls`             | `array`      | The array of URIs valid for embedding of Swedbank Pay Hosted Views.                                                                                                                                                                                       |
|    ✔︎    | └─➔&nbsp;`completeUrl`          | `string`     | The URI that Swedbank Pay will redirect back to when the payment page is completed. This does not indicate a successful payment, only that it has reached a completion state. A `GET` request needs to be performed on the payment to inspect it further. |
|    ✔︎    | └─➔&nbsp;`cancelUrl`            | `string`     | The URI that Swedbank Pay will redirect back to when the user presses the cancel button in the payment page.                                                                                                                                              |
|          | └─➔&nbsp;`callbackUrl`          | `string`     | The URI that Swedbank Pay will perform an HTTP POST against every time a transaction is created on the payment. See [callback][technical-reference-callback] for details.                                                                                 |
|          | └─➔&nbsp;`logoUrl`              | `string`     | The URI that will be used for showing the customer logo. Must be a picture with at most 50px height and 400px width. Require https.                                                                                                                       |
|          | └─➔&nbsp;`termsOfServiceUrl`    | `string`     | A URI that contains your terms and conditions for the payment, to be linked on the payment page. Require https.                                                                                                                                           |
|    ✔︎    | └➔&nbsp;`payeeInfo`             | `object`     | A object containing info about the payee.                                                                                                                                                                                                                 |
|    ✔︎    | └─➔&nbsp;`payeeId`              | `string`     | This is the unique id that identifies this payee (like merchant) set by PayEx.                                                                                                                                                                            |
|    ✔︎    | └─➔&nbsp;`payeeReference`       | `string(35)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][technical-reference-payeeReference] for details.                                               |
|          | └➔&nbsp;`payeeName`             | `string`     | The payee name (like merchant name) that will be displayed to consumer when redirected to PayEx.                                                                                                                                                          |
|          | └➔&nbsp;`productCategory`       | `string`     | A product category or number sent in from the payee/merchant. This is not validated by PayEx, but will be passed through the payment process and may be used in the settlement process.                                                                   |
|          | └➔&nbsp;`orderReference`        | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                   |
|          | └➔&nbsp;`subsite`               | `string(40)` | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay reconciliation before being used.                                                                                               |
|          | └➔&nbsp;`prefillInfo.msisdn`    | `string`     | Number will be prefilled on payment page, if valid.                                                                                                                                                                                                       |
|          | └➔&nbsp;`swish.ecomOnlyEnabled` | `boolean`    | `true` if to only enable Swish on browser based transactions.; otherwise `false` to also enable Swish transactions via mobile app.                                                                                                                        |

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/swish/payments/{{ page.paymentId }}",
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
        "initiatingSystemUserAgent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "id": "/psp/swish/payments/{{ page.paymentId }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/swish/payments/{{ page.paymentId }}/payeeinfo"
        }
    },
    "operations": [
        {
            "method": "POST",
            "href": "http://{{ page.apiHost }}/psp/swish/payments/{{ page.paymentId }}/sales",
            "rel": "create-sale"
        }
}
```

{% include settlement-reconciliation.md %}

{% include payment-link.md show-3d-secure=false show-authorization=false %}

### Prices

{% include prices.md payment-instrument="swish" %}

### Payee reference

{% include payee-info.md %}

{% include expand-parameter.md %}

{% include transactions-reference.md payment-instrument="swish" %}

{% include callback-reference.md payment-instrument="swish" %}

### Problem messages

When performing unsuccessful operations, the eCommerce API will respond with a
problem message.
We generally use the problem message type and status code to identify
the nature of the problem.
The problem name and description will often help narrow down the specifics
of the problem.

### Error types from Swish and third parties

All Swish error types will have the following URI in front of type:
`{{ page.apiUrl }}/psp/<errordetail>/swish`

{:.table .table-striped}
| Type                 | Status | Error code           | Details                                                                                         |
| :------------------- | :----- | :------------------- | :---------------------------------------------------------------------------------------------- |
| `externalerror`      | 500    | No error code        |
| `inputerror`         | 400    | FF08                 | Input validation failed (PayeeReference)                                                        |
| `inputerror`         | 400    | BE18                 | Input validation failed (Msisdn)                                                                |
| `inputerror`         | 400    | PA02                 | Input validation failed (Amount)                                                                |
| `inputerror`         | 400    | AM06                 | Input validation failed (Amount)                                                                |
| `inputerror`         | 400    | AM02                 | Input validation failed (Amount)                                                                |
| `inputerror`         | 400    | AM03                 | Input validation failed (Currency)                                                              |
| `inputerror`         | 500    | RP02                 | Input validation failed (Description)                                                           |
| `configurationerror` | 403    | RP01                 | Configuration of contract is not correct, or missing settings                                   |
| `configurationerror` | 403    | ACMT07               | Configuration of contract is not correct, or missing settings                                   |
| `systemerror`        | 500    | RP03                 | Unable to complete operation (Invalid callback url)                                             |
| `swishdeclined`      | 403    | RP06                 | Third party returned error (Duplicate swish payment request)                                    |
| `swishdeclined`      | 403    | ACMT03               | Third party returned error (Swish msisdn not enrolled)                                          |
| `swishdeclined`      | 403    | ACMT01               | Third party returned error (Swish msisdn not enrolled)                                          |
| `swishdeclined`      | 403    | RF02                 | Third party returned error (Reversal declined due to Sale transaction being over 13 months old) |
| `swishdeclined`      | 403    | RF04                 | Third party returned error (Msisdn has changed owner (organization) between sale and reversal)  |
| `swishdeclined`      | 403    | RF06                 | Third party returned error (Msisdn has changed owener (SSN) between sale and reversal)          |
| `swishdeclined`      | 403    | RF07                 | Third party returned error (Swish rejected transaction)                                         |
| `swishdeclined`      | 403    | FF10                 | Third party returned error (Bank rejected transaction)                                          |
| `usercancelled`      | 403    | BANKIDCL             | Cancelled by user                                                                               |
| `swishdeclined`      | 403    | TM01                 | Payment timed out (User din't confirm payment in app)                                           |
| `swishdeclined`      | 403    | DS24                 | Payment timed out (Bank didn't respond).                                                        |
| `systemerror`        | 500    | Any other error code |

[payee-reference]: #payeeReference
[transaction-resource]: #Transactions
