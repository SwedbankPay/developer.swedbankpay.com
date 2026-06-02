{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% assign token_field_name = include.token_field_name %}
{% capture token_url %}
    /psp/paymentorders/{{ token_field_name }}s/{{- page.payment_token -}}
{% endcapture %}
{% assign token_url=token_url | strip %}

## Mapping payerOwnedTokens vs. Payer API

What is `payerOwnedTokens`?

`payerOwnedTokens` was a `PaymentOrder` API endpoint (v2.0/v3.0/v3.1) used to
retrieve and update tokens asssociated to a specific `payerReference`. This
endpoint will be removed in v3.2 and replaced by the Payer API.

What is Payer API?

Payer API is the new, authoritative service used to retrieve, update and manage
tokens for a payer.

### At A Glance

{:.table .table-striped}

| Old (`PaymentOrder` API)    | New (Payer API)  | Description    |
| :-------------------------------------- | :--------------------------------------- | :--------------------------------------- |
| `GET /payerownedtokens/<payerReference>`      | `GET /online/payers/<payerReference>`    | Retrieve active tokens for a payer          |
| `PATCH /payerownedtokens/<payerReference>`    | `PATCH /online/payers/<payerReference>`  | Archive all tokens for a payer         |
| `GET /paymenttokens/<token>`            | `GET /online/payers/tokens/<tokenId>`    | Retrieve a single token                        |
| `PATCH /paymenttokens/<token>`          | `PATCH /online/payers/tokens/<tokenId>`  | Archive or update token             |

### Code Examples

*   Retrieve all tokens for a payer

{% capture request_header %}GET /psp/paymentorders/payerownedtokens/<payerReference>
Host: {{ page.api_host }}
Authorization: Bearer <token>{% endcapture %}

{% include code-example.html
    title='Old (PaymentOrder API) GET All Tokens Request'
    header=request_header
    %}

{% capture request_header %}GET /online/payers/<payerReference>
Host: {{ page.api_host }}
Authorization: Bearer <token>{% endcapture %}

{% include code-example.html
    title='New (Payer API) GET All Tokens Request'
    header=request_header
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{% raw %}
{
  "tokens": {
    "id": "/online/payers/<payerReference>",
    "payerReference": "customer-123",
    "tokensList": [
      {
        "id": "/online/payers/tokens/abcd-1234",
        "token": "abcd-1234",
        "tokenType": "Payment",
        "instrument": "CreditCard",
        "displayName": "492500******0004",
        "state": "Active"
      }
    ]
  }
}
{% endraw %}{% endcapture %}

{% include code-example.html
    title='Retrieve All Tokens Response'
    header=response_header
    json= response_content
    %}

*   Archive All Tokens

{% capture request_header %}HTTP PATCH /psp/paymentorders/payerownedtokens/<payerReference>
Host: {{ page.api_host }}
Authorization: Bearer <token>{% endcapture %}

{% include code-example.html
    title='Old (PaymentOrder API) Archive All Tokens Request'
    header=request_header
    %}

{% capture request_header %}HTTP PATCH /online/payers/<payerReference>/archives
Host: {{ page.api_host }}
Authorization: Bearer <token>{% endcapture %}

{% include code-example.html
    title='New (Payer API) Archive All Tokens Request'
    header=request_header
    %}

*   Retrieve Single Token

{% capture request_header %}HTTP GET /psp/paymentorders/paymenttokens/<tokenid>
Host: {{ page.api_host }}
Authorization: Bearer <token>{% endcapture %}

{% include code-example.html
    title='Old (PaymentOrder API) Retrieve Single Token Request'
    header=request_header
    %}

HTTP GET /online/payers/tokens/{tokenIdentifier}
Host: {{ page.api_host }}
Authorization: Bearer <token>{% endcapture %}

{% include code-example.html
    title='New (Payer API) Retrieve Single Token Request'
    header=request_header
    %}

### Important Differences

*   Payer API gives ypu a more structured and long-term token handling.

*   All new integrations must use the Payer API, not `payerOwnedTokens`.

*   Token types and status (Active/Archived) are the same, but the Payer API has
more detailed fields and better support for the token lifecycle.

## Delete {{ token_field_name }} Request

{% capture request_header %}PATCH {{ token_url }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% capture request_content %}{
    "state": "Deleted",
    "comment": "Comment on why the deletion is happening"
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

## Delete {{ token_field_name }} Response

{% unless token_field_name == "recurrenceToken" %}

The example shows a token connected to a card. The parameters and display name
will vary depending on the payment method.

{% endunless %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    {% if token_field_name == "paymentToken" %}
    "paymentToken": "{{ page.payment_token }}",
    {% else %}
    "token": "{{ page.payment_token }}",{% endif %} {% if token_field_name == "recurrenceToken" %}
    "isDeleted": true
    {% else %}
    "instrument": "CreditCard",
    "instrumentDisplayName": "123456xxxxxx1111"
    "correlationId": "e2f06785-805d-4605-bf40-426a725d313d",
    "instrumentParameters": {
        "cardBrand": "Visa",
        "expiryDate": "MM/YYYY"
    }
    {% endif %}
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}
