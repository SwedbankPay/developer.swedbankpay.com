{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% assign api_resource_field_name = 'paymentorder' %}
{% if api_resource != 'paymentorders' %}
    {% assign api_resource_field_name = 'payment' %}
{% endif %}
{% assign implementation = documentation_section | split: "/"  | last | capitalize | remove: "-" %}

## Transaction Risk Analysis Exemption

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "requestTraExemption": true,
        "operation": "Purchase",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "description": "Test Purchase",
        "userAgent": "Mozilla/5.0",
        "language": "sv-SE", {% if documentation_section contains "checkout-v3" %}
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
            "nationalIdentifier": {
                "socialSecurityNumber": "{{ page.consumer_ssn_se }}",
                "countryCode": "SE"
            "requireConsumerInfo": false,
            "digitalProducts": false,
            "email": "olivia.nyhuus@swedbankpay.com",
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
                "email": "olivia.nyhuus@swedbankpay.com",
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
                "email": "olivia.nyhuus@swedbankpay.com",
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
            "deliveryEmailAddress": "olivia.nyhuus@swedbankpay.com",
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
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field | Type | Description |
| :---- | :--- | :---------- |
| {% icon check %} | {% f paymentOrder %}                | `object` | {% include fields/id.md resource="paymentorder" sub_resource="payer" %}                                             |
| {% icon check %} | {% f requestTraExemption %}      | `bool`       | Set to `true` if the merchant requests a TRA exemption. |
| {% icon check %} | {% f operation %}                | `string`     | {% include fields/operation.md %}                        |
| {% icon check %} | {% f currency %}                 | `string`     | The currency of the payment.                                             |
| {% icon check %} | {% f amount %}                   | `integer`    | {% include fields/amount.md %}                       |
| {% icon check %} | {% f vatAmount %}                | `integer`    | {% include fields/vat-amount.md %}                    |
| {% icon check %} | {% f description %}              | `string`     | The description of the payment order.                                               |
| {% icon check %} | {% f userAgent %}                | `string`     | {% include fields/user-agent.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f language %}                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
| {% icon check %} | {% f productName %}              | `string`     | Used to tag the payment as Digital Payments v3.0, either in this field or the header, as you won't get the operations in the response without submitting this field.                                                                                                                                                                                                                                                                              |
|                  | {% f implementation %}           | `string`     | Indicates which implementation to use.                                                                                                                                                                                                                                                                          |
| {% icon check %} | {% f urls %}                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | {% f hostUrls, 2 %}                | `array`      | The array of valid host URLs.                                                                                                                                                                                                                                    |{% if include.integration_mode=="seamless-view" %}
|                  | {% f paymentUrl, 2 %}              | `string`     | {% include fields/payment-url.md %} | {% endif %}
| {% icon check %} | {% f completeUrl, 2 %}             | `string`     | {% include fields/complete-url.md %} |
|                  | {% f cancelUrl, 2 %}               | `string`     | The URL to redirect the payer to if the payment is cancelled, either by the payer or by the merchant trough an `abort` request of the `payment` or `paymentorder`.                                                                                                                                        |
| {% icon check %} | {% f callbackUrl, 2 %}             | `string`     | {% include fields/callback-url.md %}                                                                                                                                                                                              |
| {% icon check %} | {% f termsOfServiceUrl, 2 %}       | `string`     | {% include fields/terms-of-service-url.md %}                                                                                                                                                                                                                                                     |{% if include.integration_mode=="redirect" %},
| {% icon check %} | {% f logoUrl, 2 %}                 | `string`     | {% include fields/logo-url.md %}                                                                                                                                                                                                                                                               |{% endif %}
| {% icon check %} | {% f payeeInfo %}                | `object`     | {% include fields/payee-info.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | {% f payeeId, 2 %}                 | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | {% f payeeReference, 2 %}          | `string(30)` | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                                                                                                                                                 |
|                  | {% f payeeName, 2 %}               | `string`     | The name of the payee, usually the name of the merchant.                                                                                                                                                                                                                                                 |
|                  | {% f productCategory, 2 %}         | `string(50)`     | A product category or number sent in from the payee/merchant. This is not validated by Swedbank Pay, but will be passed through the payment process and may be used in the settlement process.                                                                                                           |
|                  | {% f orderReference, 2 %}          | `string(50)` | The order reference should reflect the order reference found in the merchant's systems.                                                                                                                                                                                                                  |
|                  | {% f subsite, 2 %}                 | `string(40)` | {% include fields/subsite.md %} | {% if documentation_section contains "checkout-v3" %}
|                  | {% f siteId, 2 %}                 | `string(15)` | {% include fields/site-id.md %}                                                                                                                    | {% endif %}
|                   |{% f payer %}                       | `object` | The payer object.       |
|                  | {% f nationalIdentifier, 2 %}    | `object` | The national identifier object.                                                                      |
|                  | {% f socialSecurityNumber, 3 %} | `string` | The payer's social security number. |
|                  | {% f countryCode, 3 %}          | `string` | The country code of the payer.                                                                     |
|                   | {% f requireConsumerInfo %}                       | `bool` | Set to `true` if the merchant wants to receive profile information from Swedbank Pay. Applicable for when the merchant only needs `email` and/or `msisdn` for digital goods, or when the full shipping address is necessary. If set to `false`, Swedbank Pay will depend on the merchant to send `email` and/or `msisdn` for digital products and shipping address for physical orders. |
|                   | {% f digitalProducts %}                       | `bool` | Set to `true` for merchants who only sell digital goods and only require `email` and/or `msisdn` as shipping details. Set to `false` if the merchant also sells physical goods. |
|                   | {% f email %}                       | `string` | Payer's registered email address.                                                                                                                                                                                                                                                                                                                       |
|                   | {% f msisdn %}                      | `string` | Payer's registered mobile phone number.                                                                                                                                                                                                                                                                                                               |
|                   | {% f authentication %}            | `object` | The authentication object related to the `payer`.                                                                                                                                                                                                                                                                                                                                             |
|                   | {% f type %}                      | `string` | Set to `Physical` or `Digital`, depending on how the authentication was done.                                                                                                                                                                                                                                                                                                               |
|                   | {% f method %}                      | `string` | Indicator of the authentication method. Set to `OneFactor`, `MultiFactor`, `BankId`, `nationalIdentityCard` or `RecurringToken`.                                                                                                                                                                                                                                  |
|                   | {% f nationalIdentityCardType %}    | `string` | Form of identity card used for the authentication. Set to `Passport`, `DriversLicense` or `BankCard`.                                                                                                                                                                                                                                                                                                  |
|                   | {% f reference %}                      | `string` | Used if the authentication method has an associated reference. Use the passport number for `Passport` authentications, session numbers for `BankID` sessions etc.                                                                                                                                    |
|                   | {% f shippingAddress %}            | `object` | The shipping address object related to the `payer`.                                                                                                                                                                                                         |
|                   | {% f firstName, 2 %}                   | `string` | The first name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                              |
|                   | {% f lastName, 2 %}                   | `string` | The last name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                            |
|                   | {% f email %}                       | `string` | Payer's registered email address.                                                                                                                                                                                                                                                                                                                      |
|                   | {% f msisdn %}                      | `string` | Payer's registered mobile phone number.                                                                                                                                                                                                                                                                                                               |
|                   | {% f streetAddress, 2 %}              | `string` | Payer's street address. Maximum 50 characters long.                                                                                                                                                                                                                                                                   |
|                   | {% f coAddress, 2 %}                  | `string` | Payer's c/o address, if applicable.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|                   | {% f city, 2 %}                       | `string` | Payer's city of residence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|                   | {% f zipCode, 2 %}                    | `string` | Payer's zip code.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|                   | {% f countryCode, 2 %}                | `string` | Country code for the payer's country of residence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|                   | {% f billingAddress %}            | `object` | The billing address object related to the `payer`.                                                                                                                                                                                                                                                                                                                                             |
|                   | {% f firstName, 2 %}                   | `string` | The first name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                   | {% f lastName, 2 %}                   | `string` | The last name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                   | {% f email %}                       | `string` | Payer's registered email address.                                                                                                                                                                                                                                                                                                                      |
|                   | {% f msisdn %}                      | `string` | Payer's registered mobile phone number.                                                                                                                                                                                                                                                                                                               |
|                   | {% f streetAddress, 2 %}              | `string` | Payer's street address. Maximum 50 characters long.                                                                                                                                                                                                                                                            |
|                   | {% f coAddress, 2 %}                  | `string` | Payer's c/o address, if applicable.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|                   | {% f city, 2 %}                       | `string` | Payer's city of residence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|                   | {% f zipCode, 2 %}                    | `string` | Payer's zip code.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|                   | {% f countryCode, 2 %}                | `string` | Country code for the payer's country of residence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|                   | {% f accountInfo %}            | `object` | Object related to the `payer` containing info about the payer's account.                                                                                                                                                                                                                                                                                                                                           |
|                   | {% f accountAgeIndicator, 2 %} | `string` | Indicates the age of the payer's account. <br>`01` (No account, guest checkout) <br>`02` (Created during this transaction) <br>`03` (Less than 30 days old) <br>`04` (30 to 60 days old) <br>`05` (More than 60 days old)             |
|                   | {% f accountChangeIndicator, 2 %} | `string` | Indicates when the last account changes occurred. <br>`01` (Changed during this transaction) <br>`02` (Less than 30 days ago) <br>`03` (30 to 60 days ago) <br>`04` (More than 60 days ago) |
|                   | {% f accountChangePwdIndicator, 2 %} | `string` | Indicates when the account's password was last changed. <br>`01` (No changes) <br>`02` (Changed during this transaction) <br>`03` (Less than 30 days ago) <br>`04` (30 to 60 days ago) <br>`05` (More than 60 days old) |
|                   | {% f shippingAddressUsageIndicator, 2 %} | `string` | Indicates when the payer's shipping address was last used. <br>`01`(This transaction) <br>`02` (Less than 30 days ago) <br>`03` (30 to 60 days ago) <br>`04` (More than 60 days ago) |
|                   | {% f shippingNameIndicator, 2 %} | `string` | Indicates if the account name matches the shipping name. <br>`01` (Account name identical to shipping name) <br>`02` (Account name different from shipping name) |
|                   | {% f suspiciousAccountActivity, 2 %} | `string` | Indicates if there have been any suspicious activities linked to this account. <br>`01` (No suspicious activity has been observed) <br>`02` (Suspicious activity has been observed) |
|                   | {% f addressMatchIndicator, 2 %} | `bool` | Allows the antifraud system to indicate if the payer's billing and shipping address are the same. |
|                   | {% f orderItems %}            | `object` | The object containing items being purchased with the order, and info about them. If you have GPC codes for the items and add them here, you won't have to include the items at the bottom of the code example.                                                                                             |
| {% icon check %} | {% f reference, 2 %}           | `string`  | A reference that identifies the order item.                                                                                                                                                                                                                                           |
| {% icon check %} | {% f name, 2 %}                | `string`  | The name of the order item.                                                                                                                                                                                                                                                           |
| {% icon check %} | {% f type, 2 %}                | `enum`    | `PRODUCT`, `SERVICE`, `SHIPPING_FEE`, `DISCOUNT`, `VALUE_CODE`, or `OTHER`. The type of the order item.                                                                                                                                                                               |
| {% icon check %} | {% f class, 2 %}               | `string`  | The classification of the order item. Can be used for assigning the order item to a specific product category, such as `MobilePhone`. Note that `class` cannot contain spaces and must follow the regex pattern `[\w-]*`. Swedbank Pay may use this field for statistics. |
|                  | {% f itemUrl, 2 %}             | `string`  | The URL to a page that can display the purchased item, such as a product page                                                                                                                                                                                                         |
|                  | {% f imageUrl, 2 %}            | `string`  | The URL to an image of the order item.                                                                                                                                                                                                                                                |
|                  | {% f description, 2 %}         | `string`  | The human readable description of the order item.                                                                                                                                                                                                                                     |
|                  | {% f discountDescription, 2 %} | `string`  | The human readable description of the possible discount.                                                                                                                                                                                                                              |
| {% icon check %} | {% f quantity, 2 %}            | `number` | The 4 decimal precision quantity of order items being purchased.                                                                                                                                                                                                                      |
| {% icon check %} | {% f quantityUnit, 2 %}        | `string`  | The unit of the quantity, such as `pcs`, `grams`, or similar.                                                                                                                                                                                                                         |
| {% icon check %} | {% f unitPrice, 2 %}           | `integer` | The price per unit of order item, including VAT.                                                                                                                                                                                                                                      |
|                  | {% f discountPrice, 2 %}       | `integer` | If the order item is purchased at a discounted price. This field should contain that price, including VAT.                                                                                                                                                                            |
| {% icon check %} | {% f vatPercent, 2 %}          | `integer` | The percent value of the VAT multiplied by 100, so `25%` becomes `2500`.                                                                                                                                                                                                              |
| {% icon check %} | {% f amount, 2 %}              | `integer` | {% include fields/amount.md %}                                                                                                                                                                                                                                             |
| {% icon check %} | {% f vatAmount, 2 %}           | `integer` | {% include fields/vat-amount.md %}                                                                                                                                                                                                                                          |
|                   | {% f riskIndicator %}               | `object` | This object consists of information that helps verifying the payer. Providing these fields decreases the likelihood of having to prompt for 3-D Secure authentication of the payer when they are authenticating the purchase.                                                                                                                                            |
|                   | {% f deliveryEmailAdress, 2 %}        | `string` | For electronic delivery (see `shipIndicator` below), the email address to which the merchandise was delivered. Providing this field when appropriate decreases the likelihood of a 3-D Secure authentication for the payer.                                                                                                                                                                              |
|                   | {% f deliveryTimeFrameIndicator, 2 %} | `string` | Indicates the merchandise delivery timeframe. <br>`01` (Electronic Delivery) <br>`02` (Same day shipping) <br>`03` (Overnight shipping) <br>`04` (Two-day or more shipping).                                                                                                                                                                                                                                                                                                                                                                                      |
|                   | {% f preOrderDate, 2 %}               | `string` | For a pre-ordered purchase. The expected date that the merchandise will be available. Format: `YYYYMMDD`.                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|                   | {% f preOrderPurchaseIndicator, 2 %}  | `string` | Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br>`01` (Merchandise available) <br>`02` (Future availability).                                                                                                                                                                                                                                                                                                                                                                                     |
|                   | {% f shipIndicator, 2 %}              | `string` | Indicates shipping method chosen for the transaction. <br>`01` (Ship to cardholder's billing address) <br>`02` (Ship to another verified address on file with merchant)<br>`03` (Ship to address that is different than cardholder's billing address)<br>`04` (Ship to Store / Pick-up at local store. Store address shall be populated in the `riskIndicator.pickUpAddress` and `payer.shippingAddress` fields)<br>`05` (Digital goods, includes online services, electronic giftcards and redemption codes) <br>`06` (Travel and Event tickets, not shipped) <br>`07` (Other, e.g. gaming, digital service) |
|                   |{% f giftCardPurchase, 2 %}           | `bool`   | `true` if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|                   | {% f reOrderPurchaseIndicator, 2 %}   | `string` | Indicates whether the cardholder is reordering previously purchased merchandise. <br>`01` (First time ordered) <br>`02` (Reordered).                                                                                                                                                                                                                                                                                                                                                                                     |
|                   | {% f pickUpAddress %}            | `object` | Object related to the `riskIndicator`, containing info about the merchant's pick-up address. If the `shipIndicator` is set to `04`, this should be filled out with the merchant's pick-up address. Do not use if the shipment is sent or delivered to a consumer address (ShipIndicator `01`, `02` or `03`). In those cases, the shipping address in the `Payer` field should be used instead.                                                                                                                                           |
|                   | {% f pickUpAddress.Name, 2 %}                   | `string` | The name of the shop or merchant.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|                   | {% f pickUpAddress.streetAddress, 2 %}              | `string` | The shop or merchant's street address. Maximum 50 characters long.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|                   | {% f pickUpAddress.coAddress, 2 %}                  | `string` | The shop or merchant's c/o address, if applicable.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|                   | {% f pickUpAddress.City, 2 %}                       | `string` | The city where the shop or merchant is located.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|                   | {% f pickUpAddress.zipCode, 2 %}                    | `string` | The zip code where the shop or merchant is located.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|                   | {% f pickUpAddress.countryCode, 2 %}                | `string` | The country code where the shop or merchant is located.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|                   | {% f items %}            | `object` | Object related to the `riskIndicator`, containing info about the items ordered. Should be added if the GPC codes for the items are available. If the `orderItems` object is used and includes the GPC codes, there is no need to add this field. Should only be used by merchants who don't use the `orderItems` object.                                                                                                                                          |
|                   | {% f gpcNumber, 2 %}                   | `string` | The specific [GPC Number](https://www.gs1.org/standards/gpc) for the order line. |
|                   | {% f amount, 2 %}                   | `string` | The amount of the specific order line. |
{% endcapture %}
{% include accordion-table.html content=table %}
