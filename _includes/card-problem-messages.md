## Problems

When performing unsuccessful operations, the eCommerce API will respond with a
problem message. We generally use the problem message `type` and `status` code
to identify the nature of the problem. The problem `name` and `description` will
often help narrow down the specifics of the problem.

### Contractual Problem Types

All contract types will have the following URI in front of type:
`{{ page.api_url }}/psp/<errordetail>/creditcard`

{:.table .table-striped}
| Type                           | Status | Description                                 |
| :----------------------------- | :----: | :------------------------------------------ |
| `cardbranddisabled`            | `403`  | The card brand is disabled.                 |
| `accountholdertyperejected`    | `403`  | The account holder type is rejected.        |
| `cardtyperejected`             | `403`  | The card type is rejected.                  |
| `3dsecurerequired`             | `403`  | The transaction was rejected by 3-D Secure. |
| `authenticationstatusrejected` | `403`  | The authentication status was rejected.     |
| `frauddetected`                | `403`  | The transaction was fraudulent.             |
| `3dsecuredeclined`             | `403`  | 3-D Secure declined the transaction.        |

### Acquirer and 3-D Secure Problem Types

All acquirer error types will have the following URI in front of type:
`https://api.payex.com/psp/errordetail/creditcard/<error-type>`

{:.table .table-striped}
| Type                           | Status | Description                                                                                   |
| :----------------------------- | :----: | :-------------------------------------------------------------------------------------------- |
| `3dsecureerror`                | `400`  | 3D Secure not working, try again some time later                                              |
| `cardblacklisted`              | `400`  | Card blacklisted, Consumer need to contact their Card-issuing bank                            |
| `paymenttokenerror`            | `403`  | There was an error with the payment token.                                                    |
| `carddeclined`                 | `403`  | The card was declined.                                                                        |
| `acquirererror`                | `403`  | The acquirer responded with a generic error.                                                  |
| `acquirercardblacklisted`      | `403`  | Card blacklisted, Consumer need to contact their Card-issuing bank                            |
| `acquirercardexpired`          | `403`  | Wrong expire date or Card has expired and consumer need to contact their Card-issuing bank    |
| `acquirercardstolen`           | `403`  | Card blacklisted, Consumer need to contact their Card-issuing bank                            |
| `acquirerinsufficientfunds`    | `403`  | Card does not have sufficient funds, consumer need to contact their Card-issuing bank.        |
| `acquirerinvalidamount`        | `403`  | Amount not valid by aquirer, contact support.ecom@payex.com                                   |
| `acquirerpossiblefraud`        | `403`  | Transaction declined due to possible fraud, consumer need to contact their Card-issuing bank. |
| `3dsecureusercanceled`         | `403`  | Transaction was Cancelled during 3DSecure verification                                        |
| `3dsecuredeclined`             | `403`  | Transaction was declined during 3DSecure verification                                         |
| `frauddetected`                | `403`  | Fraud detected. Consumer need to contact their Card-issuing bank.                             |
| `badrequest`                   | `500`  | Bad request, try again after some time                                                        |
| `internalservererror`          | `500`  | Server error, try again after some time                                                       |
| `3dsecureacquirergatewayerror` | `502`  | Problems reaching 3DSecure verification, try again after some time.                           |
| `badgateway`                   | `502`  | Problems reaching the gateway, try again after some time                                      |
| `acquirergatewayerror`         | `502`  | Problems reaching acquirers gateway, try again after some time                                |
| `acquirergatewaytimeout`       | `504`  | Problems reaching acquirers gateway, try again after some time                                |
