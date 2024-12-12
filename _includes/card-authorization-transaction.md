{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

## Card Authorization Transaction

The `authorization` resource contains information about an authorization
transaction made towards a payment. To create a new `authorization` transaction,
perform a `POST` towards the URL obtained from the `payment.authorization.id`
from the `payment` resource below. The example is abbreviated for brevity.

## GET Authorization Request

{% capture request_header %}GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/ HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

## GET Authorization Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
        "authorizations": {
            "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

## Authorization Request

{% capture request_header %}POST /psp/creditcard/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "cardNumber": "4925000000000004",
        "cardExpiryMonth": "12",
        "cardExpiryYear": "22",
        "cardVerificationCode": "749",
        "cardholderName": "Olivia Nyhuus",
        "chosenCoBrand": "Visa"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

## Authorization Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/creditcard/payments/{{ page.payment_id }}",
    "authorization": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id }}",
        "paymentToken": "{{ page.payment_token }}",
        "recurrenceToken": "{{ page.payment_id }}",
        "maskedPan": "123456xxxxxx1234",
        "expiryDate": "mm/yyyy",
        "panToken": "{{ page.transaction_id }}",
        "cardBrand": "Visa",
        "cardType": "Credit",
        "issuingBank": "UTL MAESTRO",
        "countryCode": "999",
        "acquirerTransactionType": "3DSECURE",
        "issuerAuthorizationApprovalCode": "397136",
        "acquirerStan": "39736",
        "acquirerTerminalId": "39",
        "acquirerTransactionTime": "2017-08-29T13:42:18Z",
        "authenticationStatus": "Y",
        "nonPaymentToken": "",
        "externalNonPaymentToken": "",
        "transaction": {
            "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Authorization",
            "state": "Initialized",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456",
            "failedReason": "ExternalResponseError",
            "failedActivityName": "Authorize",
            "failedErrorCode": "REJECTED_BY_ACQUIRER",
            "failedErrorDescription": "General decline, response-code: 05",
            "isOperational": "TRUE",
            "activities": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}/activities" },
            "operations": [
                {
                    "href": "https://api.payex.com/psp/creditcard/payments/{{ page.payment_id }}",
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

{:.table .table-striped}
|     Required     | Field                          | Type      | Description                                                                     |
| :--------------: | :----------------------------- | :-------- | :------------------------------------------------------------------------------ |
| {% icon check %} | `transaction`                  | `object`  | The transaction object.                                                         |
| {% icon check %} | {% f cardNumber %}           | `string`  | Primary Account Number (PAN) of the card, printed on the face of the card.      |
| {% icon check %} | {% f cardExpiryMonth %}      | `integer` | Expiry month of the card, printed on the face of the card.                      |
| {% icon check %} | {% f cardExpiryYear %}       | `integer` | Expiry year of the card, printed on the face of the card.                       |
|                  | {% f cardVerificationCode %} | `string`  | Card verification code (CVC/CVV/CVC2), usually printed on the back of the card. |
|                  | {% f cardholderName %}       | `string`  | Name of the cardholder, usually printed on the face of the card.               |

{% capture table %}
{:.table .table-striped .mb-5}
| Field                             | Type      | Description                                                                                                                                                                                                                                                                                          |
| :-------------------------------- | :-------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f payment, 0 %}                         | `object`  | The payment object.                                                                                                                                                                                                                                                                                  |
| {% f authorization, 0 %}                   | `object`  | The authorization object.                                                                                                                                                                                                                                                                            |
| {% f direct %}                  | `string`  | The type of the authorization.                                                                                                                                                                                                                                                                       |
| {% f cardBrand %}               | `string`  | `Visa`, `MC`, etc. The brand of the card.                                                                                                                                                                                                                                                            |
| {% f cardType %}                | `string`  | `Credit Card` or `Debit Card`. Indicates the type of card used for the authorization.                                                                                                                                                                                                                |
| {% f issuingBank %}             | `string`  | The name of the bank that issued the card used for the authorization.                                                                                                                                                                                                                                |
| {% f paymentToken %}            | `string`  | The payment token created for the card used in the authorization.                                                                                                                                                                                                                                    |
| {% f maskedPan %}               | `string`  | The masked PAN number of the card.                                                                                                                                                                                                                                                                   |
| {% f expiryDate %}              | `string`  | The month and year of when the card expires.                                                                                                                                                                                                                                                         |
| {% f panToken %}                | `string`  | The token representing the specific PAN of the card.                                                                                                                                                                                                                                                 |
| {% f panEnrolled %}             | `string`  |                                                                                                                                                                                                                                                                                                      |
| {% f acquirerTransactionTime %} | `string`  | The ISO-8601 date and time of the acquirer transaction.                                                                                                                                                                                                                                 |
| {% f id %}                      | `string`  | {% include fields/id.md resource="itemDescriptions" %}                                                                                                                                                                                                                                    |
| {% f nonPaymentToken %}         | `string`  | The result of our own card tokenization. Activated in POS for the merchant or merchant group.                                                                                                                                                                                                    |
| {% f externalNonPaymentToken %} | `string`  | The result of an external tokenization. This value will vary depending on card types, acquirers, customers, etc. For Mass Transit merchants, transactions redeemed by Visa will be populated with PAR. For Mastercard and Amex, it will be our own token.                                                                                                                                                                 |
| {% f transaction %}             | `object`  | {% include fields/transaction.md %}                                                                                                                                                                                                                        |
| {% f id, 2 %}                     | `string`  | {% include fields/id.md resource="transaction" %}                                                                                                                                                                                                                                         |
| {% f created, 2 %}                | `string`  | The ISO-8601 date and time of when the transaction was created.                                                                                                                                                                                                                                      |
| {% f updated, 2 %}                | `string`  | The ISO-8601 date and time of when the transaction was updated.                                                                                                                                                                                                                                      |
| {% f type, 2 %}                   | `string`  | Indicates the transaction type.                                                                                                                                                                                                                                                                      |
| {% f state, 2 %}                  | `string`  | `Initialized`, `Completed` or `Failed`. Indicates the state of the transaction.                                                                                                                                                                                                                      |
| {% f number, 2 %}                 | `integer` | {% include fields/number.md %}                                                                                         |
| {% f amount, 2 %}                 | `integer` | Amount is entered in the lowest monetary unit of the selected currency. E.g. `10000` = 100.00 NOK, `5000` = 50.00 SEK.                                                                                                                                                                             |
| {% f vatAmount, 2 %}              | `integer` | If the amount given includes VAT, this may be displayed for the user on the payment page (redirect only). Set to 0 (zero) if this is not relevant.                                                                                                                                                   |
| {% f description, 2 %}            | `string`  | {% include fields/description.md %}                                                                                                                                                                                                                          |
| {% f payeeReference, 2 %}         | `string`  | {% include fields/payee-reference.md %}                                                                                                                                                                                                                      |
| {% f failedReason, 2 %}           | `string`  | The human readable explanation of why the payment failed.                                                                                                                                                                                                                                            |
| {% f isOperational, 2 %}          | `bool`    | `true` if the transaction is operational; otherwise `false`.                                                                                                                                                                                                                                         |
| {% f operations, 2 %}             | `array`   | {% include fields/operations.md resource="transaction" %}                                                                                                                                                                                                        |
{% endcapture %}
{% include accordion-table.html content=table %}
