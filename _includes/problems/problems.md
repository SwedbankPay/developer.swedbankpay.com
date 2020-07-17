{% assign problem_include_file = include.documentation_section | default: 'generic' | prepend: 'problems/' | append: '.md' %}

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

{:.code-header}
**Problem Example**

```js
{
    "type": "https://api.payex.com/psp/errordetail/<resource>/inputerror",
    "title": "There was an input error",
    "detail": "Please correct the errors and retry the request",
    "instance": "{{ page.transaction_id }}",
    "status": 400,
    "action": "RetryNewData",
    "problems": [{
        "name": "CreditCardParameters.Issuer",
        "description": "minimum one issuer must be enabled"
    }]
}
```

{:.table .table-striped}
| Field                 | Type      | Description                                                                                                                                                                                                                                         |
| :-------------------- | :-------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `type`                | `string`  | The URI that identifies the error type. This is the **only field usable for programmatic identification** of the type of error! When dereferenced, it might lead you to a human readable description of the error and how it can be recovered from. |
| `title`               | `string`  | The title contains a human readable description of the error.                                                                                                                                                                                       |
| `detail`              | `string`  | A detailed, human readable description of the error and how you can recover from it.                                                                                                                                                                |
| `instance`            | `string`  | The identifier of the error instance. This might be of use to Swedbank Pay support personnel in order to find the exact error and the context it occurred in.                                                                                       |
| `status`              | `integer` | The HTTP status code that the problem was served with.                                                                                                                                                                                              |
| `action`              | `string`  | The `action` indicates how the error can be recovered from.                                                                                                                                                                                         |
| `problems`            | `array`   | The array of problem detail objects.                                                                                                                                                                                                                |
| └➔&nbsp;`name`        | `string`  | The name of the field, header, object, entity or likewise that was erroneous.                                                                                                                                                                       |
| └➔&nbsp;`description` | `string`  | The human readable description of what was wrong with the field, header, object, entity or likewise identified by `name`.                                                                                                                           |

### Common Problems

All common problem types will have a URI in the format
`https://api.payex.com/psp/errordetail/<error-type>`. The **URI is an
identifier** that you can hard-code and implement logic around. It is currently
not not possible to dereference this URI, although that might be possible in the
future.

{:.table .table-striped}
| Type                 | Status | Description                                                                                                                                        |
| :------------------- | :----: | :------------------------------------------------------------------------------------------------------------------------------------------------- |
| `inputerror`         | `400`  | The server cannot or will not process the request due to an apparent client error (e.g. malformed request syntax, size to large, invalid request). |
| `forbidden`          | `403`  | The request was valid, but the server is refusing the action. The necessary permissions to access the resource might be lacking.                   |
| `notfound`           | `404`  | The requested resource could not be found, but may be available in the future. Subsequent requests are permissible.                                |
| `systemerror`        | `500`  | A generic error message.                                                                                                                           |
| `configurationerror` | `500`  | A error relating to configuration issues.                                                                                                          |

{% include {{ problem_include_file }} %}

[rfc-7807]: https://tools.ietf.org/html/rfc7807
