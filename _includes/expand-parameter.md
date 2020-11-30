{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

### Expansion

The payment resource contain the ID of related sub-resources in its response
properties. These sub-resources can be expanded inline by using the request
parameter `expand`. This is an effective way to limit the number of necessary
calls to the API, as you return several properties related to a Payment resource
in a single request.

{% include alert.html type="informative" icon="info" body="
Note that the `expand` parameter is available to all API requests but only
applies to the request response. This means that you can use the expand
parameter on a `POST`  or `PATCH`request to get a response containing the target
resource including expanded properties." %}

This example below add the `urls` and `authorizations` field inlines to the
response, enabling you to access information from these sub-resources.

{:.code-view-header}
**Expansion**

```http
GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}?$expand=urls,authorizations HTTP/1.1
Host: {{ page.api_host }}
```

To avoid unnecessary overhead, you should only expand the nodes you need info
about.
