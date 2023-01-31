{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

## Prices

The `prices` resource lists the prices related to a specific payment. In short,
it is where you enter the payment's amount. It consists of the payment's `id`
and the `priceList`, which again contains the payment's `type`, `amount` and
`vatAmount`.

 The `type` refers to the payment instrument, like `Swish`, `Trustly` or
 `Creditcard`. Read more about the types below the code example and table. The
 `amount` refers to the **full** amount (incl. VAT) for the payment, and
 `vatAmount` indicates how much of the full amount which is VAT.

## GET Prices Request

{:.code-view-header}
**Request**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/prices/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json
```

## GET Prices Response

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
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
}
```

{% capture collapsible_table %}
{:.table .table-striped}
| Field                | Type      | Description                                                                                                                                                                                 |
| :------------------- | :-------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `payment`            | `string`  | {% include field-description-id.md sub_resource="prices" %}                                                                                                                                 |
| `prices`             | `object`  | The `prices`  resource.                                                                                                                                                                     |
| └➔&nbsp;`id`         | `string`  | {% include field-description-id.md resource="prices" %}                                                                                                                                     |
| └➔&nbsp;`priceList`  | `array`   | The array of price objects. **Note:** Even if you specify  `CreditCard`  in the input message the system will return all your configured card brands instead when you expan the priceList. |
| └─➔&nbsp;`type`      | `string`  | The type of the price object.                                                                                                                                                               |
| └─➔&nbsp;`amount`    | `integer` | {% include field-description-amount.md %}                                                                                                                                                   |
| └─➔&nbsp;`vatAmount` | `integer` | {% include field-description-vatamount.md %}                                          |
{% endcapture %}
{% include accordion-table.html content = collapsible_table %}

## Prices Object Types

Each payment instrument have one or more prices object types. Usually there is
only one, whichs corresponds with the name of the payment instrument, like
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

{% capture collapsible_table %}
{:.table .table-striped}
| Type            | Description                                |
| :-------------- | :----------------------------------------- |
| `Creditcard`    | Enables all brands activated for merchant  |
| `Visa`          | Visa                                       |
| `MasterCard`    | MasterCard                                 |
| `Amex`          | American Express                           |
| `Dankort`       | Dankort (only available with currency DKK) |
| `Diners`        | Diners Club                                |
| `Finax`         | Finax                                      |
| `Jcb`           | JCB                                        |
| `IkanoFinansDK` | Ikano Finans Denmark                       |
| `Maestro`       | MasterCard Maestro                         |
{% endcapture %}
{% include accordion-table.html content = collapsible_table %}

{% when "invoice" %}

## Invoice Payments

{% capture collapsible_table %}
{:.table .table-striped}
| Type      | Description    |
| :-------- | :------------- |
| `Invoice` | Always Invoice |
{% endcapture %}
{% include accordion-table.html content = collapsible_table %}

{% when "mobilepay" %}

## MobilePay Online Payments

{% capture collapsible_table %}
{:.table .table-striped}
| Type        | Description      |
| :---------- | :--------------- |
| `Mobilepay` | Always MobilePay |
{% endcapture %}
{% include accordion-table.html content = collapsible_table %}

{% when "swish" %}

## Swish Payments

{% capture collapsible_table %}
{:.table .table-striped}
| Type    | Description  |
| :------ | :----------- |
| `Swish` | Always Swish |
{% endcapture %}
{% include accordion-table.html content = collapsible_table %}

{% when "vipps" %}

## Vipps Payments

{% capture collapsible_table %}
{:.table .table-striped}
| Type    | Description  |
| :------ | :----------- |
| `Vipps` | Always Vipps |
{% endcapture %}
{% include accordion-table.html content = collapsible_table %}

{% endcase %}
