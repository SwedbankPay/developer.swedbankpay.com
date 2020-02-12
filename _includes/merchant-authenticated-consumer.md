## Merchant Authenticated Consumer

{% include jumbotron.html body="When the consumer is identified and
authenticated by the merchant, the consumer's identity can be included in the
Payment Order request." %}

**Merchant Authenticated Consumer** is performed as an alternative to
[Checkin][checkin] when creating the Payment Order upon the initializaiont of
the [Payment Menu][payment-menu]. You can use Merchant Authenticated Consumer
only if you have an agreement with Swedbank Pay. The additional
`nationalIdentifier` property described below should be added to the
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
| Required | Property                         | Type     | Description                                                                                          |
| :------: | :------------------------------- | :------- | :--------------------------------------------------------------------------------------------------- |
|  ✔︎︎︎︎︎  | `paymentorder`                   | `object` | The payment order object.                                                                            |
|          | └➔&nbsp;`payer`                  | `object` | The `payer` object containing information about the payer relevant for the payment order.            |
|          | └─➔&nbsp;`nationalIdentifier`    | `string` | The national identifier object.                                                                      |
|          | └──➔&nbsp;`socialSecurityNumber` | `string` | The consumers social security number. Must be part of what you get from your authentication process. |
|          | └──➔&nbsp;`countryCode`          | `string` | The countrycode of the consumer.                                                                     |

[checkin]: /checkout/checkin
[payment-menu]: /checkout/payment-menu
