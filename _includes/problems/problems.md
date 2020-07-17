### Common Problem Types

All common types will have the following URI in front of type:
`https://api.payex.com/psp/errordetail/<error-type>`

{:.table .table-striped}
| Type                 | Status | Description                                                                                                                                        |
|:---------------------|:------:|:---------------------------------------------------------------------------------------------------------------------------------------------------|
| `inputerror`         | `400`  | The server cannot or will not process the request due to an apparent client error (e.g. malformed request syntax, size to large, invalid request). |
| `forbidden`          | `403`  | The request was valid, but the server is refusing the action. The necessary permissions to access the resource might be lacking.                   |
| `notfound`           | `404`  | The requested resource could not be found, but may be available in the future. Subsequent requests are permissible.                                |
| `systemerror`        | `500`  | A generic error message.                                                                                                                           |
| `configurationerror` | `500`  | A error relating to configuration issues.                                                                                                          |
