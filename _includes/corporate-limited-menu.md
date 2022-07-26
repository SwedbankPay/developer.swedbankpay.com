{% capture documentation_section %}{%- include documentation-section.md -%}{% endcapture %}
{% assign features_url = documentation_section | prepend: '/' | append: '/features' %}

## Corporate Limited Menu

Corporate Limited Menu allows you to limit what payment instruments shows up
when your customers pays through the menu. Do note that both the instrument in
question needs to support corporate payment methods and have the feature
enabled during the contract setup to be shown in the menu.

Do note that if you were to not invoke the restriction, every valid payment
method will show up as usual in the payment menu. Only when you restrict the
payment menu to corporate-supported instruments AND have instruments set to
be restricted will other instruments be hidden.

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
        "language": "sv-SE",{% if documentation_section == "payment-menu" %}
        "instrument": null,{% endif %}
        "corporateMode": "false",
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "completeUrl": "https://example.com/payment-completed",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditoons.pdf",
            "logoUrl": "https://example.com/logo.png"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832"
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
| {% icon check %} | └➔&nbsp;`instrument`               | `string`     | The payment instrument used. Selected by using the {% if documentation_section == "payment-menu" %}[Instrument Mode]({{ features_url }}/optional/instrument-mode){% else %}Instrument Mode{% endif %}.                                                                                                   |
| {% icon check %} | └➔&nbsp;`userAgent`                | `string`     | {% include field-description-user-agent.md %}                                                                                                                                                                                                                                                                             |
| {% icon check %} | └➔&nbsp;`language`                 | `string`     | The language of the payer.                                                                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`corporateMode`                 | `bool`     | Determines if the menu should only show instruments that supports corporate payment methods and has been enabled in your contracts.                                                                                                                                                                                                                                                                            |
| {% icon check %} | └➔&nbsp;`urls`                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | └─➔&nbsp;`hostUrls`                | `array`      | The array of URLs valid for embedding of Swedbank Pay Seamless Views.                                                                                                                                                                                                                                    |
| {% icon check %} | └─➔&nbsp;`completeUrl`             | `string`     | The URL that Swedbank Pay will redirect back to when the payer has completed their interactions with the payment. This does not indicate a successful payment, only that it has reached a final (complete) state. A `GET` request needs to be performed on the payment order to inspect it further. See [`completeUrl`][complete-url] for details.  |
| {% icon check %} | └─➔&nbsp;`callbackUrl`             | `string`     | The URL to the API endpoint receiving `POST` requests on transaction activity related to the payment order.                                                                                                                                                                                              |
| {% icon check %} | └─➔&nbsp;`termsOfServiceUrl`       | `string`     | {% include field-description-termsofserviceurl.md %}                                                                                                                                                                                                                                                     |
| {% icon check %} | └─➔&nbsp;`logoUrl`                 | `string`     | {% include field-description-logourl.md %}                                                                                                                                                                                                                                                               |
| {% icon check %} | └➔&nbsp;`payeeInfo`                | `string`     | {% include field-description-payeeinfo.md %}                                                                                                                                                                                                                                                             |
| {% icon check %} | └─➔&nbsp;`payeeId`                 | `string`     | The ID of the payee, usually the merchant ID.                                                                                                                                                                                                                                                            |
| {% icon check %} | └─➔&nbsp;`payeeReference`          | `string(30)` | {% include field-description-payee-reference.md describe_receipt=true %}                                                                                                                                                                                                                                 |

[complete-url]: /{{ documentation_section }}/features/technical-reference/complete-url
