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
| `FORBIDDEN`    | `403`  | N/A. There is a conflict or the resource is unprocessable.      |
| `NOTFOUND`     | `404`  | No authorization for the provided ID wad found on this ledger.             |
| `UNKNOWN`     | `403`  | Unexpected error.            |
| `CREDITNOTAPPROVED` | `403`  | Credit check for new account was denied.                 |
| `SIGNINGFAILED`      | `403`  | Something went wrong during account onboarding or the user cancelled in BankID.       |
| `CREDITNOTAPPROVED` | `403`  | Credit check for account limit upgrade was denied. |
| `SIGNINGFAILED` | `403`  | Something went wrong during account limit upgrade or user cancelled in BankID.          |
| `CREDITNOTAPPROVED`   | `403`  | Credit check denied.  |
| `USERCANCELLED` | `403`  | User cancelled on Ledger & Factoring page.          |
