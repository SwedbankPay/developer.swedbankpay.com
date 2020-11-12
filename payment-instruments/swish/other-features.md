---
title: Other Features
redirect_from: /payments/swish/other-features
estimated_read: 65
menu_order: 1000
---

{% include payment-resource.md api_resource="swish"
documentation_section="swish" show_status_operations=true %}

{% include payment-transaction-states.md %}

{% include payment-state.md api_resource="swish" %}

{% include payments-operations.md api_resource="swish" documentation_section="swish" %}

## Create Payment

To create a Swish payment, you perform an HTTP `POST` against the
`/psp/swish/payments` resource.

An example of a payment creation request is provided below. Each individual
field of the JSON document is described in the following section. Use the
[expand][expand] request parameter to get a response that includes one or more
expanded sub-resources inlined.

{:.code-view-header}
**Request**

```http
POST /psp/swish/payments HTTP/1.1
Host: {{ page.api_host }}
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
            "payeeId": "{{ page.merchant_id }}",
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
            "enableEcomOnly": false,
            "paymentRestrictedToAgeLimit": 18,
            "paymentRestrictedToSocialSecurityNumber": "{{ page.consumer_ssn_se }}"
        }
    }
}
```

{:.table .table-striped}
|     Required     | Field                          | Type         | Description                                                                                                                                                                                                                                               |
| :--------------: | :----------------------------- | :----------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %}︎ | `payment`                      | `object`     | The `payment`object.                                                                                                                                                                                                                                      |
| {% icon check %}︎ | └➔&nbsp;`operation`            | `string`     | `Purchase`                                                                                                                                                                                                                                                |
| {% icon check %}︎ | └➔&nbsp;`intent`               | `string`     | `Sale`                                                                                                                                                                                                                                                    |
| {% icon check %}︎ | └➔&nbsp;`currency`             | `string`     | `SEK`                                                                                                                                                                                                                                                     |
| {% icon check %}︎ | └➔&nbsp;`prices`               | `object`     | The `prices` object contains information about what is being bought in this payment.                                                                                                                                                                      |
| {% icon check %}︎ | └─➔&nbsp;`type`                | `string`     | `Swish`                                                                                                                                                                                                                                                   |
| {% icon check %}︎ | └─➔&nbsp;`amount`              | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                 |
| {% icon check %}︎ | └─➔&nbsp;`vatAmount`           | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                                                              |
| {% icon check %}︎ | └➔&nbsp;`description`          | `string(40)` | {% include field-description-description.md documentation_section="swish" %}                                                                                                                                                                              |
|                  | └➔&nbsp;`payerReference`       | `string`     | {% include field-description-payer-reference.md documentation_section="swish" %}                                                                                                                                         |
| {% icon check %}︎ | └➔&nbsp;`userAgent`            | `string`     | The [`User-Agent` string][user-agent] of the payer's web browser.                                                                                                                                                                                      |
| {% icon check %}︎ | └➔&nbsp;`language`             | `string`     | {% include field-description-language.md api_resource="swish" %}                                                                                                                                                                                          |
| {% icon check %}︎ | └➔&nbsp;`urls`                 | `object`     | The URLS object contains information about what urls this payment should use.                                                                                                                                                                             |
| {% icon check %}︎ | └─➔&nbsp;`hostUrls`            | `array`      | The array of URIs valid for embedding of Swedbank Pay Hosted Views.                                                                                                                                                                                       |
| {% icon check %}︎ | └─➔&nbsp;`completeUrl`         | `string`     | The URI that Swedbank Pay will redirect back to when the payment page is completed. This does not indicate a successful payment, only that it has reached a completion state. A `GET` request needs to be performed on the payment to inspect it further. See [`completeUrl`](#completeurl) for details.  |
| {% icon check %}︎ | └─➔&nbsp;`cancelUrl`           | `string`     | The URI that Swedbank Pay will redirect back to when the user presses the cancel button in the payment page.                                                                                                                                              |
|                  | └─➔&nbsp;`callbackUrl`         | `string`     | The URI that Swedbank Pay will perform an HTTP POST against every time a transaction is created on the payment. See [callback][technical-reference-callback] for details.                                                                                 |
|                  | └─➔&nbsp;`logoUrl`             | `string`     | {% include field-description-logourl.md documentation_section="swish" %}                                                                                                                       |
|                  | └─➔&nbsp;`termsOfServiceUrl`   | `string`     | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                      |
| {% icon check %}︎ | └➔&nbsp;`payeeInfo`            | `object`     | {% include field-description-payeeinfo.md documentation_section="swish" %}                                                                                                                                                                                                                 |
| {% icon check %}︎ | └─➔&nbsp;`payeeId`             | `string`     | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                     |
| {% icon check %}︎ | └─➔&nbsp;`payeeReference`      | `string(35)` | {% include field-description-payee-reference.md documentation_section="swish" %}                                                                                                                                                                          |
|                  | └➔&nbsp;`payeeName`            | `string`     | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                   |
|                  | └➔&nbsp;`productCategory`      | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                            |
|                  | └➔&nbsp;`orderReference`       | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                   |
|                  | └➔&nbsp;`subsite`              | `string(40)` | {% include field-description-subsite.md %}                                                                                               |
|                  | └➔&nbsp;`prefillInfo.msisdn`   | `string`     | Number will be prefilled on payment page, if valid. The mobile number must have a country code prefix and be 8 to 15 digits in length.                                                                                                                    |
|                  | └➔&nbsp;`swish.enableEcomOnly` | `boolean`    | `true` if to only enable Swish on browser based transactions.; otherwise `false` to also enable Swish transactions via mobile app.                                                                                                                        |
|                  | └─➔&nbsp;`paymentRestrictedToAgeLimit`             | `integer`     | Positive number that sets the required age needed to fulfill the payment. To use this feature it has to be configured in the contract.                                                                                                                                                            |
|                 | └─➔&nbsp;`paymentRestrictedToSocialSecurityNumber` | `string`      | When provided, the payment will be restricted to a specific social security number to make sure its the same logged in customer who is also the payer. Format: yyyyMMddxxxx. To use this feature it has to be configured in the contract.                                                                                                                             |

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
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
        "initiatingSystemUserAgent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36",
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
            "method": "POST",
            "href": "http://{{ page.api_host }}/psp/swish/payments/{{ page.payment_id }}/sales",
            "rel": "create-sale"
        }
    ]
}
```

### Mobile Number Validation

#### eCommerce

All international mobile numbers are supported. To be valid, the number input
must be with a country code prefix and consist of 8 to 15 characters. Digits are
the only characters allowed, and the regex used is `\\+[1-9]\\d{7,14}`. A valid
Swedish mobile number would be `+46739000001`, a valid Norwegian mobile number
would be `+4792345678`.

#### mCommerce

No number input is needed in the mCommerce flow. The payer's mobile number must
be connected to a Swish account.

{% include settlement-reconciliation.md documentation_section="swish" %}

{% include payment-link.md show_3d_secure=false show_authorization=false %}

{% include description.md api_resource = "swish" %}

{% include complete-url.md %}

{% include payment-url.md api_resource="swish" documentation_section="swish" full_reference=true %}

{% include prices.md api_resource="swish" %}

{% include payee-info.md api_resource="swish" documentation_section="swish" %}

{% include expand-parameter.md %}

{% include transactions.md api_resource="swish" documentation_section="swish" %}

{% include callback-reference.md api_resource="swish" %}

{% include metadata.md api_resource="swish" %}

{% include problems/problems.md documentation_section="swish" %}

{% include seamless-view-events.md api_resource="swish" %}

{% include iterator.html prev_href="after-payment" prev_title="After
Payment" %}

[expand]: /home/technical-information#expansion
[payee-reference]: #payee-reference
[transaction-resource]: #Transactions
