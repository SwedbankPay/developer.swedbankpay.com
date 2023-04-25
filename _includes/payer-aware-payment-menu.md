{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{% assign features_url = documentation_section | prepend: '/' | append: '/features' %}

## Payer Aware Payment Menu

To give your payers the best experience possible, you should implement the Payer
Aware Payment Menu by identifying each payer with a unique identifier. It is
important that you enforce a good SCA (Strong Consumer Authentication) strategy
when authenticating the payer. The payer identifier must then be included as a
`payerReference` in the `paymentOrder` request to Swedbank Pay. This will enable
Swedbank Pay to render a unique payment menu experience for each payer. It will
also increase the chance for a frictionless payment.

By identifying your payers, their payment information can be stored for future
purchases by setting the `generatePaymentToken` value to `true`. The payer is,
by default, asked if they want to store their payment details, so even with
`generatePaymentToken` set to `true`, it is still up to the payer if they want
the details stored or not.

{% include alert.html type="informative" icon="info" body="Please note that not
all payment instruments provided by Swedbank Pay support Payer Awareness today."
%}

## BYO Payment Menu

Payment Menu v2 is versatile and can be configured in such a way that it
functions like a single payment instrument. In such configuration, it is easy to
Bring Your Own Payment Menu, i.e. building a customized payment menu in your own
user interface.

## Add Stored Payment Instrument Details

When building a custom payment menu, features like adding new stored payment
instrument details (i.e. "Add new card") is something that needs to be provided
in your UI.

This can be achieved by forcing the creation of a `paymentToken` by setting
`disableStoredPaymentDetails` to `true` in a Purchase payment (if you want
to withdraw money and create the token in the same operation), or by performing
a [verification][verify] (without withdrawing any money).

Setting `disableStoredPaymentDetails` to `true` will turn off all stored payment
details for the current purchase. The payer will also not be asked if they want
to store the payment details that will be part of the purchase. When you use
this feature, it is important that you have asked the payer in advance if it is
ok to store their payment details for later use.

Most often you will use the `disableStoredPaymentDetails` feature in combination
with the [Instrument Mode][instrument-mode] capability. If you build your own
menu and want to show stored payment details, you will need to set the
`disableStoredPaymentDetails` to `true`. It is important that you then store the
`paymentToken` in your system or call Swedbank Pay with the `payerReference` to
get all active payment tokens registered on that payer when building your
menu.

## GDPR

Remember that you have the responsibility of enforcing GDPR requirements and
letting the payer remove active payment tokens when they want. It is up to you
how to implement this functionality on your side, but Swedbank Pay has the API
you need to make it easy to [clean up old data][tokens]. See more below the main
`paymentOrder` request example, or follow the hyperlink above.

A Payer Aware Payment Menu request can look like this.

## Payer Aware Payment Menu Request

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
        "generatePaymentToken": true,
        "language": "sv-SE", {% if documentation_section contains "checkout-v3/payments-only" %}
        "productName": "Checkout3",
        "implementation": "PaymentsOnly", {% endif %} {% if documentation_section contains "payment-menu" %}
        "instrument": null,{% endif %}
        "disableStoredPaymentDetails": false,
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ], {% if include.integration_mode=="seamless-view" %}
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
            "subsite": "MySubsite", {% if documentation_section contains "checkout-v3/payments-only" %}
            "siteId": "MySiteId",{% endif %}
        },
,
        "payer": {
            "digitalProducts": false,
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
                "city": "Solna",
                "zipCode": "17674",
                "countryCode": "SE"
            },
            "billingAddress": {
                "firstName": "firstname/companyname",
                "lastName": "lastname",
                "email": "karl.anderssson@mail.se",
                "msisdn": "+46759123456",
                "streetAddress": "string",
                "coAddress": "string",
                "city": "Solna",
                "zipCode": "17674",
                "countryCode": "SE"
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

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                             | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :-------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f paymentOrder, 0 %}                    | `object`     | The payment order object.                                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f operation %}               | `string`     | {% include fields/operation.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | {% f currency %}                | `string`     | The currency of the payment.                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f amount %}                  | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f vatAmount %}               | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f description %}             | `string`     | The description of the payment order.                                                                                                                                                                                                                                                                     |{% if include.documentation_section contains "payment-menu" %}
| {% icon check %} | {% f instrument %}              | `string`     | The payment instrument used. Selected by using the [Instrument Mode][instrument-mode].                                                                                                                                                                                          | {% endif %}                                              |
|                  | {% f disableStoredPaymentDetails %} | `bool` | Set to `false` by default. Switching to `true` will turn off all stored payment details for the current purchase. When you use this feature it is important that you have asked the payer in advance if it is ok to store their payment details for later use.                                                                                         |
| {% icon check %} | {% f userAgent %}               | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                             |
|                  | {% f generatePaymentToken %}     | `bool`       | Determines if a payment token should be generated. Default value is `false`.                                               |
| {% icon check %} | {% f language %}                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               | {% if documentation_section contains "checkout-v3/payments-only" %}
| {% icon check %} | {% f productName %}              | `string`     | Used to tag the payment as Checkout v3. Mandatory for Checkout v3, as you won't get the operations in the response without submitting this field.                                                                                                                                                                                                                                                                              |{% endif %}
| {% icon check %} | {% f urls %}                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | {% f hostUrls, 2 %}                | `array`      | The array of URLs valid for embedding of Swedbank Pay Seamless Views.                                                                                                                                                                                                                                    |{% if include.integration_mode=="seamless-view" %}
|                  | {% f paymentUrl, 2 %}              | `string`     | {% include fields/payment-url.md %} | {% endif %}
| {% icon check %} | {% f completeUrl, 2 %}             | `string`     | {% include fields/complete-url.md %} |
|                  | {% f cancelUrl, 2 %}               | `string`     | The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
| {% icon check %} | {% f callbackUrl, 2 %}             | `string`     | {% include fields/callback-url.md %}                                                                                                                                                                                              |
| {% icon check %} | {% f termsOfServiceUrl, 2 %}       | `string`     | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                                     |{% if include.integration_mode=="redirect" %},
| {% icon check %} | {% f logoUrl, 2 %}                 | `string`     | {% include fields/logo-url.md %}                                                                                                                                                                                                                                                               |{% endif %}
| {% icon check %} | {% f payeeInfo %}               | `string`     | The `payeeInfo` object, containing information about the payee.                                                                                                                                                                                                                                          |
| {% icon check %} | {% f payeeId, 2 %}                | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f payeeReference, 2 %}         | `string` | {% include fields/payee-reference.md documentation_section=include.documentation_section describe_receipt=true %}                                                                                                                                                                             |
|                  | {% f payeeName, 2 %}              | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                 |
|                  | {% f productCategory, 2 %}        | `string`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                           |
|                  | {% f orderReference, 2 %}         | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                  |
|                  | {% f subsite, 2 %}                | `string(40)` | {% include fields/subsite.md %} | {% if documentation_section contains "checkout-v3/payments-only" %}
|                  | {% f siteId, 2 %}                 | `string(15)` | {% include fields/site-id.md %}                                                                      | {% endif %}
|                  | {% f payer %}                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                |
| | {% f digitalProducts %}                       | `bool` | Set to `true` for merchants who only sell digital goods and only require `email` and/or `msisdn` as shipping details. Set to `false` if the merchant also sells physical goods. |
|  | {% f firstName, 2 %}                    | `string`     | The first name of the payer.                                                                                                                                                                                                                                                                              |
|  | {% f lastName, 2 %}                    | `string`     | The last name of the payer.                                                                                                                                                                                                                                                                              |
|                  | {% f email, 2 %}                   | `string`     | The e-mail address of the payer. Will be used to prefill the Checkin as well as on the payer's profile, if not already set. Increases the chance for [frictionless 3-D Secure 2 flow]({{ features_url }}/core/3d-secure-2).                                                                             |
|                  | {% f msisdn, 2 %}                  | `string`     | The mobile phone number of the Payer. Will be prefilled on Checkin page and used on the payer's profile, if not already set. The mobile number must have a country code prefix and be 8 to 15 digits in length. The field is related to [3-D Secure 2]({{ features_url }}/core/3d-secure-2).            |
|                  | {% f payerReference, 2 %}                     | `string`     | A reference used in the Enterprise and Payments Only implementations to recognize the payer when no SSN is stored.                                                                                                                                                                                                            |
| | {% f shippingAddress %}            | `object` | The shipping address object related to the `payer`. The field is related to [3-D Secure 2]({{ features_url }}/core/3d-secure-2).                                                                                                                                  |
| | {% f firstName, 2 %}                   | `string` | The first name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                                                                          |
| | {% f lastName, 2 %}                   | `string` | The last name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                                                                          |
| | {% f streetAddress, 2 %}              | `string` | Payer's street address. Maximum 50 characters long.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| | {% f coAddress, 2 %}                  | `string` | Payer' s c/o address, if applicable.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| | {% f zipCode, 2 %}                    | `string` | Payer's zip code                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| | {% f city, 2 %}                       | `string` | Payer's city of residence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| | {% f countryCode, 2 %}                | `string` | Country code for country of residence, e.g. `SE`, `NO`, or `FI`.                                                               |
|   | `billingAddress`               | `object`  | The billing address object containing information about the payer's billing address.                                                                            |
|   | {% f firstName %}            | `string`  | The first name of the payer.                                                                                                                  |
|   | {% f lastName %}            | `string`  | The last name of the payer.                                                                                                                  |
|  ︎ | {% f streetAddress %}        | `string`  | The street address of the payer. Maximum 50 characters long.                                                                                                   |
|                   | {% f coAddress %}            | `string`  | The CO-address (if used)                                                                                                                                         |
|   | {% f zipCode %}              | `string`  | The postal number (ZIP code) of the payer.                                                                                                                    |
|   | {% f city %}                 | `string`  | The city of the payer.                                                                                                                                        |
|  | {% f countryCode %}          | `string`  | Country code for country of residence, e.g. `SE`, `NO`, or `FI`.                                                                                                                                             |
| | {% f accountInfo %}            | `object` | Object related to the `payer` containing info about the payer's account.               |
| | {% f accountAgeIndicator, 2 %} | `string` | Indicates the age of the payer's account. <br>`01` (No account, guest checkout) <br>`02` (Created during this transaction) <br>`03` (Less than 30 days old) <br>`04` (30 to 60 days old) <br>`05` (More than 60 days old)             |
| | {% f accountChangeIndicator, 2 %} | `string` | Indicates when the last account changes occurred. <br>`01` (Changed during this transaction) <br>`02` (Less than 30 days ago) <br>`03` (30 to 60 days ago) <br>`04` (More than 60 days ago) |
| | {% f accountChangePwdIndicator, 2 %} | `string` | Indicates when the account's password was last changed. <br>`01` (No changes) <br>`02` (Changed during this transaction) <br>`03` (Less than 30 days ago) <br>`04` (30 to 60 days ago) <br>`05` (More than 60 days old) |
| | {% f shippingAddressUsageIndicator, 2 %} | `string` | Indicates when the payer's shipping address was last used. <br>`01`(This transaction) <br>`02` (Less than 30 days ago) <br>`03` (30 to 60 days ago) <br>`04` (More than 60 days ago) |
| | {% f shippingNameIndicator, 2 %} | `string` | Indicates if the account name matches the shipping name. <br>`01` (Account name identical to shipping name) <br>`02` (Account name different from shipping name) |
| | {% f suspiciousAccountActivity, 2 %} | `string` | Indicates if there have been any suspicious activities linked to this account. <br>`01` (No suspicious activity has been observed) <br>`02` (Suspicious activity has been observed) |
| {% icon check %} | {% f orderItems %}               | `array`      | {% include fields/order-items.md %}                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f reference, 2 %}               | `string`     | A reference that identifies the order item.                                                                                                                                                                                                                                                              |
| {% icon check %} | {% f name, 2 %}                    | `string`     | The name of the order item.                                                                                                                                                                                                                                                                              |
| {% icon check %} | {% f type, 2 %}                    | `string`     | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `PAYMENT_FEE` `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item. `PAYMENT_FEE` is the amount you are charged with when you are paying with invoice. The amount can be defined in the `amount` field below.                                           |
| {% icon check %} | {% f class, 2 %}                   | `string`     | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics.                                |
|                  | {% f itemUrl, 2 %}                 | `string`     | The URL to a page that can display the purchased item, product or similar.                                                                                                                                                                                                                               |
|        ︎︎︎          | {% f imageUrl, 2 %}                | `string`     | The URL to an image of the order item.                                                                                                                                                                                                                                                                    |
|                  | {% f description, 2 %}             | `string`     | {% include fields/description.md %}                                                                                                                                                                                                                                                           |
|                  | {% f discountDescription, 2 %}     | `string`     | The human readable description of the possible discount.                                                                                                                                                                                                                                                 |
| {% icon check %} | {% f quantity, 2 %}                | `number`    | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                                         |
| {% icon check %} | {% f quantityUnit, 2 %}            | `string`     | The unit of the quantity, such as `pcs`, `grams`, or similar. This is used for your own book keeping.                                                                                                                                                                                                    |
| {% icon check %} | {% f unitPrice, 2 %}               | `integer`    | The price per unit of order item, including VAT.                                                                                                                                                                                                                                                         |
|                  | {% f discountPrice, 2 %}           | `integer`    | If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                                               |
| {% icon check %} | {% f vatPercent, 2 %}              | `integer`    | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                                                 |
| {% icon check %} | {% f amount, 2 %}                  | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f vatAmount, 2 %}               | `integer`    | {% include fields/vat-amount.md %}                                                     |
|                  | {% f restrictedToInstruments %}  | `array`      | A list of the instruments you wish to restrict the payment to. Currently `Invoice` only. `Invoice` supports the subtypes `PayExFinancingNo`, `PayExFinancingSe` and `PayMonthlyInvoiceSe`, separated by a dash, e.g.; `Invoice-PayExFinancingNo`. Default value is all supported payment instruments. Use of this field requires an agreement with Swedbank Pay. You can restrict fees and/or discounts to certain instruments by adding this field to the orderline you want to restrict. Use positive amounts to add fees and negative amounts to add discounts.                                                  |
{% include risk-indicator-table.md %}
{% endcapture %}
{% include accordion-table.html content=table %}

## Payer Aware Payment Menu Response

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
        "operation": "Purchase", {% if documentation_section contains "checkout-v3" %}
        "status": "Initialized", {% else %}
        "state": "Ready", {% endif %}
        "paymentToken" : "{{ page.payment_token }}",
        "currency": "SEK",
        "vatAmount": 375,
        "amount": 1500,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [
          "CreditCard",
          "Invoice-PayExFinancingSe",
          "Invoice-PayMonthlyInvoiceSe",
          "Swish",
          "CreditAccount",
          "Trustly" ], {% if documentation_section contains "checkout-v3" %}
        "implementation": "PaymentsOnly", {% endif %} {% if include.integration_mode=="seamless-view" %}
        "integration": "HostedView", {% endif %} {% if include.integration_mode=="redirect" %}
        "integration": "Redirect",
        {% endif %}
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
          "href": "https://api.payex.com/psp/paymentorders/222a50ca-b268-4b32-16fa-08d6d3b73224",
          "rel":"update-order",
          "method":"PATCH",
          "contentType":"application/json"
        },
        {
          "href": "https://api.payex.com/psp/paymentorders/222a50ca-b268-4b32-16fa-08d6d3b73224",
          "rel": "abort",
          "method": "PATCH",
          "contentType": "application/json"
        }
       ]
      }
```

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                                                                                                                                                                                                 |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}                                                                                                                                                             |
| {% f created %}        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| {% f updated %}        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| {% f operation %}      | `string`     | `Purchase`                                                                                                                                              |{% if documentation_section contains "checkout-v3" %}
| {% f status %}          | `string`     | Indicates the payment order's current status. `Initialized` is returned when the payment is created and still ongoing. The request example above has this status. `Paid` is returned when the payer has completed the payment successfully. [See the `Paid` response]({{ features_url }}/technical-reference/status-models#paid). `Failed` is returned when a payment has failed. You will find an error message in [the `Failed` response]({{ features_url }}/technical-reference/status-models#failed). `Cancelled` is returned when an authorized amount has been fully cancelled. [See the `Cancelled` response]({{ features_url }}/technical-reference/status-models#cancelled). It will contain fields from both the cancelled description and paid section. `Aborted` is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). [See the `Aborted` response]({{ features_url }}/technical-reference/status-models#aborted). |{% else %}
| {% f state %}          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment order. Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes. | {% endif %}
| {% f paymentToken %}   | `string`     | The payment token generated in the initial purchase.                                                                                                |
| {% f currency %}       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| {% f amount %}         | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                 |
| {% f vatAmount %}      | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                              |
| {% f description %}    | `string(40)` | {% include fields/description.md %}                                                                                                                        |
| {% f initiatingSystemUserAgent %}      | `string`     | The `userAgent` of the system used when the merchant makes a call towards the resource.                                                                                                                                                          |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f availableInstruments %}       | `string`     | A list of instruments available for this payment.                                                                                                                                                   |
| {% f implementation %}       | `string`     | The merchant's Checkout v3 implementation type. `Enterprise` or `PaymentsOnly`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                   |
| {% f integration %}       | `string`     | The merchant's Checkout v3 integration type. `HostedView` (Seamless View) or `Redirect`. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.                           |
| {% f instrumentMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment instrument available.                                                                                    |
| {% f guestMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a `payerReference` in the original `paymentOrder` request.                                                                                                                                                | {% if documentation_section contains "checkout-v3" %}
| {% f payer %}         | `string`     | The URL to the [`payer` resource]({{ features_url }}/technical-reference/resource-sub-models#payer) where information about the payer can be retrieved.                                                                                                                 | {% else %}
| {% f payer %}         | `string`     | The URL to the `payer` resource where information about the payer can be retrieved. | {% endif %}
| {% f orderItems %}     | `string`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            |
| {% f history %}     | `string`     | The URL to the `history` resource where information about the payment's history can be retrieved.                                                                                                                            |
| {% f failed %}     | `string`     | The URL to the `failed` resource where information about the failed transactions can be retrieved.                                                                                                                            |
| {% f aborted %}     | `string`     | The URL to the `aborted` resource where information about the aborted transactions can be retrieved.                                                                                                                            |
| {% f paid %}     | `string`     | The URL to the `paid` resource where information about the paid transactions can be retrieved.                                                                                                                            |
| {% f cancelled %}     | `string`     | The URL to the `cancelled` resource where information about the cancelled transactions can be retrieved.                                                                                                                            |
| {% f financialTransactions %}     | `string`     | The URL to the `financialTransactions` resource where information about the financial transactions can be retrieved.                                                                                                                            |
| {% f failedAttempts %}     | `string`     | The URL to the `failedAttempts` resource where information about the failed attempts can be retrieved.                                                                                                                            |
| {% f metadata %}     | `string`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            |
| {% f operations %}     | `array`      | {% include fields/operations.md %} [See Operations for details]({{ features_url }}/technical-reference/operations).                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

## Tokens

It is possible to query for all active payment tokens registered on a specific
`payerReference`. After doing so, you can either remove all tokens or a subset
of the tokens registered on the payer. This is the easiest way of cleaning up
all data for **Payments Only** implementations. It is also possible to [delete a
single token][delete-tokens] if you wish to do that.

## GET Tokens Request

Querying with a `GET` request will give you a response containing all tokens and
the operation(s) available for them.

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/payerownedtokens/<payerReference> HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

## GET Tokens Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payerOwnedTokens": {
        "id": "/psp/paymentorders/payerownedtokens/{payerReference}",
        "payerReference": "{payerReference}",
        "tokens": [
            {
                "token": "{paymentToken}",
                "tokenType": "Payment",
                "instrument": "CreditCard",
                "instrumentDisplayName": "492500******0004",
                "instrumentParameters": {
                    "expiryDate": "12/2022",
                    "cardBrand": "Visa"
                },
                "operations": [
                    {
                        "method": "PATCH",
                        "href": "https://api.internaltest.payex.com/psp/paymentorders/paymenttokens/0ecf804f-e68f-404e-8ae6-adeb43052559",
                        "rel": "delete-paymenttokens",
                        "contentType": "application/json"
                    }
                ]
            },
            {
                "token": "{paymentToken}",
                "tokenType": "Payment",
                "instrument": "Invoice-payexfinancingno",
                "instrumentDisplayName": "260267*****",
                "instrumentParameters": {
                    "email": "hei@hei.no",
                    "msisdn": "+4798765432",
                    "zipCode": "1642"
                },
                "operations": [
                    {
                        "method": "PATCH",
                        "href": "https://api.internaltest.payex.com/psp/paymentorders/paymenttokens/dd9c1103-3e0f-492a-95a3-a39bb32a6b59",
                        "rel": "delete-paymenttokens",
                        "contentType": "application/json"
                    }
                ]
            },
            {
                "token": "{token}",
                "tokenType": "Unscheduled",
                "instrument": "CreditCard",
                "instrumentDisplayName": "492500******0004",
                "instrumentParameters": {
                    "expiryDate": "12/2020",
                    "cardBrand": "Visa"
                },
                "operations": [
                    {
                        "method": "PATCH",
                        "href": "https://api.internaltest.payex.com/psp/paymentorders/unscheduledtokens/e2f06785-805d-4605-bf40-426a725d313d",
                        "rel": "delete-unscheduledtokens",
                        "contentType": "application/json"
                    }
                ]
            }
        ]
    },
    "operations": [
        {
            "method": "PATCH",
            "href": "https://api.internaltest.payex.com/psp/paymentorders/payerOwnedPaymentTokens/{payerReference}",
            "rel": "delete-payerownedtokens",
            "contentType": "application/json"
        }
    ]
}
```

{% capture table %}
{:.table .table-striped .mb-5}
| Field                          | Type      | Description    |
| :----------------------------- | :-------- | :------------------- |
| {% f payerOwnedTokens %}       | `object`  | The `payerOwnedTokens` object containing information about the payer relevant for the payment order.       |
| {% f id %}                     | `string`  | {% include fields/id.md resource="paymentorder" %}                                                   |
| {% f payerReference, 2 %}      | `string`  | A reference used in the Enterprise and Payments Only implementations to recognize the payer when no SSN is stored.                                  |
| {% f tokens %}                 | `integer` | A list of tokens connected to the payment.                                           |
| {% f token, 2 %}               | `string`  | The token `guid`. |
| {% f tokenType, 2 %}           | `string`  | {% f payment, 0 %}, `recurrence`, `transactionOnFile` or `unscheduled`. The different types of available tokens. |
| {% f instrument %}             | `string`  | Payment instrument connected to the token. |
| {% f instrumentDisplayName %}  | `string`  | Payment instrument connected to the token.|
| {% f instrumentParameters %}   | `integer` | A list of additional information connected to the token. Depending on the instrument, it can e.g. be `expiryDate`, `cardBrand`, `email`, `msisdn` or `zipCode`.|
| {% f operations %}             | `array`   | {% include fields/operations.md resource="token" %}                                                                                              |
{% endcapture %}
{% include accordion-table.html content=table %}

## PATCH Request For Removing Tokens

You can remove the tokens by using the following `PATCH` request.

{:.code-view-header}
**Request**

```http
PATCH /psp/paymentorders/payerownedtokens/<payerReference> HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "state": "Deleted",
  "comment": "Some words about why the tokens are being deleted"
}
```

{:.table .table-striped}
| Field                    | Type         | Description    |
| :----------------------- | :----------- | :------------------- |
| {% f state %}          | `string`  | The state you want the token to be in.                                                                                     |
| {% f comment %}          | `string`  | Explanation as to why the token is being deleted.                                                                                     |

Which will provide this response.

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "payerOwnedTokens": {
        "id": "/psp/paymentorders/payerownedtokens/{payerReference}",
        "payerReference": "{payerReference}",
        "tokens": [
            {
                "token": "{paymentToken}",
                "tokenType": "Payment",
                "instrument": "Invoice-payexfinancingno",
                "instrumentDisplayName": "260267*****",
                "instrumentParameters": {
                    "email": "hei@hei.no",
                    "msisdn": "+4798765432",
                    "zipCode": "1642"
                }
            },
            {
                "token": "{paymentToken}",
                "tokenType": "Unscheduled",
                "instrument": "CreditCard",
                "instrumentDisplayName": "492500******0004",
                "instrumentParameters": {
                    "expiryDate": "12/2020",
                    "cardBrand": "Visa"
                }
            }
        ]
    }
}
```

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description    |
| :----------------------- | :----------- | :------------------- |
| {% f payerOwnedTokens %}                    | `object`     | The `payerOwnedTokens` object containing information about the payer relevant for the payment order.       |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}                                                   |
| {% f payerReference, 2 %}                     | `string`     | A reference used in the Enterprise and Payments Only implementations to recognize the payer when no SSN is stored.                                  |
| {% f tokens %}                   | `integer`    | A list of tokens connected to the payment.                                           |
| {% f token, 2 %}  | `string`   | The token `guid`. |
| {% f tokenType, 2 %}  | `string`   | {% f payment, 0 %}, `recurrence`, `transactionOnFile` or `unscheduled`. The different types of available tokens. |
| {% f instrument %}             | `string`     | Payment instrument connected to the token. |
| {% f instrumentDisplayName %}             | `string`     | Payment instrument connected to the token.|
| {% f instrumentParameters %}             | `integer`     | A list of additional information connected to the token. Depending on the instrument, it can e.g. be `expiryDate`, `cardBrand`, `email`, `msisdn` or `zipCode`.|
{% endcapture %}
{% include accordion-table.html content=table %}

[split-settlement]: {{ features_url }}/core/settlement-reconciliation#split-settlement
[settlement-reconciliation]: {{ features_url }}/core/settlement-reconciliation
[delete-tokens]: {{ features_url }}/optional/delete-token
[tokens]: {{ features_url }}/optional/payer-aware-payment-menu#tokens
[verify]: {{ features_url }}/optional/verify
[instrument-mode]: {{ features_url }}/optional/instrument-mode
