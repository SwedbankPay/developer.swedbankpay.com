{% capture documentation_section %}{%- include documentation-section.md -%}{% endcapture %}
{% capture features_url %}{% include documentation-section-url.md href='/features' %}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}

## Payment Order Request

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
        "language": "sv-SE",
        "productName": "Checkout3",
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "paymentUrl": "https://example.com/perform-payment",
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditions.pdf"
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
            "requireConsumerInfo": true,
            "digitalProducts": false,
            "shippingAddressRestrictedToCountryCodes": [ "NO", "US" ]
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
                "quantity": 5,
                "quantityUnit": "pcs",
                "unitPrice": 300,
                "discountPrice": 0,
                "vatPercent": 2500,
                "amount": 1500,
                "vatAmount": 375
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

{:.table .table-striped}
|     Required     | Field                              | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :--------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `paymentorder`                     | `object`     | The payment order object.                                                                                                                                                                                                                                                                                |
| {% icon check %} | └➔&nbsp;`operation`                | `string`     | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`currency`                 | `string`     | The currency of the payment.                                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`amount`                   | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                                                |
| {% icon check %} | └➔&nbsp;`vatAmount`                | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`description`              | `string`     | The description of the payment order.                                                                                                                                                                                                                                                                    |                                                 |
| {% icon check %} | └➔&nbsp;`userAgent`                | `string`     | {% include field-description-user-agent.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`language`                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`productName`                 | `string`     | Used to tag the payment as Checkout v3. Mandatory for Checkout v3, as you won't get the operations in the response without submitting this field.                                                                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`urls`                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | └─➔&nbsp;`hostUrls`                | `array`      | The array of URLs valid for embedding of Swedbank Pay Seamless Views.                                                                                                                                                                                                                                    |
|                  | └─➔&nbsp;`paymentUrl`              | `string`     | The URL that Swedbank Pay will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. See [`paymentUrl`]({{ features_url }}/technical-reference/payment-url) for details.                                                                   |
| {% icon check %} | └─➔&nbsp;`completeUrl`             | `string`     | The URL that Swedbank Pay will redirect back to when the payer has completed their interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment order to inspect it further. See [`completeUrl`]({{ features_url }}/technical-reference/complete-url) for details.  |
|                  | └─➔&nbsp;`cancelUrl`               | `string`     | The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
| {% icon check %} | └─➔&nbsp;`callbackUrl`             | `string`     | The URL to the API endpoint receiving `POST` requests on transaction activity related to the payment order.                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`termsOfServiceUrl`       | `string`     | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                                                                     |
| {% icon check %} | └➔&nbsp;`payeeInfo`                | `string`     | {% include field-description-payeeinfo.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | └─➔&nbsp;`payeeId`                 | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | └─➔&nbsp;`payeeReference`          | `string(30)` | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                                                                                                                                                                 |
|                  | └─➔&nbsp;`payeeName`               | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                 |
|                  | └─➔&nbsp;`productCategory`         | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                           |
|                  | └─➔&nbsp;`orderReference`          | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                  |
|                  | └─➔&nbsp;`subsite`                | `String(40)` | The subsite field can be used to perform split settlement on the payment. The subsites must be resolved with Swedbank Pay [reconciliation]({{ features_url }}/core/settlement-reconciliation) before being used.                                                                                         |
|                  | └➔&nbsp;`payer`                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                |
| | └➔&nbsp;`digitalProducts`                       | `bool` | Set to `true` for merchants who only sell digital goods and only require `email` and/or `msisdn` as shipping details. Set to `false` if the merchant also sells physical goods. |
|                  | `shippingAddressRestrictedToCountryCodes` | `string` | List of supported shipping countries for merchant. Using [ISO-3166] standard. Mandatory if `digitalProducts` is set to `false`, and not to be included if it is `true`.                                    |
|  {% icon check %} | `requireConsumerInfo` | `string` | Must be set to `true` by merchants using Starter, as they receive profile information from Swedbank Pay. This applies both when the merchant needs `email` and/or `msisdn` for digital goods, and when full shipping address is needed.                             |
| {% icon check %} | └➔&nbsp;`orderItems`               | `array`      | {% include field-description-orderitems.md %}                                 |
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
|                  | └➔&nbsp;`restrictedToInstruments`  | `array`      | A list of the instruments you wish to restrict the payment to. Currently `Invoice` only. `Invoice` supports the subtypes `PayExFinancingNo`, `PayExFinancingSe` and `PayMonthlyInvoiceSe`, separated by a dash, e.g.; `Invoice-PayExFinancingNo`. Default value is all supported payment instruments. Use of this field requires an agreement with Swedbank Pay. You can restrict fees and/or discounts to certain instruments by adding this field to the orderline you want to restrict. Use positive amounts to add fees and negative amounts to add discounts.                                                  |
{% include risk-indicator-table.md %}

## Payment Order Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",
        "created": "2020-06-22T10:56:56.2927632Z",
        "updated": "2020-06-22T10:56:56.4035291Z",
        "operation": "Purchase",
        "status": "Initialized",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [
          "CreditCard",
          "Invoice-PayExFinancingSe",
          "Invoice-PayMonthlyInvoiceSe",
          "Swish",
          "CreditAccount",
          "Trustly" ],
        "implementation": "Starter",
        "integration": "HostedView",
        "instrumentMode": false,
        "guestMode": false,
        "payer": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payers"
        },
        "orderItems": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderitems"
        },
        "history": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/history"
        },
        "failed": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/failed"
        },
        "aborted": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/aborted"
        },
        "paid": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/paid"
        },
        "cancelled": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/cancelled"
        },
        "financialTransactions": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/financialtransactions"
        },
        "failedAttempts": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/failedattempts"
        },
        "metadata": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/metadata"
        }
      },
      "operations": [ {% if include.integration_mode=="redirect" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "redirect-checkout",
          "contentType": "text/html"
        },{% endif %} {% if include.integration_mode=="seamless-view" %}
        {
          "method": "GET",
          "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
          "rel": "view-checkout",
          "contentType": "application/javascript"
        },{% endif %}
        {
          "method":"PATCH",
          "href": "https://api.payex.com/psp/paymentorders/222a50ca-b268-4b32-16fa-08d6d3b73224",
          "rel":"update-order",
          "contentType":"application/json"
        },
        {
          "method":"PATCH",
          "href": "https://api.payex.com/psp/paymentorders/222a50ca-b268-4b32-16fa-08d6d3b73224",
          "rel": "abort",
          "contentType": "application/json"
        }
       ]
      }
```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `paymentorder`           | `object`     | The payment order object.                                                                                                                                                                                                 |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md resource="paymentorder" %}                                                                                                                                                             |
| └➔&nbsp;`created`        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| └➔&nbsp;`updated`        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| └➔&nbsp;`operation`      | `string`     | `Purchase`                                                                                                                                                                                                                |
| └➔&nbsp;`status`          | `string`     | Indicates the payment order's current status. `Initialized` is returned when the payment is created and still ongoing. The request example above has this status. `Paid` is returned when the payer has completed the payment successfully. [See the `Paid` response]({{ features_url }}/technical-reference/status-models#paid). `Failed` is returned when a payment has failed. You will find an error message in [the `Failed` response]({{ features_url }}/technical-reference/status-models#failed). `Cancelled` is returned when an authorized amount has been fully cancelled. [See the `Cancelled` response]({{ features_url }}/technical-reference/status-models#cancelled). It will contain fields from both the cancelled description and paid section. `Aborted` is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). [See the `Aborted` response]({{ features_url }}/technical-reference/status-models#aborted). |
| └➔&nbsp;`currency`       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| └➔&nbsp;`amount`         | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                 |
| └➔&nbsp;`vatAmount`      | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                              |
| └➔&nbsp;`description`    | `string(40)` | {% include field-description-description.md %}                                                                                                                        |
| └➔&nbsp;`initiatingSystemUserAgent`      | `string`     | {% include field-description-initiating-system-user-agent.md %}                                                                                                                                                          |
| └➔&nbsp;`language`       | `string`     | {% include field-description-language.md %}                                                                                                                                                  |
| └➔&nbsp;`availableInstruments`       | `string`     | A list of instruments available for this payment.                                                                                                                                                   |
| └➔&nbsp;`implementation`       | `string`     | The merchant's Checkout v3 implementation type. `Business`, `Enterprise`, `PaymentsOnly` or `Starter`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                                                                  |
| └➔&nbsp;`integration`       | `string`     | The merchant's Checkout v3 integration type. `HostedView` (Seamless View) is the only available option when using `Starter`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the integration types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                                      |
| └➔&nbsp;`instrumentMode`       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment instrument available.                                                                                    |
| └➔&nbsp;`guestMode`       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Starter implementation, this is achieved if the payer chooses to proceed as a guest when given the option during checkin.                                                                                                                                                 |
| └➔&nbsp;`payer`         | `string`     | The URL to the `payers` resource where information about the payee of the payment order can be retrieved.                                                                                                                 |
| └➔&nbsp;`orderItems`     | `string`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| └➔&nbsp;`history`     | `string`     | The URL to the `history` [resource]({{ features_url }}/technical-reference/resource-sub-models#history) where information about the payment's history can be retrieved.                                                                                                                            |
| └➔&nbsp;`failed`     | `string`     | The URL to the `failed` [resource]({{ features_url }}/technical-reference/resource-sub-models#failed) where information about the failed transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`aborted`     | `string`     | The URL to the `aborted` [resource]({{ features_url }}/technical-reference/resource-sub-models#aborted) where information about the aborted transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`paid`     | `string`     | The URL to the `paid` [resource]({{ features_url }}/technical-reference/resource-sub-models#paid) where information about the paid transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`cancelled`     | `string`     | The URL to the `cancelled` [resource]({{ features_url }}/technical-reference/resource-sub-models#cancelled) where information about the cancelled transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`financialTransactions`     | `string`     | The URL to the `financialTransactions` [resource]({{ features_url }}/technical-reference/resource-sub-models#financialtransactions) where information about the financial transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`failedAttempts`     | `string`     | The URL to the `failedAttempts` [resource]({{ features_url }}/technical-reference/resource-sub-models#failedattempts) where information about the failed attempts can be retrieved.                                                                                                                            |
| └➔&nbsp;`metadata`     | `string`     | The URL to the `metadata` [resource]({{ features_url }}/technical-reference/resource-sub-models#metadata) where information about the metadata can be retrieved.                                                                                                                            |
| └➔&nbsp;`operations`     | `array`      | The array of possible operations to perform, given the state of the payment order. [See Operations for details]({{ features_url }}/technical-reference/operations).                                                                                              |
