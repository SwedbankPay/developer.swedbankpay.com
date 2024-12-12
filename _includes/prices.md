{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

## Prices

The `prices` resource lists the prices related to a specific payment. In short,
it is where you enter the payment's amount. It consists of the payment's `id`
and the `priceList`, which again contains the payment's `type`, `amount` and
`vatAmount`.

 The `type` refers to the payment method, like `Swish`, `Trustly` or
 `Creditcard`. Read more about the types below the code example and table. The
 `amount` refers to the **full** amount (incl. VAT) for the payment, and
 `vatAmount` indicates how much of the full amount which is VAT.

## GET Prices Request

{% capture request_content %}GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/prices/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

## GET Prices Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "prices": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/prices",
        "priceList": [
            {
                "type": "VISA",
                "amount": 2350,
                "vatAmount": 0
            },
            {
                "type": "MasterCard",
                "amount": 2350,
                "vatAmount": 0
            }
        ]
    }
}{% endcapture %}

    {% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{:.table .table-striped}
| Field                | Type      | Description                                                                                                                                                                                 |
| :------------------- | :-------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% f payment, 0 %}            | `string`  | {% include fields/id.md sub_resource="prices" %}                                                                                                                                 |
| {% f prices, 0 %}             | `object`  | The `prices` resource.                                                                                                                                                                     |
| {% f id %}         | `string`  | {% include fields/id.md resource="prices" %}                                                                                                                                     |
| {% f priceList %}  | `array`   | The array of price objects. **Note:** Even if you specify  `CreditCard`  in the input message the system will return all your configured card brands instead when you expan the priceList. |
| {% f type, 2 %}      | `string`  | The type of the price object.                                                                                                                                                               |
| {% f amount, 2 %}    | `integer` | {% include fields/amount.md %}                                                                                                                                                   |
| {% f vatAmount, 2 %} | `integer` | {% include fields/vat-amount.md %}                                          |

## Prices Object Types

Each payment method have one or more prices object types. Usually there is
only one, whichs corresponds with the name of the payment method, like
`Vipps`, `Swish` or `Mobilepay`.

The most common occurrence of several object types is for card payments. While it
is possible to group them all as `Creditcard`, you can also differentiate on
card types as shown in the example above. This is useful if certain card brands
have additional fees, others have discounts or something similar. If you do
differentiate, you need to add all accepted card brands as a separate object
types.

{% case api_resource %}

{% when "creditcard" %}

#### Card Payments

{:.table .table-striped}
| Type            | Description                                |
| :-------------- | :----------------------------------------- |
| {% f Creditcard, 0 %}    | Enables all brands activated for merchant  |
| {% f Visa, 0 %}          | Visa                                       |
| {% f MasterCard, 0 %}    | MasterCard                                 |
| {% f Amex, 0 %}          | American Express                           |
| {% f Dankort, 0 %}       | Dankort (only available with currency DKK) |
| {% f Maestro, 0 %}       | MasterCard Maestro                         |

{% when "invoice" %}

## Invoice Payments

{:.table .table-striped}
| Type      | Description    |
| :-------- | :------------- |
| {% f Invoice, 0 %} | Always Invoice |

{% when "mobilepay" %}

## MobilePay Online Payments

{:.table .table-striped}
| Type        | Description      |
| :---------- | :--------------- |
| {% f Mobilepay, 0 %} | Always MobilePay |

{% when "swish" %}

## Swish Payments

{:.table .table-striped}
| Type    | Description  |
| :------ | :----------- |
| {% f Swish, 0 %} | Always Swish |

{% when "vipps" %}

## Vipps Payments

{:.table .table-striped}
| Type    | Description  |
| :------ | :----------- |
| {% f Vipps, 0 %} | Always Vipps |

{% endcase %}
