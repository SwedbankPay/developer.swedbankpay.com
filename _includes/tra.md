{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include documentation-section.md %}{% endcapture %}
{% capture features_url %}{% include documentation-section-url.md href='/features' %}{% endcapture %}
{% assign api_resource_field_name = 'paymentorder' %}
{% if api_resource != 'paymentorders' %}
    {% assign api_resource_field_name = 'payment' %}
{% endif %}

## Transaction Risk Analysis Exemption

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
        "userAgent": "Mozilla/5.0",
        "language": "sv-SE", {% if documentation_section contains "checkout-v3" %}
        "productName": "Checkout3", {% endif %}
        "requestTraExemption": true,
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
            "nationalIdentifier": {
                "socialSecurityNumber": "{{ page.consumer_ssn_se }}",
                "countryCode": "SE"
            "requireConsumerInfo": false,
            "digitalProducts": false,
            "email": "olivia.nyhuus@payex.com",
            "msisdn": "+4798765432",
            "authentication" : {
                "type" : "Digital",
                "method" : "OneFactor",
                "nationalIdentityCardType": null,
                "reference" : null
            },
            "shippingAddress": {
                "firstName": "Olivia",
                "lastName": "Nyhuus",
                "email": "olivia.nyhuus@payex.com",
                "msisdn": "+4798765432",
                "streetAddress": "Saltnestoppen 43",
                "coAddress": "",
                "city": "Saltnes",
                "zipCode": "1642",
                "countryCode": "NO"
              },
              "billingAddress": {
                "firstName": "Olivia",
                "lastName": "Nyhuus",
                "email": "olivia.nyhuus@payex.com",
                "msisdn": "+4798765432",
                "streetAddress": "Saltnestoppen 43",
                "coAddress": "",
                "city": "Saltnes",
                "zipCode": "1642",
                "countryCode": "NO"
              },
              "accountInfo": {
                "accountAgeIndicator": "01",
                "accountChangeIndicator": "01",
                "accountPwdChangeIndicator": "01",
                "shippingAddressUsageIndicator": "01",
                "shippingNameIndicator": "01",
                "suspiciousAccountActivity": "01",
                "addressMatchIndicator": true
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
            "deliveryTimeFrameindicator": "01",
            "preOrderDate": "20210220",
            "preOrderPurchaseIndicator": "01",
            "shipIndicator": "01",
            "giftCardPurchase": false,
            "reOrderPurchaseIndicator": "01",
            "pickUpAddress": {
            "name": "Company Megashop Sarpsborg",
            "streetAddress": "Hundskinnveien 92",
            "coAddress": "",
            "city": "Sarpsborg",
            "zipCode": "1711",
            "countryCode": "NO"
            },
            "items": [
            {
                "gpcNumber": 11220000,
                "amount": 5000
            },
            {
                "gpcNumber": 12340000,
                "amount": 3000
            }
            ]
        }
    }
}
```

{:.table .table-striped}
| Field | Type | Description |
| :---- | :--- | :---------- |
| {% icon check %} | └➔&nbsp;`paymentorder`                | `object` | {% include field-description-id.md resource="paymentorder" sub_resource="payer" %}                                             |
| {% icon check %} | └➔&nbsp;`operation`                | `string`     | The operation that the payment order is supposed to perform.                        |
| {% icon check %} | └➔&nbsp;`currency`                 | `string`     | The currency of the payment.                                             |
| {% icon check %} | └➔&nbsp;`amount`                   | `integer`    | {% include field-description-amount.md %}                       |
| {% icon check %} | └➔&nbsp;`vatAmount`                | `integer`    | {% include field-description-vatamount.md %}                    |
| {% icon check %} | └➔&nbsp;`description`              | `string`     | The description of the payment order.                                               |
| {% icon check %} | └➔&nbsp;`userAgent`                | `string`     | {% include field-description-user-agent.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`language`                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`productName`                 | `string`     | Used to tag the payment as Checkout v3. Mandatory for Checkout v3, as you won't get the operations in the response without submitting this field.                                                                                                                                                                                                                                                                              |
| {% icon check %} | └➔&nbsp;`requestTraExemption`                       | `bool` | Set to `true` if the merchant requests a TRA exemption. |
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
|                  | └─➔&nbsp;`subsite`                 | `String(40)` | The subsite field can be used to perform [split settlement]({{ features_url }}/core/settlement-reconciliation#split-settlement) on the payment. The subsites must be resolved with Swedbank Pay [reconciliation]({{ features_url }}/core/settlement-reconciliation) before being used.                   | {% if documentation_section contains "checkout-v3" %}
|                  | └─➔&nbsp;`siteId`                 | `String(15)` | This parameter is used when you as a Merchant is using Swedbank Pays ”Split Settlement” and have a need to be able to specify towards AMEX which Merchant that the transaction belongs to.                                                                                                                | {% endif %}
|                   |└➔&nbsp;`payer`                       | `object` | The payer object.       |
|                  | └─➔&nbsp;`nationalIdentifier`    | `object` | The national identifier object.                                                                      |
|                  | └──➔&nbsp;`socialSecurityNumber` | `string` | The payer's social security number. |
|                  | └──➔&nbsp;`countryCode`          | `string` | The country code of the payer.                                                                     |
|                   | └➔&nbsp;`requireConsumerInfo`                       | `bool` | Set to `true` if the merchant wants to receive profile information from Swedbank Pay. Applicable for when the merchant only needs `email` and/or `msisdn` for digital goods, or when the full shipping address is necessary. If set to `false`, Swedbank Pay will depend on the merchant to send `email` and/or `msisdn` for digital products and shipping address for physical orders. |
|                   | └➔&nbsp;`digitalProducts`                       | `bool` | Set to `true` for merchants who only sell digital goods and only require `email` and/or `msisdn` as shipping details. Set to `false` if the merchant also sells physical goods. |
|                   | └➔&nbsp;`email`                       | `string` | Payer's registered email address.                                                                                                                                                                                                                                                                                                                       |
|                   | └➔&nbsp;`msisdn`                      | `string` | Payer's registered mobile phone number.                                                                                                                                                                                                                                                                                                               |
|                   | └➔&nbsp;`authentication`            | `object` | The authentication object related to the `payer`.                                                                                                                                                                                                                                                                                                                                             |
|                   | └➔&nbsp;`type`                      | `string` | Set to `Physical` or `Digital`, depending on how the authentication was done.                                                                                                                                                                                                                                                                                                               |
|                   | └➔&nbsp;`method`                      | `string` | Indicator of the authentication method. Set to `OneFactor`, `MultiFactor`, `BankId`, `nationalIdentityCard` or `RecurringToken`.                                                                                                                                                                                                                                  |
|                   | └➔&nbsp;`nationalIdentityCardType`    | `string` | Form of identity card used for the authentication. Set to `Passport`, `DriversLicense` or `BankCard`.                                                                                                                                                                                                                                                                                                  |
|                   | └➔&nbsp;`reference`                      | `string` | Used if the authentication method has an associated reference. Use the passport number for `Passport` authentications, session numbers for `BankID` sessions etc.                                                                                                                                    |
|                   | └➔&nbsp;`shippingAddress`            | `object` | The shipping address object related to the `payer`.                                                                                                                                                                                                         |
|                   | └─➔&nbsp;`firstName`                   | `string` | The first name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                              |
|                   | └─➔&nbsp;`lastName`                   | `string` | The last name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                            |
|                   | └➔&nbsp;`email`                       | `string` | Payer's registered email address.                                                                                                                                                                                                                                                                                                                      |
|                   | └➔&nbsp;`msisdn`                      | `string` | Payer's registered mobile phone number.                                                                                                                                                                                                                                                                                                               |
|                   | └─➔&nbsp;`streetAddress`              | `string` | Payer's street address. Maximum 50 characters long.                                                                                                                                                                                                                                                                   |
|                   | └─➔&nbsp;`coAddress`                  | `string` | Payer's c/o address, if applicable.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|                   | └─➔&nbsp;`city`                       | `string` | Payer's city of residence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|                   | └─➔&nbsp;`zipCode`                    | `string` | Payer's zip code.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|                   | └─➔&nbsp;`countryCode`                | `string` | Country code for the payer's country of residence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|                   | └➔&nbsp;`billingAddress`            | `object` | The billing address object related to the `payer`.                                                                                                                                                                                                                                                                                                                                             |
|                   | └─➔&nbsp;`firstName`                   | `string` | The first name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                   | └─➔&nbsp;`lastName`                   | `string` | The last name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                   | └➔&nbsp;`email`                       | `string` | Payer's registered email address.                                                                                                                                                                                                                                                                                                                      |
|                   | └➔&nbsp;`msisdn`                      | `string` | Payer's registered mobile phone number.                                                                                                                                                                                                                                                                                                               |
|                   | └─➔&nbsp;`streetAddress`              | `string` | Payer's street address. Maximum 50 characters long.                                                                                                                                                                                                                                                            |
|                   | └─➔&nbsp;`coAddress`                  | `string` | Payer's c/o address, if applicable.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|                   | └─➔&nbsp;`city`                       | `string` | Payer's city of residence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|                   | └─➔&nbsp;`zipCode`                    | `string` | Payer's zip code.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|                   | └─➔&nbsp;`countryCode`                | `string` | Country code for the payer's country of residence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|                   | └➔&nbsp;`accountInfo`            | `object` | Object related to the `payer` containing info about the payer's account.                                                                                                                                                                                                                                                                                                                                           |
|                   | └─➔&nbsp;`accountAgeIndicator` | `string` | Indicates the age of the payer's account. <br>`01` (No account, guest checkout) <br>`02` (Created during this transaction) <br>`03` (Less than 30 days old) <br>`04` (30 to 60 days old) <br>`05` (More than 60 days old)             |
|                   | └─➔&nbsp;`accountChangeIndicator` | `string` | Indicates when the last account changes occurred. <br>`01` (Changed during this transaction) <br>`02` (Less than 30 days ago) <br>`03` (30 to 60 days ago) <br>`04` (More than 60 days ago) |
|                   | └─➔&nbsp;`accountChangePwdIndicator` | `string` | Indicates when the account's password was last changed. <br>`01` (No changes) <br>`02` (Changed during this transaction) <br>`03` (Less than 30 days ago) <br>`04` (30 to 60 days ago) <br>`05` (More than 60 days old) |
|                   | └─➔&nbsp;`shippingAddressUsageIndicator` | `string` | Indicates when the payer's shipping address was last used. <br>`01`(This transaction) <br>`02` (Less than 30 days ago) <br>`03` (30 to 60 days ago) <br>`04` (More than 60 days ago) |
|                   | └─➔&nbsp;`shippingNameIndicator` | `string` | Indicates if the account name matches the shipping name. <br>`01` (Account name identical to shipping name) <br>`02` (Account name different from shipping name) |
|                   | └─➔&nbsp;`suspiciousAccountActivity` | `string` | Indicates if there have been any suspicious activities linked to this account. <br>`01` (No suspicious activity has been observed) <br>`02` (Suspicious activity has been observed) |
|                   | └─➔&nbsp;`addressMatchIndicator` | `bool` | Allows the antifraud system to indicate if the payer's billing and shipping address are the same. |
|                   | └➔&nbsp;`orderItems`            | `object` | The object containing items being purchased with the order, and info about them. If you have GPC codes for the items and add them here, you won't have to include the items at the bottom of the code example.                                                                                             |
| {% icon check %} | └─➔&nbsp;`reference`           | `string`  | A reference that identifies the order item.                                                                                                                                                                                                                                           |
| {% icon check %} | └─➔&nbsp;`name`                | `string`  | The name of the order item.                                                                                                                                                                                                                                                           |
| {% icon check %} | └─➔&nbsp;`type`                | `enum`    | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `DISCOUNT`, `VALUE_CODE`, or `OTHER`. The type of the order item.                                                                                                                                                                               |
| {% icon check %} | └─➔&nbsp;`class`               | `string`  | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics. |
|                  | └─➔&nbsp;`itemUrl`             | `string`  | The URL to a page that can display the purchased item, such as a product page                                                                                                                                                                                                         |
|                  | └─➔&nbsp;`imageUrl`            | `string`  | The URL to an image of the order item.                                                                                                                                                                                                                                                |
|                  | └─➔&nbsp;`description`         | `string`  | The human readable description of the order item.                                                                                                                                                                                                                                     |
|                  | └─➔&nbsp;`discountDescription` | `string`  | The human readable description of the possible discount.                                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`quantity`            | `decimal` | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                      |
| {% icon check %} | └─➔&nbsp;`quantityUnit`        | `string`  | The unit of the quantity, such as `pcs`, `grams`, or similar.                                                                                                                                                                                                                         |
| {% icon check %} | └─➔&nbsp;`unitPrice`           | `integer` | The price per unit of order item, including VAT.                                                                                                                                                                                                                                      |
|                  | └─➔&nbsp;`discountPrice`       | `integer` | If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                            |
| {% icon check %} | └─➔&nbsp;`vatPercent`          | `integer` | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp `amount`              | `integer` | {% include field-description-amount.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | └─➔&nbsp;`vatAmount`           | `integer` | {% include field-description-vatamount.md %}                                                                                                                                                                                                                                          |
|                   | └➔&nbsp;`riskIndicator`               | `object` | This object consists of information that helps verifying the payer. Providing these fields decreases the likelihood of having to prompt for 3-D Secure authentication of the payer when they are authenticating the purchase.                                                                                                                                            |
|                   | └─➔&nbsp;`deliveryEmailAdress`        | `string` | For electronic delivery (see `shipIndicator` below), the email address to which the merchandise was delivered. Providing this field when appropriate decreases the likelihood of a 3-D Secure authentication for the payer.                                                                                                                                                                              |
|                   | └─➔&nbsp;`deliveryTimeFrameIndicator` | `string` | Indicates the merchandise delivery timeframe. <br>`01` (Electronic Delivery) <br>`02` (Same day shipping) <br>`03` (Overnight shipping) <br>`04` (Two-day or more shipping).                                                                                                                                                                                                                                                                                                                                                                                      |
|                   | └─➔&nbsp;`preOrderDate`               | `string` | For a pre-ordered purchase. The expected date that the merchandise will be available. Format: `YYYYMMDD`.                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|                   | └─➔&nbsp;`preOrderPurchaseIndicator`  | `string` | Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br>`01` (Merchandise available) <br>`02` (Future availability).                                                                                                                                                                                                                                                                                                                                                                                     |
|                   | └─➔&nbsp;`shipIndicator`              | `string` | Indicates shipping method chosen for the transaction. <br>`01` (Ship to cardholder's billing address) <br>`02` (Ship to another verified address on file with merchant)<br>`03` (Ship to address that is different than cardholder's billing address)<br>`04` (Ship to Store / Pick-up at local store. Store address shall be populated in the `riskIndicator.pickUpAddress` and `payer.shippingAddress` fields)<br>`05` (Digital goods, includes online services, electronic giftcards and redemption codes) <br>`06` (Travel and Event tickets, not shipped) <br>`07` (Other, e.g. gaming, digital service) |
|                   |└─➔&nbsp;`giftCardPurchase`           | `bool`   | `true` if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|                   | └─➔&nbsp;`reOrderPurchaseIndicator`   | `string` | Indicates whether the cardholder is reordering previously purchased merchandise. <br>`01` (First time ordered) <br>`02` (Reordered).                                                                                                                                                                                                                                                                                                                                                                                     |
|                   | └➔&nbsp;`pickUpAddress`            | `object` | Object related to the `riskIndicator`, containing info about the merchant's pick-up address. If the `shipIndicator` is set to `04`, this should be filled out with the merchant's pick-up address. Do not use if the shipment is sent or delivered to a consumer address (ShipIndicator `01`, `02` or `03`). In those cases, the shipping address in the `Payer` field should be used instead.                                                                                                                                           |
|                   | └─➔&nbsp;`pickUpAddress.Name`                   | `string` | The name of the shop or merchant.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|                   | └─➔&nbsp;`pickUpAddress.streetAddress`              | `string` | The shop or merchant's street address. Maximum 50 characters long.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|                   | └─➔&nbsp;`pickUpAddress.coAddress`                  | `string` | The shop or merchant's c/o address, if applicable.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|                   | └─➔&nbsp;`pickUpAddress.City`                       | `string` | The city where the shop or merchant is located.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|                   | └─➔&nbsp;`pickUpAddress.zipCode`                    | `string` | The zip code where the shop or merchant is located.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|                   | └─➔&nbsp;`pickUpAddress.countryCode`                | `string` | The country code where the shop or merchant is located.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|                   | └➔&nbsp;`items`            | `object` | Object related to the `riskIndicator`, containing info about the items ordered. Should be added if the GPC codes for the items are available. If the `orderItems` object is used and includes the GPC codes, there is no need to add this field. Should only be used by merchants who don't use the `orderItems` object.                                                                                                                                          |
|                   | └─➔&nbsp;`gpcNumber`                   | `string` | The specific [GPC Number][gpc] for the order line. |
|                   | └─➔&nbsp;`amount`                   | `string` | The amount of the specific order line. |

[gpc]: https://www.gs1.org/standards/gpc
