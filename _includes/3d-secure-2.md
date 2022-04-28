{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture features_url %}{% include documentation-section-url.md href='/features' %}{% endcapture %}
{% assign api_resource_field_name = 'paymentorder' %}
{% if api_resource != 'paymentorders' %}
    {% assign api_resource_field_name = 'payment' %}
{% endif %}

## 3-D Secure 2

When dealing with card payments, 3-D Secure authentication of the cardholder is
an essential topic. 3-D Secure 2 is an improved version of the old protocol, now
allowing frictionless payments where transactions can be completed without
input from the cardholder. To increase the chances of this, there are certain
fields that should be included in your request when implementing 3-D Secure 2.

{% if api_resource == "creditcard" %}

## Cardholder

{% else %}

## Payer

{% endif %}

{% if api_resource == "creditcard" %}

```json
{
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
            }
}
```

{% else %}

```json
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
            }
}
```

{% endif %}

{% if api_resource == "creditcard" %}

{:.table .table-striped}
| Field | Type | Description |
| :---- | :--- | :---------- |
| └➔&nbsp;`cardholder`                  | `object` | Cardholder object that can hold information about a payer (private or company). The information added increases the chance for a frictionless 3-D Secure 2 flow.                                                                                    |
| └➔&nbsp;`firstname`                   | `string` | Cardholder's first name.                 |
| └➔&nbsp;`lastname`                    | `string` | Cardholder's last name.                    |
| └➔&nbsp;`email`                       | `string` | Cardholder's registered email address.                                                  |
| └➔&nbsp;`msisdn`  | `string` | Cardholder's registered mobile phone number.                                                  |
| └➔&nbsp;`homePhoneNumber`             | `string` | Cardholder's registered home phone number.                                                               |
| └➔&nbsp;`workPhoneNumber`             | `string` | Cardholder's registered work phone number.                                                                 |
| └➔&nbsp;`shippingAddress`             | `object` | The shipping address object related to the `cardholder`.                                                         |
| └─➔&nbsp;`addressee`                  | `string` | The name of the addressee – the receiver of the shipped goods.                                                      |
| └─➔&nbsp;`coAddress`                  | `string` | Cardholder's c/o address, if applicable.                                                          |
| └─➔&nbsp;`streetAddress`              | `string` | Cardholder's street address. Maximum 50 characters long.                                                                         |
| └─➔&nbsp;`zipCode`                    | `string` | Cardholder's zip code.                                           |
| └─➔&nbsp;`city`                       | `string` | Cardholder's city of residence.                                                                            |
| └─➔&nbsp;`countryCode`                | `string` | Country Code for the country of residence.                                                                      |

{% else %}

{:.table .table-striped}
| Field | Type | Description |
| :---- | :--- | :---------- |
| └➔&nbsp;`payer`                       | `object` | The payer object.        |
| └➔&nbsp;`email`                       | `string` | Payer's registered email address.                                                  |
| └➔&nbsp;`msisdn`  | `string` | Payer's registered mobile phone number.                                                  |
| └➔&nbsp;`homePhoneNumber`             | `string` | Payer's registered home phone number.                                                               |
| └➔&nbsp;`workPhoneNumber`             | `string` | Payer's registered work phone number.                                                                 |
| └➔&nbsp;`shippingAddress`             | `object` | The shipping address object related to the `payer`.                                                         |
| └─➔&nbsp;`addressee`                  | `string` | The name of the addressee – the receiver of the shipped goods.                                                      |
| └─➔&nbsp;`coAddress`                  | `string` | Payer' s c/o address, if applicable.                                                          |
| └─➔&nbsp;`streetAddress`              | `string` | Payer's street address. Maximum 50 characters long.                                                                         |
| └─➔&nbsp;`zipCode`                    | `string` | Payer's zip code.                                           |
| └─➔&nbsp;`city`                       | `string` | Payer's city of residence.                                                                            |
| └─➔&nbsp;`countryCode`                | `string` | Country Code for the country of residence.                                                                      |

{% endif %}

## Risk Indicator

```json
{
    "riskIndicator": {
        "deliveryEmailAddress": "olivia.nyhuus@payex.com",
        "deliveryTimeFrameIndicator": "01",
        "preOrderDate": "19801231",
        "preOrderPurchaseIndicator": "01",
        "shipIndicator": "01",
        "giftCardPurchase": false,
        "reOrderPurchaseIndicator": "01"
        "pickUpAddress" : {
            "name": "Company Megashop Sarpsborg",
            "streetAddress": "Hundskinnveien 92",
            "coAddress": "",
            "city": "Sarpsborg",
            "zipCode": "1711",
            "countryCode": "NO"
        }
    }
}
```

{:.table .table-striped}
| Field | Type | Description |
| :---- | :--- | :---------- |
| └➔&nbsp;`riskIndicator`               | `object` | This object consist of information that helps verifying the payer. Providing these fields decreases the likelihood of having to prompt for a 3-D Secure authentication of the payer when they are authenticating the purchase.                                                                 |
| └─➔&nbsp;`deliveryEmailAdress`        | `string` | For electronic delivery, the email address to which the merchandise was delivered.                                   |
| └─➔&nbsp;`deliveryTimeFrameIndicator` | `string` | Indicates the merchandise delivery timeframe. <br>`01` (Electronic Delivery) <br>`02` (Same day shipping) <br>`03` (Overnight shipping) <br>`04` (Two-day or more shipping).                                                 |
| └─➔&nbsp;`preOrderDate`               | `string` | For a pre-ordered purchase. The expected date that the merchandise will be available. Format: `YYYYMMDD`.                  |
| └─➔&nbsp;`preOrderPurchaseIndicator`  | `string` | Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br>`01` (Merchandise available) <br>`02` (Future availability).                                                  |
| └─➔&nbsp;`shipIndicator`              | `string` | Indicates shipping method chosen for the transaction. <br>`01` (Ship to cardholder's billing address) <br>`02` (Ship to another verified address on file with merchant)<br>`03` (Ship to address that is different than cardholder's billing address)<br>`04` (Ship to Store / Pick-up at local store. Store address shall be populated in the `riskIndicator.pickUpAddress` and `payer.shippingAddress` fields)<br>`05` (Digital goods, includes online services, electronic giftcards and redemption codes) <br>`06` (Travel and Event tickets, not shipped) <br>`07` (Other, e.g. gaming, digital service). |
| └─➔&nbsp;`giftCardPurchase`           | `bool`   | `true` if this is a purchase of a gift card.                                                                 |
| └─➔&nbsp;`reOrderPurchaseIndicator`   | `string` | Indicates if the cardholder is reordering previously purchased merchandise. <br>`01` (First time ordered) <br>`02` (Reordered).                                               |
| └➔&nbsp;`pickUpAddress`               | `object`     | If the `shipIndicator` is set to `04`, you can prefill these fields with the payer's `pickUpAddress` of the purchase to decrease the risk factor of the purchase.                                                                      |
| └─➔&nbsp;`name`                       | `string`     | If the `shipIndicator` is set to `04`, prefill this with the payer's `name`.                                                                           |
| └─➔&nbsp;`streetAddress`              | `string`     | If the `shipIndicator` is set to `04`, prefill this with the payer's `streetAddress`. Maximum 50 characters long.                                                        |
| └─➔&nbsp;`coAddress`                  | `string`     | If the `shipIndicator` is set to `04`, prefill this with the payer's `coAddress`.                                                     |
| └─➔&nbsp;`city`                       | `string`     | If the `shipIndicator` is set to `04`, prefill this with the payer's `city`.                                                                           |
| └─➔&nbsp;`zipCode`                    | `string`     | If the `shipIndicator` is set to `04`, prefill this with the payer's `zipCode`.                                                                               |
| └─➔&nbsp;`countryCode`                | `string`     | If the `shipIndicator` is set to `04`, prefill this with the payer's `countryCode`.                                                  |
