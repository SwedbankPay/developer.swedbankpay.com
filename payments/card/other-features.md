---
title: Swedbank Pay Card Payments – Other Features
sidebar:
  navigation:
  - title: Card Payments
    items:
    - url: /payments/card/
      title: Introduction
    - url: /payments/card/redirect
      title: Redirect
    - url: /payments/card/seamless-view
      title: Seamless View
    - url: /payments/card/direct
      title: Direct
    - url: /payments/card/capture
      title: Capture
    - url: /payments/card/mobile-card-payments
      title: Mobile Card Payments
    - url: /payments/card/after-payment
      title: After Payment
    - url: /payments/card/other-features
      title: Other Features
---

{% include jumbotron.html body="Welcome to Other Features - a subsection of
Credit Card. This section has extented code examples and features that were not
covered by the other subsections." %}

{% include payment-resource.md api_resource="creditcard"
documentation_section="card" show_status_operations=true %}

{% include payments-operations.md api_resource="creditcard" documentation_section="card" %}

{% include payment-transaction-states.md %}

{% include create-payment.md %}

## Purchase

A `Purchase` payment is a straightforward way to charge the card of the payer.
It is followed up by posting a `capture`, `cancellation` or `reversal` transaction.

An example of a request is provided below. Each individual field of the JSON
document is described in the following section.

{% include alert-risk-indicator.md %}

{% include card-purchase.md full_reference=true %}

{% include complete-url.md %}

{% include description.md %}

{% include recur.md %}

{% include unscheduled-purchase.md %}

{% include payout.md %}

{% include verify.md %}

{% include one-click-payments.md %}

{% include payment-url.md api_resource="card" documentation_section="card"
when="at the 3-D Secure verification for credit card payments" full_reference=true %}

{% include callback-reference.md api_resource="creditcard" %}

{% include payment-link.md %}

{% include card-authorization-transaction.md %}

{% include payee-info.md api_resource="creditcard" documentation_section="card" %}

{% include prices.md %}

## 3-D Secure 2

When dealing with card payments, 3-D Secure authentication of the
cardholder is an essential topic. 3-D Secure 2 is an improved version of the
old protocol, now allowing frictionless payments where transactions can be
completed without input from the cardholder. Therefore, there are certain fields
that should be included when implementing 3-D Secure 2. These are listed below
and can be seen in the abbreviated request example below.

{:.code-header}
**Request**

```http
POST /psp/creditcard/payments HTTP/1.1
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Purchase",
        "intent": "Authorization",
        "currency": "SEK",
        "description": "Test Purchase",
        "urls": {
            "hostUrls": ["https://example.com"]
        },
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
        },
        "riskIndicator": {
            "deliveryEmailAddress": "olivia.nyhuus@payex.com",
            "deliveryTimeFrameIndicator": "01",
            "preOrderDate": "19801231",
            "preOrderPurchaseIndicator": "01",
            "shipIndicator": "01",
            "giftCardPurchase": false,
            "reOrderPurchaseIndicator": "01"
        }
    }
}
```

{:.table .table-striped}
| Field                                 | Type     | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|:--------------------------------------|:---------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `payment`                             | `object` | The payment object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| └➔&nbsp;`cardholder`                  | `object` | Cardholder object that can hold information about a buyer (private or company). The information added increases the chance for [frictionless 3-D Secure 2 flow][3ds2].                                                                                                                                                                                                                                                                                                                                                                                           |
| └➔&nbsp;`firstname`                   | `string` | Payer's first name.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| └➔&nbsp;`lastname`                    | `string` | Payer's last name.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| └➔&nbsp;`email`                       | `string` | Payer's registered email address. The field is related to [3-D Secure 2][3ds2].                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| └➔&nbsp;`msisdn`                      | `string` | Payer's registered mobile phone number. The field is related to [3-D Secure 2][3ds2].                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| └➔&nbsp;`homePhoneNumber`             | `string` | Payer's registered home phone number. The field is related to [3-D Secure 2][3ds2]                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| └➔&nbsp;`workPhoneNumber`             | `string` | Payer's registered work phone number. The field is related to [3-D Secure 2][3ds2].                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| └─➔&nbsp;`shippingAddress`            | `object` | The shipping address object related to the `payer`. The field is related to [3-D Secure 2][3ds2].                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| └─➔&nbsp;`addresse`                   | `string` | The name of the addressee – the receiver of the shipped goods.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| └─➔&nbsp;`coAddress`                  | `string` | Payer' s c/o address, if applicable.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| └─➔&nbsp;`streetAddress`              | `string` | Payer's street address                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| └─➔&nbsp;`zipCode`                    | `string` | Payer's zip code                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| └─➔&nbsp;`city`                       | `string` | Payer's city of residence                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| └─➔&nbsp;`countryCode`                | `string` | Country Code for country of residence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| └➔&nbsp;`riskIndicator`               | `object` | This object consist of information that helps verifying the payer. Providing these fields decreases the likelihood of having to promt for [3-D Secure authentication][3ds2] of the payer when they are authenticating the purchase.                                                                                                                                                                                                                                                                                                                              |
| └─➔&nbsp;`deliveryEmailAdress`        | `string` | For electronic delivery, the email address to which the merchandise was delivered. Providing this field when appropriate decreases the likelyhood of a 3-D Secure authentication for the payer.                                                                                                                                                                                                                                                                                                                                                                  |
| └─➔&nbsp;`deliveryTimeFrameIndicator` | `string` | ndicates the merchandise delivery timeframe. <br>`01` (Electronic Delivery) <br>`02` (Same day shipping) <br>`03` (Overnight shipping) <br>`04` (Two-day or more shipping).                                                                                                                                                                                                                                                                                                                                                                                      |
| └─➔&nbsp;`preOrderDate`               | `string` | For a pre-ordered purchase. The expected date that the merchandise will be available. Format: `YYYYMMDD`.                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| └─➔&nbsp;`preOrderPurchaseIndicator`  | `string` | Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br>`01` (Merchandise available) <br>`02` (Future availability).                                                                                                                                                                                                                                                                                                                                                                                     |
| └─➔&nbsp;`shipIndicator`              | `string` | Indicates shipping method chosen for the transaction. <br>`01` (Ship to cardholder's billing address) <br>`02` (Ship to another verified address on file with merchant)<br>`03` (Ship to address that is different than cardholder's billing address)<br>`04` (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)<br>`05` (Digital goods, includes online services, electronic giftcards and redemption codes) <br>`06` (Travel and Event tickets, not shipped) <br>`07` (Other, e.g. gaming, digital service) |
| └─➔&nbsp;`giftCardPurchase`           | `bool`   | `true` if this is a purchase of a gift card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| └─➔&nbsp;`reOrderPurchaseIndicator`   | `string` | Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br>`01` (Merchandise available) <br>`02` (Future availability).                                                                                                                                                                                                                                                                                                                                                                                     |

## Co-badge Card Choice for Dankort

Due to new [EU regulations from 2016-06-09][eu-regulation] regarding cards that have
more than one payment application, we have developed support for the end users
of Dankort to be able to choose their preferred payment application on the
Swedbank Pay payment page. If you are a Dankort user, read more about this
feature at [Dankort][dankort-eu].

As a merchant you are able to set a priority selection of payment application by
contacting [SwedbankPay Support][swedbankpay-support]. The end user will always
be able to override this priority selection on the payment page.

If you want more information about Co-badge Card Choice for Dankort users please
contact [SwedankPay Support][swedbankpay-support]. The example below shows the
payment window where there payer can choose between Dankort or Visa before
completing the payment.

![Co-badge Dankort cards with option to choose between Dankort and Visa before paying][card-badge]{:height="500px" width="425px"}

{% include settlement-reconciliation.md %}

{% include common-problem-types.md %}

{% include card-problem-messages.md %}

{% include seamless-view-events.md api_resource="creditcard" %}

{% include iterator.html prev_href="after-payment" prev_title="Back: After
payment"  %}

[3ds2]: /payments/card/other-features#3-d-secure-2
[purchase]: #purchase
[user-agent]: https://en.wikipedia.org/wiki/User_agent
[cancel]: /payments/card/after-payment#cancellations
[capture]: /payments/card/capture
[callback]: /payments/card/other-features#callback
[card-badge]: /assets/img/card-badge.png
[dankort-eu]: https://www.dankort.dk/Pages/Dankort-eller-Visa.aspx
[eu-regulation]: https://ec.europa.eu/commission/presscorner/detail/en/MEMO_16_2162
[mcc]: https://en.wikipedia.org/wiki/Merchant_category_code
[price-resource]: /payments/card/other-features#prices
[redirect]: /payments/card/redirect
[hosted-view]: /payments/card/seamless-view
[one-click-payments]: #one-click-payments
[payee-reference]: #payee-reference
[split-settlement]: #split-settlement
[settlement-and-reconciliation]: #settlement-and-reconciliation
[swedbankpay-support]: https://www.swedbankpay.se/support
[recurrence]: #recur
[verify]: #verify
[payout]: #payout
[card-payment]: /assets/img/payments/card-payment.png
