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
