{% capture features_url %}{% include documentation-section-url.md href='/features' %}{% endcapture %}

## Unscheduled Purchase

An `unscheduled purchase`, also called a Merchant Initiated Transaction (MIT),
is a payment which uses a `unscheduledToken` generated through a previous payment in
order to charge the same card at a later time. They are done by the merchant
without the cardholder being present.

{:.code-view-header}
**Request**

```http
POST /psp/{{ include.api_resource }}/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "UnscheduledPurchase",
        "intent": "Authorization",
        "unscheduledToken": "{{ page.payment_id }}",
        "currency": "NOK",
        "amount": 1500,
        "vatAmount": 0,
        "description": "Test Unscheduled Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls": {
            "callbackUrl": "https://example.com/payment-callback"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}"
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite"
        },
        "payer": {
            "payerReference": "AB1234",
        },
        "metadata": {
            "key1": "value1",
            "key2": 2,
            "key3": 3.1,
            "key4": false
        }
    }
}
```

{:.table .table-striped}
|     Required     | Field                          | Type         | Description                                                                                                                                                                                                                                                                           |
| :--------------: | :----------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | `payment`                      | `object`     | The payment object.                                                                                                                                                                                                                                                                  |
| {% icon check %} | `operation`                    | `object`     | `UnscheduledPurchase`.                                                                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`unscheduledToken`     | `string`     | The created unscheduledToken, if `operation: Verify`, `operation: UnscheduledPurchase` or `generateUnscheduledToken: true` was used.                                                                                                                                                                  |
| {% icon check %} | └➔&nbsp;`currency`             | `string`     | The currency of the payment order.                                                                                                                                                                                                                                                    |
| {% icon check %} | └➔&nbsp;`amount`               | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`vatAmount`            | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                          |
| {% icon check %} | └➔&nbsp;`description`          | `string`     | {% include field-description-description.md %}                                                                                                                                                                                     |
| {% icon check %} | └─➔&nbsp;`userAgent`           | `string`     | The [`User-Agent` string][user-agent] of the payer's web browser.                                                                                                                                                                                                                  |
| {% icon check %} | └─➔&nbsp;`language`            | `string`     | {% include field-description-language.md %}                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`urls`                | `string`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`callbackUrl`         | `string`     | The URL that Swedbank Pay will perform an HTTP `POST` against every time a transaction is created on the payment. See [callback][technical-reference-callback] for details.                                                                                                                              |
| {% icon check %} | └➔&nbsp;`payeeInfo`            | `string`     | {% include field-description-payeeinfo.md %}                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`payeeId`             | `string`     | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.                                                                                                                                                                                                 |
| {% icon check %} | └➔&nbsp;`payeeReference`       | `string(30)` | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                                                                                          |
|                  | └➔&nbsp;`receiptReference`     | `string(30)` | A unique reference from the merchant system. It is used to supplement `payeeReference` as an additional receipt number.                                                                                                                                                               |
| {% icon check %} | └─➔&nbsp;`payeeName`           | `string`     | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                                                                                                                                               |
| {% icon check %} | └─➔&nbsp;`productCategory`     | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                        |
| {% icon check %} | └─➔&nbsp;`orderReference`      | `String(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                               |
| {% icon check %} | └─➔&nbsp;`subsite`             | `String(40)` | The subsite field can be used to perform [split settlement]({{ features_url }}/core/settlement-reconciliation) on the payment. The subsites must be resolved with Swedbank Pay [reconciliation][settlement-reconciliation] before being used.                                                                      |
|                  | └➔&nbsp;`payer`                | `string`     | The `payer` object, containing information about the payer.                                                                                                                                                                                                                                          |
|                  | └─➔&nbsp;`payerReference`      | `string`     | {% include field-description-payer-reference.md %}                                                                                                                                                                                                                                                           |
|                  | └➔&nbsp;`metadata`             | `object`     | {% include field-description-metadata.md %}                                                                                                                                                 |

<!--lint disable final-definition -->

[user-agent]: https://en.wikipedia.org/wiki/User_agent
[technical-reference-callback]: {{ features_url }}/technical-reference/callback
[settlement-reconciliation]: {{ features_url }}/core/settlement-reconciliation
