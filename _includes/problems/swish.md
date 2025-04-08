### Swish Problems

There are a few problems specific to the `swish` resource that you may want to
guard against in your integrations. All Swish problem types will have the
following URL structure:

`https://api.payex.com/psp/errordetail/<error-type>`

#### `bankidalreadyinuse`

Caused By:

*   The payer's BankID is already in use

{% capture response_header %}HTTP/1.1 409 Conflict Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/bankidalreadyinuse",
    "title": "BankID Already in Use",
    "status": 409,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer´s BankID is already in use."
}{% endcapture %}

{% include code-example.html
    title='Example response bankidalreadyinuse'
    header=response_header
    json= response_content
    %}

#### `bankidcancelled`

Caused By:

*   The payer cancelled BankID authorization.

{% capture response_header %}HTTP/1.1 409 Conflict
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/bankidcancelled",
    "title": "BankID Authorization cancelled",
    "status": 409,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer cancelled BankID authorization."
}{% endcapture %}

{% include code-example.html
    title='Example response bankidcancelled'
    header=response_header
    json= response_content
    %}

#### `bankiderror`

Caused By:

*   Something went wrong with the payer's BankID authorization.

{% capture response_header %}HTTP/1.1 502 Bad Gateway
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/bankiderror",
    "title": "BankID error",
    "status": 502,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Something went wrong with the payer´s BankID authorization."
}{% endcapture %}

{% include code-example.html
    title='Example response bankiderror'
    header=response_header
    json= response_content
    %}

#### `configerror`

Caused By:

*   Payee alias is missing or not correct.
*   PaymentReference is invalid.
*   Amount value is missing or not a valid number.
*   Amount is less than agreed minimum.
*   Amount value is too large.
*   Invalid or missing currency.
*   Wrong formatted message.
*   Amount value is too large, or amount exceeds the amount of the original payment minus any previous refunds.
*   Counterpart is not activated.
*   Payee not enrolled.

{% capture response_header %}HTTP/1.1 403 Forbidden
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/configerror",
    "title": "Config error",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Payee alias is missing or not correct."
}{% endcapture %}

{% include code-example.html
    title='Example response configerror'
    header=response_header
    json= response_content
    %}

#### `inputerror`

Caused By:

*   MSISDN is invalid.
*   Payer's MSISDN is not enrolled at Swish.

{% capture response_header %}HTTP/1.1 400 Bad Request
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/inputerror",
    "title": "Input error",
    "status": 400,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Msisdn is invalid."
}{% endcapture %}

{% include code-example.html
    title='Example response inputerror'
    header=response_header
    json= response_content
    %}

#### `paymentagelimitnotmet`

Caused By:

*   The payer does not meet the payment's age limit.

{% capture response_header %}HTTP/1.1 403 Forbidden
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/paymentagelimitnotmet",
    "title": "Payment Age Limit Not Met",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer does not meet the payment´s age limit."
}{% endcapture %}

{% include code-example.html
    title='Example response paymentagelimitnotmet'
    header=response_header
    json= response_content
    %}

#### `socialsecuritynumbermismatch`

Caused By:

*   The payer's social security number does not match with the one required by this payment.

{% capture response_header %}HTTP/1.1 403 Forbidden
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/socialsecuritynumbermismatch",
    "title": "Social Security Number Mismatch",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer´s social security number does not match with the one required by this payment."
}{% endcapture %}

{% include code-example.html
    title='Example response socialsecuritynumbermismatch'
    header=response_header
    json= response_content
    %}

#### `swishalreadyinuse`

Caused By:

*   The payer's Swish is already in use.

{% capture response_header %}HTTP/1.1 403 Forbidden
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/swishalreadyinuse",
    "title": "Error in Swish",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payers Swish is already in use."
}{% endcapture %}

{% include code-example.html
    title='Example response swishalreadyinuse'
    header=response_header
    json= response_content
    %}

#### `swishdeclined`

Caused By:

*   Original payment not found or original payment is more than than 13 months old.
*   It appears that merchant's organization number has changed since sale was made.
*   The MSISDN of the original payer seems to have changed owner.
*   Transaction declined. Could be that the payer has exceeded their swish limit or have insufficient founds.
*   Payment request not cancellable.

{% capture response_header %}HTTP/1.1 403 Forbidden
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/swishdeclined",
    "title": "Swish Declined",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The MSISDN of the original payer seems to have changed owner."
}{% endcapture %}

{% include code-example.html
    title='Example response swishdeclined'
    header=response_header
    json= response_content
    %}

#### `swisherror`

Caused By:

*   Bank system processing error.
*   Swish timed out waiting for an answer from the banks after payment was started.

{% capture response_header %}HTTP/1.1 502 Bad Gateway
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/swisherror",
    "title": "Error in Swish",
    "status": 502,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Bank system processing error."
}{% endcapture %}

{% include code-example.html
    title='Example response swisherror'
    header=response_header
    json= response_content
    %}

#### `swishgatewaytimeout`

Caused By:

*   During a create a sale call to e-commerce, Swish responded with 504 (Gateway Timeout).

{% capture response_header %}HTTP/1.1 504 Gateway Timeout
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/swishgatewaytimeout",
    "title": "Swish Gateway Timeout",
    "status": 504,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Request to Swish timed out."
}{% endcapture %}

{% include code-example.html
    title='Example response swishgatewaytimeout'
    header=response_header
    json= response_content
    %}

#### `swishtimeout`

Caused By:

*   Swish timed out before the payment was started.

{% capture response_header %}HTTP/1.1 403 Forbidden
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/swishtimeout",
    "title": "Swish Timed Out",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "Swish timed out before the payment was started."
}{% endcapture %}

{% include code-example.html
    title='Example response swishtimeout'
    header=response_header
    json= response_content
    %}

#### `systemerror`

{% capture response_header %}HTTP/1.1 500 Internal Server Error
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/systemerror",
    "title": "Error in System",
    "status": 500,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "A system error occurred. We are working on it."
}{% endcapture %}

{% include code-example.html
    title='Example response systemerror'
    header=response_header
    json= response_content
    %}

#### `usercancelled`

Caused By:

*   The payer cancelled the payment in the Swish app.

{% capture response_header %}HTTP/1.1 403 Forbidden
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "sessionId": "570ad610-3bd5-43d2-a270-ca1510562972",
    "type": "https://api.payex.com/psp/errordetail/usercancelled",
    "title": "User cancelled",
    "status": 403,
    "instance": "https://api.payex.com/psp/swish/payments/0cf55e0f-9931-476b-249d-08d7a3ee4e14/sales",
    "detail": "The payer cancelled the payment in the Swish app."
}{% endcapture %}

{% include code-example.html
    title='Example response usercancelled'
    header=response_header
    json= response_content
    %}
