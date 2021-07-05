{% capture documentation_section_url %}{% include documentation-section-url.md %}{% endcapture %}

## Merchant Authenticated Consumer

{% include jumbotron.html body="When the payer is identified and
authenticated by the merchant, the payer's identity can be included in the
Payment Order request." %}

{% if documentation_section != 'checkout/v3/basic' %}
**Merchant Authenticated
Consumer** (hereby abbreviated as "MAC") is performed as an alternative to
[Checkin][checkin] when creating the Payment Order upon the initialization of
the [Payment Menu][payment-menu]. You can only use MAC if you have an agreement
with Swedbank Pay. The additional `nationalIdentifier` field described below
should be added to the `paymentorder.payer` object already in the Payment Order
creation request, as an alternative to `consumerProfileRef`.
{% else %}
**Merchant Authenticated Consumer** (hereby abbreviated as "MAC") is
performed as an alternative to `Checkin` when creating the Payment Order upon
the initialization of the `Payment Menu`. You can only use MAC if you have an
agreement with Swedbank Pay. The additional `nationalIdentifier` field described
below should be added to the `paymentorder.payer` object already in the Payment
Order creation request, as an alternative to `consumerProfileRef`.
{% endif %}

{% include alert.html type="warning" icon="warning" header="Bank ID
authentication required" body="In order to use the MAC feature, you
need a **legal agreement with Swedbank Pay** which mandates that the payer
identified by the `nationalIdentifier` is authenticated with **Bank ID** prior
to the request." %}

An abbreviated example of a MAC request looks like this:

{:.code-view-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "paymentorder": {
        "payer": {
            "nationalIdentifier": {
                "socialSecurityNumber": "{{ page.consumer_ssn_se }}",
                "countryCode": "SE"
            }
        }
    }
}
```

{:.table .table-striped}
|     Required     | Field                            | Type     | Description                                                                                          |
| :--------------: | :------------------------------- | :------- | :--------------------------------------------------------------------------------------------------- |
| {% icon check %} | `paymentorder`                   | `object` | The payment order object.                                                                            |
|                  | └➔&nbsp;`payer`                  | `object` | The `payer` object containing information about the payer relevant for the payment order.            |
|                  | └─➔&nbsp;`nationalIdentifier`    | `string` | The national identifier object.                                                                      |
|                  | └──➔&nbsp;`socialSecurityNumber` | `string` | The payer's social security number. Must be part of what you get from your authentication process. |
|                  | └──➔&nbsp;`countryCode`          | `string` | The country code of the payer.                                                                     |

When the payer is authenticated by the merchant, some payment instruments
will allow a more frictionless payment process. Invoice One-Click Payments does
not require the last 4/5 digits of the payer's social security number (SSN),
for instance.

Below you can see an example of the payment window with and without MAC. In the
first image, the SSN is removed altogether because the payer is authenticated by
the merchant. In the bottom image, the last 4/5 digits of the SSN are required.

{:.text-center}
![One-Click Payments without SSN][mac-no-ssn]{:width="475" height="385"}

{:.text-center}
![Payments with SSN][mac-with-ssn]{:width="475" height="460"}

[checkin]: {{ documentation_section_url }}/checkin
[payment-menu]: {{ documentation_section_url }}/payment-menu
[mac-no-ssn]: /assets/img/checkout/mac-no-ssn.png
[mac-with-ssn]: /assets/img/checkout/mac-with-ssn.png
