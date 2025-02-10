### Update Payment Order

{% include alert.html type="warning" icon="warning" body="If a payment is
attempted, failed or currently being processed, you will not be able to
update the `orderItems` for the payment order. Should you need to update the
`orderItems`, you will have to `abort` the payment order and create a new order
with the updated `orderItems`." %}

The `UpdateOrder` operation is used when there is a change in the amount, vat
amount or there are added or removed order items in the payment order. This
feature is available in **Seamless View** only.

{% include alert.html type="informative" icon="info" body="If you implement
`UpdateOrder` you need to `refresh()` the Payment Menu frontend after you have
called the `UpdateOrder` API from the backend." %}

In case the shopping cart is changed in another browser tab, that should also
lead to an `UpdateOrder`. On `window.onfocus` in the tab that had Payment Menu
initialized, `refresh()` should be invoked so the correct amount is authorized.

If the page is refreshed by a full page reload, `refresh()` is not necessary.

The response given when changing a payment order is equivalent to a `GET`
request towards the `paymentorders` resource. Even though the fields are the
same, the `UpdateOrder` request will overwrite the fields that were sent in the
initial `Purchase` request.

{% capture request_header %}PATCH /psp/paymentorders/{{ page.payment_order_id }} HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "UpdateOrder",
        "amount": 1500,
        "vatAmount": 375,
        "orderItems": [
            {
                "reference": "P1",
                "name": "Product1",
                "type": "PRODUCT",
                "class": "ProductGroup1",
                "itemUrl": "https://example.com/shop/products/1234",
                "imageUrl": "https://example.com/products/product1.jpg",
                "description": "Product description",
                "discountDescription": "Volume discount",
                "quantity": 351.3514,
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
                "description": "Product description",
                "quantity": 9876.1531,
                "quantityUnit": "pcs",
                "unitPrice": 500,
                "vatPercent": 2500,
                "amount": 500,
                "vatAmount": 125
            }
        ]
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                          | Type      | Description                                                                                                                                                                                                                                                                           |
| :--------------: | :----------------------------- | :-------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | {% f paymentOrder, 0 %}                 | `object`  | The payment order object.                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f operation %}            | `string`  | {% include fields/operation.md %}                                                                                                                                                                                                                          |
| {% icon check %} | {% f amount %}               | `integer` | {% include fields/amount.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | {% f vatAmount %}            | `integer` | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                          |
| {% icon check %} | {% f description %}          | `string`  | The description of the payment order.                                                                                                                                                                                                                                                 |
| {% icon check %} | {% f orderItems %}           | `array`   | {% include fields/order-items.md %}                                                                                                                                                                                                                                         |
| {% icon check %} | {% f reference, 2 %}           | `string`  | A reference that identifies the order item.                                                                                                                                                                                                                                           |
| {% icon check %} | {% f name, 2 %}                | `string`  | The name of the order item.                                                                                                                                                                                                                                                           |
| {% icon check %} | {% f type, 2 %}                | `enum`    | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `PAYMENT_FEE`, `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item.                                                                                                                                                                 |
| {% icon check %} | {% f class, 2 %}               | `string`  | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics. |
| {% icon check %} | {% f itemUrl, 2 %}             | `string`  | The URL to a page that can display the purchased item, product or similar.                                                                                                                                                                                                            |
| {% icon check %} | {% f imageUrl, 2 %}            | `string`  | The URL to an image of the order item.                                                                                                                                                                                                                                                |
| {% icon check %} | {% f description, 2 %}         | `string`  | The human readable description of the order item.                                                                                                                                                                                                                                     |
| {% icon check %} | {% f discountDescription, 2 %} | `string`  | The human readable description of the possible discount.                                                                                                                                                                                                                              |
| {% icon check %} | {% f quantity, 2 %}            | `number` | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                      |
| {% icon check %} | {% f quantityUnit, 2 %}        | `string`  | The unit of the quantity, such as `pcs`, `grams`, or similar. This is used for your own book keeping.                                                                                                                                                        |
| {% icon check %} | {% f unitPrice, 2 %}           | `integer` | The price per unit of order item, including VAT.                                                                                                                                                                                                                                      |
| {% icon check %} | {% f discountPrice, 2 %}       | `integer` | If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                            |
| {% icon check %} | {% f vatPercent, 2 %}          | `integer` | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                              |
| {% icon check %} | {% f amount, 2 %}              | `integer` | The total amount including VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `500`0 equals `50.00 NOK`.                                                                                 |
| {% icon check %} | {% f vatAmount, 2 %}           | `integer` | The total amount of VAT to be paid for the specified quantity of this order item, in the lowest monetary unit of the currency. E.g. `10000` equals `100.00 NOK` and `500`0 equals `50.00 NOK`.                                                                                        |
{% endcapture %}
{% include accordion-table.html content=table %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",
        "created": "2018-09-14T13:21:29.3182115Z",
        "updated": "2018-09-14T13:21:57.6627579Z",
        "operation": "Purchase",
        "state": "Ready",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 0,
        "remainingCaptureAmount": 1500,
        "remainingCancellationAmount": 1500,
        "remainingReversalAmount": 0,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",
        "urls" : { "id": "/psp/paymentorders/{{ page.payment_order_id }}/urls" },
        "payeeInfo" : { "id": "/psp/paymentorders/{{ page.payment_order_id }}/payeeinfo" },
        "payers": { "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/payers"
        "orderItems" : { "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderItems" },
        "metadata": { "id": "/psp/paymentorders/{{ page.payment_order_id }}/metadata" },
        "payments": { "id": "/psp/paymentorders/{{ page.payment_order_id }}/payments" },
        "currentPayment": { "id": "/psp/paymentorders/{{ page.payment_order_id }}/currentpayment" }
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.stage.payex.com/psp/paymentorders/7f27f445-cefe-4a48-d405-08d8143ed22b",
            "rel": "update-paymentorder-updateorder",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-abort",
            "contentType": "application/json"
        },
        {
            "method": "PATCH",
            "href": "{{ page.api_url }}/psp/paymentorders/{{ page.payment_order_id }}",
            "rel": "update-paymentorder-expandinstrument",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/paymentmenu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "redirect-paymentorder",
            "contentType": "text/html"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/paymentmenu/core/scripts/client/px.paymentmenu.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "view-paymentorder",
            "contentType": "application/javascript"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                             | Type         | Description                                                                                                                                                                                                                                                                                                                                                |
| :-------------------------------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}                         | `object`     | The `payment` object contains information about the specific payment.                                                                                                                                                                                                                                                                                      |
| {% f id %}                      | `string`     | {% include fields/id.md %}                                                                                                                                                                                                                                                                                                                      |
| {% f number %}                  | `integer`    | {% include fields/number.md resource="payment" %}                                                                                                                                                           |
| {% f created %}                 | `string`     | The ISO-8601 date of when the payment was created.                                                                                                                                                                                                                                                                                                         |
| {% f updated %}                 | `string`     | The ISO-8601 date of when the payment was updated.                                                                                                                                                                                                                                                                                                         |
| {% f state %}                   | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment, not the state of any transactions performed on the payment. To find the state of the payment's transactions (such as a successful authorization), see the `transactions` resource or the different specialized type-specific resources such as `authorizations` or `sales`. |
| {% f prices %}                  | `object`     | The `prices` resource lists the prices related to a specific payment.                                                                                                                                                                                                                                                                                      |
| {% f id, 2 %}                     | `string`     | {% include fields/id.md resource="prices" %}                                                                                                                                                                                                                                                                                                    |
| {% f amount %}                  | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                                                                                                  |
| {% f remainingCaptureAmount %}  | `integer`    | The available amount to capture.                                                                                                                                                                                                                                                                                                                           |
| {% f remainingCancelAmount %}   | `integer`    | The available amount to cancel.                                                                                                                                                                                                                                                                                                                            |
| {% f remainingReversalAmount %} | `integer`    | The available amount to reverse.                                                                                                                                                                                                                                                                                                                           |
| {% f description %}             | `string(40)` | {% include fields/description.md %}                                                                                                                                                                                                                                                         |
| {% f userAgent %}               | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                                             |
| {% f language %}                | `string`     | {% include fields/language.md %}                                                                                                                                                                                                                                                                                      |
| {% f urls %}                    | `string`     | The URL to the urls resource where all URLs related to the payment can be retrieved.                                                                                                                                                                                                                                                                     |
| {% f payeeInfo %}               | `object`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                 |
| {% f payers %}                  | `string`     | The URL to the `payer` resource where the information about the payer can be retrieved.                                                        |
| {% f operations, 0 %}                      | `array`      | {% include fields/operations.md resource="payment" %}                                                                                                                                                                                                                                                                                                                |
| {% f method, 2 %}                 | `string`     | The HTTP method to use when performing the operation.                                                                                                                                                                                                                                                                                                      |
| {% f href, 2 %}                   | `string`     | The target URL to perform the operation against.                                                                                                                                                                                                                                                                                                           |
| {% f rel, 2 %}                    | `string`     | The name of the relation the operation has to the current resource.                                                                                                                                                                                                                                                                                        |
{% endcapture %}
{% include accordion-table.html content=table %}
