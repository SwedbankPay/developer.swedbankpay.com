{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

## List Authorizations

The `authorizations` resource will list the authorization transactions
made on a specific payment.

{% capture request_header %}GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% include transaction-list-response.md transaction="authorization" %}

## Create Authorization Transaction

To create an `authorization` transaction, perform the `create-authorization`
operation as returned in a previously created invoice payment.

{% include alert.html type="informative" icon="info" body="
Note: The legal address must be the registered address of the payer." %}

## Authorization Request

{% capture request_header %}POST /psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "activity": "FinancingConsumer"
    },
    "consumer": {
        "socialSecurityNumber": "socialSecurityNumber",
        "customerNumber": "123456",
        "name": "Olivia Nyhuus",
        "email": "olivia.nyhuus@swedbankpay.com",
        "msisdn": "+4798765432",
        "ip": "127.0.0.1"
    },
    "legalAddress": {
        "addressee": "Olivia Nyhuus",
        "streetAddress": "SaltnesToppen 43",
        "zipCode": "1642",
        "city": "Saltnes",
        "countryCode": "no"
    },
    "billingAddress": {
        "addressee": "Olivia Nyhuus",
        "coAddress": "Bernt Nyhuus",
        "streetAddress": "SaltnesToppen 43",
        "zipCode": "1642",
        "city": "Saltnes",
        "countryCode": "no"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Required          | Field                          | Data type | Description                                                                                                                                                      |
| :---------------- | :----------------------------- | :-------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %}  | `transaction.activity`         | `string`  | `FinancingConsumer`                                                                                                                                              |
| {% icon check %}  | `consumer`                     | `object`  | The payer object.                                                                                                                                             |
| {% icon check %}  | {% f socialSecurityNumber %} | `string`  | The social security number (national identity number) of the payer. Format Sweden: `YYMMDD-NNNN`. Format Norway: `DDMMYYNNNNN`. Format Finland: `DDMMYYNNNNN` |
|                   | {% f customerNumber %}       | `string`  | The customer number in the merchant system.                                                                                                                      |
|                   | {% f email %}                | `string`  | The e-mail address of the payer.                                                                                                                              |
| {% icon check %}  | {% f msisdn %}               | `string`  | The mobile phone number of the payer. Format Sweden: `+46707777777`. Format Norway: `+4799999999`. Format Finland: `+358501234567`                            |
| {% icon check %}  | {% f ip %}                   | `string`  | The IP address of the payer.                                                                                                                                  |
| {% icon check %}  | `legalAddress`                 | `object`  | The legal address object containing information about the payer's legal address.                                                                                |
| {% icon check %}  | {% f addressee %}            | `string`  | The full (first and last) name of the payer.                                                                                                                  |
|                   | {% f coAddress %}            | `string`  | The CO-address (if used)                                                                                                                                         |
|                   | {% f streetAddress %}        | `string`  | The street address of the payer. Maximum 50 characters long.                                                                                                  |
| {% icon check %}  | {% f zipCode %}              | `string`  | The postal code (ZIP code) of the payer.                                                                                                                      |
| {% icon check %}  | {% f city %}                 | `string`  | The city of the payer.                                                                                                                                        |
| {% icon check %}  | {% f countryCode %}          | `string`  | `SE`, `NO`, or `FI`. The country code of the payer.                                                                                                           |
| {% icon check %}  | `billingAddress`               | `object`  | The billing address object containing information about the payer's billing address.                                                                            |
| {% icon check %}  | {% f addressee %}            | `string`  | The full (first and last) name of the payer.                                                                                                                  |
|                   | {% f coAddress %}            | `string`  | The CO-address (if used)                                                                                                                                         |
| {% icon check %}︎︎︎︎ ︎ | {% f streetAddress %}        | `string`  | The street address of the payer. Maximum 50 characters long.                                                                                                   |
| {% icon check %}  | {% f zipCode %}              | `string`  | The postal number (ZIP code) of the payer.                                                                                                                    |
| {% icon check %}  | {% f city %}                 | `string`  | The city of the payer.                                                                                                                                        |
| {% icon check %}  | {% f countryCode %}          | `string`  | `SE`, `NO`, or `FI`.                                                                                                                                             |
{% endcapture %}
{% include accordion-table.html content=table %}

## Authorization Response

The `authorization` resource will be returned, containing information about
the newly created authorization transaction.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "authorization": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id}}",
        "consumer": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/consumer"
        },
        "legalAddress": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/legaladdress"
        },
        "billingAddress": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/billingaddress"
        },
        "transaction": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id}}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Authorization",
            "state": "Initialized",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456",
            "isOperational": false,
            "operations": [
                {
                    "href": "{{ page.api_url }}/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
                    "rel": "edit-authorization",
                    "method": "PATCH"
                }
            ]
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}
