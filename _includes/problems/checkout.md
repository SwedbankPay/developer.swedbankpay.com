{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md fallback="generic" %}{% endcapture %}

## Problems

When performing operations against a resource in the Swedbank Pay API Platform,
it will respond with a problem message that contain details of the error type if
the request could not be successfully performed. Regardless of why the error
occurred, the problem message will follow the same structure as specified in the
[Problem Details for HTTP APIs (RFC 7807)][rfc-7807] specification.

We generally use the problem message `type` and `status` code to identify the
nature of the problem. The `problems` array contains objects with `name` and
`description` that will often help narrow down the specifics of the problem,
usually to the field in the request that was missing or contained invalid data.

The structure of a problem message will look like this:

{:.code-view-header}
**Problem Example**

```json
{
    "type": "https://api.payex.com/psp/errordetail/<resource>/inputerror",
    "title": "There was an input error",
    "detail": "Please correct the errors and retry the request",
    "instance": "{{ page.transaction_id }}",
    "status": 400,
    "problems": [{
        "name": "CreditCardParameters.Issuer",
        "description": "minimum one issuer must be enabled"
    }]
}
```

{:.table .table-striped}
| Field                 | Type      | Description                                                                                                                                                                                                                                         |
| :-------------------- | :-------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `type`                | `string`  | The URL that identifies the error type. This is the **only field usable for programmatic identification** of the type of error! When dereferenced, it might lead you to a human readable description of the error and how it can be recovered from. |
| `title`               | `string`  | The title contains a human readable description of the error.                                                                                                                                                                                       |
| `detail`              | `string`  | A detailed, human readable description of the error and how you can recover from it.                                                                                                                                                                |
| `instance`            | `string`  | The identifier of the error instance. This might be of use to Swedbank Pay support personnel in order to find the exact error and the context it occurred in.                                                                                       |
| `status`              | `integer` | The HTTP status code that the problem was served with.                                                                                                                                                                                              |
| `action`              | `string`  | The `action` indicates how the error can be recovered from.                                                                                                                                                                                         |
| `problems`            | `array`   | The array of problem detail objects.                                                                                                                                                                                                                |
| {% f name %}        | `string`  | The name of the field, header, object, entity or likewise that was erroneous.                                                                                                                                                                       |
| {% f description %} | `string`  | The human readable description of what was wrong with the field, header, object, entity or likewise identified by `name`.                                                                                                                           |

## Common Problems

All common problem types will have a URL in the format
`https://api.payex.com/psp/errordetail/<error-type>`. The **URL is an
identifier** that you can hard-code and implement logic around. It is currently
not not possible to dereference this URL, although that might be possible in the
future.

{:.table .table-striped}
| Type                 | Status | Description                                                                                                                                        |
| :------------------- | :----: | :------------------------------------------------------------------------------------------------------------------------------------------------- |
| `inputerror`         | `400`  | The server cannot or will not process the request due to an apparent client error (e.g. malformed request syntax, size to large, invalid request). |
| `configurationerror` | `403`  | A error relating to configuration issues.   |
| `forbidden`          | `403`  | The request was valid, but the server is refusing the action. The necessary permissions to access the resource might be lacking.                   |
| `notfound`           | `404`  | The requested resource could not be found, but may be available in the future. Subsequent requests are permissible.                                |
| `systemerror`        | `500`  | A generic error message.                 |

## Card Problems

There are a few problems specific to the `creditcard` resource that you may want
to guard against in your integrations. All credit card problem types will have
the following URL structure:

`https://api.payex.com/psp/errordetail/creditcard/<error-type>`

### Contractual Problem Types

{:.table .table-striped}
| Type                           | Status | Description                                                                                                                    |
| :----------------------------- | :----: | :----------------------------------------------------------------------------------------------------------------------------- |
| `cardbranddisabled`            | `403`  | The card brand is disabled.                                                                                                    |
| `accountholdertyperejected`    | `403`  | The account holder type is rejected.                                                                                           |
| `cardtyperejected`             | `403`  | The card type is rejected.                                                                                                     |
| `3dsecurerequired`             | `403`  | The transaction was rejected by 3-D Secure.                                                                                    |
| `authenticationstatusrejected` | `403`  | The authentication status was rejected.                                                                                        |
| `frauddetected`                | `403`  | The transaction was fraudulent.                                                                                                |
| `3dsecuredeclined`             | `403`  | 3-D Secure declined the transaction.                                                                                           |
| `velocitycheck`                | `429`  | Indicates that the limit for how  many times a card or different cards can be used for attempting a purchase has been reached. |

### Acquirer and 3-D Secure Problem Types

{:.table .table-striped}
| Type                           | Status | Description                                                                                   |
| :----------------------------- | :----: | :-------------------------------------------------------------------------------------------- |
| `3dsecureerror`                | `400`  | 3-D Secure is not working. Try again after some time.                                              |
| `badrequest`                   | `400`  | Bad request. Try again after some time.                                                        |
| `cardblacklisted`              | `400`  | The card is blacklisted. The payer needs to contact their card issuing bank.                            |
| `3dsecureusercancelled`        | `403`  | Transaction was cancelled during 3-D Secure verification.                                        |
| `3dsecuredeclined`             | `403`  | Transaction was declined during 3-D Secure verification.                                         |
| `acquirercardblacklisted`      | `403`  | The card is blacklisted. The payer needs to contact their card issuing bank.                            |
| `acquirercardexpired`          | `403`  | The expiry date is wrong, or the card has expired. The payer needs to contact their card issuing bank.   |
| `acquirercardstolen`           | `403`  | The card is blacklisted. The payer needs to contact their card issuing bank.                            |
| `acquirererror`                | `403`  | The acquirer responded with a generic error.                                                  |
| `acquirerinsufficientfunds`    | `403`  | The card does not have sufficient funds. The payer needs to contact their card issuing bank.        |
| `acquirerinvalidamount`        | `403`  | Amount not valid by acquirer. Contact teknisksupport@swedbankpay.com.                                   |
| `acquirerpossiblefraud`        | `403`  | Transaction declined due to possible fraud. The payer needs to contact their card issuing bank. |
| `authenticationrequired`       | `403`  | Transaction declined due to missing 3-D Secure credentials. The payer needs to initiate a new transaction.                         |
| `carddeclined`                 | `403`  | The card was declined.                  |
| `frauddetected`                | `403`  | Fraud detected. The payer needs to contact their card issuing bank.                             |
| `paymenttokenerror`            | `403`  | There was an error with the payment token.                                                    |
| `internalservererror`          | `500`  | Server error. Try again after some time.                                                       |
| `3dsecureacquirergatewayerror` | `502`  | Problems reaching 3-D Secure verification. Try again after some time.                           |
| `acquirergatewayerror`         | `502`  | Problems reaching acquirers gateway. Try again after some time.                                |
| `badgateway`                   | `502`  | Problems reaching the gateway. Try again after some time.                                |
| `acquirergatewaytimeout`       | `504`  | Problems reaching acquirers gateway. Try again after some time.                                |

## Invoice Problems

There are a few problems specific to the `invoice` resource that you may want to
guard against in your integrations. All invoice error types will have the
following URL structure:

`https://api.payex.com/psp/errordetail/invoice/<error-type>`

{:.table .table-striped}
| Type            | Status | Description                       |
| :-------------- | :----: | :-------------------------------- |
| `inputerror`    | `400`  | `10` - `ValidationWarning`        |
| `inputerror`    | `400`  | `30` - `ValidationError`          |
| `inputerror`    | `400`  | `3010` - `ClientRequestInvalid`   |
| `forbidden`     | `403`  | Any other error code              |
| `externalerror` | `500`  | No error code                     |
| `externalerror` | `502`  | `40` - `Error`                    |
| `externalerror` | `502`  | `50` - `SystemConfigurationError` |
| `externalerror` | `502`  | `60` - `SystemError`              |
| `externalerror` | `502`  | `9999` - `ServerOtherServer`      |

## Swish Problems

There are a few problems specific to the `swish` resource that you may want to
guard against in your integrations. All Swish problem types will have the
following URL structure:

`https://api.payex.com/psp/errordetail/<error-type>`

### `bankidalreadyinuse`

Caused By:

-   The payer's BankID is already in use

{:.code-view-header}
Example response bankidalreadyinuse

```http
HTTP/1.1 409 Conflict
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/bankidalreadyinuse",
    "title": "BankID Already in Use",
    "status": 409,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer's BankID is already in use."
}
```

### `bankidcancelled`

Caused By:

-   The payer cancelled BankID authorization.

{:.code-view-header}
Example response bankidcancelled

```http
HTTP/1.1 409 Conflict
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/bankidcancelled",
    "title": "BankID Authorization cancelled",
    "status": 409,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer cancelled BankID authorization."
}
```

### `bankiderror`

Caused By:

-   Something went wrong with the payer's BankID authorization.

{:.code-view-header}
Example response bankiderror

```http
HTTP/1.1 502 Bad Gateway
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/bankiderror",
    "title": "BankID error",
    "status": 502,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Something went wrong with the payer's BankID authorization."
}
```

### `configerror`

Caused By:

-   Payee alias is missing or not correct.
-   PaymentReference is invalid.
-   Amount value is missing or not a valid number.
-   Amount is less than agreed minimum.
-   Amount value is too large.
-   Invalid or missing currency.
-   Wrong formatted message.
-   Amount value is too large, or amount exceeds the amount of the original payment minus any previous refunds.
-   Counterpart is not activated.
-   Payee not enrolled.

{:.code-view-header}
Example response configerror

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/configerror",
    "title": "Config error",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Payee alias is missing or not correct."
}
```

### `inputerror`

Caused By:

-   MSISDN is invalid.
-   Payer's MSISDN is not enrolled at Swish.

{:.code-view-header}
Example response inputerror

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/inputerror",
    "title": "Input error",
    "status": 400,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Msisdn is invalid."
}
```

### `paymentagelimitnotmet`

Caused By:

-   The payer does not meet the payment's age limit.

{:.code-view-header}
Example response paymentagelimitnotmet

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/paymentagelimitnotmet",
    "title": "Payment Age Limit Not Met",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer does not meet the payment's age limit."
}
```

### `socialsecuritynumbermismatch`

Caused By:

-   The payer's social security number does not match with the one required by this payment.

{:.code-view-header}
Example response socialsecuritynumbermismatch

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/socialsecuritynumbermismatch",
    "title": "Social Security Number Mismatch",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer's social security number does not match with the one required by this payment."
}
```

### `swishalreadyinuse`

Caused By:

-   The payer's Swish is already in use.

{:.code-view-header}
Example response swishalreadyinuse

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/swishalreadyinuse",
    "title": "Error in Swish",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer's Swish is already in use."
}
```

### `swishdeclined`

Caused By:

-   Original payment not found or original payment is more than than 13 months old.
-   It appears that merchant's organization number has changed since sale was made.
-   The MSISDN of the original payer seems to have changed owner.
-   Transaction declined. Could be that the payer has exceeded their swish limit or have insufficient founds.
-   Payment request not cancellable.

{:.code-view-header}
Example response swishdeclined

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/swishdeclined",
    "title": "Swish Declined",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The MSISDN of the original payer seems to have changed owner."
}
```

### `swisherror`

Caused By:

-   Bank system processing error.
-   Swish timed out waiting for an answer from the banks after payment was started.

{:.code-view-header}
Example response swisherror

```http
HTTP/1.1 502 Bad Gateway
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/swisherror",
    "title": "Error in Swish",
    "status": 502,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Bank system processing error."
}
```

### `swishgatewaytimeout`

Caused By:

-   During a create a sale call to e-com, Swish responded with 504 (Gateway Timeout).

{:.code-view-header}
Example response swishgatewaytimeout

```http
HTTP/1.1 504 Gateway Timeout
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/swishgatewaytimeout",
    "title": "Swish Gateway Timeout",
    "status": 504,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Request to Swish timed out."
}
```

### `swishtimeout`

Caused By:

-   Swish timed out before the payment was started.

{:.code-view-header}
Example response swishtimeout

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/swishtimeout",
    "title": "Swish Timed Out",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Swish timed out before the payment was started."
}
```

### `systemerror`

{:.code-view-header}
Example response systemerror

```http
HTTP/1.1 500 Internal Server Error
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/systemerror",
    "title": "Error in System",
    "status": 500,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "A system error occurred. We are working on it."
}
```

### `usercancelled`

Caused By:

-   The payer cancelled the payment in the Swish app.

{:.code-view-header}
Example response usercancelled

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/usercancelled",
    "title": "User cancelled",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer cancelled the payment in the Swish app."
}
```

## Trustly Problems

There are a few problems specific to the `trustly` resource that you may want to
guard against in your integrations. All Trustly problem types will have the
following URL structure:

`https://api.payex.com/psp/errordetail/trustly/<error-type>`

{:.table .table-striped}
| Type            | Status | Description                       |
| :-------------- | :----: | :-------------------------------- |
| `systemerror`   | `502`  | Happens if Trustly is experiencing technical difficulties, a contract is configured with bad account name / password, or if the operation (i.e. reversal) is not allowed on the payment due to its current state on Trustly's end. |

## Vipps Problems

There are a few problems specific to the `vipps` resource that you may want to
guard against in your integrations. All Vipps problem types will have the
following URL structure:

`https://api.payex.com/psp/errordetail/vipps/<error-type>`

### Problem Types from Vipps (Init-call)

{:.table .table-striped}
| Type          | Status | Note       |
| :------------ | :----- | :--------- |
| `vipps_error` | `403`  | All errors |

### Problem Types from Vipps (Callback)

{:.table .table-striped}
| Type             | Status | Note                              |
| :--------------- | :----- | :-------------------------------- |
| `vipps_declined` | `400`  | Any status that is not successful |

### Problem Types from Acquirer

{:.table .table-striped}
| Type                          | Status |
| :---------------------------- | :----- |
| `card_blacklisted`            | `400`  |
| `acquirer_card_blacklisted`   | `403`  |
| `acquirer_card_expired`       | `403`  |
| `acquirer_card_stolen`        | `403`  |
| `acquirer_error`              | `403`  |
| `acquirer_insufficient_funds` | `403`  |
| `acquirer_invalid_amount`     | `403`  |
| `acquirer_possible_fraud`     | `403`  |
| `card_declined`               | `403`  |
| `fraud_detected`              | `403`  |
| `payment_token_error`         | `403`  |
| `bad_request`                 | `500`  |
| `internal_server_error`       | `500`  |
| `unknown_error`               | `500`  |
| `acquirer_gateway_error`      | `502`  |
| `bad_gateway`                 | `502`  |
| `acquirer_gateway_timeout`    | `504`  |

[rfc-7807]: https://tools.ietf.org/html/rfc7807
