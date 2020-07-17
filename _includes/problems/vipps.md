### Vipps Problems

There are a few problems specific to the `vipps` resource that you may want to
guard against in your integrations. All Vipps problem types will have the
following URI structure:

`https://api.payex.com/psp/errordetail/vipps/<error-type>`

#### Problem Types from Vipps (Init-call)

{:.table .table-striped}
| Type          | Status | Note       |
| :------------ | :----- | :--------- |
| `vipps_error` | `403`  | All errors |

#### Problem Types from Vipps (Callback)

{:.table .table-striped}
| Type             | Status | Note                              |
| :--------------- | :----- | :-------------------------------- |
| `vipps_declined` | `400`  | Any status that is not successful |

#### Problem Types from Acquirer

{:.table .table-striped}
| Type                          | Status |
| :---------------------------- | :----- |
| `card_blacklisted`            | `400`  |
| `payment_token_error`         | `403`  |
| `card_declined`               | `403`  |
| `acquirer_error`              | `403`  |
| `acquirer_card_blacklisted`   | `403`  |
| `acquirer_card_expired`       | `403`  |
| `acquirer_card_stolen`        | `403`  |
| `acquirer_insufficient_funds` | `403`  |
| `acquirer_invalid_amount`     | `403`  |
| `acquirer_possible_fraud`     | `403`  |
| `fraud_detected`              | `403`  |
| `bad_request`                 | `500`  |
| `internal_server_error`       | `500`  |
| `bad_gateway`                 | `502`  |
| `acquirer_gateway_error`      | `502`  |
| `acquirer_gateway_timeout`    | `504`  |
| `unknown_error`               | `500`  |
