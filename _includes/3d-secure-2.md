{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include documentation-section.md %}{% endcapture %}
{% assign other_features_url = documentation_section | prepend: '/' | append: '/other-features' %}

{% if api_resource == "creditcard" %}
    {% assign other_features_url = other_features_url | prepend: '/payment-instruments' %}
    {% assign api_resource_field_name = "payment" %}
{% else %}
    {% assign api_resource_field_name = "paymentorder" %}
{% endif %}

## 3-D Secure 2

When dealing with card payments, 3-D Secure authentication of the
cardholder is an essential topic. 3-D Secure 2 is an improved version of the
old protocol, now allowing frictionless payments where transactions can be
completed without input from the cardholder. Therefore, there are certain fields
that should be included when implementing 3-D Secure 2. These are listed below
and can be seen in the abbreviated request example below.

{:.code-view-header}
**Request**

```http
POST /psp/{{ api_resource }}/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "{{ api_resource_field_name }}": {
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "SEK",
        "description": "Test Purchase",
        "urls": {
            "hostUrls": ["https://example.com"]
        }, {% if api_resource == "creditcard" %}
        "cardholder": {
            "firstName": "Olivia",
            "lastName": "Nyhuus",
            "email": "olivia.nyhuus@payex.com",
            "msisdn": "+4798765432",
            "homePhoneNumber": "+4787654321",
            "workPhoneNumber": "+4776543210",
            "shippingAddress": {
                "addressee": "Olivia Nyhuus",
                "email": "olivia.nyhuus@payex.com",
                "msisdn": "+4798765432",
                "streetAddress": "Saltnestoppen 43",
                "coAddress": "",
                "city": "Saltnes",
                "zipCode": "1642",
                "countryCode": "NO",
            },{% else %}
        "payer": {
            "email": "olivia.nyhuus@payex.com",
            "msisdn": "+4798765432",
            "workPhoneNumber" : "+4787654321",
            "homePhoneNumber" : "+4776543210",
            "shippingAddress": {
               "addressee": "Olivia Nyhuus",
               "streetAddress": "Saltnestoppen 43",
                "coAddress": "",
                "city": "Saltnes",
                "zipCode": "1642",
                "countryCode": "NO"
            }{% endif %}
        },
        "riskIndicator": {
            "deliveryEmailAddress": "olivia.nyhuus@payex.com",
            "deliveryTimeFrameIndicator": "01",
            "preOrderDate": "19801231",
            "preOrderPurchaseIndicator": "01",
            "shipIndicator": "01",
            "giftCardPurchase": false,
            "reOrderPurchaseIndicator": "01"
            "pickUpAddress" : {
                "name" : "Company Megashop Sarpsborg",
                "streetAddress" : "Hundskinnveien 92",
                "coAddress" : "",
                "city" : "Sarpsborg",
                "zipCode" : "1711",
                "countryCode" : "NO"
            }
        }
    }
}
```

{:.table .table-striped}
| Field | Type | Description |
| :---- | :--- | :---------- |{% if api_resource == "creditcard" %}
| `payment`                             | `object` | The payment object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| └➔&nbsp;`cardholder`                  | `object` | Cardholder object that can hold information about a buyer (private or company). The information added increases the chance for [frictionless 3-D Secure 2 flow]({{ other_features_url }}#3-d-secure-2).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| └➔&nbsp;`firstname`                   | `string` | Payer's first name.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| └➔&nbsp;`lastname`                    | `string` | Payer's last name.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |{% else %}
| └➔&nbsp;`paymentorder`                | `object` | {% include field-description-id.md resource="paymentorder" sub_resource="payer" %}                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| └➔&nbsp;`payer`                       | `object` | The payer object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |{% endif %}
| └➔&nbsp;`email`                       | `string` | Payer's registered email address. The field is related to [3-D Secure 2]({{ other_features_url }}#3-d-secure-2).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| └➔&nbsp;`msisdn`                      | `string` | Payer's registered mobile phone number. The field is related to [3-D Secure 2]({{ other_features_url }}#3-d-secure-2).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| └➔&nbsp;`homePhoneNumber`             | `string` | Payer's registered home phone number. The field is related to [3-D Secure 2]({{ other_features_url }}#3-d-secure-2).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| └➔&nbsp;`workPhoneNumber`             | `string` | Payer's registered work phone number. The field is related to [3-D Secure 2]({{ other_features_url }}#3-d-secure-2).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| └➔&nbsp;`shippingAddress`            | `object` | The shipping address object related to the `payer`. The field is related to [3-D Secure 2]({{ other_features_url }}#3-d-secure-2).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| └─➔&nbsp;`addresse`                   | `string` | The name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| └─➔&nbsp;`coAddress`                  | `string` | Payer' s c/o address, if applicable.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| └─➔&nbsp;`streetAddress`              | `string` | Payer's street address. Maximum 50 characters long.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| └─➔&nbsp;`zipCode`                    | `string` | Payer's zip code                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| └─➔&nbsp;`city`                       | `string` | Payer's city of residence                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| └─➔&nbsp;`countryCode`                | `string` | Country Code for country of residence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| └➔&nbsp;`riskIndicator`               | `object` | This object consist of information that helps verifying the payer. Providing these fields decreases the likelihood of having to promt for [3-D Secure authentication]({{ other_features_url }}#3-d-secure-2) of the payer when they are authenticating the purchase.                                                                                                                                                                                                                                                                                                                                                                                                                        |
| └─➔&nbsp;`deliveryEmailAdress`        | `string` | For electronic delivery, the email address to which the merchandise was delivered. Providing this field when appropriate decreases the likelyhood of a 3-D Secure authentication for the payer.                                                                                                                                                                                                                                                                                                                                                                  |
| └─➔&nbsp;`deliveryTimeFrameIndicator` | `string` | ndicates the merchandise delivery timeframe. <br>`01` (Electronic Delivery) <br>`02` (Same day shipping) <br>`03` (Overnight shipping) <br>`04` (Two-day or more shipping).                                                                                                                                                                                                                                                                                                                                                                                      |
| └─➔&nbsp;`preOrderDate`               | `string` | For a pre-ordered purchase. The expected date that the merchandise will be available. Format: `YYYYMMDD`.                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| └─➔&nbsp;`preOrderPurchaseIndicator`  | `string` | Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br>`01` (Merchandise available) <br>`02` (Future availability).                                                                                                                                                                                                                                                                                                                                                                                     |
| └─➔&nbsp;`shipIndicator`              | `string` | Indicates shipping method chosen for the transaction. <br>`01` (Ship to cardholder's billing address) <br>`02` (Ship to another verified address on file with merchant)<br>`03` (Ship to address that is different than cardholder's billing address)<br>`04` (Ship to Store / Pick-up at local store. Store address shall be populated in the `riskIndicator.pickUpAddress` and `payer.shippingAddress` fields)<br>`05` (Digital goods, includes online services, electronic giftcards and redemption codes) <br>`06` (Travel and Event tickets, not shipped) <br>`07` (Other, e.g. gaming, digital service) |
| └─➔&nbsp;`giftCardPurchase`           | `bool`   | `true` if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| └─➔&nbsp;`reOrderPurchaseIndicator`   | `string` | Indicates whether the cardholder is reordering previously purchased merchandise. <br>`01` (First time ordered) <br>`02` (Reordered).                                                                                                                                                                                                                                                                                                                                                                                     |
