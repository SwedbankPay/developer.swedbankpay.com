### Invoice Problems

There are a few problems specific to the `invoice` resource that you may want to
guard against in your integrations. All invoice error types will have the
following URI structure:

`https://api.payex.com/psp/errordetail/invoice/<error-type>`

{:.table .table-striped}
| Type            | Status | Description                       |
| :-------------- | :----: | :-------------------------------- |
| `externalerror` | `500`  | No error code                     |
| `inputerror`    | `400`  | `10` - `ValidationWarning`        |
| `inputerror`    | `400`  | `30` - `ValidationError`          |
| `inputerror`    | `400`  | `3010` - `ClientRequestInvalid`   |
| `externalerror` | `502`  | `40` - `Error`                    |
| `externalerror` | `502`  | `60` - `SystemError`              |
| `externalerror` | `502`  | `50` - `SystemConfigurationError` |
| `externalerror` | `502`  | `9999` - `ServerOtherServer`      |
| `forbidden`     | `403`  | Any other error code              |
