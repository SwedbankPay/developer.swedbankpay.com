{% capture documentation_section %}{% include documentation-section.md %}{% endcapture %}
{% capture documentation_section_url %}{% include documentation-section-url.md %}{% endcapture %}
{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{%- unless documentation_section contains 'checkout' or documentation_section == 'payment-menu' or documentation_section == 'invoice' %}
    {% assign has_one_click = true %}
{%- endunless %}

The `Verify` operation lets you post verification payments, which are used to
confirm the validity of card information without reserving or charging any
amount.

## Introduction to Verify

This option is commonly used when initiating a subsequent
{%- if has_one_click %}
[One-click card payment][one-click-payments] or a
{%- endif %}
[recurring card payment][recurrence] flow - where you do not want
to charge the payer right away.

{% include alert.html type="informative" icon="info" body="
Please note that all boolean credit card attributes involving the rejection of
certain card types are optional and require enabling on the contract with
Swedbank Pay." %}

## Verification through Swedbank Pay Payments

*   When properly set up in your merchant/webshop site and the payer initiates a
    verification operation, you make a `POST` request towards Swedbank Pay with
    your Verify information. This will create a payment resource with a unique
    `id`. You either receive a Redirect URL to a hosted page or a
    JavaScript source in response.
*   You need to
    {%- unless documentation_section contains 'checkout' or documentation_section == 'payment-menu' %}
    [redirect][redirect] the payer's browser to that specified URL, or
    {%- endunless %}
    embed the script source on your site to create a
    {%- unless documentation_section contains 'checkout' or documentation_section == 'payment-menu' %}
    [Seamless View][seamless-view]
    {%- else -%}
    Seamless View
    {%- endunless %}
    in an `iframe`; so that the payer can enter the
    card details in a secure Swedbank Pay hosted environment.
*   Swedbank Pay will handle 3-D Secure authentication when this is required.
*   Swedbank Pay will redirect the payer's browser to - or display directly in
    the `iframe` - one of two specified URLs, depending on whether the payment
    session is followed through completely or cancelled beforehand.
    Please note that both a successful and rejected payment reach completion,
    in contrast to a cancelled payment.
*   When you detect that the payer reach your completeUrl, you need to do a
    `GET` request to receive the state of the transaction.
*   Finally you will make a `GET` request towards Swedbank Pay with the
    `id` of the payment received in the first step, which will return the
    payment result and
    {%- if has_one_click %}
    a `paymentToken` that can be used for subsequent
    [One-Click Payments][one-click-payments] or
    {%- endif %}
    a `recurrenceToken` that can be used for subsequent
    [recurring server-to-server based payments][recurrence].

## Screenshots

You will redirect the payer to Swedbank Pay hosted pages to collect
the credit card information.

{:.text-center}
![screenshot of the swedish card verification page][swedish-verify]{:height="600px" width="475px"}

## API Requests

The API requests are displayed in the Verification flow below. The options you can
choose from when creating a payment with key operation set to Value Verify are
listed below.

Please note that not including `paymentUrl` in the request will generate a
`redirect-verification` operation in the response, meant to be used in the
Redirect flow. Adding `paymentUrl` input will generate the response meant for
Seamless View, which does not include the `redirect-verification`. The request
below is the Redirect option.

{:.code-view-header}
**Request**

```http
POST /psp/{{ api_resource }}/payments HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "payment": {
        "operation": "Verify",
        "currency": "NOK",
        "description": "Test Verification",
        "userAgent": "Mozilla/5.0...",
        "language": "nb-NO",{% unless documentation_section contains "checkout" %}
        "generatePaymentTooken": true,{% endunless %}
        "generateRecurrenceToken": true,{% if documentation_section == "payment-menu" or documentation_section contains "checkout" %}
        "generateUnscheduledToken": true,{% endif %}
        "urls": {
            "hostUrls": ["https://example.com", "https://example.net"],
            "completeUrl": "https://example.com/payment-completed",
            "cancelUrl": "https://example.com/payment-canceled",
            "logoUrl": "https://example.com/payment-logo.png",
            "termsOfServiceUrl": "https://example.com/payment-terms.html"
        },
        "payeeInfo": {
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "CD1234",
            "payeeName": "Merchant1",
            "productCategory": "A123",
            "orderReference": "or-12456",
            "subsite": "MySubsite"
        },
        "payer": {
            "payerReference": "AB1234",
        }
    },
    "creditCard": {
        "rejectCreditCards": false,
        "rejectDebitCards": false,
        "rejectConsumerCards": false,
        "rejectCorporateCards": false
    }
}
```

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
        "number": 1234567890,
        "created": "2016-09-14T13:21:29.3182115Z",
        "updated": "2016-09-14T13:21:57.6627579Z",
        "operation": "Verify",
        "state": "Ready",
        "currency": "NOK",
        "amount": 0,
        "description": "Test Verification",
        "initiatingSystemUserAgent": "PostmanRuntime/3.0.1",
        "userAgent": "Mozilla/5.0",
        "language": "nb-NO",
        "transactions": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions" },
        "verifications": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/verifications" },
        "urls" : { "id": "/psp/creditcard/payments/{{ page.payment_id }}/urls" },
        "payeeInfo" : { "id": "/psp/creditcard/payments/{{ page.payment_id }}/payeeInfo" },
        "payers": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/payers" },
        "settings": { "id": "/psp/creditcard/payments/{{ page.payment_id }}/settings" }
    },
    "operations": [
        {
            "href": "{{ page.api_url }}/psp/{{ include.api_resource }}/payments/{{ page.payment_id }}",
            "rel": "update-payment-abort",
            "method": "PATCH",
            "contentType": "application/json"
        },
        {
            "href": "{{ page.front_end_url }}/{{ include.api_resource }}payments/verification/{{ page.payment_token }}",
            "rel": "redirect-verification",
            "method": "GET",
            "contentType": "application/json"
        },
        {
            "method": "GET",
            "href": "{{ page.front_end_url }}/{{ include.api_resource }}core/scripts/client/px.creditcard.client.js?token={{ page.payment_token }}",
            "rel": "view-verification",
            "contentType": "application/javascript"
        },
        {
            "method": "POST",
            "href": "{{ page.front_end_url }}/psp/{{ include.api_resource }}/confined/payments/{{ page.payment_id }}/verifications",
            "rel": "direct-verification",
            "contentType": "application/json"
        }
    ]
}
```

## Verification flow

The sequence diagram below shows the two requests you have to send to Swedbank
Pay to make a purchase. The links will take you directly to the API description
for the specific request. The diagram also shows in high level, the sequence of
the process of a complete purchase.
When dealing with credit card payments, 3-D Secure authentication of the
cardholder is an essential topic. There are three alternative outcome of a
credit card payment:

*   3-D Secure enabled - by default, 3-D Secure should be enabled, and Swedbank
    Pay will check if the card is enrolled with 3-D Secure. This depends on the
    issuer of the card. If the card is not enrolled with 3-D Secure, no
    authentication of the cardholder is done.
*   Card supports 3-D Secure - if the card is enrolled with 3-D Secure, Swedbank
    Pay will redirect the cardholder to the autentication mechanism that is
    decided by the issuing bank. Normally this will be done using BankID or Mobile
    BankID.

```mermaid
sequenceDiagram
    participant Payer
    participant Merchant
    participant SwedbankPay as Swedbank Pay
    participant IssuingBank

  activate Payer
  Payer->>+Merchant: start verification
  deactivate Payer
  Merchant->>+SwedbankPay: POST /psp/{{ include.api_resource }}/payments(operation=VERIFY)
  deactivate Merchant
  note left of Payer: First API request
  SwedbankPay-->+Merchant: payment resource
  deactivate SwedbankPay
  Merchant-->>+Payer: redirect to verification page
  deactivate Merchant
  Payer->>+SwedbankPay: access verification page
  deactivate Payer
  note left of Payer: redirect to SwedbankPay<br>(If Redirect scenario)
  SwedbankPay-->>+Payer: display purchase information
  deactivate SwedbankPay

  Payer->>Payer: input {{ include.api_resource }} information
  Payer->>+SwedbankPay: submit {{ include.api_resource }}information
  deactivate Payer
  opt Card supports 3-D Secure
    SwedbankPay-->>Payer: redirect to IssuingBank
    deactivate SwedbankPay
    Payer->>IssuingBank: 3-D Secure authentication process
    Payer->>+SwedbankPay: access authentication page
    deactivate Payer
  end

  SwedbankPay-->>+Payer: redirect to merchant
  deactivate SwedbankPay
  note left of Payer: redirect back to merchant<br>(If Redirect scenario)

  Payer->>+Merchant: access merchant page
  Merchant->>+SwedbankPay: GET <payment.id>
  deactivate Merchant
  note left of Merchant: Second API request
  SwedbankPay-->>+Merchant: rel: redirect-authorization
  deactivate SwedbankPay
  Merchant-->>Payer: display purchase result
  deactivate Merchant

  opt Callback is set
    activate SwedbankPay
    SwedbankPay->>SwedbankPay: Payment is updated
    SwedbankPay->>Merchant: POST Payment Callback
    deactivate SwedbankPay
  end
```

[seamless-view]: {{ documentation_section_url }}/seamless-view
[one-click-payments]: {{ documentation_section_url }}/features/optional/one-click-payments
[recurrence]: {{ documentation_section_url }}/features/optional/recur
[redirect]: {{ documentation_section_url }}/redirect
[swedish-verify]: /assets/img/payments/swedish-verify.png
