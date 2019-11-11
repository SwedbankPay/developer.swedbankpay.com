Capture can only be done on a payment with a successful authorized transaction.
It is possible to do a part-capture where you only capture a smaller amount
than the authorized amount. You can later do more captures on the same payment
up to the total authorization amount.

**Notice** that the `orderItems` property object is optional. If the `POST`
request has `orderItems` in the `paymentorder`, remember to include `orderItems`
in the `capture` operation. If the `paymentorder` is without `orderItems`,
remember to leave this out in the `capture` operation.

To capture the authorized payment, we need to perform
`create-paymentorder-capture` against the accompanying href returned in the
`operations` list. See the abbreviated request and response below:

{:.code-header}
**Request**

```http
POST /psp/paymentorders/b80be381-b572-4f1e-9691-08d5dd095bc4/captures HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <MerchantToken>
Content-Type: application/json

{
  "transaction": {
    "description": "Capturing the authorized payment",
    "amount": 15610,
    "vatAmount": 3122,
    "payeeReference": "AB832"
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
    ],
  }
}
```

{:.table .table-striped}
| ✔︎︎︎︎︎ | Property                       | Type         | Description                                                                                                                                                                                                                                |
| :----: | :----------------------------- | :----------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ✔︎︎︎︎︎ | `transaction`                  | `object`     | The transaction object.                                                                                                                                                                                                                    |
| ✔︎︎︎︎︎ | └➔&nbsp;`description`          | `string`     | The description of the capture transaction.                                                                                                                                                                                                |
| ✔︎︎︎︎︎ | └➔&nbsp;`amount`               | `integer`    | The amount including VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.                                                                                                          |
| ✔︎︎︎︎︎ | └➔&nbsp;`vatAmount`            | `integer`    | The amount of VAT in the lowest monetary unit of the currency. E.g. `10000` equals 100.00 NOK and `5000` equals 50.00 NOK.                                                                                                                 |
| ✔︎︎︎︎︎ | └➔&nbsp;`payeeReference`       | `string(30)` | A unique reference from the merchant system. It is set per operation to ensure an exactly-once delivery of a transactional operation. See [payeeReference][payee-reference] for details.                                                   |
|        | └➔&nbsp;`orderItems`           | `array`      | The array of items being purchased with the order. Used to print on invoices if the payer chooses to pay with invoice, among other things. Required in `capture` requests if already sent with the initial creation of the Payment Order. Note that this should only contain the items to be captured from the order.  |
| ✔︎︎︎︎︎ | └─➔&nbsp;`reference`           | `string`     | A reference that identifies the order item.                                                                                                                                                                                                |
| ✔︎︎︎︎︎ | └─➔&nbsp;`name`                | `string`     | The name of the order item.                                                                                                                                                                                                                |
| ✔︎︎︎︎︎ | └─➔&nbsp;`type`                | `string`     | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item.                                                                                                                                     |
| ✔︎︎︎︎︎ | └─➔&nbsp;`class`               | `string`     | The classification of the order item. Can be used for assigning the order item to a specific product category, for instance. Swedbank Pay has no use for this value itself, but it's useful for some payment instruments and integrations. Note that this cannot contain spaces. |
|  ︎︎︎   | └─➔&nbsp;`itemUrl`             | `string`     | The URL to a page that contains a human readable description of the order item, or similar.                                                                                                                                                |
|  ︎︎︎   | └─➔&nbsp;`imageUrl`            | `string`     | The URL to an image of the order item.                                                                                                                                                                                                     |
|  ︎︎︎   | └─➔&nbsp;`description`         | `string`     | The human readable description of the order item.                                                                                                                                                                                          |
|  ︎︎︎   | └─➔&nbsp;`discountDescription` | `string`     | The human readable description of the possible discount.                                                                                                                                                                                   |
| ✔︎︎︎︎︎ | └─➔&nbsp;`quantity`            | `integer`    | The quantity of order items being purchased.                                                                                                                                                                                               |
| ✔︎︎︎︎︎ | └─➔&nbsp;`quantityUnit`        | `string`     | The unit of the quantity, such as `pcs`, `grams`, or similar.                                                                                                                                                                              |
| ✔︎︎︎︎︎ | └─➔&nbsp;`unitPrice`           | `integer`    | The price per unit of order item.                                                                                                                                                                                                          |
|  ︎︎︎   | └─➔&nbsp;`discountPrice`       | `integer`    | If the order item is purchased at a discounted price, this property should contain that price.                                                                                                                                             |
| ✔︎︎︎︎︎ | └─➔&nbsp;`vatPercent`          | `integer`    | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                   |
| ✔︎︎︎︎︎ | └─➔&nbsp;`amount`              | `integer`    | The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `500`0 equals `50.00 NOK`.                                      |
| ✔︎︎︎︎︎ | └─➔&nbsp;`vatAmount`           | `integer`    | The total amount of VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `500`0 equals `50.00 NOK`.                                             |

If the capture succeeds, it should respond with something like the following:

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251",
    "capture": {
        "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/captures/af43be30-8dfa-4458-2222-08d5df73b9f1",
        "transaction": {
            "id": "/psp/creditcard/payments/d34bceb7-2b19-488a-cbf2-08d5df73b251/transactions/af43be30-8dfa-4458-2222-08d5df73b9f1",
            "type": "Capture",
            "state": "Completed",
            "amount": 15610,
            "vatAmount": 3122,
            "description": "Capturing the authorized payment",
            "payeeReference": "AB832",
        }
    }
}
```

{:.table .table-striped}
| Property                  | Type      | Description                                                                                                                                                                                                  |
| :------------------------ | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `payment`                 | `string`  | The relative URI of the payment this capture transaction belongs to.                                                                                                                                         |
| `capture`                 | `object`  | The capture object, containing the information about the capture transaction.                                                                                                                                |
| └➔&nbsp;`id`              | `string`  | The relative URI of the created capture transaction.                                                                                                                                                         |
| └➔&nbsp;`transaction`     | `object`  | The transaction object, containing information about the current transaction.                                                                                                                                |
| └─➔&nbsp;`id`             | `string`  | The relative URI of the current `transaction` resource.                                                                                                                                                      |
| └─➔&nbsp;`created`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`updated`        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| └─➔&nbsp;`type`           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| └─➔&nbsp;`state`          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| └─➔&nbsp;`number`         | `string`  | The transaction `number`, useful when there's need to reference the transaction in human communication. Not usable for programmatic identification of the transaction, for that `id` should be used instead. |
| └─➔&nbsp;`amount`         | `integer` | Amount is entered in the lowest momentary units of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 SEK.                                                                                     |
| └─➔&nbsp;`vatAmount`      | `integer` | If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                           |
| └─➔&nbsp;`description`    | `string`  | A human readable description of maximum 40 characters of the transaction.                                                                                                                                    |
| └─➔&nbsp;`payeeReference` | `string`  | A unique reference for the transaction. See [`payeeReference`][payee-reference] for details.                                                                                                                 |
