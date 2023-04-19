{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md fallback="generic" %}{% endcapture %}
{% if documentation_section contains "checkout" or documentation_section contains "payment-menu" %}
    {% assign documentation_section = "generic" %}
{% endif %}
{% assign problem_include_file = documentation_section | prepend: "problems/" | append: ".md" %}

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

{:.code-view-header}
**Problem Example**

```json
{
    "type": "https://api.payex.com/psp/errordetail/<resource>/inputerror",
    "title": "There was an input error",
    "detail": "Please correct the errors and retry the request",
    "instance": "{{ page.transaction_id }}",
    "status": 400,
    "problems": [{
        "name": "CreditCardParameters.Issuer",
        "description": "minimum one issuer must be enabled"
    }]
}
```

{:.table .table-striped}
| Field                 | Type      | Description                                                                                                                                                                                                                                         |
| :-------------------- | :-------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% f type, 0 %}                | `string`  | The URL that identifies the error type. This is the **only field usable for programmatic identification** of the type of error! When dereferenced, it might lead you to a human readable description of the error and how it can be recovered from. |
| {% f title, 0 %}               | `string`  | The title contains a human readable description of the error.                                                                                                                                                                                       |
| {% f detail, 0 %}              | `string`  | A detailed, human readable description of the error and how you can recover from it.                                                                                                                                                                |
| {% f instance, 0 %}            | `string`  | The identifier of the error instance. This might be of use to Swedbank Pay support personnel in order to find the exact error and the context it occurred in.                                                                                       |
| {% f status, 0 %}              | `integer` | The HTTP status code that the problem was served with.                                                                                                                                                                                              |
| {% f action, 0 %}              | `string`  | The `action` indicates how the error can be recovered from.                                                                                                                                                                                         |
| {% f problems, 0 %}            | `array`   | The array of problem detail objects.                                                                                                                                                                                                                |
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
| {% f inputerror, 0 %}         | `400`  | The server cannot or will not process the request due to an apparent client error (e.g. malformed request syntax, size to large, invalid request). |
| {% f configurationerror, 0 %} | `403`  | A error relating to configuration issues.   |
| {% f forbidden, 0 %}          | `403`  | The request was valid, but the server is refusing the action. The necessary permissions to access the resource might be lacking.                   |
| {% f notfound, 0 %}           | `404`  | The requested resource could not be found, but may be available in the future. Subsequent requests are permissible.                                |
| {% f systemerror, 0 %}        | `500`  | A generic error message.                 |

{% include {{ problem_include_file }} %}

[rfc-7807]: https://tools.ietf.org/html/rfc7807
