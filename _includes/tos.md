If you have specific terms of service you want to display and the payer to
approve during the payment process, you can do this by adding a
`termsOfServiceUrl` to the `urls` node of your `paymentOrder` request.

The url will appear as a clickable hyperlink below the pay button in the
payment UI. The terms of service open in a separate tab when clicked.

{:.text-center}
![screenshot of payment UI with added terms of service][tos-payment]

{:.code-view-header}
**Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
        "urls": {
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditions.pdf",
            "logoUrl": "https://example.com/logo.png"
        }
    }
}
```

{:.table .table-striped .mb-5}
| Field                    | Type         | Description       |
| :----------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | {% f urls %}                     | `object`     | The `urls` object, containing the URLs relevant for the payment order.                                                                                                                                                                                                                                   |
| {% icon check %} | {% f termsOfServiceUrl, 2 %}       | `string`     | {% include fields/terms-of-service-url.md %}                               |

[tos-payment]: /assets/img/checkout/tos-payment-ui.png
