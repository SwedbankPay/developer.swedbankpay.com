{% capture documentation_section %}{%- include documentation-section.md -%}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{% assign features_url = documentation_section | prepend: '/' | append: '/features' %}

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
        "urls": { {% if include.integration_mode=="seamless-view" %}
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "paymentUrl": "https://example.com/perform-payment", {% endif %}
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditions.pdf"{% if include.integration_mode=="redirect" %},
            "logoUrl": "https://example.com/logo.png" {% endif %}
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-123456",
            "subsite": "MySubsite",
            "siteId": "MySiteId"
        },
        "payer": {
            "digitalProducts": false,
            "nationalIdentifier": {
                "socialSecurityNumber": "{{ page.consumer_ssn_se }}",
                "countryCode": "SE"
            }
            "firstName": "Leia"
            "lastName": "Ahlström"
            "email": "leia@payex.com",
            "msisdn": "+46787654321",
            "payerReference": "AB1234",
            "shippingAddress": {
                "firstName": "firstname/companyname",
                "lastName": "lastname",
                "email": "karl.anderssson@mail.se",
                "msisdn": "+46759123456",
                "streetAddress": "string",
                "coAddress": "string",
                "city": "string",
                "zipCode": "string",
                "countryCode": "string"
            },
            "billingAddress": {
                "firstName": "firstname/companyname",
                "lastName": "lastname",
                "email": "karl.anderssson@mail.se",
                "msisdn": "+46759123456",
                "streetAddress": "string",
                "coAddress": "string",
                "city": "string",
                "zipCode": "string",
                "countryCode": "string"
            },
            "accountInfo": {
                "accountAgeIndicator": "04",
                "accountChangeIndicator": "04",
                "accountPwdChangeIndicator": "01",
                "shippingAddressUsageIndicator": "01",
                "shippingNameIndicator": "01",
                "suspiciousAccountActivity": "01",
            }
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

{:.table .table-striped}
|     Required     | Field                              | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :--------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | `paymentorder`                     | `object`     | The payment order object.                                                                                                                                                                                                                                                                                |
| {% icon check %} | └➔&nbsp;`operation`                | `string`     | The operation that the payment order is supposed to perform.                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`currency`                 | `string`     | The currency of the payment.                                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`amount`                   | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                                                                                                |
| {% icon check %} | └➔&nbsp;`vatAmount`                | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`description`              | `string`     | The description of the payment order.                                                                                                                                                                                                                                                                    |
| {% icon check %} | └➔&nbsp;`userAgent`                | `string`     | {% include field-description-user-agent.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`language`                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`productName`                 | `string`     | Used to tag the payment as Checkout v3. Mandatory for Checkout v3, as you won't get the operations in the response without submitting this field.                                                                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`urls`                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |{% if include.integration_mode=="seamless-view" %}
| {% icon check %} | └─➔&nbsp;`hostUrls`                | `array`      | The array of URLs valid for embedding of Swedbank Pay Seamless Views.                                                                                                                                                                                                                                    |
|                  | └─➔&nbsp;`paymentUrl`              | `string`     | The URL that Swedbank Pay will redirect back to when the payment menu needs to be loaded, to inspect and act on the current status of the payment. See [`paymentUrl`]({{ features_url }}/technical-reference/payment-url) for details.                                                                   | {% endif %}
| {% icon check %} | └─➔&nbsp;`completeUrl`             | `string`     | The URL that Swedbank Pay will redirect back to when the payer has completed their interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment order to inspect it further. See [`completeUrl`]({{ features_url }}/technical-reference/complete-url) for details. |
|                  | └─➔&nbsp;`cancelUrl`               | `string`     | The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
| {% icon check %} | └─➔&nbsp;`callbackUrl`             | `string`     | The URL to the API endpoint receiving `POST` requests on transaction activity related to the payment order.                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`termsOfServiceUrl`       | `string`     | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                                                                     |{% if include.integration_mode=="redirect" %},
| {% icon check %} | └─➔&nbsp;`logoUrl`                 | `string`     | {% include field-description-logourl.md %}                                                                                                                                                                                                                                                               |{% endif %}
| {% icon check %} | └➔&nbsp;`payeeInfo`                | `string`     | {% include field-description-payeeinfo.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | └─➔&nbsp;`payeeId`                 | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | └─➔&nbsp;`payeeReference`          | `string` | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                                                                                                                                                                 |
|                  | └─➔&nbsp;`payeeName`               | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                 |
|                  | └─➔&nbsp;`productCategory`         | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                           |
|                  | └─➔&nbsp;`orderReference`          | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                  |
|                  | └─➔&nbsp;`subsite`                 | `String(40)` | The subsite field can be used to perform [split settlement]({{ features_url }}/core/settlement-reconciliation#split-settlement) on the payment. The subsites must be resolved with Swedbank Pay [reconciliation]({{ features_url }}/core/settlement-reconciliation) before being used. Must be in the format of `A-Za-z0-9`.                                                                                         |
|                  | └─➔&nbsp;`siteId`                 | `String(15)` | `SiteId` is used for [split settlement][split-settlement] transactions when you, as a merchant, need to specify towards AMEX which sub-merchant the transaction belongs to. Must be in the format of `A-Za-z0-9`.                                                                                          |
|                  | └➔&nbsp;`payer`                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                |
| | └➔&nbsp;`digitalProducts`                       | `bool` | Set to `true` for merchants who only sell digital goods and only require `email` and/or `msisdn` as shipping details. Set to `false` if the merchant also sells physical goods. |
|                  | └─➔&nbsp;`nationalIdentifier`    | `string` | The national identifier object.                                                                      |
|                  | └──➔&nbsp;`socialSecurityNumber` | `string` | The payer's social security number. |
|                  | └──➔&nbsp;`countryCode`          | `string` | The country code of the payer.                                                                     |
|  | └─➔&nbsp;`firstName`                    | `string`     | The first name of the payer.                                                                                                                                                                                                                                                                              |
|  | └─➔&nbsp;`lastName`                    | `string`     | The last name of the payer.                                                                                                                                                                                                                                                                              |
|                  | └─➔&nbsp;`email`                   | `string`     | The e-mail address of the payer. Will be used to prefill the Checkin as well as on the payer's profile, if not already set. Increases the chance for [frictionless 3-D Secure 2 flow]({{ features_url }}/core/3d-secure-2).                                                                             |
|                  | └─➔&nbsp;`msisdn`                  | `string`     | The mobile phone number of the Payer. Will be prefilled on Checkin page and used on the payer's profile, if not already set. The mobile number must have a country code prefix and be 8 to 15 digits in length. The field is related to [3-D Secure 2]({{ features_url }}/core/3d-secure-2).            |
|                  | └─➔&nbsp;`payerReference`                     | `string`     | A reference used in Enterprise integrations to recognize the payer in the absence of SSN and/or a secure login. Read more about this in the [payerReference](/checkout-v3/enterprise/features/optional/enterprise-payer-reference) feature section.                                                                                                                                                                                                                       |
| | └➔&nbsp;`shippingAddress`            | `object` | The shipping address object related to the `payer`. The field is related to [3-D Secure 2]({{ features_url }}/core/3d-secure-2).                                                                                                                                  |
| | └─➔&nbsp;`firstName`                   | `string` | The first name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                                                                          |
| | └─➔&nbsp;`lastName`                   | `string` | The last name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                                                                          |
| | └─➔&nbsp;`streetAddress`              | `string` | Payer's street address. Maximum 50 characters long.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| | └─➔&nbsp;`coAddress`                  | `string` | Payer' s c/o address, if applicable.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| | └─➔&nbsp;`zipCode`                    | `string` | Payer's zip code                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| | └─➔&nbsp;`city`                       | `string` | Payer's city of residence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| | └─➔&nbsp;`countryCode`                | `string` | Country code for country of residence.                                                                                                         |
|  | `billingAddress`               | `object`  | The billing address object containing information about the payer's billing address.                                                                            |
|  | └➔&nbsp;`firstName`            | `string`  | The first name of the payer.                                                                                                                  |
|   | └➔&nbsp;`lastName`            | `string`  | The last name of the payer.                                                                                                                  |
|  ︎ | └➔&nbsp;`streetAddress`        | `string`  | The street address of the payer. Maximum 50 characters long.                                                                                                   |
|                   | └➔&nbsp;`coAddress`            | `string`  | The CO-address (if used)                                                                                                                                         |
|  | └➔&nbsp;`zipCode`              | `string`  | The postal number (ZIP code) of the payer.                                                                                                                    |
|  | └➔&nbsp;`city`                 | `string`  | The city of the payer.                                                                                                                                        |
|   | └➔&nbsp;`countryCode`          | `string`  | `SE`, `NO`, or `FI`.                                                                                                                                             |
| | └➔&nbsp;`accountInfo`            | `object` | Object related to the `payer` containing info about the payer's account.               |
| | └─➔&nbsp;`accountAgeIndicator` | `string` | Indicates the age of the payer's account. <br>`01` (No account, guest checkout) <br>`02` (Created during this transaction) <br>`03` (Less than 30 days old) <br>`04` (30 to 60 days old) <br>`05` (More than 60 days old)             |
| | └─➔&nbsp;`accountChangeIndicator` | `string` | Indicates when the last account changes occurred. <br>`01` (Changed during this transaction) <br>`02` (Less than 30 days ago) <br>`03` (30 to 60 days ago) <br>`04` (More than 60 days ago) |
| | └─➔&nbsp;`accountChangePwdIndicator` | `string` | Indicates when the account's password was last changed. <br>`01` (No changes) <br>`02` (Changed during this transaction) <br>`03` (Less than 30 days ago) <br>`04` (30 to 60 days ago) <br>`05` (More than 60 days old) |
| | └─➔&nbsp;`shippingAddressUsageIndicator` | `string` | Indicates when the payer's shipping address was last used. <br>`01`(This transaction) <br>`02` (Less than 30 days ago) <br>`03` (30 to 60 days ago) <br>`04` (More than 60 days ago) |
| | └─➔&nbsp;`shippingNameIndicator` | `string` | Indicates if the account name matches the shipping name. <br>`01` (Account name identical to shipping name) <br>`02` (Account name different from shipping name) |
| | └─➔&nbsp;`suspiciousAccountActivity` | `string` | Indicates if there have been any suspicious activities linked to this account. <br>`01` (No suspicious activity has been observed) <br>`02` (Suspicious activity has been observed) |
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
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
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
        },{% if include.integration_mode=="redirect" %}
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/payment/menu/{{ page.payment_token }}?_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "redirect-checkout",
            "contentType": "text/html"
        }{% endif %} {% if include.integration_mode=="seamless-view" %}
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/payment/core/js/px.payment.client.js?token={{ page.payment_token }}&culture=nb-NO&_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "view-checkout",
            "contentType": "application/javascript"
        }{% endif %}
    ]
}
```

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `paymentorder`           | `object`     | The payment order object.                                                                                                                                                                                                 |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md resource="paymentorder" %}                                                                                                                                                             |{% if documentation_section == "payment-menu" %}
| └➔&nbsp;`instrument`     | `string`     | The payment instrument used. Selected by using the [Instrument Mode]({{ features_url }}/optional/instrument-mode).                                                                                                           |
| └➔&nbsp;`paymentToken`   | `string`     | The payment token created for the purchase used in the authorization to create [One Click Payments]({{ documentation_section }}/features/#one-click-payments).                                                                                                  | {% endif %}                                              |
| └➔&nbsp;`created`        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| └➔&nbsp;`updated`        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| └➔&nbsp;`operation`      | `string`     | `Purchase`                                                                                                                                                                                                                |
| └➔&nbsp;`state`          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment order. Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes. |
| └➔&nbsp;`currency`       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| └➔&nbsp;`amount`         | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                 |
| └➔&nbsp;`vatAmount`      | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                              |
| └➔&nbsp;`description`    | `string(40)` | {% include field-description-description.md %}                                                                                                                        |
| └➔&nbsp;`userAgent`      | `string`     | {% include field-description-user-agent.md %}                                                                                                                                                            |
| └➔&nbsp;`language`       | `string`     | {% include field-description-language.md %}                                                                                                                                                  |
| └➔&nbsp;`urls`           | `string`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                                                                                                              |
| └➔&nbsp;`payeeInfo`      | `string`     | {% include field-description-payeeinfo.md %}                                                                                                          |
| └➔&nbsp;`payers`         | `string`     | The URL to the `payer` resource where information about the payer of the payment order can be retrieved.                                                                                                                |
| └➔&nbsp;`orderItems`     | `string`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| └➔&nbsp;`payments`       | `string`     | The URL to the `payments` resource where information about all underlying payments can be retrieved.                                                                                                                      |
| └➔&nbsp;`currentPayment` | `string`     | The URL to the `currentPayment` resource where information about the current – and sole active – payment can be retrieved.                                                                                                |
| └➔&nbsp;`operations`     | `array`      | The array of possible operations to perform, given the state of the payment order. [See Operations for details]({{ features_url }}/technical-reference/operations).                                                                                              |

[split-settlement]: {{ features_url }}/core/settlement-reconciliation#split-settlement
