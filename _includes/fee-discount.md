{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}

## Fees And Discounts

 If you want to add fees or discounts to your payment order, this can be done by
 include them as `orderItems` in your request. The feature is currently
 available for **Invoice**, **Installment Account** and **Monthly Payments**.

 Use positive amounts for fees and negative amounts for discounts. Remember
 that the sum of the `orderItems` must match the total payment order amount.

 Restricting the fee or discount to certain payment methods is also possible.
 Simply add the `restrictedToInstruments` field and which payment method the fee
 or discount applies to. This is currently available for invoice only.

 The example below shows a fee which only applies to Swedish invoices. Other
 options for some of the fields are in the table below.

## Fee Request

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
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
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
 | Field                    | Type         | Description                                                                                                                                                                                                               |
 | :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
 | {% icon check %} | {% f orderItems %}               | `array`      | {% include fields/order-items.md %}                                                                                                                                                                                                                                                            |
 | {% icon check %} | {% f reference, 2 %}               | `string`     | A reference that identifies the order item.                                                                                                                                                                                                                                                              |
 | {% icon check %} | {% f name, 2 %}                    | `string`     | The name of the order item.                                                                                                                                                                                                                                                                              |
 | {% icon check %} | {% f type, 2 %}                    | `string`     | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `PAYMENT_FEE` `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item. `PAYMENT_FEE` is the amount you are charged with when you are paying with invoice. The amount can be defined in the `amount` field below.                                           |
 | {% icon check %} | {% f class, 2 %}                   | `string`     | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics.                                |
 |                  | {% f itemUrl, 2 %}                 | `string`     | The URL to a page that can display the purchased item, product or similar.                                                                                                                                                                                                                               |
 |        ︎︎︎          | {% f imageUrl, 2 %}                | `string`     | The URL to an image of the order item.                                                                                                                                                                                                                                                                    |
 |                  | {% f description, 2 %}             | `string`     | {% include fields/description.md %}                                                                                                                                                                                                                                                           |
 |                  | {% f discountDescription, 2 %}     | `string`     | Used for discounts only. The human readable description of the possible discount.                                                                                                                                                                                                                                                 |
 | {% icon check %} | {% f quantity, 2 %}                | `number`    | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                                         |
 | {% icon check %} | {% f quantityUnit, 2 %}            | `string`     | The unit of the quantity, such as `pcs`, `grams`, or similar. This is used for your own book keeping.                                                                                                                                                                                                    |
 | {% icon check %} | {% f unitPrice, 2 %}               | `integer`    | The price per unit of order item, including VAT.                                                                                                                                                                                                                                                         |
 |                  | {% f discountPrice, 2 %}           | `integer`    | Used for discounts only. If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                                               |
 | {% icon check %} | {% f vatPercent, 2 %}              | `integer`    | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                                                 |
 | {% icon check %} | {% f amount, 2 %}                  | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                                                |
 | {% icon check %} | {% f vatAmount, 2 %}               | `integer`    | {% include fields/vat-amount.md %}                                                     |
 |                  | {% f restrictedToInstruments %}  | `array`      | A list of the payment methods you wish to restrict the payment to. Currently `Invoice` only. `Invoice` supports the subtypes `PayExFinancingNo`, `PayExFinancingSe` and `PayMonthlyInvoiceSe`, separated by a dash, e.g.; `Invoice-PayExFinancingNo`. The fee or discount applies to all payment methods if a restriction is not included. Use of this field requires an agreement with Swedbank Pay.                                    |
{% endcapture %}
{% include accordion-table.html content=table %}
