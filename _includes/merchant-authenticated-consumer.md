## Merchant Authenticated Consumer

{% include jumbotron.html body="When the consumer is identified and
authenticated by the merchant, the consumer's identity can be included in the
Payment Order request." %}

**Merchant Authenticated Consumer** is performed as an alternative to
[Checkin][checkin] when creating the Payment Order upon the initializaiont of
the [Payment Menu][payment-menu]. You can use Merchant Authenticated Consumer
only if you have an agreement with Swedbank Pay. The additional
`nationalIdentifier` field described below should be added to the
`paymentorder.payer` object already in the Payment Order creation request, as
an alternative to `consumerProfileRef`.

{% include alert.html type="warning" icon="warning" header="Bank ID
authentication required" body="In order to use the Merchant Authenticated
Consumer feature, you need a **legal agreement with Swedbank Pay** which
mandates that the consumer identified by the `nationalIdentifier` is
authenticated with **Bank ID** prior to the request." %}

An example of how a Merchant Authenticated Consumer request looks like is
provided below (abbreviated for brevity):

{:.code-header}
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
| Required | Field                         | Type     | Description                                                                                          |
| :------: | :------------------------------- | :------- | :--------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `paymentorder`                   | `object` | The payment order object.                                                                            |
|          | └➔&nbsp;`payer`                  | `object` | The `payer` object containing information about the payer relevant for the payment order.            |
|          | └─➔&nbsp;`nationalIdentifier`    | `string` | The national identifier object.                                                                      |
|          | └──➔&nbsp;`socialSecurityNumber` | `string` | The consumers social security number. Must be part of what you get from your authentication process. |
|          | └──➔&nbsp;`countryCode`          | `string` | The countrycode of the consumer.                                                                     |

When the consumer is authenticated by the Merchant, some payment instruments
will allow a more frictionless payment process. Invoice One-Click payments does
not require the last 4/5 digits in the payers social security number (SSN).
Below you can see an example of how the payment window looks like with the
One-Click payment without SSN to the left. And the payer can press the pay
button directly. To the right, the payment window
from the response and request from above with the required SSN number.

![One-Click Payments without SSN][mac-no-ssn]{:width="436" height="393"}
![Payments with SSN][mac-with-ssn]{:width="436" height="393"}

[checkin]: /checkout/checkin
[payment-menu]: /checkout/payment-menu
[mac-no-ssn]: /assets/img/checkout/mac-no-ssn.png
[mac-with-ssn]: /assets/img/checkout/mac-with-ssn.png
