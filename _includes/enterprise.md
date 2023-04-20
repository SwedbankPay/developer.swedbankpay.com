{% capture documentation_section_url %}{% include utils/documentation-section-url.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}

## Enterprise

{% include jumbotron.html body="When the payer is identified and
authenticated by the merchant, the payer's identity can be included in the
Payment Order request." %}

**Delegated Strong Customer Authentication** (hereby abbreviated as "Delegated
SCA") is performed as an alternative to `Checkin` when creating the
Payment Order upon the initialization of the `Payment Menu`. You
can only use Delegated SCA if you have an agreement with Swedbank Pay. The
additional `nationalIdentifier` field described below should be added to the
`paymentorder.payer` object already in the Payment Order creation request, as an
alternative to `consumerProfileRef`.

{% include alert.html type="warning" icon="warning" header="Bank ID
authentication required" body="In order to use the Enterprise feature, you
need a **legal agreement with Swedbank Pay** which mandates that the payer
identified by the `nationalIdentifier` is authenticated with **Bank ID** prior
to the request." %}

An abbreviated example of an **Enterprise** request looks like this:

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
| {% icon check %} | {% f paymentOrder, 0 %}                   | `object` | The payment order object.                                                                            |
|                  | {% f payer %}                  | `object` | The `payer` object containing information about the payer relevant for the payment order.            |
|                  | {% f nationalIdentifier, 2 %}    | `string` | The national identifier object.                                                                      |
|                  | {% f socialSecurityNumber, 3 %} | `string` | The payer's social security number. Must be part of what you get from your authentication process. |
|                  | {% f countryCode, 3 %}          | `string` | The country code of the payer.                                                                     |

When the payer is authenticated by the merchant, some payment instruments
will allow a more frictionless payment process. Invoice One-Click Payments does
not require the last 4/5 digits of the payer's social security number (SSN),
for instance.

Below you can see an example of the payment window with and without Enterprise. In the
first image, the SSN is removed altogether because the payer is authenticated by
the merchant. In the bottom image, the last 4/5 digits of the SSN are required.

{:.text-center}
![One-Click Payments without SSN][enterprise-no-ssn]{:width="475" height="385"}

{:.text-center}
![Payments with SSN][enterprise-with-ssn]{:width="475" height="460"}

[checkin]: {{ documentation_section_url }}/checkin
[payment-menu]: {{ documentation_section_url }}/payment-menu-v2
[enterprise-no-ssn]: /assets/img/checkout/enterprise-no-ssn.png
[enterprise-with-ssn]: /assets/img/checkout/enterprise-with-ssn.png
