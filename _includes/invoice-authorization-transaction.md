## Create Invoice Authorization Transaction

The `redirect-authorization` operation redirects the payer to Swedbank Pay
Payments where the payment is authorized.

{% capture request_header %}POST /psp/invoice/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "activity": "FinancingConsumer"
    },
    "consumer": {
        "socialSecurityNumber": "{{ page.consumer_ssn_no }}",
        "customerNumber": "123456",
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
|     Required     | Field                          | Type     | Description                                                            |
| :--------------: | :----------------------------- | :------- | :--------------------------------------------------------------------- |
| {% icon check %} | `transaction`                  | `object` | The transaction object.                                                |
|                  | {% f activity %}             | `string` | Only the value `"FinancingConsumer"` or `"AccountsReceivableConsumer"` |
|                  | `consumer`                     | `object` | The payer object.                                                   |
|                  | {% f socialSecurityNumber %} | `string` | The social security number of the payer.                            |
|                  | {% f customerNumber %}       | `string` | Customer number of the payer.                                       |
|                  | {% f email %}                | `string` | The customer email address.                                            |
|                  | {% f msisdn %}               | `string` | The MSISDN of the payer.                                            |
|                  | {% f ip %}                   | `string` | The IP address of the payer.                                        |
|                  | `legalAddress`                 | `object` | The Address object.                                                    |
|                  | {% f addressee %}            | `string` | The full name of the addressee of this invoice                         |
|                  | {% f coAddress %}            | `string` | The co Address of the addressee.                                       |
|                  | {% f streetAddress %}        | `string` | The street address of the addresse. Maximum 50 characters long.        |
|                  | {% f zipCode %}              | `string` | The zip code of the addresse.                                          |
|                  | {% f city %}                 | `string` | The city name  of the addresse.                                        |
|                  | {% f countryCode %}          | `string` | The country code of the addresse.                                      |
|                  | `billingAddress`               | `object` | The BillingAddress object for the billing address of the addresse.     |
|                  | {% f addressee %}            | `string` | The full name of the billing address adressee.                         |
|                  | {% f coAddress %}            | `string` | The co address of the billing address adressee.                        |
|                  | {% f streetAddress %}        | `string` | The street address of the billing address adressee. Maximum 50 characters long.|
|                  | {% f zipCode %}              | `string` | The zip code of the billing address adressee.                          |
|                  | {% f city %}                 | `string` | The city name of the billing address adressee.                         |
|                  | {% f countryCode %}          | `string` | The country code of the billing address adressee.                      |
{% endcapture %}
{% include accordion-table.html content=table %}

## Invoice Authorization Response

{% capture response_content %}{
    "payment": "/psp/invoice/payments/{{ page.payment_id }}",
    "authorization": {
        "id": "/psp/invoice/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id }}",
        "consumer": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/consumer"
        },
        "legalAddress": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/legaladdress"
        },
        "billingAddress": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/billingaddress"
        },
        "transaction": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Authorization",
            "state": "Failed",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456",
            "failedReason": "ExternalResponseError",
            "failedActivityName": "Authorize",
            "failedErrorCode": "ThirdPartyErrorCode",
            "failedErrorDescription": "ThirdPartyErrorMessage",
            "isOperational": "TRUE",
            "activities": {
                "id": "/psp/invoice/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}/activities"
            },
            "operations": [
                {
                    "href": "{{ page.api_url }}/psp/invoice/payments/{{ page.payment_id }}",
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

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type      | Description                                                                                                                                                                                                  |
| :----------------------- | :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}                | `string`  | {% include fields/id.md sub_resource="authorization" %}                                                                                                                                           |
| {% f authorization, 0 %}          | `object`  | The transaction object.                                                                                                                                                                                      |
| {% f id %}             | `string`  | {% include fields/id.md resource="authorization" %}                                                                                                                                               |
| {% f created %}        | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                              |
| {% f updated %}        | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                              |
| {% f type %}           | `string`  | Indicates the transaction type.                                                                                                                                                                              |
| {% f state %}          | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                              |
| {% f number %}         | `integer` | {% include fields/number.md %} |
| {% f amount %}         | `integer` | {% include fields/amount.md %}                                                                                                                                                                    |
| {% f vatAmount %}      | `integer` | {% include fields/vat-amount.md %}                                                                                                                                                                 |
| {% f description %}    | `string`  | {% include fields/description.md %}                                                                                                                               |
| {% f payeeReference %} | `string(30)`  | {% include fields/payee-reference.md describe_receipt=true %}                                                                                                     |
| {% f failedReason %}   | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                    |
| {% f isOperational %}  | `bool`    | `true` if the transaction is operational; otherwise `false`.                                                                                                                                                 |
| {% f operations %}     | `array`   | {% include fields/operations.md resource="transaction" %}                                                                                                                |
{% endcapture %}
{% include accordion-table.html content=table %}

The `authorization` resource contains information about an authorization
transaction made towards a payment, as previously described.
