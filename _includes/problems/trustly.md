### Trustly Problems

There are a few problems specific to the `trustly` resource that you may want to
guard against in your integrations. All Trustly problem types will have the
following URI structure:

`https://api.payex.com/psp/errordetail/trustly/<error-type>`

{:.table .table-striped}
| Type            | Status | Description                       |
| :-------------- | :----: | :-------------------------------- |
| `systemerror`   | `502`  | Happens if Trustly is experiencing technical difficulties, a contract is configured with bad account name / password, or if the operation (i.e. reversal) is not allowed on the payment due to its current state on Trustly's end. |
