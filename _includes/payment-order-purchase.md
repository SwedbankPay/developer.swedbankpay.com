{:.code-header}
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
        "language": "sv-SE",
        "generateRecurrenceToken": false,
        "restrictedToInstruments": ["CreditCard", "Invoice"],
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "paymentUrl": "https://example.com/perform-payment",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditoons.pdf"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456",
            "subsite": "MySubsite"
        },
        "payer": {
            "consumerProfileRef": "{{ page.payment_token }}",
            "email": "olivia.nyhuus@payex.com",
            "msisdn": "+4798765432",
            "workPhoneNumber" : "+4787654321",
            "homePhoneNumber" : "+4776543210"
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
                    "Invoice-PayExFinancingSe", "Invoice-CampaignInvoiceSe"
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

{:.table .table-striped}
| Required | Field                             | Type         | Description                                                                                                                                                                                                                                                                                                                                                                                                   |
| :------: | :-------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|  ✔︎︎︎︎︎  | `paymentorder`                    | `object`     | The payment order object.                                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └➔&nbsp;`operation`               | `string`     | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                                                                                                                                  |
|  ✔︎︎︎︎︎  | └➔&nbsp;`currency`                | `string`     | The currency of the payment.                                                                                                                                                                                                                                                                                                                                                                                  |
|  ✔︎︎︎︎︎  | └➔&nbsp;`amount`                  | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └➔&nbsp;`vatAmount`               | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                                                                                                                                                  |
|  ✔︎︎︎︎︎  | └➔&nbsp;`description`             | `string`     | The description of the payment order.                                                                                                                                                                                                                                                                                                                                                                         |
|  ✔︎︎︎︎︎  | └➔&nbsp;`userAgent`               | `string`     | The user agent of the payer.                                                                                                                                                                                                                                                                                                                                                                                  |
|  ✔︎︎︎︎︎  | └➔&nbsp;`language`                | `string`     | The language of the payer.                                                                                                                                                                                                                                                                                                                                                                                    |
|  ✔︎︎︎︎︎  | └➔&nbsp;`generateRecurrenceToken` | `bool`       | Determines if a recurrence token should be generated. A recurrence token is primarily used to enable future recurring payments - with the same token - through server-to-server calls. Default value is `false`.                                                                                                                                                                                              |
|          | └➔&nbsp;`restrictedToInstruments` | `array`      | `CreditCard`, `Invoice`, `Vipps`, `Swish` and/or `CreditAccount`. `Invoice` supports the subtypes `PayExFinancingNo`, `PayExFinancingSe` and `PayMonthlyInvoiceSe`, separated by a dash, e.g.; `Invoice-PayExFinancingNo`. Limits the options available to the consumer in the payment menu. Default value is all supported payment instruments. Usage of this field requires an agreement with Swedbank Pay. |
|  ✔︎︎︎︎︎  | └➔&nbsp;`urls`                    | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                                                                                                                        |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`hostUrls`               | `array`      | The array of URIs valid for embedding of Swedbank Pay Hosted Views.                                                                                                                                                                                                                                                                                                                                           |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`completeUrl`            | `string`     | The URL that Swedbank Pay will redirect back to when the payer has completed his or her interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment order to inspect it further.                                                                                                      |
|          | └─➔&nbsp;`cancelUrl`              | `string`     | The URI to redirect the payer to if the payment is canceled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                                                                                                                             |
|          | └─➔&nbsp;`paymentUrl`             | `string`     | The URI that Swedbank Pay will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment.                                                                                                                                                                                                                                                            |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`callbackUrl`            | `string`     | The URI to the API endpoint receiving `POST` requests on transaction activity related to the payment order.                                                                                                                                                                                                                                                                                                   |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`termsOfServiceUrl`      | `string`     | The URI to the merchant terms of service document the payer must accept in order to complete the payment. This is not the Swedbank Pay Terms of Service. Requires `https`.                                                                                                                                                                                                                                    |
|  ✔︎︎︎︎︎  | └➔&nbsp;`payeeInfo`               | `string`     | The `payeeInfo` object, containing information about the payee.                                                                                                                                                                                                                                                                                                                                               |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeId`                | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                                                                                                                                 |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`payeeReference`         | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [`payeeReference`][payee-reference] for details.                                                                                                                                                                                                                    |
|          | └─➔&nbsp;`payeeName`              | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                                                                                                                      |
|          | └─➔&nbsp;`productCategory`        | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                                                                                                                                |
|          | └─➔&nbsp;`orderReference`         | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                                                                                                                       |
|          | └─➔&nbsp;`subsite`                | `String(40)` | The subsite field can be used to perform [split settlement][split-settlement] on the payment. The subsites must be resolved with Swedbank Pay [reconciliation][settlement-and-reconciliation] before being used.                                                                                                                                                                                              |
|          | └➔&nbsp;`payer`                   | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                                                                                                                     |
|   ︎︎︎    | └─➔&nbsp;`consumerProfileRef`     | `string`     | The consumer profile reference as obtained through [initiating a consumer session][initiate-consumer-session].                                                                                                                                                                                                                                                                                                |
|          | └➔&nbsp;`orderItems`              | `array`      | The array of items being purchased with the order. Used to print on invoices if the payer chooses to pay with invoice, among other things                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`reference`              | `string`     | A reference that identifies the order item.                                                                                                                                                                                                                                                                                                                                                                   |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`name`                   | `string`     | The name of the order item.                                                                                                                                                                                                                                                                                                                                                                                   |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`type`                   | `string`     | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `PAYMENT_FEE` `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item. `PAYMENT_FEE` is the amount you are charged with when you are paying with invoice. The amount can be defined in the `amount` field below.                                                                                                                                          |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`class`                  | `string`     | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w]* (a-zA-Z0-9_)`. Swedbank Pay may use this field for statistics.                                                                                                                                                                                |
|          | └─➔&nbsp;`itemUrl`                | `string`     | The URL to a page that can display the purchased item, product or similar.                                                                                                                                                                                                                                                                                                                                    |
|   ︎︎︎    | └─➔&nbsp;`imageUrl`               | `string`     | The URL to an image of the order item.                                                                                                                                                                                                                                                                                                                                                                        |
|          | └─➔&nbsp;`description`            | `string`     | The human readable description of the order item.                                                                                                                                                                                                                                                                                                                                                             |
|          | └─➔&nbsp;`discountDescription`    | `string`     | The human readable description of the possible discount.                                                                                                                                                                                                                                                                                                                                                      |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`quantity`               | `integer`    | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                                                                                                                                              |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`quantityUnit`           | `string`     | The unit of the quantity, such as `pcs`, `grams`, or similar. This is a free-text field and is used for your own book keeping.                                                                                                                                                                                                                                                                                |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`unitPrice`              | `integer`    | The price per unit of order item, including VAT.                                                                                                                                                                                                                                                                                                                                                              |
|          | └─➔&nbsp;`discountPrice`          | `integer`    | If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                                                                                                                                                    |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`vatPercent`             | `integer`    | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                                                                                                                                                      |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`amount`                 | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                                                                                                                                                     |
|  ✔︎︎︎︎︎  | └─➔&nbsp;`vatAmount`              | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                                                                                                                                                  |
{% include risk-indicator-table.md %}
