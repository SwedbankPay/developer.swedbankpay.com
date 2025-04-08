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

{% capture response_content %}{
    "type": "https://api.payex.com/psp/errordetail/<resource>/inputerror",
    "title": "There was an input error",
    "detail": "Please correct the errors and retry the request",
    "instance": "{{ page.transaction_id }}",
    "status": 400,
    "problems": [{
        "name": "CreditCardParameters.Issuer",
        "description": "minimum one issuer must be enabled"
    }]
}{% endcapture %}

{% include code-example.html
    title='Problem Example'
    header=response_header
    json= response_content
    %}

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

### Token Problems

We will be making a change in the error messages that are given in response in
the e-commerce API if the requested `Payment`/`One-Click`/`Recur`/`Unscheduled`
token does not exist or is deleted.

The following new `errorType` will be introduced (only for Payment Order):
`https://api.payex.com/psp/errordetail/paymentorders/paymenttokeninactive`

In addition to the one currently in use for both Payment Methods and Payment
Order:
`https://api.payex.com/psp/errordetail/paymentorders/inputerror`

First, a check is made to verify if the token exists or not. If it does not
exist, the API returns an error of the type `InputError`. If, however, the token
exists but is deleted, the API will return the error `TokenInactive`.

Examples of the error messages are presented below.

### InputError

`InputError` for a `RecurrenceToken`:

{% capture response_content %}{
   "type":"https://api.payex.com/psp/errordetail/paymentorders/inputerror",
   "title":"Error in input data",
   "status":404,
   "instance":"https://api.payex.com/psp/probleminstance/00-e53deef0eb5e47bcb5ba1739bdd9086c-
    b5512dfc02b74f07-01",
   "detail":"Input validation failed, error description in problems node!",
   "problems":
   [
      {
         "name":"RecurrenceToken",
         "description":"The given RecurrenceToken does not exist."
      }
   ]
}{% endcapture %}

{% include code-example.html
    title='InputError for RecurrenceToken'
    header=response_header
    json= response_content
    %}

### TokenInactive

`TokenInactive` example with `UnscheduledToken`:

{% capture response_content %}{
    "type": "https://api.payex.com/psp/errordetail/paymentorders/paymenttokeninactive",
    "title": "Payment token is inactive",
    "status": 422,
    "instance": "https://api.payex.com/psp/probleminstance/00-2fc18bd40743401596bf2de3b51ab16d-
     bfebd4ae81ea8423-01",
    "detail": "The given UnscheduledToken is inactive.",
    "problems":
     [
       {
           "name": "UnscheduledToken",
           "description": "The given UnscheduledToken is inactive."
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='TokenInactive for UnscheduledToken'
    header=response_header
    json= response_content
    %}

`TokenInactive` example with a `RecurrenceToken`:

{% capture response_content %}{
    "type": "https://api.payex.com/psp/errordetail/paymentorders/paymenttokeninactive",
    "title": "Payment token is inactive",
    "status": 422,
    "instance": "https://api.payex.com/psp/probleminstance/00-2fc18bd40743401596bf2de3b51ab16d-
     bfebd4ae81ea8423-01",
    "detail": "The given RecurrenceToken is inactive.",
    "problems":
     [
       {
           "name": "UnscheduledToken",
           "description": "The given RecurrenceToken is inactive."
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='TokenInactive for RecurrenceToken'
    header=response_header
    json= response_content
    %}

If you have questions regarding the new error types, do not hesitate to contact
us through the ordinary support channels.

### Payment Details Problems

In order to use the new parameter `EnablePaymentDetailsConsentCheckbox` – which
determines whether or not to show the checkbox used to save payment details –
the `DisableStoredPaymentDetails` parameter must be set to `true`. Otherwise you
will get a validation error.

{% capture response_content %}{
    "type": "https://api.payex.com/psp/errordetail/paymentorders/inputerror",
    "title": "Error in input data",
    "status": 400,
    "instance": "https://api.payex.com/psp/probleminstance/00-f75cfaedb1eb467bbefd4917c67a7664-b25fb23de26682e9-01",
    "detail": "Input validation failed, error description in problems node!",
    "problems": [
        {
            "name": "PaymentOrder.EnablePaymentDetailsConsentCheckbox",
            "description": "EnablePaymentDetailsConsentCheckbox cannot be used without DisableStoredPaymentDetails."
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Consent Checkbox Problems'
    header=response_header
    json= response_content
    %}

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

### Creditcard Payments MIT - Do Not Try Again & Excessive Reattempts

In accordance with directives from Visa and Mastercard, we will be implementing
2 different types of limitations in the amount of successive reattempts of a
previously failed transaction using either a `recurrence`- or `unscheduledToken`
that can be done using card based payment methods. This limitation has up
until now been handled by Swedbank Pay Acquiring, but will now be handled
earlier in the transaction process - enabling us to provide better and clearer
response messages through the e-commerce API.

To test these response messages, we have added new magic amounts in the
[test data section][test-data]. The new amounts are for `DAILYLIMITEXCEEDED`,
`MONTHLYLIMITEXCEEDED`, `DONOTRETRY` and `MODIFICATIONSREQUIRED`.
SuspensionWarning can be tested by using the `limit exceeded` amounts.

One such limitation will be limiting the amount of successive reattempts of a
previously failed transaction that can be done using creditcard based payment
method within a specified period The limitation in question varies based on the
card brand:

*   MasterCard - 10 failed payment attempts allowed during a period of **24 hours**.
*   MasterCard - 35 failed payment attempts allowed during a period of **30 days**.
*   Visa - 15 failed payment attempts allowed during a period of **30 days**.

The other limitation that will be implemented is in the case that Visa or
Mastercard gives such a response that is flagged as "Do Not Retry" in accordance
to Visa and MasterCard regulations. This response is given in the cases that
they deem the transaction to never be possible to be valid - as an example, if
the card no longer exists, and thus there is no point in retrying.

In these cases, the card will be blocked immediately and no further attempts
allowed. This block will be active for **30 days** for both Visa and MasterCard.

Both of these limitations are based on the combination of the acquiring
agreement that the transaction was initiated from, and the PAN of the card that
was used. That is, a card might be blocked because of "Excessive Reattempts" at
a particular merchant, while being allowed more reattempts at another. Please
note that in the case a new card is issued in place of an old expired one, the
new card usually keeps the same PAN - meaning that if the old card was blocked,
the new one will be as well (until the period resets). This marks the importance
of having such a logic in place that limits reattempts before the block actually
takes place - this is where the new, clearer response messages will help.

**Please note that the limitations of excessive reattempts are present in both**
**test and productions environments.** We recommend having two test cards
available if you are testing this functionality.

When it comes to Excessive Reattempts, the new response messages will be
returned if the quota for the period gets to 5 attempts remaining, as follows:

{% capture response_content %}{
    "type": "https://api.payex.com/psp/errordetail/creditcard/authenticationrequired",
    "title": "SuspensionWarning. The card might be blocked.",
    "status": 403,
    "detail": "5 attempts left before the card is blocked.",
    "problems": [{
            "name": "ExternalResponse",
            "description": "Forbidden-AuthenticationRequired"
        }, {
            "name": "AUTHENTICATION_REQUIRED",
            "description": "Acquirer soft-decline, 3-D Secure authentication required, response-code: O5, hostId: 20, hostName: PayEx Test"
        }, {
            "name": "Component",
            "description": "pospay-ecommerce-financial-service"
        }
    ],
    "suspension": {
            "attempts": 12,
            "remaining": 3,
            "product": "VISA",
            "acquirerCode": "O5",
            "acquirerDetail": "AUTHENTICATION_REQUIRED",
            "state": "WARNING"
    }
}{% endcapture %}

{% include code-example.html
    title='5 Attempts Remaining'
    header=response_header
    json= response_content
    %}

Should more attempts be tried, and the transaction fail, the number of remaining
attempts will update accordingly. Once the card is blocked, the following
responses will be given, depending on if the card in question is Visa or
MasterCard:

{% capture response_content %}{
    "type": "https://api.payex.com/psp/errordetail/creditcard/dailylimitexceeded",
    "title": "Daily attempt limit is exceeded.",
    "status": 403,
    "detail": "The attempt is rejected after trying multiple times with same token.",
    "problems": [{
            "name": "REJECTED_BY_POSPAY_DAILY_LIMIT",
            "description": "Intent with intentId 85ac3576-1e69-4aef-a066-84a0e6dcfa61, agreementId 80d0244c-2b15-4719-8ab1-ed83eddfee61 was suspended after exceeding the rolling 24 hour constraint of 10 attempts"
        },
        {
            "name": "Component",
            "description": "pospay-ecommerce-financial-service"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Attempt limit exceeded MasterCard'
    header=response_header
    json= response_content
    %}

{% capture response_content %}{
    "type": "https://api.payex.com/psp/errordetail/creditcard/monthlylimitexceeded",
    "title": "Monthly attempt limit is exceeded.",
    "status": 403,
    "detail": "The attempt is rejected after trying multiple times with same token.",
    "problems": [{
            "name": "REJECTED_BY_POSPAY_MONTHLY_LIMIT",
            "description": "Intent with intentId 80456a1d-1cb1-429b-bf4e-8e1313362800, agreementId 3a47c702-7963-4915-9567-e1bce06d20dd was suspended after exceeding the rolling 30 day constraint of 15 attempts"
        },
        {
            "name": "Component",
            "description": "pospay-ecommerce-financial-service"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Attempt limit exceeded Visa'
    header=response_header
    json= response_content
    %}

The new responses for "Do Not Retry" will be as follows:

{% capture response_content %}{
    "type": "https://api.payex.com/psp/errordetail/creditcard/acquirererrordonotretry",
    "title": "Do not retry.",
    "status": 403,
    "detail": "The attempt is rejected.",
    "problems": [{
            "name": "ExternalResponse",
            "description": "Forbidden-AcquirerErrorDoNotRetry"
        }, {
            "name": "REJECTED_BY_ACQUIRER_DO_NOT_RETRY",
            "description": "TOKEN04.ERR_FLG received in response, response-code: 05"
        }, {
            "name": "Component",
            "description": "pospay-ecommerce-financial-service"
        }
    ]
}{% endcapture %}

{% include code-example.html
    title='Blocked card, no further attempts allowed'
    header=response_header
    json= response_content
    %}

Furthermore, a new response is added, being returned in cases where the
transaction is declined, but might be accepted after modifications:

{% capture response_content %}{
    "type": "https://api.payex.com/psp/errordetail/creditcard/authenticationrequired",
    "title": "AUTHENTICATION_REQUIRED",
    "status": 403,
    "detail": "Acquirer soft-decline, 3-D Secure authentication required, response-code: O5,   hostId: 20, hostName: PayEx Test - ModificationsRequired",
    "problems": [{
            "name": "AUTHENTICATION_REQUIRED",
            "description": "Acquirer soft-decline, 3-D Secure authentication required,   response-code: O5, hostId: 20, hostName: PayEx Test"
        }, {
            "name": "Component",
            "description": "pospay-ecommerce-financial-service"
        }
    ],
    "modification": {
            "required": "YES",
            "reason": "AUTHENTICATION_REQUIRED",
            "acquirerCode": "O5",
            "acquirerDetail": "AUTHENTICATION_REQUIRED"
    }
}{% endcapture %}

{% include code-example.html
    title='Transaction declined, modifications required'
    header=response_header
    json= response_content
    %}

## Installment Account Problems

There are a few problems specific to the `creditaccount` resource that you may
want to guard against in your integrations. All invoice error types will have
the following URL structure:

`https://api.payex.com/psp/errordetail/creditaccount/<error-type>`

{:.table .table-striped}
| Type            | Status | Description                       |
| :-------------- | :----: | :-------------------------------- |
| `CURRENCYNOTSUPPORTED`    | `400`  | The provided currency does not match the authorization currency.       |
| `INVALIDAMOUNT`     | `400`  | The provided capture amount is invalid, likely larger than the remaining authorized amount.             |
| `FAILEDAMOUNT`     | `400`  | The authorized amount exceeds the valid maximum amount or subceeds the valid minimum amount.             |
| `VALIDATION`     | `400`  | Validation error. The problem(s) should be described in the response.             |
| `CREDITNOTAPPROVED` | `403`  | Credit check or extension of credit check was rejected.                  |
| `AMOUNTEXCEEDSLIMIT`      | `403`  | Amount in the pre-authorization is no longer valid for this authorization.         |
| `AUTHORIZATIONEXPIRED` | `403`  | The provided authorization is not open or has already expired  |
| `INVALIDSTATE` | `403`  | the provided pre-authorization resource is in an invalid state for this payment method.             |
| `MISSINGPREAUTHORIZATION`   | `403`  | The resource is missing. It may have been created on different ledger or have expired.   |
| `INVALIDACCOUNTUSAGE` | `403`  | The provided pre-authorization is invalid for this kind of authorization.           |
| `IDENTIFIERALREADYINUSE`   | `403`  | The Authorization ID provided is already used, provide a new one and try again.  |
| `FORBIDDEN`    | `403`  | There is a conflict or the resource is unprocessable.      |
| `NOTFOUND`     | `404`  | No authorization for the provided ID wad found on this ledger.             |
| `UNKNOWN`     | `403`  | Unexpected error.            |
| `CREDITNOTAPPROVED` | `403`  | Credit check for new account was denied.                 |
| `SIGNINGFAILED`      | `403`  | Something went wrong during account onboarding or the user cancelled in BankID.       |
| `CREDITNOTAPPROVED` | `403`  | Credit check for account limit upgrade was denied. |
| `SIGNINGFAILED` | `403`  | Something went wrong during account limit upgrade or user cancelled in BankID.          |
| `CREDITNOTAPPROVED`   | `403`  | Credit check denied.  |
| `USERCANCELLED` | `403`  | User cancelled on Ledger & Factoring page.          |

## Invoice Problems

There are a few problems specific to the `invoice` resource that you may want to
guard against in your integrations. All invoice error types will have the
following URL structure:

`https://api.payex.com/psp/errordetail/invoice/<error-type>`

### Invoice With New Assessment Flow

{:.table .table-striped}
| Type            | Status | Description                       |
| :-------------- | :----: | :-------------------------------- |
| `InputError`    | `400`  | Occurs if the input validation fails. The problem field will specify which parameter failed the validation.      |
| `Forbidden`     | `403`  | Invalid authentication status for the requested method.              |
| `Forbidden`     | `403`  | The authentication's time limit has expired.             |
| `CreditNotApproved` | `403`  | Credit check or extension of credit check was rejected.                  |
| `NotFound`      | `404`  | The requested resource was not found.         |
| `SystemError` | `500`  | Unexpected error. The logs might provide further problem details. |
| `SystemError` | `500`  | The requested method is not implemented fully by code, or not configured for the resource. The problem body will specify which.            |
| `SystemError`   | `500`  | State of the resource is invalid for further progress.  |

### Invoice Authentication Status Mapping - Assessment Flow

{:.table .table-striped}
| Type            | Status | Description                       |
| :-------------- | :----: | :-------------------------------- |
| `ABORTEDIDENTIFICATION`    | `403`  | Authentication aborted in BankID-app.       |
| `USERPREABORTED`    | `403`  | User aborted before starting signing or authentication.       |
| `USERABORTED`    | `403`  | Signing or authentication aborted from web.   |
| `TIMEOUTIDENTIFICATION`     | `403`  | User haven't completed authentication in time.          |
| `NATIONALIDENTIFIERMISMATCH` | `403`  | The Social Security Number provided in purchase did not match the Social Security Number from the BankID.                   |
| `FAILED` | `403`  | Unclassified failure.                 |
| `ERROR` | `502`  | Unexpected error. |

### Invoice Without Assessment Flow

Invoice transactions without SCA is only available in Norway, and only for
merchants who have a special agreement with Swedbank Pay.

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

### `bankidcancelled`

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

### `bankiderror`

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

### `configerror`

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

### `inputerror`

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

### `paymentagelimitnotmet`

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

### `socialsecuritynumbermismatch`

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
    "detail": "The social security number of the payer does not match with the one required by this payment."
}{% endcapture %}

{% include code-example.html
    title='Example response socialsecuritynumbermismatch'
    header=response_header
    json= response_content
    %}

### `swishalreadyinuse`

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
    "detail": "The Swish account of the payer is already in use."
}{% endcapture %}

{% include code-example.html
    title='Example response swishalreadyinuse'
    header=response_header
    json= response_content
    %}

### `swishdeclined`

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

### `swisherror`

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

### `swishgatewaytimeout`

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

### `swishtimeout`

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

### `systemerror`

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

### `usercancelled`

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

#### Problem Types from Vipps (Init-call)

{:.table .table-striped}
| Type             | Status | Note                              |
| :--------------- | :----- | :-------------------------------- |
| `vipps_error`    | `403`  | All errors                        |

#### Problem Types from Vipps (Callback)

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
[test-data]: /checkout-v3/test-data/#magic-amounts-error-testing-using-amounts
