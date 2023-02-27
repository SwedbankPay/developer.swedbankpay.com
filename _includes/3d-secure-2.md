{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
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
{
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
| {% f cardholder %}                  | `object` | Cardholder object that can hold information about a payer (private or company). The information added increases the chance for a frictionless 3-D Secure 2 flow.                                                                                    |
| {% f firstname %}                   | `string` | Cardholder's first name.                 |
| {% f lastname %}                    | `string` | Cardholder's last name.                    |
| {% f email %}                       | `string` | Cardholder's registered email address.                                                  |
| {% f msisdn %}  | `string` | Cardholder's registered mobile phone number.                                                  |
| {% f homePhoneNumber %}             | `string` | Cardholder's registered home phone number.                                                               |
| {% f workPhoneNumber %}             | `string` | Cardholder's registered work phone number.                                                                 |
| {% f shippingAddress %}             | `object` | The shipping address object related to the `cardholder`.                                                         |
| {% f addressee, 2 %}                  | `string` | The name of the addressee – the receiver of the shipped goods.                                                      |
| {% f coAddress, 2 %}                  | `string` | Cardholder's c/o address, if applicable.                                                          |
| {% f streetAddress, 2 %}              | `string` | Cardholder's street address. Maximum 50 characters long.                                                                         |
| {% f zipCode, 2 %}                    | `string` | Cardholder's zip code.                                           |
| {% f city, 2 %}                       | `string` | Cardholder's city of residence.                                                                            |
| {% f countryCode, 2 %}                | `string` | Country Code for the country of residence.                                                                      |

{% else %}

{:.table .table-striped}
| Field | Type | Description |
| :---- | :--- | :---------- |
| {% f payer %}                       | `object` | The payer object.        |
| {% f email %}                       | `string` | Payer's registered email address.                                                  |
| {% f msisdn %}  | `string` | Payer's registered mobile phone number.                                                  |
| {% f homePhoneNumber %}             | `string` | Payer's registered home phone number.                                                               |
| {% f workPhoneNumber %}             | `string` | Payer's registered work phone number.                                                                 |
| {% f shippingAddress %}             | `object` | The shipping address object related to the `payer`.                                                         |
| {% f addressee, 2 %}                  | `string` | The name of the addressee – the receiver of the shipped goods.                                                      |
| {% f coAddress, 2 %}                  | `string` | Payer' s c/o address, if applicable.                                                          |
| {% f streetAddress, 2 %}              | `string` | Payer's street address. Maximum 50 characters long.                                                                         |
| {% f zipCode, 2 %}                    | `string` | Payer's zip code.                                           |
| {% f city, 2 %}                       | `string` | Payer's city of residence.                                                                            |
| {% f countryCode, 2 %}                | `string` | Country Code for the country of residence.                                                                      |

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
| {% f riskIndicator %}               | `object` | This object consist of information that helps verifying the payer. Providing these fields decreases the likelihood of having to prompt for a 3-D Secure authentication of the payer when they are authenticating the purchase.                                                                 |
| {% f deliveryEmailAdress, 2 %}        | `string` | For electronic delivery, the email address to which the merchandise was delivered.                                   |
| {% f deliveryTimeFrameIndicator, 2 %} | `string` | Indicates the merchandise delivery timeframe. <br>`01` (Electronic Delivery) <br>`02` (Same day shipping) <br>`03` (Overnight shipping) <br>`04` (Two-day or more shipping).                                                 |
| {% f preOrderDate, 2 %}               | `string` | For a pre-ordered purchase. The expected date that the merchandise will be available. Format: `YYYYMMDD`.                  |
| {% f preOrderPurchaseIndicator, 2 %}  | `string` | Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br>`01` (Merchandise available) <br>`02` (Future availability).                                                  |
| {% f shipIndicator, 2 %}              | `string` | Indicates shipping method chosen for the transaction. <br>`01` (Ship to cardholder's billing address) <br>`02` (Ship to another verified address on file with merchant)<br>`03` (Ship to address that is different than cardholder's billing address)<br>`04` (Ship to Store / Pick-up at local store. Store address shall be populated in the `riskIndicator.pickUpAddress` and `payer.shippingAddress` fields)<br>`05` (Digital goods, includes online services, electronic giftcards and redemption codes) <br>`06` (Travel and Event tickets, not shipped) <br>`07` (Other, e.g. gaming, digital service). |
| {% f giftCardPurchase, 2 %}           | `bool`   | `true` if this is a purchase of a gift card.                                                                 |
| {% f reOrderPurchaseIndicator, 2 %}   | `string` | Indicates if the cardholder is reordering previously purchased merchandise. <br>`01` (First time ordered) <br>`02` (Reordered).                                               |
| {% f pickUpAddress %}               | `object`     | If the `shipIndicator` is set to `04`, you can prefill these fields with the payer's `pickUpAddress` of the purchase to decrease the risk factor of the purchase.                                                                      |
| {% f name, 2 %}                       | `string`     | If the `shipIndicator` is set to `04`, prefill this with the payer's `name`.                                                                           |
| {% f streetAddress, 2 %}              | `string`     | If the `shipIndicator` is set to `04`, prefill this with the payer's `streetAddress`. Maximum 50 characters long.                                                        |
| {% f coAddress, 2 %}                  | `string`     | If the `shipIndicator` is set to `04`, prefill this with the payer's `coAddress`.                                                     |
| {% f city, 2 %}                       | `string`     | If the `shipIndicator` is set to `04`, prefill this with the payer's `city`.                                                                           |
| {% f zipCode, 2 %}                    | `string`     | If the `shipIndicator` is set to `04`, prefill this with the payer's `zipCode`.                                                                               |
| {% f countryCode, 2 %}                | `string`     | If the `shipIndicator` is set to `04`, prefill this with the payer's `countryCode`.                                                  |
