{% capture documentation_section %}{%- include documentation-section.md -%}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{% assign features_url = documentation_section | prepend: '/' | append: '/features' %}

## Payer Aware Payment Menu

To maximize the experience of your payers, you should implement the Payer
Aware Payment Menu by identifying each payer with a unique identifier. It is
important that you enforce a good SCA (Strong Consumer Authentication) strategy
when authenticating the payer. The payer identifier must then be sent with
the creation of the payment order to Swedbank Pay. This will enable Swedbank Pay
to render a unique payment menu experience for each payer. It will also
increase the chance for a frictionless payment.

By identifying your payers, they are able to store payment information for
future payments by setting the `generatePaymentToken` value to `true`. This will
enable the Swedbank Pay Payment Menu to show stored payment instrument details
for future purchases. The payer is, by default, asked if they want to store
their payment details, so even with `generatePaymentToken` set to `true`, it is
still up to the payer if they want the details stored or not.

{% include alert.html type="informative" icon="info" body="Please note that not
all payment instruments provided by Swedbank Pay support Payer Awareness today."
%}

### BYO Payment Menu

Payment Menu is versatile and can be configured in such a way that it functions
like a single payment instrument. In such configuration, it is easy to Bring
Your Own Payment Menu, i.e. building a customized payment menu in our own user
interface.

#### Add Stored Payment Instrument Details

When building a custom payment menu, features like adding new stored payment
instrument details (i.e. "Add new card") is something that needs to be provided
in your UI.

This can be achieved by forcing the creation of a `paymentToken` by setting
`disableStoredPaymentDetails` to `true` in a Purchase payment (if you want
to withdraw money and create the token in the same operation), or by performing
a [verification][verify] (without withdrawing any money).

Setting `disableStoredPaymentDetails` to `true` will turn off all stored payment
details for the current purchase. The payer will also not be asked if they
want to store the payment detail that will be part of the purchase. When you use
this feature it is important that you have asked the payer in advance if it
is ok to store their payment details for later use.

Most often you will use the `disableStoredPaymentDetails` feature in combination
with the [Instrument Mode][instrument-mode] capability. If you build your own
menu and want to show stored payment details, you will need to set the
`disableStoredPaymentDetails` to `true`. It is important that you then store the
`paymentToken` in your system or call Swedbank Pay with the `payerReference` to
get all active payment tokens registered on that payer when building your
menu. See the abbreviated `Purchase` example below.

{:.code-view-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE", {% if documentation_section == "payment-menu" %}
        "instrument": null{% endif %}
        "generateRecurrenceToken": true,
        "generatePaymentToken": true,
        "disableStoredPaymentDetails": true,
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "paymentUrl": "https://example.com/perform-payment",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditoons.pdf",
            "logoUrl": "https://example.com/logo.png"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456",
            "subsite": "MySubsite"
        }
   }
}
```

{:.table .table-striped}
|     Required     | Field                             | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :-------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `paymentorder`                    | `object`     | The payment order object.                                                                                                                                                                                                                                                                                |
| {% icon check %} | └➔&nbsp;`operation`               | `string`     | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`currency`                | `string`     | The currency of the payment.                                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`amount`                  | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                                                |
| {% icon check %} | └➔&nbsp;`vatAmount`               | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`description`             | `string`     | The description of the payment order.                                                                                                                                                                                                                                                                     |{% if include.documentation_section == "payment-menu" %}
| {% icon check %} | └➔&nbsp;`instrument`              | `string`     | The payment instrument used. Selected by using the [Instrument Mode][instrument-mode].                                                                                                                                                                                          | {% endif %}                                              |
| {% icon check %} | └➔&nbsp;`generateRecurrenceToken` | `bool`       | Determines whether a recurrence token should be generated. A recurrence token is primarily used to enable future [recurring payments][recur] – with the same token – through server-to-server calls. Default value is `false`.                                     | {% if include.documentation_section == "payment-menu" %} |
| {% icon check %} | └➔&nbsp;`generatePaymentToken`    | `bool`       | `true` or `false`. Set this to `true` if you want to create a `paymentToken` to use in future [One Click Payments][one-click-payments].                                                                                                                                                                  | {% endif %}                                              |
|                  | └➔&nbsp;`disableStoredPaymentDetails` | `bool` | Setting to `true` will turn off all stored payment details for the current purchase. When you use this feature it is important that you have asked the payer in advance if it is ok to store their payment details for later use.                                                                                         |
| {% icon check %} | └➔&nbsp;`userAgent`               | `string`     | The user agent of the payer.                                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`language`                | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`urls`                    | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | └─➔&nbsp;`hostUrls`               | `array`      | The array of URIs valid for embedding of Swedbank Pay Seamless Views.                                                                                                                                                                                                                                      |
| {% icon check %} | └─➔&nbsp;`completeUrl`            | `string`     | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment order to inspect it further. See [`completeUrl`][completeurl] for details.  |
|                  | └─➔&nbsp;`cancelUrl`              | `string`     | The URI to redirect the payer to if the payment is canceled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
|                  | └─➔&nbsp;`paymentUrl`             | `string`     | The URI that Swedbank Pay will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. See [`paymentUrl`][payment-url] for details.                                                                                                                                                        |
| {% icon check %} | └─➔&nbsp;`callbackUrl`            | `string`     | The URI to the API endpoint receiving `POST` requests on transaction activity related to the payment order.                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`termsOfServiceUrl`      | `string`     | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                                                                     |
| {% icon check %} | └─➔&nbsp;`logoUrl`                | `string`     | {% include field-description-logourl.md documentation_section=include.documentation_section %}         |
| {% icon check %} | └➔&nbsp;`payeeInfo`               | `string`     | The `payeeInfo` object, containing information about the payee.                                                                                                                                                                                                                                          |
| {% icon check %} | └─➔&nbsp;`payeeId`                | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | └─➔&nbsp;`payeeReference`         | `string(30)` | {% include field-description-payee-reference.md documentation_section=include.documentation_section describe_receipt=true %}                                                                                                                                                                             |
|                  | └─➔&nbsp;`payeeName`              | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                 |
|                  | └─➔&nbsp;`productCategory`        | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                           |
|                  | └─➔&nbsp;`orderReference`         | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                  |
|                  | └─➔&nbsp;`subsite`                | `String(40)` | The subsite field can be used to perform [split settlement][split-settlement] on the payment. The subsites must be resolved with Swedbank Pay [reconciliation][settlement-reconciliation] before being used.                                                                                         |

### GDPR

Remember that you will have the responsibility to enforce GDPR requirements and
let the payer remove active payment tokens when they want. It is up to you
how to implement this functionality on your side but Swedbank Pay has the
API you need to ensure that cleaning up old data is easy. It is possible
to query for all active payment tokens registered on a specific
`payerReference`. Then you can either remove all tokens for that payer or
only a subset of all tokens.

[split-settlement]: /payment-menu/features/core/settlement-reconciliation#split-settlement
[settlement-reconciliation]: /payment-menu/features/core/settlement-reconciliation
[completeurl]: /payment-menu/features/technical-reference/complete-url
[payment-url]: /payment-menu/features/technical-reference/payment-url
[one-click-payments]: /payment-instruments/card/features/optional/one-click-payments
[recur]: /payment-menu/features/optional/recur
[verify]: /payment-menu/features/optional/verify
[instrument-mode]: /payment-menu/features/optional/instrument-mode
