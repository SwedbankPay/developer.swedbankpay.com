{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}

## Custom Logo

If you have permission and the feature has been activated in your contract, you
can replace the Swedbank Pay logo in the Payment Menu. See the **abbreviated**
example below with `logoUrl` present in the `paymentOrder` request's `urls`.

*   The logo URL ust be a picture with maximum 50px height and 400px width.
    Requires HTTPS.

*   If the configuration is activated and you add a `logoUrl`, the Swedbank Pay
    logo will be replaced and the text changed accordingly.

*   If the configuration is activated and you do not add a `logoUrl`, no logo or
    text will be shown.

*   If the configuration is deactivated, adding a `logoUrl` has no effect.

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "urls": {
            "logoUrl": "https://example.com/logo.png",
            "hostUrls": [ "https://example.com", "https://example.net" ],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-cancelled",
            "paymentUrl": "https://example.com/perform-payment",
            "callbackUrl": "https://api.example.com/payment-callback",
            "termsOfServiceUrl": "https://example.com/termsandconditions.pdf"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}
