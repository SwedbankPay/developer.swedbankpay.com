{%- capture documentation_section -%}{%- include documentation-section.md -%}{%- endcapture -%}

{% if documentation_section == "checkout" %}
## Step 5: Capture the funds
{% else %}
## Step 3: Capture the funds
{% endif %}


Capture can only be done on a payment with a successful authorized transaction,
and if the authorization was not done with a one-phase payment instrument.
Examples of one-phase payment instruments are [Swish][swish] and
[Trustly][trustly], while payment instruments such as [Card Payments][card] and
[Vipps][vipps] are two-phase payments, requiring a `Capture` to be performed.

It is possible to do a partial capture where you only capture a smaller amount
than the authorized amount. You can later do more captures on the same payment
up to the total authorization amount.

This is done by requesting the order information from the server, to get the
request link to perform the capture. With this, you can request the capture
with the sum to capture, and get back the status.

```mermaid
sequenceDiagram
    participant Merchant
    participant SwedbankPay as Swedbank Pay

    rect rgba(81,43,43,0.1)
        activate Merchant
        note left of Payer: Capture
        Merchant ->>+ SwedbankPay: rel:create-paymentorder-capture
        deactivate Merchant
        SwedbankPay -->>- Merchant: Capture status
        note right of Merchant: Capture here only if the purchased<br/>goods don't require shipping.<br/>If shipping is required, perform capture<br/>after the goods have shipped.<br>Should only be used for <br>PaymentInstruments that support <br>Authorizations.
    end
```

To capture the authorized payment, we need to perform
`create-paymentorder-capture` against the accompanying `href` returned in the
`operations` list. See the abbreviated request and response below:

{:.code-view-header}
**Request**

```http
POST /psp/paymentorders/{{ page.payment_order_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "transaction": {
        "description": "Capturing the authorized payment",
        "amount": 1500,
        "vatAmount": 375,
        "payeeReference": "AB832",
        "receiptReference": "AB831",
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
                "reference": "P2",
                "name": "Product2",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "description": "Product 2 description",
                "quantity": 1,
                "quantityUnit": "pcs",
                "unitPrice": 500,
                "vatPercent": 2500,
                "amount": 500,
                "vatAmount": 125
            }
        ]
    }
}
```

{:.table .table-striped}
|     Required     | Field                          | Type         | Description                                                                                                                                                                                                                                                                           |
| :--------------: | :----------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | `transaction`                  | `object`     | The transaction object.                                                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`description`          | `string`     | The description of the capture transaction.                                                                                                                                                                                                                                           |
| {% icon check %} | └➔&nbsp;`amount`               | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`vatAmount`            | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                          |
| {% icon check %} | └➔&nbsp;`payeeReference`       | `string(30)` | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                                                                                                  |
|                  | └➔&nbsp;`receiptReference`     | `string(30)` | A unique reference from the merchant system. It is used to supplement `payeeReference` as an additional receipt number.                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`orderItems`           | `array`      | {% include field-description-orderitems.md %}                                                                                                                                                                                                                                         |
| {% icon check %} | └─➔&nbsp;`reference`           | `string`     | A reference that identifies the order item.                                                                                                                                                                                                                                           |
| {% icon check %} | └─➔&nbsp;`name`                | `string`     | The name of the order item.                                                                                                                                                                                                                                                           |
| {% icon check %} | └─➔&nbsp;`type`                | `enum`       | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `PAYMENT_FEE`, `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item.                                                                                                                                                                 |
| {% icon check %} | └─➔&nbsp;`class`               | `string`     | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics. |
|                  | └─➔&nbsp;`itemUrl`             | `string`     | The URL to a page that can display the purchased item, product or similar.                                                                                                                                                                                                            |
|        ︎︎︎         | └─➔&nbsp;`imageUrl`            | `string`     | The URL to an image of the order item.                                                                                                                                                                                                                                                |
|                  | └─➔&nbsp;`description`         | `string`     | The human readable description of the order item.                                                                                                                                                                                                                                     |
|                  | └─➔&nbsp;`discountDescription` | `string`     | The human readable description of the possible discount.                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`quantity`            | `integer`    | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                      |
| {% icon check %} | └─➔&nbsp;`quantityUnit`        | `string`     | The unit of the quantity, such as `pcs`, `grams`, or similar. This is used for your own book keeping.                                                                                                                                                        |
| {% icon check %} | └─➔&nbsp;`unitPrice`           | `integer`    | The price per unit of order item, including VAT.                                                                                                                                                                                                                                      |
|                  | └─➔&nbsp;`discountPrice`       | `integer`    | If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                            |
| {% icon check %} | └─➔&nbsp;`vatPercent`          | `integer`    | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`amount`              | `integer`    | The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 SEK` and `5000` equals `50.00 SEK`.                                                                                 |
| {% icon check %} | └─➔&nbsp;`vatAmount`           | `integer`    | The total amount of VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 SEK` and `5000` equals `50.00 SEK`.                                                                                        |
| {% icon check %} | └─➔&nbsp;`reference`           | `string`     | A reference that identifies the order item.                                                                                                                                                                                                                                           |
| {% icon check %} | └─➔&nbsp;`name`                | `string`     | The name of the order item.                                                                                                                                                                                                                                                           |
| {% icon check %} | └─➔&nbsp;`type`                | `enum`       | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `PAYMENT_FEE`, `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item.                                                                                                                                                                 |
| {% icon check %} | └─➔&nbsp;`class`               | `string`     | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics. |
|        ︎︎︎         | └─➔&nbsp;`itemUrl`             | `string`     | The URL to a page that can display the purchased item, such as a product page                                                                                                                                                                                                         |
|        ︎︎︎         | └─➔&nbsp;`imageUrl`            | `string`     | The URL to an image of the order item.                                                                                                                                                                                                                                                |
|        ︎︎︎         | └─➔&nbsp;`description`         | `string`     | The human readable description of the order item.                                                                                                                                                                                                                                     |
|        ︎︎︎         | └─➔&nbsp;`discountDescription` | `string`     | The human readable description of the possible discount.                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`quantity`            | `decimal`    | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                      |
| {% icon check %} | └─➔&nbsp;`quantityUnit`        | `string`     | The unit of the quantity, such as `pcs`, `grams`, or similar.                                                                                                                                                                                                                         |
| {% icon check %} | └─➔&nbsp;`unitPrice`           | `integer`    | The price per unit of order item, including VAT.                                                                                                                                                                                                                                      |
|        ︎︎︎         | └─➔&nbsp;`discountPrice`       | `integer`    | If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                            |
| {% icon check %} | └─➔&nbsp;`vatPercent`          | `integer`    | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`amount`              | `integer`    | The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `500`0 equals `50.00 NOK`.                                                                                 |
| {% icon check %} | └─➔&nbsp;`vatAmount`           | `integer`    | The total amount of VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `500`0 equals `50.00 NOK`.                                                                                        |

If the capture succeeds, it should respond with something like the following:

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/paymentorders/payments/{{ page.payment_id }}",
    "capture": {
        "id": "/psp/paymentorders/payments/{{ page.payment_id }}/captures/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/paymentorders/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "type": "Capture",
            "state": "Completed",
            "amount": 15610,
            "vatAmount": 3122,
            "description": "Capturing the authorized payment",
            "payeeReference": "AB832",
            "receiptReference": "AB831"
        }
    }
}
```

{:.table .table-striped}
| Property                    | Type         | Description                                                                                                                                                                                                       |
| :-------------------------- | :----------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                   | `string`     | The relative URI of the payment this capture transaction belongs to.                                                                                                                                              |
| `capture`                   | `object`     | The capture object, containing the information about the capture transaction.                                                                                                                                     |
| └➔&nbsp;`id`                | `string`     | The relative URI of the created capture transaction.                                                                                                                                                              |
| └➔&nbsp;`transaction`       | `object`     | The transaction object, containing information about the current transaction.                                                                                                                                     |
| └─➔&nbsp;`id`               | `string`     | The relative URI of the current `transaction` resource.                                                                                                                                                           |
| └─➔&nbsp;`created`          | `string`     | The ISO-8601 date and time of when the transaction was created.                                                                                                                                                   |
| └─➔&nbsp;`updated`          | `string`     | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                                   |
| └─➔&nbsp;`type`             | `string`     | Indicates the transaction type.                                                                                                                                                                                   |
| └─➔&nbsp;`state`            | `string`     | {% include field-description-state.md %}            |
| └─➔&nbsp;`number`           | `string`     | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, where `id` should be used instead.      |
| └─➔&nbsp;`amount`           | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                         |
| └─➔&nbsp;`vatAmount`        | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                      |
| └─➔&nbsp;`description`      | `string`     | {% include field-description-description.md %}                                                                                                                                   |
| └─➔&nbsp;`payeeReference`   | `string`     | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                              |
| └─➔&nbsp;`receiptReference` | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation.  It is used to supplement `payeeReference` as an additional receipt number. |

[card]: /payment-instruments/card
[vipps]: /payment-instruments/vipps
[payee-reference]: /checkout/features/technical-reference/payee-reference
[swish]: /payment-instruments/swish/
[trustly]: /payment-instruments/trustly/
