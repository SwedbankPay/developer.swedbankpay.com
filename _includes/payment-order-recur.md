{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{%- capture documentation_section -%}{%- include utils/documentation-section.md -%}{%- endcapture -%}
{% assign operation_status_bool = include.operation_status_bool | default: "false" %}
{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% assign implementation = documentation_section | split: "/" | last | capitalize | remove: "-" %}

## Recur

A `recur` payment is a payment which uses a `recurrenceToken` generated through
a previous payment in order to charge the same card or account at a later time.

As the name implies, these payments are used for transactions which happen on a
recurring basis. Common use cases could be subscriptions for magazines,
newspapers or streaming services.

Please note that you need to do a capture after sending the recur request.
We have added a capture section at the end of this page for that reason.

## Generating The Token

First, you need an initial transaction where the `recurrenceToken` is generated
and connected. You do that by adding the field `generateRecurrenceToken` in the
`PaymentOrder` request and set the value to `true`. The payer must complete the
purchase to activate the token.

(Read more about [deleting the recurrence token][delete-token] here.)

## Initial Recur Request

The initial request should look like this:

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0...",
        "language": "sv-SE",
        "generateRecurrenceToken": true, {% if documentation_section contains "checkout-v3" %}
        "productName": "Checkout3", // Removed in 3.1, can be excluded in 3.0 if version is added in header
        {% endif %}
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
            "subsite": "MySubsite", {% if documentation_section contains "checkout-v3" %}
            "siteId": "MySiteId", {% endif %}
        },
        "payer": {
            "digitalProducts": false,
            "firstName": "Leia",
            "lastName": "Ahlström",
            "email": "leia@swedbankpay.com",
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
            }
        ],
        "riskIndicator": {
            "deliveryEmailAddress": "olivia.nyhuus@swedbankpay.com",
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
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                              | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :--------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f paymentOrder, 0 %}                     | `object`     | The payment order object.                                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f operation %}                | `string`     | {% include fields/operation.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | {% f currency %}                 | `string`     | The currency of the payment.                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f amount %}                   | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                                                                                                |
| {% icon check %} | {% f vatAmount %}                | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f description %}              | `string`     | The description of the payment order.                                                                                                                                                                                                                                                                    |                                                 |
| {% icon check %} | {% f userAgent %}                | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f language %}                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
|                  | {% f generateRecurrenceToken %}| `boolean`     | `true` or `false`. Set to `true` if you want to generate an `recurrenceToken` for future recurring purchases.       |
| {% icon check %} | {% f productName %}              | `string`     | Used to tag the payment as Digital Payments v3.0. Mandatory for Digital Payments v3.0, either in this field or the header, as you won't get the operations in the response without submitting this field.                                                                                                                                                                                                                                                                              |
|                  | {% f implementation %}           | `string`     | Indicates which implementation to use.                                                                                                                                                                                                                                                                         |
| {% icon check %} | {% f urls %}                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | {% f hostUrls, 2 %}                | `array`      | The array of URLs valid for embedding of Swedbank Pay Seamless Views.                                                                                                                                                                                                                                    |{% if include.integration_mode=="seamless-view" %}
|                  | {% f paymentUrl, 2 %}              | `string`     | {% include fields/payment-url.md %} | {% endif %}
| {% icon check %} | {% f completeUrl, 2 %}             | `string`     | {% include fields/complete-url.md %} |
|                  | {% f cancelUrl, 2 %}               | `string`     | The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
| {% icon check %} | {% f callbackUrl, 2 %}             | `string`     | {% include fields/callback-url.md %} For recurring transactions, the callback will only be sent for Trustly transactions, not card.                                                                                                                                                                                             |
| {% icon check %} | {% f termsOfServiceUrl, 2 %}       | `string`     | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                                     |{% if include.integration_mode=="redirect" %},
| {% icon check %} | {% f logoUrl, 2 %}                 | `string`     | {% include fields/logo-url.md %}                                                                                                                                                                                                                                                               |{% endif %}
| {% icon check %} | {% f payeeInfo %}                | `object`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f payeeId, 2 %}                 | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f payeeReference, 2 %}          | `string(30)` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                                                                                 |
|                  | {% f payeeName, 2 %}               | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                 |
|                  | {% f productCategory, 2 %}         | `string(50)`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                           |
|                  | {% f orderReference, 2 %}          | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                  |
|                  | {% f subsite, 2 %}                | `string(40)` | {% include fields/subsite.md %} | {% if documentation_section contains "checkout-v3" %}
|                  | {% f siteId, 2 %}                 | `string(15)` | {% include fields/site-id.md %}                                                                                                                    | {% endif %}
|                  | {% f payer %}                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                |
| | {% f digitalProducts %}                       | `bool` | Set to `true` for merchants who only sell digital goods and only require `email` and/or `msisdn` as shipping details. Set to `false` if the merchant also sells physical goods. |
| | {% f firstName, 2 %}                    | `string`     | The first name of the payer.                                                                                                                                                                                                                                                                              |
|  | {% f lastName, 2 %}                    | `string`     | The last name of the payer.                                                                                                                                                                                                                                                                              |
|                  | {% f email, 2 %}                   | `string`     | The e-mail address of the payer. Will be used to prefill the Checkin as well as on the payer's profile, if not already set. Increases the chance for {% if documentation_section contains "checkout-v3" %} [frictionless 3-D Secure 2 flow]({{ features_url }}/customize-payments/frictionless-payments) {% else %} [frictionless 3-D Secure 2 flow]({{ features_url }}/core/frictionless-payments) {% endif %}.                                                                              |
|                  | {% f msisdn, 2 %}                  | `string`     | The mobile phone number of the Payer. Will be prefilled on Checkin page and used on the payer's profile, if not already set. The mobile number must have a country code prefix and be 8 to 15 digits in length. {% if documentation_section contains "checkout-v3" %} [3-D Secure 2]({{ features_url }}/customize-payments/frictionless-payments) {% else %} [3-D Secure 2]({{ features_url }}/core/frictionless-payments) {% endif %}           |
| | {% f shippingAddress %}            | `object` | The shipping address object related to the `payer`. The field is related to {% if documentation_section contains "checkout-v3" %} [3-D Secure 2]({{ features_url }}/customize-payments/frictionless-payments) {% else %} [3-D Secure 2]({{ features_url }}/core/frictionless-payments) {% endif %}                                                                                                                                 |
| | {% f firstName, 2 %}                   | `string` | The first name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                                                                          |
| | {% f lastName, 2 %}                   | `string` | The last name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                                                                          |
| | {% f streetAddress, 2 %}              | `string` | Payer's street address. Maximum 50 characters long.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| | {% f coAddress, 2 %}                  | `string` | Payer' s c/o address, if applicable.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| | {% f zipCode, 2 %}                    | `string` | Payer's zip code                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| | {% f city, 2 %}                       | `string` | Payer's city of residence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| | {% f countryCode, 2 %}                | `string` | Country code for country of residence.                                                                                                         |
| {% icon check %}  | `billingAddress`               | `object`  | The billing address object containing information about the payer's billing address.                                                                            |
|  | {% f firstName %}            | `string`  | The first name of the payer.                                                                                                                  |
|   | {% f lastName %}            | `string`  | The last name of the payer.                                                                                                                  |
|  | {% f streetAddress %}        | `string`  | The street address of the payer. Maximum 50 characters long.                                                                                                   |
|                   | {% f coAddress %}            | `string`  | The CO-address (if used)                                                                                                                                         |
|  | {% f zipCode %}              | `string`  | The postal number (ZIP code) of the payer.                                                                                                                    |
|   | {% f city %}                 | `string`  | The city of the payer.                                                                                                                                        |
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
{% include risk-indicator-table.md %}
{% endcapture %}
{% include accordion-table.html content=table %}

## Initial Recur Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",
        "created": "2020-06-22T10:56:56.2927632Z",
        "updated": "2020-06-22T10:56:56.4035291Z",
        "operation": "Purchase", {% if documentation_section contains "checkout-v3" %}
        "status": "Initialized", {% else %}
        "state": "Ready", {% endif %}
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "initiatingSystemUserAgent": "swedbankpay-sdk-dotnet/3.0.1",
        "language": "sv-SE",
        "availableInstruments": [
          "CreditCard", ],{% if documentation_section contains "old-implementations/enterprise" %}
        "implementation": "Enterprise", {% endif %} {% if documentation_section contains "checkout-v3/payments-only" %}
        "implementation": "PaymentsOnly", {% endif %} {% if include.integration_mode=="seamless-view" %}
        "integration": "HostedView", {% endif %} {% if include.integration_mode=="redirect" %}
        "integration": "Redirect", {% endif %}
        "instrumentMode": false,
        "guestMode": false,
        "payer": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/payers"
        },
        "orderItems": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderitems"
        }{% if documentation_section contains "checkout-v3" %},
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
        } {% endif %}
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
        }{% if documentation_section contains "checkout-v3" %},
        {
          "href": "https://api.payex.com/psp/paymentorders/{{ page.payment_order_id }}",
          "rel": "abort-paymentattempt",
          "method": "PATCH",
          "contentType": "application/json"
        }{% endif %}
       ]
      }{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                                                                                                                                                                                                 |
| {% f id %}             | `string`     | {% include fields/id.md resource="paymentorder" %}                                                                                                                                                             |
| {% f created %}        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| {% f updated %}        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| {% f operation %}      | `string`     | `Purchase`                                                                                                                                             | {% if documentation_section contains "checkout-v3" %}
| {% f status %}          | `string`     | Indicates the payment order's current status. `Initialized` is returned when the payment is created and still ongoing. The request example above has this status. `Paid` is returned when the payer has completed the payment successfully. See the [`Paid` response]({{ features_url }}/technical-reference/status-models#paid). `Failed` is returned when a payment has failed. You will find an error message in [the `Failed` response]({{ features_url }}/technical-reference/status-models#failed). `Cancelled` is returned when an authorized amount has been fully cancelled. See the [`Cancelled` response]({{ features_url }}/technical-reference/status-models#cancelled). It will contain fields from both the cancelled description and paid section. `Aborted` is returned when the merchant has aborted the payment, or if the payer cancelled the payment in the redirect integration (on the redirect page). See the [`Aborted` response]({{ features_url }}/technical-reference/status-models#aborted). | {% else %}
| {% f state %}          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment order. Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes. | {% endif %}
| {% f currency %}       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| {% f amount %}         | `integer`    | {% include fields/amount.md %}                                                                                                                                                                                 |
| {% f vatAmount %}      | `integer`    | {% include fields/vat-amount.md %}                                                                                                                                                                              |
| {% f description %}    | `string(40)` | {% include fields/description.md %}                                                                                                                        |
| {% f initiatingSystemUserAgent %}      | `string`     | {% include fields/initiating-system-user-agent.md %}                                                                                                                                                          |
| {% f language %}       | `string`     | {% include fields/language.md %}                                                                                                                                                  |
| {% f recurrenceToken %}     | `string`     | The generated recurrence token if `operation: recur` or `generaterecurrenceToken: true` was used.                                                                                                                                                                  |
| {% f availableInstruments %}       | `string`     | A list of payment methods available for this payment.                                                                                                                                                   |
| {% f implementation %}       | `string`     | The merchant's Digital Payments implementation type. `Enterprise` or `PaymentsOnly`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                   |
| {% f integration %}       | `string`     | The merchant's Digital Payments integration type. `HostedView` (Seamless View) or `Redirect`. This field will not be populated until the payer has opened the payment UI, and the client script has identified if Swedbank Pay or another URI is hosting the container with the payment iframe. We ask that you don't build logic around this field's response. It is mainly for information purposes. as the integration types might be subject to name changes, If this should happen, updated information will be available in this table.                           |
| {% f instrumentMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment method available.                                                                                    |
| {% f guestMode %}       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Payments Only implementation, this is triggered by not including a `payerReference` in the original `paymentOrder` request.                                                                                                                                                |{% if documentation_section contains "checkout-v3" %}
| {% f payer %}         | `id`     | The URL to the [`payer` resource]({{ features_url }}/technical-reference/resource-sub-models#payer) where information about the payer can be retrieved.                                                                                                                 | {% else %}
| {% f payer %}         | `id`     | The URL to the `payer` resource where information about the payer can be retrieved. | {% endif %}
| {% f orderItems %}     | `id`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            | {% if documentation_section contains "checkout-v3" %}
| {% f history %}     | `id`     | The URL to the [`history` resource]({{ features_url }}/technical-reference/resource-sub-models#history) where information about the payment's history can be retrieved.                                                                                                                            |
| {% f failed %}     | `id`     | The URL to the [`failed` resource]({{ features_url }}/technical-reference/resource-sub-models#failed) where information about the failed transactions can be retrieved.                                                                                                                            |
| {% f aborted %}     | `id`     | The URL to the [`aborted` resource]({{ features_url }}/technical-reference/resource-sub-models#aborted) where information about the aborted transactions can be retrieved.                                                                                                                            |
| {% f paid %}     | `id`     | The URL to the [`paid` resource]({{ features_url }}/technical-reference/resource-sub-models#paid) where information about the paid transactions can be retrieved.                                                                                                                            |
| {% f cancelled %}     | `id`     | The URL to the [`cancelled` resource]({{ features_url }}/technical-reference/resource-sub-models#cancelled) where information about the cancelled transactions can be retrieved.                                                                                                                            |
| {% f financialTransactions %}     | `id`     | The URL to the [`financialTransactions` resource]({{ features_url }}/technical-reference/resource-sub-models#financialtransactions) where information about the financial transactions can be retrieved.                                                                                                                            |
| {% f failedAttempts %}     | `id`     | The URL to the [`failedAttempts` resource]({{ features_url }}/technical-reference/resource-sub-models#failedattempts) where information about the failed attempts can be retrieved.                                                                                                                            |
| {% f metadata %}     | `id`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            | {% endif %}
| {% f operations %}     | `array`      | {% include fields/operations.md %}                                                                                               |
{% endcapture %}
{% include accordion-table.html content=table %}

## GET The Token

{% if documentation_section contains "checkout-v3" %}

The token can be retrieved by performing a [`GET` towards
`paid`][paid-resource-model]. It will be visible under `tokens` in the `paid`
field.

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

As an alternative, you can also retrieve it by using the expand option when you
`GET` your payment. The `GET` request should look like the one below, with a
`?$expand=paid` after the `paymentOrderId`. The response should match the
initial payment response, but with an expanded `paid` field.

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% else %}

You can retrieve it by using the expand option when you `GET` your payment. The
`GET` request should look like the one below, with a `?$expand=paid` after the
`paymentOrderId`. The response should match the initial payment response, but
with an expanded `paid` field.

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_order_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% endif %}

## Performing The Recurring Purchase

When you are ready to perform the recurring purchase, simply add the
`recurrenceToken` field to the `paymentOrder` request and use the token as the
value. Your request should look like the example below, and the response will
match the `paymentOrder` response from the initial purchase.

{% if documentation_section contains "checkout-v3" %}

## After The Recurring Purchase

Please remember that the `recur` request will reserve the amount, but not charge
it. You will (i.e. when you are ready to ship purchased physical products) have
to perform a [Capture][payment-order-capture] request later on to complete the
recurring purchase. You can also [Cancel][payment-order-cancel] it if needed.

{% else %}

## After The Recurring Purchase

Please remember that the `recur` request will reserve the amount, but not charge
it. You will (i.e. when you are ready to ship purchased physical products) have
to perform a [Capture][old-payment-order-capture] request later on to complete
the recurring purchase. You can also [Cancel][old-payment-order-cancel] it if
needed.

{% endif %}

## Recur Request

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "Recur",
        "recurrenceToken": "{{ page.payment_id }}",
        "currency": "NOK",
        "amount": 1500,
        "vatAmount": 0,
        "description": "Test Recurrence",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",  {% if documentation_section contains "checkout-v3" %}
        "productName": "Checkout3", // Removed in 3.1, can be excluded in 3.0 if version is added in header {% endif %}
        "urls": {
            "callbackUrl": "https://example.com/payment-callback"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}"
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite",  {% if documentation_section contains "checkout-v3" %}
            "siteId": "MySiteId", {% endif %}
        },
        "payer": {
            "payerReference": "AB1234",
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
|     Required     | Field                          | Type         | Description      |
| :--------------: | :----------------------------- | :----------- | :---------------------------------- |
| {% icon check %} | {% f payment, 0 %}                      | `object`     | The payment object.                                        |
| {% icon check %} | `operation`                    | `object`     | `Recur`.                                                |
| {% icon check %} | {% f recurrenceToken %}      | `string`     | The created recurrenceToken if `operation: Recur` or `generateRecurrenceToken: true` was used.                                                    |
| {% icon check %} | {% f currency %}             | `string`     | The currency of the payment order.                             |
| {% icon check %} | {% f amount %}               | `integer`    | {% include fields/amount.md %}                        |
| {% icon check %} | {% f vatAmount %}            | `integer`    | {% include fields/vat-amount.md %}                   |
| {% icon check %} | {% f description %}          | `string`     | {% include fields/description.md %}         |
| {% icon check %} | {% f userAgent, 2 %}           | `string`     | {% include fields/user-agent.md %}     |
| {% icon check %} | {% f language, 2 %}            | `string`     | {% include fields/language.md %}       | {% if documentation_section contains "checkout-v3" %}
| {% icon check %} | {% f productName %}                 | `string`     | Used to tag the payment as Digital Payments v3.0. Mandatory for Digital Payments v3.0, either in this field or the header, as you won't get the operations in the response without submitting this field.                                |
|                  | {% f implementation %}       | `string`     | Indicates which implementation to use.                                                                                                                                                                                                                                                                         | {% endif %}
| {% icon check %} | {% f urls, 2 %}                | `string`     | The URL to the `urls` resource where all URLs related to the payment order can be retrieved.                                               |
| | {% f callbackUrl, 2 %}         | `string`     | {% include fields/callback-url.md %} For recurring transactions, the callback will only be sent for Trustly transactions, not card.                    |
| {% icon check %} | {% f payeeInfo %}            | `object`     | {% include fields/payee-info.md %}                                               |
| {% icon check %} | {% f payeeId, 2 %}             | `string`     | This is the unique id that identifies this payee (like merchant) set by Swedbank Pay.          |
| {% icon check %} | {% f payeeReference %}       | `string(30)` | {% include fields/payee-reference.md describe_receipt=true %}                   |
|                  | {% f receiptReference %}     | `string(30)` | {% include fields/receipt-reference.md %}                                              |
| {% icon check %} | {% f payeeName, 2 %}           | `string`     | The payee name (like merchant name) that will be displayed when redirected to Swedbank Pay.                                                       |
| {% icon check %} | {% f productCategory, 2 %}     | `string(50)`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                        |
| {% icon check %} | {% f orderReference, 2 %}      | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                         |
| {% icon check %} | {% f subsite, 2 %}             | `string(40)` | {% include fields/subsite.md %} | {% if documentation_section contains "checkout-v3" %}
|                  | {% f siteId, 2 %}                 | `string(15)` | {% include fields/site-id.md %}                                                            | {% endif %}
|                  | {% f payer %}                | `string`     | The `payer` object, containing information about the payer.                     |
|                  | {% f payerReference, 2 %}      | `string`     | {% include fields/payer-reference.md %}                                   |
|                  | {% f metadata %}             | `object`     | {% include fields/metadata.md %}                                       |
| {% icon check %} | {% f orderItems %}               | `array`      | {% include fields/order-items.md %}                                  |
| {% icon check %} | {% f reference, 2 %}               | `string`     | A reference that identifies the order item.                                    |
| {% icon check %} | {% f name, 2 %}                    | `string`     | The name of the order item.                                             |
| {% icon check %} | {% f type, 2 %}                    | `string`     | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `PAYMENT_FEE` `DISCOUNT`, `VALUE_CODE` or `OTHER`. The type of the order item. `PAYMENT_FEE` is the amount you are charged with when you are paying with invoice. The amount can be defined in the `amount` field below.                                           |
| {% icon check %} | {% f class, 2 %}                   | `string`     | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics.                                |
|                  | {% f itemUrl, 2 %}                 | `string`     | The URL to a page that can display the purchased item, product or similar.           |
|                  | {% f imageUrl, 2 %}                | `string`     | The URL to an image of the order item.                                       |
|                  | {% f description, 2 %}             | `string`     | {% include fields/description.md %}                                     |
|                  | {% f discountDescription, 2 %}     | `string`     | The human readable description of the possible discount.                           |
| {% icon check %} | {% f quantity, 2 %}                | `integer`    | The 4 decimal precision quantity of order items being purchased.                     |
| {% icon check %} | {% f quantityUnit, 2 %}            | `string`     | The unit of the quantity, such as `pcs`, `grams`, or similar. This is used for your own book keeping.                                                                            |
| {% icon check %} | {% f unitPrice, 2 %}               | `integer`    | The price per unit of order item, including VAT.                     |
|                  | {% f discountPrice, 2 %}           | `integer`    | If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                       |
| {% icon check %} | {% f vatPercent, 2 %}              | `integer`    | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.               |
| {% icon check %} | {% f amount, 2 %}                  | `integer`    | {% include fields/amount.md %}                                    |
| {% icon check %} | {% f vatAmount, 2 %}               | `integer`    | {% include fields/vat-amount.md %}                                 |
|                  | {% f restrictedToInstruments %}  | `array`      | A list of the payment methods you wish to restrict the payment to. Currently `Invoice` only. `Invoice` supports the subtypes `PayExFinancingNo`, `PayExFinancingSe` and `PayMonthlyInvoiceSe`, separated by a dash, e.g.; `Invoice-PayExFinancingNo`. Default value is all supported payment methods. Use of this field requires an agreement with Swedbank Pay. You can restrict fees and/or discounts to certain payment methods by adding this field to the orderline you want to restrict. Use positive amounts to add fees and negative amounts to add discounts.                                                  |
{% endcapture %}
{% include accordion-table.html content=table %}

{% include payment-order-capture.md %}

<!--lint disable final-definition -->

[delete-token]: {{ features_url }}/optional/delete-token
[paid-resource-model]: {{ features_url }}/technical-reference/resource-sub-models#paid
[old-payment-order-cancel]: /old-implementations/checkout-v2/after-payment#cancel
[old-payment-order-capture]: /old-implementations/checkout-v2/capture
[payment-order-cancel]: /checkout-v3/get-started/post-purchase/#cancel-v31
[payment-order-capture]: /checkout-v3/get-started/post-purchase/#capture-v31
