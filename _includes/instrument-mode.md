
{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include documentation-section.md %}{%
endcapture %}

## Instrument Mode

In "Instrument Mode" the Payment Menu will display only one specific payment
instrument instead of all configured on your merchant account. The Payment Order
resource works just like it otherwise would, allowing you to remain largely
indifferent to the payment instrument in use.

If you do not want to use Swedbank Pay Payment Menu or do have multiple payment
providers on your site we strongly recommend that you implement the "Instrument
Mode" functionality. To use this feature you will need to add the `instrument`
field to the request. This will make the  Swedbank Pay Payment Menu only render
a single payment instrument. So even if Swedbank Pay is set up to provide more
than one instrument you will be able to let it only show one at a time.

It is important to use this feature if you want to build your own payment menu.
In this case you should use the `instrument` field to enforce which payment
instrument to show. If you have an agreement with Swedbank Pay for both Card and
Swish/Vipps processing, and the payer chooses either of these instruments, you
should add the `instrument` parameter with the specific payment instrument. If
the payer later changes their mind and chooses the other instrument, you can
make a call to Swedbank Pay to change the instrument on the active payment. This
is important because we do not allow creating multiple payments with the same
`orderReference`. To ensure that you can still use the same `orderReference`,
you should only make one payment for each purchase and change the `instrument`
to reflect what the payer has chosen in your menu.

The Payment Menu is switched to "Instrument Mode" by providing the request field
`instrument` as described in the abbreviated example below.

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
        "instrument": "CreditCard"
        "generateRecurrenceToken": true,{% if include.documentation_section == "payment-menu" %}
        "generatePaymentToken": true,{% endif %}
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
        }
    }
}
```

{:.code-view-header}
**Response**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "paymentorder": {
        "id": "/psp/paymentorders/{{ page.payment_order_id }}",
        "instrument": "CreditCard"{% if include.documentation_section == "payment-menu" %}
        "paymentToken" : "{{ page.payment_token }}",{% endif %}
        "created": "2020-06-22T10:56:56.2927632Z",
        "updated": "2020-06-22T10:56:56.4035291Z",
        "operation": "Purchase",
        "state": "Ready",
        "currency": "SEK",
        "amount": 1500,
        "vatAmount": 375,
        "orderItems": {
            "id": "/psp/paymentorders/{{ page.payment_order_id }}/orderitems"
        }
    }
}
```

It is possible to switch instrument after the `paymentOrder` has been created.
You can do this with the following `PATCH` request, using Swish as an example.

```http
PATCH /psp/{{ include.api_resource }}/paymentorders/{{ page.payment_id }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
  "paymentorder": {
    "operation": "SetInstrument",
    "instrument": "Swish"
  }
}
```

The valid instruments for the `paymentOrder` can be retrieved from the
`availableInstruments` parameter in the `paymentOrder` response. Using a
merchant set up with contracts for `Creditcard`, `Swish` and `Invoice`,
`availableInstruments` will look like this:

```
        "availableInstruments": [
            "CreditCard",
            "Invoice-PayExFinancingSe",
            "Swish"
        ],
```
