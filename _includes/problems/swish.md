### Swish Problems

There are a few problems specific to the `swish` resource that you may want to
guard against in your integrations. All Swish problem types will have the
following URI structure:

`https://api.payex.com/psp/errordetail/<error-type>`

#### `inputerror`

Caused By:

-   MSISDN is invalid.
-   Payer's MSISDN is not enrolled at Swish.

{:.code-header}
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

#### `configerror`

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

{:.code-header}
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

#### `swishdeclined`

Caused By:

-   Original payment not found or original payment is more than than 13 months old.
-   It appears that merchant's organization number has changed since sale was made.
-   The MSISDN of the original payer seems to have changed owner.
-   Transaction declined. Could be that the payer has exceeded their swish limit or have insufficient founds.
-   Payment request not cancellable.

{:.code-header}
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

#### `swisherror`

Caused By:

-   Bank system processing error.
-   Swish timed out waiting for an answer from the banks after payment was started.

{:.code-header}
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

#### `swishalreadyinuse`

Caused By:

-   The payer's Swish is already in use.

{:.code-header}
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

#### `swishtimeout`

Caused By:

-   Swish timed out before the payment was started.

{:.code-header}
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

#### `bankidcancelled`

Caused By:

-   The payer cancelled BankID authorization.

{:.code-header}
Example response bankidcancelled

```http
HTTP/1.1 409 Conflict
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/bankidcancelled",
    "title": "BankID Authorization Cancelled",
    "status": 409,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer cancelled BankID authorization."
}
```

#### `bankidalreadyinuse`

Caused By:

-   The payer's BankID is already in use

{:.code-header}
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

#### `bankiderror`

Caused By:

-   Something went wrong with the payer's BankID authorization.

{:.code-header}
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

#### `socialsecuritynumbermismatch`

Caused By:

-   The payer's social security number does not match with the one required by this payment.

{:.code-header}
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

#### `paymentagelimitnotmet`

Caused By:

-   The payer does not meet the payment's age limit.

{:.code-header}
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

#### `usercancelled`

Caused By:

-   The payer cancelled the payment in the Swish app.

{:.code-header}
Example response usercancelled

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/usercancelled",
    "title": "User Cancelled",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer cancelled the payment in the Swish app."
}
```

#### `swishgatewaytimeout`

Caused By:

-   During a create a sale call to e-com, Swish responded with 504 (Gateway Timeout).

{:.code-header}
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

#### `systemerror`

{:.code-header}
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
