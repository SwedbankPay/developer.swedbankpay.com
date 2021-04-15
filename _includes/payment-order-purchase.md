{% capture documentation_section %}{%- include documentation-section.md -%}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{% assign features_url = documentation_section | prepend: '/' | append: '/features' %}

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
        "language": "sv-SE",{% if documentation_section == "payment-menu" %}
        "instrument": null,{% endif %}
        "disablePaymentMenu": {{ operation_status_bool }},
        "generateRecurrenceToken": {{ operation_status_bool }},
        "generateUnscheduledToken": {{ operation_status_bool }},{% if documentation_section == "payment-menu" %}
        "generatePaymentToken": {{ operation_status_bool }},{% endif %}
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
        },
        "payer": {  {% if documentation_section contains "checkout" %}
            "consumerProfileRef": "{{ page.payment_token }}"{% else %}
            "email": "olivia.nyhuus@payex.com",
            "msisdn": "+4798765432",
            "workPhoneNumber" : "+4787654321",
            "homePhoneNumber" : "+4776543210"{% endif %}
        },
        "orderItems": [
            {
                "reference": "P1",
                "name": "Product1",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "itemUrl": "https://example.com/products/123",
                "imageUrl": "https://example.com/product123.jpg",
                "description": "Product 1 description",
                "discountDescription": "Volume discount",
                "quantity": 4,
                "quantityUnit": "pcs",
                "unitPrice": 300,
                "discountPrice": 200,
                "vatPercent": 2500,
                "amount": 1000,
                "vatAmount": 250
            },
            {
                "reference": "I1",
                "name": "InvoiceFee",
                "type": "PAYMENT_FEE",
                "class": "Fees",
                "description": "Fee for paying with Invoice",
                "quantity": 1,
                "quantityUnit": "pcs",
                "unitPrice": 1900,
                "vatPercent": 0,
                "amount": 1900,
                "vatAmount": 0,
                "restrictedToInstruments": [
                    "Invoice-PayExFinancingSe"
                ]
            }
        ],
        "riskIndicator": {
            "deliveryEmailAddress": "olivia.nyhuus@payex.com",
            "deliveryTimeFrameIndicator": "01",
            "preOrderDate": "19801231",
            "preOrderPurchaseIndicator": "01",
            "shipIndicator": "01",
            "giftCardPurchase": false,
            "reOrderPurchaseIndicator": "01",
            "pickUpAddress": {
                "name": "Olivia Nyhus",
                "streetAddress": "Saltnestoppen 43",
                "coAddress": "",
                "city": "Saltnes",
                "zipCode": "1642",
                "countryCode": "NO"
            }
        }
    }
}
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",{% if documentation_section == "payment-menu" %}
        "instrument": "CreditCard",
        "paymentToken" : "{{ page.payment_token }}",{% endif %}
        "created": "2020-06-22T10:56:56.2927632Z",
        "updated": "2020-06-22T10:56:56.4035291Z",
        "operation": "Purchase",
        "state": "Ready",
        "currency": "SEK",
        "amount": 10000,
        "vatAmount": 0,
        "orderItems": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderitems"
        },
        "description": "test description",
        "initiatingSystemUserAgent": "Mozilla/5.0",
        "userAgent": "Mozilla/5.0",
        "language": "sv-SE",
        "urls": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/urls"
        },
        "payeeInfo": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/payeeInfo"
        },
        "payments": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/payments"
        },
        "currentPayment": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/currentpayment"
        },
        "items": [
            {
                "creditCard": {
                    "cardBrands": [
                        "Visa",
                        "MasterCard"
                    ]
                }
            }
        ]
    }
    "operations": [
        {
            "method": "PATCH",
            "href": "{{ page.front_end_url }}/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-updateorder",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "{{ page.front_end_url }}/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-expandinstrument",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/paymentmenu/{{ page.payment_token }}",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token={{ page.payment_token }}&culture=nb-NO",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
        }
    ]
}
```

{:.table .table-striped}
|     Required     | Field                              | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :--------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `paymentorder`                     | `object`     | The payment order object.                                                                                                                                                                                                                                                                                |
| {% icon check %} | └➔&nbsp;`operation`                | `string`     | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`currency`                 | `string`     | The currency of the payment.                                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`amount`                   | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                                                |
| {% icon check %} | └➔&nbsp;`vatAmount`                | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`description`              | `string`     | The description of the payment order.                                                                                                                                                                                                                                                                    |
| {% icon check %} | └➔&nbsp;`instrument`               | `string`     | The payment instrument used. Selected by using the {% if documentation_section == "payment-menu" %}[Instrument Mode]({{ features_url }}/optional/instrument-mode){% else %}Instrument Mode{% endif %}.                                                                                                   |
{% if documentation_section contains "checkout" -%}
|                  | └➔&nbsp;`disablePaymentMenu`       | `bool`       | Set to `true` if only one payment instrument exist. Default value is `false`.                                                                                                                                                                                                                            |
{% elsif documentation_section == "payment-menu" -%}
|                  | └➔&nbsp;`generatePaymentToken`     | `bool`       | `true` or `false`. Set this to `true` if you want to create a `paymentToken` to use in future [One Click Payments][one-click-payments].                                                                                                                                                                  |
{% endif -%}
|                  | └➔&nbsp;`generateRecurrenceToken`  | `bool`       | Determines whether a recurrence token should be generated. A recurrence token is primarily used to enable future [recurring payments]({{ features_url }}/optional/recur) – with the same token – through server-to-server calls. Default value is `false`.                                               |
|                  | └➔&nbsp;`generateUnscheduledToken` | `bool`       | Determines whether an unscheduled token should be generated. An unscheduled token is primarily used to enable future [unscheduled payments]({{ features_url }}/optional/unscheduled) – with the same token – through server-to-server calls. Default value is `false`.                                                  |
| {% icon check %} | └➔&nbsp;`userAgent`                | `string`     | The user agent of the payer.                                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`language`                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`urls`                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | └─➔&nbsp;`hostUrls`                | `array`      | The array of URIs valid for embedding of Swedbank Pay Seamless Views.                                                                                                                                                                                                                                    |
| {% icon check %} | └─➔&nbsp;`completeUrl`             | `string`     | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment order to inspect it further. See [`completeUrl`][complete-url] for details.  |
|                  | └─➔&nbsp;`cancelUrl`               | `string`     | The URI to redirect the payer to if the payment is canceled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
|                  | └─➔&nbsp;`paymentUrl`              | `string`     | The URI that Swedbank Pay will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. See [`paymentUrl`]({{ features_url }}/technical-reference/payment-url) for details.                                                                   |
| {% icon check %} | └─➔&nbsp;`callbackUrl`             | `string`     | The URI to the API endpoint receiving `POST` requests on transaction activity related to the payment order.                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`termsOfServiceUrl`       | `string`     | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                                                                     |
| {% icon check %} | └─➔&nbsp;`logoUrl`                 | `string`     | {% include field-description-logourl.md %}                                                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`payeeInfo`                | `string`     | {% include field-description-payeeinfo.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | └─➔&nbsp;`payeeId`                 | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | └─➔&nbsp;`payeeReference`          | `string(30)` | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                                                                                                                                                                 |
|                  | └─➔&nbsp;`payeeName`               | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                 |
|                  | └─➔&nbsp;`productCategory`         | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                           |
|                  | └─➔&nbsp;`orderReference`          | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                  |
|                  | └─➔&nbsp;`subsite`                 | `String(40)` | The subsite field can be used to perform [split settlement][split-settlement] on the payment. The subsites must be resolved with Swedbank Pay [reconciliation][settlement-reconciliation] before being used.                                                                                         |
|                  | └➔&nbsp;`payer`                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                |
{% if documentation_section contains "checkout" -%}
|        ︎︎︎          | └─➔&nbsp;`consumerProfileRef`       | `string`    | The consumer profile reference as obtained through [initiating a consumer session][initiate-consumer-session].                                                                                                                                                                                            |
{% endif -%}
|                  | └─➔&nbsp;`email`                   | `string`     | The e-mail address of the payer. Will be used to prefill the Checkin as well as on the payer's profile, if not already set. Increases the chance for [frictionless 3-D Secure 2 flow]({{ features_url }}/core/3d-secure-2).                                                                             |
|                  | └─➔&nbsp;`msisdn`                  | `string`     | The mobile phone number of the Payer. Will be prefilled on Checkin page and used on the payer's profile, if not already set. The mobile number must have a country code prefix and be 8 to 15 digits in length. The field is related to [3-D Secure 2]({{ features_url }}/core/3d-secure-2).            |
|                  | └─➔&nbsp;`workPhoneNumber`         | `string`     | The work phone number of the payer. Optional (increased chance for frictionless flow if set) and is related to [3-D Secure 2]({{ features_url }}/core/3d-secure-2).                                                                                                                                     |
|                  | └─➔&nbsp;`homePhoneNumber`         | `string`     | The home phone number of the payer. Optional (increased chance for frictionless flow if set) and is related to [3-D Secure 2]({{ features_url }}/core/3d-secure-2).                                                                                                                                     |
| {% icon check %} | └➔&nbsp;`orderItems`               | `array`      | {% include field-description-orderitems.md %}                                                                                                                                                                                                                                                            |
| {% icon check %} | └─➔&nbsp;`reference`               | `string`     | A reference that identifies the order item.                                                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`name`                    | `string`     | The name of the order item.                                                                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`type`                    | `string`     | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `PAYMENT_FEE` `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item. `PAYMENT_FEE` is the amount you are charged with when you are paying with invoice. The amount can be defined in the `amount` field below.                                           |
| {% icon check %} | └─➔&nbsp;`class`                   | `string`     | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics.                                |
|                  | └─➔&nbsp;`itemUrl`                 | `string`     | The URL to a page that can display the purchased item, product or similar.                                                                                                                                                                                                                               |
|        ︎︎︎          | └─➔&nbsp;`imageUrl`                | `string`     | The URL to an image of the order item.                                                                                                                                                                                                                                                                    |
|                  | └─➔&nbsp;`description`             | `string`     | {% include field-description-description.md %}                                                                                                                                                                                                                                                           |
|                  | └─➔&nbsp;`discountDescription`     | `string`     | The human readable description of the possible discount.                                                                                                                                                                                                                                                 |
| {% icon check %} | └─➔&nbsp;`quantity`                | `integer`    | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                                         |
| {% icon check %} | └─➔&nbsp;`quantityUnit`            | `string`     | The unit of the quantity, such as `pcs`, `grams`, or similar. This is used for your own book keeping.                                                                                                                                                                                                    |
| {% icon check %} | └─➔&nbsp;`unitPrice`               | `integer`    | The price per unit of order item, including VAT.                                                                                                                                                                                                                                                         |
|                  | └─➔&nbsp;`discountPrice`           | `integer`    | If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                                               |
| {% icon check %} | └─➔&nbsp;`vatPercent`              | `integer`    | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                                                 |
| {% icon check %} | └─➔&nbsp;`amount`                  | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                                                |
| {% icon check %} | └─➔&nbsp;`vatAmount`               | `integer`    | {% include field-description-vatamount.md %}                                                     |
|                  | └➔&nbsp;`restrictedToInstruments`  | `array`      | `CreditCard`, `Invoice`, `Vipps`, `Swish`, `Trustly` and/or `CreditAccount`. `Invoice` supports the subtypes `PayExFinancingNo`, `PayExFinancingSe` and `PayMonthlyInvoiceSe`, separated by a dash, e.g.; `Invoice-PayExFinancingNo`. Limits the options available to the consumer in the payment menu. Default value is all supported payment instruments. Usage of this field requires an agreement with Swedbank Pay.                                                   |
{% include risk-indicator-table.md %}

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `paymentorder`           | `object`     | The payment order object.                                                                                                                                                                                                 |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md resource="paymentorder" %}                                                                                                                                                             |{% if documentation_section == "payment-menu" %}
| └➔&nbsp;`instrument`     | `string`     | The payment instrument used. Selected by using the [Instrument Mode]({{ features_url }}/optional/instrument-mode).                                                                                                           |
| └➔&nbsp;`paymentToken`   | `string`     | The payment token created for the purchase used in the authorization to create [One Click Payments][one-click-payments].                                                                                                  | {% endif %}                                              |
| └➔&nbsp;`created`        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| └➔&nbsp;`updated`        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| └➔&nbsp;`operation`      | `string`     | `Purchase`                                                                                                                                                                                                                |
| └➔&nbsp;`state`          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment order. Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes. |
| └➔&nbsp;`currency`       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| └➔&nbsp;`amount`         | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                 |
| └➔&nbsp;`vatAmount`      | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                              |
| └➔&nbsp;`description`    | `string(40)` | {% include field-description-description.md %}                                                                                                                        |
| └➔&nbsp;`userAgent`      | `string`     | The [user agent][user-agent] string of the payer's browser.                                                                                                                                                            |
| └➔&nbsp;`language`       | `string`     | {% include field-description-language.md %}                                                                                                                                                  |
| └➔&nbsp;`urls`           | `string`     | The URI to the `urls` resource where all URIs related to the payment order can be retrieved.                                                                                                                              |
| └➔&nbsp;`payeeInfo`      | `string`     | {% include field-description-payeeinfo.md %}                                                                                                          |
| └➔&nbsp;`payers`         | `string`     | The URI to the `payers` resource where information about the payee of the payment order can be retrieved.                                                                                                                 |
| └➔&nbsp;`orderItems`     | `string`     | The URI to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| └➔&nbsp;`metadata`       | `string`     | {% include field-description-metadata.md %}                                                                                                                      |
| └➔&nbsp;`payments`       | `string`     | The URI to the `payments` resource where information about all underlying payments can be retrieved.                                                                                                                      |
| └➔&nbsp;`currentPayment` | `string`     | The URI to the `currentPayment` resource where information about the current – and sole active – payment can be retrieved.                                                                                                |
| └➔&nbsp;`operations`     | `array`      | The array of possible operations to perform, given the state of the payment order. [See Operations for details][operations].                                                                                              |

{{ documentation_section }}

[complete-url]: /{{ documentation_section }}/features/technical-reference/complete-url
[initiate-consumer-session]: {{ documentation_section }}/checkin#step-1-initiate-session-for-consumer-identification
[one-click-payments]: {{ documentation_section }}/features/#one-click-payments
[operations]: {{ documentation_section }}/features/technical-reference/operations
[settlement-reconciliation]: /{{ documentation_section }}/features/core/settlement-reconciliation
[split-settlement]: {{ documentation_section }}/features/core/settlement-reconciliation#split-settlement
[user-agent]: https://en.wikipedia.org/wiki/User_agent
