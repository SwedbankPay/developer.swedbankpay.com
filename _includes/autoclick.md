{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include documentation-section.md %}{%
endcapture %}
{% capture features_url %}{% include documentation-section-url.md href='/features' %}{% endcapture %}

## AutoClick

AutoClick is a feature which automatically forwards the payer from the payment
window when an instrument is selected, just as if they pressed the Pay button.
It is only available when using **Checkout v3** and the wallet **Click to Pay**.
Support for more payment instruments will be added going forward. Apart from
adding the field in your payment order request, no changes are required at your
(the merchant's) end for AutoClick to work.

There are a couple of limitations in place for this feature. First of all, it is
restricted to payment instruments which require **no input** from the payer
before pressing the Pay button. It will also be limited to instruments with
**no terms and conditions**. This will exclude instruments like Invoice, as
there are terms and conditions attached. As a consequence, activating AutoClick
in a request which also contains a `termsOfServiceUrl` will result in an error
message.

## Request

The field itself is a `bool` which must be added in the `paymentorder` node of
the request, like the example below.

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
        "autoClick": true,
        "productName": "Checkout3",
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ], {% if include.integration_mode=="seamless-view" %}
            "paymentUrl": "https://example.com/perform-payment", {% endif %}
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "callbackUrl": "https://api.example.com/payment-callback"{% if include.integration_mode=="redirect" %},
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
        }, {% if documentation_section contains "checkout-v3/business" %}
        "payer": {
            "digitalProducts": false,
            "firstName": "Leia",
            "lastName": "Ahlström",
            "email": "leia@payex.com",
            "msisdn": "+46787654321",
            "shippingAddress": {
                "firstName": "firstname/companyname",
                "lastName": "lastname",
                "email": "karl.anderssson@mail.se",
                "msisdn": "+46759123456",
                "streetAddress": "Helgestavägen 9",
                "coAddress": "",
                "city": "Solna",
                "zipCode": "17674",
                "countryCode": "SE"
            },
            "billingAddress": {
                "firstName": "firstname/companyname",
                "lastName": "lastname",
                "email": "karl.anderssson@mail.se",
                "msisdn": "+46759123456",
                "streetAddress": "Helgestavägen 9",
                "coAddress": "",
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
                "suspiciousAccountActivity": "01"
            }
        }, {% endif %} {% if documentation_section contains "checkout-v3/enterprise" %}
        "payer": {
            "digitalProducts": false,
            "nationalIdentifier": {
                "socialSecurityNumber": "{{ page.consumer_ssn_se }}",
                "countryCode": "SE"
            }
            "firstName": "Leia",
            "lastName": "Ahlström",
            "email": "leia@payex.com",
            "msisdn": "+46787654321",
            "payerReference": "AB1234",
            "shippingAddress": {
                "firstName": "firstname/companyname",
                "lastName": "lastname",
                "email": "karl.anderssson@mail.se",
                "msisdn": "+46759123456",
                "streetAddress": "Helgestavägen 9",
                "coAddress": "",
                "city": "Solna",
                "zipCode": "17674",
                "countryCode": "SE"
            },
            "billingAddress": {
                "firstName": "firstname/companyname",
                "lastName": "lastname",
                "email": "karl.anderssson@mail.se",
                "msisdn": "+46759123456",
                "streetAddress": "Helgestavägen 9",
                "coAddress": "",
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
                "suspiciousAccountActivity": "01"
            }
        }, {% endif %} {% if documentation_section contains "checkout-v3/starter" %}
        "payer": {
            "requireConsumerInfo": true,
            "digitalProducts": false,
            "shippingAddressRestrictedToCountryCodes": [ "NO", "US" ]
        }, {% endif %} {% if documentation_section contains "checkout-v3/payments-only" %}
        "payer": {
            "digitalProducts": false,
            "firstName": "Leia",
            "lastName": "Ahlström",
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
                "suspiciousAccountActivity": "01"
            }
        }, {% endif %}
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
| Required         | Field     | Type         | Description   |
| :--------------: | :-------- | :----------- | :------------ |
| {% icon check %} | `paymentorder`                     | `object`     | The payment order object.                                              |
| {% icon check %} | └➔&nbsp;`operation`                | `string`     | The operation that the payment order is supposed to perform.                        |
| {% icon check %} | └➔&nbsp;`currency`                 | `string`     | The currency of the payment.                                             |
| {% icon check %} | └➔&nbsp;`amount`                   | `integer`    | {% include field-description-amount.md %}                       |
| {% icon check %} | └➔&nbsp;`vatAmount`                | `integer`    | {% include field-description-vatamount.md %}                    |
| {% icon check %} | └➔&nbsp;`description`              | `string`     | The description of the payment order.                                               |
| {% icon check %} | └➔&nbsp;`userAgent`                | `string`     | {% include field-description-user-agent.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`language`                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
| | └➔&nbsp;`autoClick`                 | `bool`     | Set to `true` or `false`. Used to indicate if the payer should be automatically redirected from the payment window when selecting supported instruments. If set to `true`, the `termsOfServiceUrl` can't be included in the request.                                                                                                                                                                                                                                                                         |
| {% icon check %} | └➔&nbsp;`productName`                 | `string`     | Used to tag the payment as Checkout v3. Mandatory for Checkout v3, as you won't get the operations in the response without submitting this field.                                                                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`urls`                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | └─➔&nbsp;`hostUrls`                | `array`      | The array of URLs valid for embedding of Swedbank Pay Seamless Views.                                                                                                                                                                                                                                    |{% if include.integration_mode=="seamless-view" %}
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
|                  | └─➔&nbsp;`subsite`                 | `String(40)` | The subsite field can be used to perform [split settlement]({{ features_url }}/core/settlement-reconciliation#split-settlement) on the payment. The subsites must be resolved with Swedbank Pay [reconciliation]({{ features_url }}/core/settlement-reconciliation) before being used. Must be in the format of `A-Za-z0-9`.                                                                                          |
|                  | └─➔&nbsp;`siteId`                 | `String(15)` | `SiteId` is used for [split settlement][split-settlement] transactions when you, as a merchant, need to specify towards AMEX which sub-merchant the transaction belongs to. Must be in the format of `A-Za-z0-9`.                                                                                       |
|                  | └➔&nbsp;`payer`                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                | {% if documentation_section contains "checkout-v3/starter" %}
|  {% icon check %} | `requireConsumerInfo` | `string` | Must be set to `true` by merchants using Starter, as they receive profile information from Swedbank Pay. This applies both when the merchant needs `email` and/or `msisdn` for digital goods, and when full shipping address is needed.                             |
|                  | `shippingAddressRestrictedToCountryCodes` | `string` | List of supported shipping countries for merchant. Using [ISO-3166] standard. Mandatory if `digitalProducts` is set to `false`, and not to be included if it is `true`.                                    | {% endif %}
| | └➔&nbsp;`digitalProducts`                       | `bool` | Set to `true` for merchants who only sell digital goods and only require `email` and/or `msisdn` as shipping details. Set to `false` if the merchant also sells physical goods. | {% unless documentation_section contains "checkout-v3/starter" %} {% if documentation_section contains "checkout-v3/enterprise" %}
|                  | └─➔&nbsp;`nationalIdentifier`    | `object` | The national identifier object.                                                                      |
|                  | └──➔&nbsp;`socialSecurityNumber` | `string` | The payer's social security number. |
|                  | └──➔&nbsp;`countryCode`          | `string` | The country code of the payer.                                                                     | {% endif %}
| | └─➔&nbsp;`firstName`                    | `string`     | The first name of the payer.                                                                                                                                                                                                                                                                              |
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
|  | └➔&nbsp;`lastName`            | `string`  | The last name of the payer.                                                                                                                  |
|  | └➔&nbsp;`streetAddress`        | `string`  | The street address of the payer. Maximum 50 characters long.                                                                                                   |
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
| | └─➔&nbsp;`suspiciousAccountActivity` | `string` | Indicates if there have been any suspicious activities linked to this account. <br>`01` (No suspicious activity has been observed) <br>`02` (Suspicious activity has been observed) | {% endunless %}
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

## Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "paymentOrder": {
        "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b",
        "created": "2022-01-07T07:58:26.1300282Z",
        "updated": "2022-01-07T08:17:44.6839034Z",
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
            "CreditCard",
            "Invoice-PayExFinancingSe",
            "Invoice-PayMonthlyInvoiceSe",
            "Swish",
            "CreditAccount",
            "Trustly"
        ],{% if documentation_section contains "checkout-v3/enterprise" %}
        "implementation": "Enterprise", {% endif %} {% if documentation_section contains "checkout-v3/payments-only" %}
        "implementation": "PaymentsOnly", {% endif %} {% if documentation_section contains "checkout-v3/business" %}
        "implementation": "Business", {% endif %} {% if documentation_section contains "checkout-v3/starter" %}
        "implementation": "Starter", {% endif %} {% if include.integration_mode=="seamless-view" %}
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
        }{% endif %} {% if include.integration_mode=="seamless-view" %}
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

{:.table .table-striped}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `paymentorder`           | `object`     | The payment order object.                                                                                                                                                                                                 |
| └➔&nbsp;`id`             | `string`     | {% include field-description-id.md resource="paymentorder" %}                                                                                                                                                             |
| └➔&nbsp;`created`        | `string`     | The ISO-8601 date of when the payment order was created.                                                                                                                                                                  |
| └➔&nbsp;`updated`        | `string`     | The ISO-8601 date of when the payment order was updated.                                                                                                                                                                  |
| └➔&nbsp;`operation`      | `string`     | `Purchase`                                                                                                                                                      |{% if documentation_section contains "checkout-v3" %}
| └➔&nbsp;`status`          | `string`     | Indicates the payment order's current status. `Initialized` is returned when the payment is created and still ongoing. The request example above has this status. `Paid` is returned when the payer has completed the payment successfully. [See the `Paid` section for further information]({{ features_url }}/technical-reference/status-models#paid). `Failed` is returned when a payment has failed. You will find an error message in the failed section. [Further information here]({{ features_url }}/technical-reference/status-models#failed). `Cancelled` is returned when an authorized amount has been fully cancelled. [See the cancel feature section for further information]({{ features_url }}/technical-reference/status-models#cancelled). It will contain fields from both the cancelled description and paid section. `Aborted` is returned when the merchant has aborted the payment or if the payer cancelled the payment in the redirect integration (on the redirect page). [See the Abort feature section for further information]({{ features_url }}/technical-reference/status-models#aborted). | {% else %}
| └➔&nbsp;`state`          | `string`     | `Ready`, `Pending`, `Failed` or `Aborted`. Indicates the state of the payment order. Does not reflect the state of any ongoing payments initiated from the payment order. This field is only for status display purposes. | {% endif %}
| └➔&nbsp;`currency`       | `string`     | The currency of the payment order.                                                                                                                                                                                        |
| └➔&nbsp;`amount`         | `integer`    | {% include field-description-amount.md %}                                                                                                                                                                                 |
| └➔&nbsp;`vatAmount`      | `integer`    | {% include field-description-vatamount.md %}                                                                                                                                                                              |
| └➔&nbsp;`description`    | `string(40)` | {% include field-description-description.md %}                                                                                                                        |
| └➔&nbsp;`initiatingSystemUserAgent`      | `string`     | {% include field-description-initiating-system-user-agent.md %}                                                                                                                                                          |
| └➔&nbsp;`language`       | `string`     | {% include field-description-language.md %}                                                                                                                                                  |
| └➔&nbsp;`availableInstruments`       | `string`     | A list of instruments available for this payment.                                                                                                                                                   |
| └➔&nbsp;`implementation`       | `string`     | The merchant's Checkout v3 implementation type. `Business`, `Enterprise`, `PaymentsOnly` or `Starter`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the implementation types might be subject to name changes. If this should happen, updated information will be available in this table.                                                                                                   |
| └➔&nbsp;`integration`       | `string`     | The merchant's Checkout v3 integration type. `HostedView` (Seamless View) or `Redirect`. We ask that you don't build logic around this field's response. It is mainly for information purposes, as the integration types might be subject to name changes. If this should happen, updated information will be available in this table.                           |
| └➔&nbsp;`instrumentMode`       | `bool`     | Set to `true` or `false`. Indicates if the payment is initialized with only one payment instrument available.                                                                                    |
| └➔&nbsp;`guestMode`       | `bool`     | Set to `true` or `false`. Indicates if the payer chose to pay as a guest or not. When using the Enterprise implementation, this is triggered by not including a `payerReference` or `nationalIdentifier` in the original payment order request.                                                                                                                                                   |
| └➔&nbsp;`payer`         | `string`     | The URL to the `payer` resource where information about the payer of the payment order can be retrieved.                                                                                                                |
| └➔&nbsp;`orderItems`     | `string`     | The URL to the `orderItems` resource where information about the order items can be retrieved.                                                                                                                            | {% if documentation_section contains "checkout-v3" %}
| └➔&nbsp;`history`     | `string`     | The URL to the `history` [resource]({{ features_url }}/technical-reference/resource-sub-models#history) where information about the payment's history can be retrieved.                                                                                                                            |
| └➔&nbsp;`failed`     | `string`     | The URL to the `failed` [resource]({{ features_url }}/technical-reference/resource-sub-models#failed) where information about the failed transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`aborted`     | `string`     | The URL to the `aborted` [resource]({{ features_url }}/technical-reference/resource-sub-models#aborted) where information about the aborted transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`paid`     | `string`     | The URL to the `paid` [resource]({{ features_url }}/technical-reference/resource-sub-models#paid) where information about the paid transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`cancelled`     | `string`     | The URL to the `cancelled` [resource]({{ features_url }}/technical-reference/resource-sub-models#cancelled) where information about the cancelled transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`financialTransactions`     | `string`     | The URL to the `financialTransactions` [resource]({{ features_url }}/technical-reference/resource-sub-models#financialtransactions) where information about the financial transactions can be retrieved.                                                                                                                            |
| └➔&nbsp;`failedAttempts`     | `string`     | The URL to the `failedAttempts` [resource]({{ features_url }}/technical-reference/resource-sub-models#failedattempts) where information about the failed attempts can be retrieved.                                                                                                                            |
| └➔&nbsp;`metadata`     | `string`     | The URL to the `metadata` resource where information about the metadata can be retrieved.                                                                                                                            | {% endif %}
| └➔&nbsp;`operations`     | `array`      | The array of possible operations to perform, given the state of the payment order. As this is an initialized payment, the available operations are `abort`, `update-order` and `redirect-checkout` or `view-checkout`, depending on the integration. [See Operations for details]({{ features_url }}/technical-reference/operations).                                                                                              |

[split-settlement]: {{ features_url }}/core/settlement-reconciliation#split-settlement
