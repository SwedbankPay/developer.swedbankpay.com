## Unscheduled Purchase

{% include alert.html type="warning" icon="warning" body="please note that this feature is only available through Payment Order." %}

An `unscheduled purchase`, also called a Merchant Initiated Transaction (MIT),
is a payment which uses a `paymentToken` generated through a previous payment in
order to charge the same card at a later time. They are done by the merchant
without the user being present.

To use this, you need to make sure `directDebitEnabled` is `true` in the Trustly contract. After that you need to have the field `generateUnscheduledToken` set to `true` when creating an initial Purchase or Verify. Another important step is to make sure the `email` field is set, as this is a required parameter.

{:.code-view-header}
**Request**

```http
POST /psp/trustly/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "UnscheduledPurchase",
        "intent": "Sale",
        "unscheduledToken": "{{ page.payment_id }}",
        "currency": "SEK",
        "prices": [
            {
                "type": "Trustly",
                "amount": 4201,
                "vatAmount": 0
            }
        ],
        "description": "Test Unscheduled",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "urls": {
            "callbackUrl": "https://example.com/payment-callback"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12345"
        }
    },
    "trustly": {
        "email": "test@test.no",
        "bank": "Swedbank",
        "accountId": "1980908426"
    }
}
```

{:.table .table-striped}
|     Required     | Field                          | Type         | Description                                                                                                                                                                                                                                                                           |
| :--------------: | :----------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | `payment`                      | `object`     | The payment object.                                                                                                                                                                                                                                                                  |
| {% icon check %} | `operation`                    | `object`     | `Recur`.                                                                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`unscheduledToken`      | `string`     | The created unscheduledToken, if `operation: Verify` or `operation: Recur`, and `generateUnscheduledToken: true` was used.                                                                                                                                                                  |
| {% icon check %} | └➔&nbsp;`currency`             | `string`     | The currency of the payment order.                                                                                                                                                                                                                                                    |
| {% icon check %} | └➔&nbsp;`prices`               | `object`    | {% include prices.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | └─➔&nbsp;`type`            | `string`    | The type of the price object.                                                                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`amount`            | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`vatAmount`            | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                          |
| {% icon check %} | └➔&nbsp;`description`          | `string`     | {% include field-description-description.md %}                                                                                                                                                                                     |
| {% icon check %} | └─➔&nbsp;`userAgent`           | `string`     | The [`User-Agent` string](https://en.wikipedia.org/wiki/User_agent) of the payer's web browser.                                                                                                                                                                                                                  |
| {% icon check %} | └─➔&nbsp;`language`            | `string`     | {% include field-description-language.md %}                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`urls`                | `string`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`callbackUrl`         | `string`     | The URL that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][technical-reference-callback] for details.                                                                                                                              |
| {% icon check %} | └➔&nbsp;`payeeInfo`            | `string`     | {% include field-description-payeeinfo.md %}                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`payeeId`             | `string`     | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                 |
| {% icon check %} | └➔&nbsp;`payeeReference`       | `string(30)` | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`payeeName`           | `string`     | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                               |
| {% icon check %} | └─➔&nbsp;`productCategory`     | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                        |
| {% icon check %} | └─➔&nbsp;`orderReference`      | `String(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`trustly`             | `object`     | An object containing trustly specific parameters.                                                                                                                                                 |
| {% icon check %} | └─➔&nbsp;`email`             | `string`     | The email address of the end user. This is required when using Direct Debit.                                                                                                                                                 |
| {% icon check %} | └─➔&nbsp;`bank`             | `string`     | The bank used for the payment. This is mostly used for support purposes.                                                                                                                                                |
| {% icon check %} | └─➔&nbsp;`accountId`             | `string`     | The accountId recieved from an account notification which shall be charged                                                                                                                                               |
