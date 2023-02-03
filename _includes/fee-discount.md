{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}

## Fees And Discounts

 If you want to add fees or discounts to your payment order, this can be done by
 adding them as `orderItems` in your request. Use positive amounts for fees and
 negative amounts for discounts. Remember that the sum of the `orderItems` must
 match the total payment order amount.

 Restricting the fee or discount to certain instruments is also possible. Simply
 add the `restrictToInstruments` field and which instruments the fee or discount
 applies to. This is currently available for invoice only.

 The example below shows a fee which only applies to Swedish invoices. Other
 options for some of the fields are in the table at the bottom.

## Fee Request

 {:.code-view-header}
 **Request**

 ```http
 POST /psp/paymentorders HTTP/1.1
 Host: {{ page.api_host }}
 Authorization: Bearer <AccessToken>
 Content-Type: application/json
      "orderItems": [
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
         ]
 ```

 {:.table .table-striped}
 | Field                    | Type         | Description                                                                                                                                                                                                               |
 | :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
 | {% icon check %} | └➔&nbsp;`orderItems`               | `array`      | {% include fields/order-items.md %}                                                                                                                                                                                                                                                            |
 | {% icon check %} | └─➔&nbsp;`reference`               | `string`     | A reference that identifies the order item.                                                                                                                                                                                                                                                              |
 | {% icon check %} | └─➔&nbsp;`name`                    | `string`     | The name of the order item.                                                                                                                                                                                                                                                                              |
 | {% icon check %} | └─➔&nbsp;`type`                    | `string`     | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `PAYMENT_FEE` `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item. `PAYMENT_FEE` is the amount you are charged with when you are paying with invoice. The amount can be defined in the `amount` field below.                                           |
 | {% icon check %} | └─➔&nbsp;`class`                   | `string`     | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics.                                |
 |                  | └─➔&nbsp;`itemUrl`                 | `string`     | The URL to a page that can display the purchased item, product or similar.                                                                                                                                                                                                                               |
 |        ︎︎︎          | └─➔&nbsp;`imageUrl`                | `string`     | The URL to an image of the order item.                                                                                                                                                                                                                                                                    |
 |                  | └─➔&nbsp;`description`             | `string`     | {% include fields/description.md %}                                                                                                                                                                                                                                                           |
 |                  | └─➔&nbsp;`discountDescription`     | `string`     | Used for discounts only. The human readable description of the possible discount.                                                                                                                                                                                                                                                 |
 | {% icon check %} | └─➔&nbsp;`quantity`                | `integer`    | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                                         |
 | {% icon check %} | └─➔&nbsp;`quantityUnit`            | `string`     | The unit of the quantity, such as `pcs`, `grams`, or similar. This is used for your own book keeping.                                                                                                                                                                                                    |
 | {% icon check %} | └─➔&nbsp;`unitPrice`               | `integer`    | The price per unit of order item, including VAT.                                                                                                                                                                                                                                                         |
 |                  | └─➔&nbsp;`discountPrice`           | `integer`    | Used for discounts only. If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                                               |
 | {% icon check %} | └─➔&nbsp;`vatPercent`              | `integer`    | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                                                 |
 | {% icon check %} | └─➔&nbsp;`amount`                  | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                                                |
 | {% icon check %} | └─➔&nbsp;`vatAmount`               | `integer`    | {% include fields/vat-amount.md %}                                                     |
 |                  | └➔&nbsp;`restrictedToInstruments`  | `array`      | A list of the instruments you wish to restrict the payment to. Currently `Invoice` only. `Invoice` supports the subtypes `PayExFinancingNo`, `PayExFinancingSe` and `PayMonthlyInvoiceSe`, separated by a dash, e.g.; `Invoice-PayExFinancingNo`. The fee or discount applies to all instruments if a restriction is not included. Use of this field requires an agreement with Swedbank Pay.                                    |
