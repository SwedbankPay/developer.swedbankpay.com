{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}
{% if features_url contains "payment-instruments" %}
    {% capture capture_url %}capture{% endcapture %}
{% else %}
    {% capture capture_url %}payment-order-capture{% endcapture %}
{% endif %}
{% if documentation_section contains "payment-menu" or "checkout" %}
    {% capture verification_url %}/psp/paymentorders/{{ page.payment_id }}/verifications{% endcapture %}
    {% capture authorization_url %}/psp/paymentorders/{{ page.payment_id }}/authorizations{% endcapture %}
    {% capture purchase_url %}/psp/paymentorders{% endcapture %}
{% else %}
    {% capture verification_url %}/psp/{{ api_resource }}/payments/{{ page.payment_id }}/verifications{% endcapture %}
    {% capture authorization_url %}/psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations{% endcapture %}
    {% capture purchase_url %}/psp/{{ api_resource }}/payments/{{ page.payment_id }}{% endcapture %}
{% endif %}

## One-Click Payments

{% include jumbotron.html body="One-Click Payments utilize a previously
generated payment token to prefill payment details for credit card payments
pages - which means that the payer don't need to enter these details for every
purchase." %}

## Introduction

{% if documentation_section contains "checkout-v3" %}

For card and Trustly payments, the payment flow and implementation varies from
your default only being the use of a `paymentToken`. The details in this section
describe explicitly the parameters that must be set to enable one-click
purchases.

{% else %}

For [card][card] payments, the payment flow and implementation varies from your
default only being the use of a `paymentToken`. The details in this section
describe explicitly the parameters that must be set to enable one-click
purchases.

{% endif %}

## API Requests To Generate The Payment Token

When making the initial purchase request, you need to generate a `paymentToken`.
You can do this by setting the `generatePaymentToken` field in the request's
payment object to `true` (see example below) when doing a card purchase, or
setting the initial operation to [`Verify`][verify].

{% capture request_content %}{
    "generatePaymentToken": true,
    "payer": {
    "payerReference": "AB1234",
    }
}{% endcapture %}

{% include code-example.html
    title='generatePaymentToken field'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                              | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :--------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  | {% f generatePaymentToken, 0 %}                     | `bool`     | Determines if a payment token should be generated. Default value is `false`.                                                                                                                                                                                                                                             |
| | {% f payer, 0 %}                | `object`     | The payer object                                                                                                                                                                                                                                           |
| | {% f payerReference, 0 %}                 | `string`     | A reference used to recognize the payer when no SSN is stored.                                                                                                                                                                                                                                                                            |
{% endcapture %}
{% include accordion-table.html content=table %}

## Finding The `paymentToken` Value

{% if documentation_section contains "payment-instruments" %}

When the initial purchase is successful, a `paymentToken` is linked to
the payment. You can return the value by sending a `GET` request towards the
payment resource (expanding either the authorizations or verifications
sub-resource), after the payer successfully has completed the purchase. The two
examples are provided below.

{% capture request_header %}GET  {{ verification_url }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% else %}

When the initial purchase is successful, a `paymentToken` is linked to
the payment. You can return the value by performing a `GET` request towards the
payment resource with the `payerReference` included.

{% capture request_header %}GET /psp/paymentorders/payerownedtokens/{{ page.payment_token }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Get Request Payment Resource'
    header=request_header
    %}

You can also perform a GET request towards the `id` of a Payment Order and find
the paymentToken in its linked [`paid` resource][paid-resource].

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_id }}/paid HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='GET Request Paid Resource'
    header=request_header
    %}

{% endif %}

You need to store the `paymentToken` from the response in your system and keep
track of the corresponding `payerReference` in your system.

## Returning Purchases

{% unless documentation_section contains "checkout" or "payment-menu" %}

When a known payer (where you have attained a `payerReference` or similar)
returns to your system, you can use the `paymentToken`, using already stored
payment data, to initiate one-click payments.

You will need to make a standard purchase, following the sequence as specified
in the Redirect or Seamless View scenarios for [credit card][card]. When
creating the first `POST` request you insert the `paymentToken` field. This must
be the `paymentToken` you received in the initial purchase, where you specified
the `generatePaymentToken` to `true`.

You can add the field `noCvc` set to `false` in the `creditcard` object to make
the CVC field present. This feature needs to be enabled in your contract.
Otherwise it will be `true`.

{% if documentation_section contains "payment-instruments" %}

See the Features section for how to create a [card][create-card-payment]
payment.

## One-Click Request

Abbreviated code example:

{% capture request_header %}POST {{ purchase_url }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "payment": {
        "operation": "Purchase",
        "intent": "Authorization",
        "paymentToken": "{{ page.payment_token }}"
    },
    "creditCard": {
        "noCvc": true
    }
}{% endcapture %}

{% include code-example.html
    title='One-Click Request'
    header=request_header
    json= request_content
    %}

{% endif %}

{:.table .table-striped}
|     Required     | Field                  | Type      | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :--------------: | ---------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f payment, 0 %}              | `object`  | The `payment` object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | {% f operation %}    | `string`  | {% include fields/operation.md resource="payment" %} |
| {% icon check %} | {% f intent %}       | `string`  | {% include fields/intent.md %} |
| {% icon check %} | {% f paymentToken %} | `string`  | The `paymentToken` value received in `GET` response towards the Payment Resource is the same `paymentToken` generated in the initial purchase request. The token allow you to use already stored card data to initiate one-click payments.                                                                                                                                                                                                                                                                                                                                                |
|                  | {% f creditCard %}   | `object`  | An object that holds different scenarios for card payments.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|                  | {% f noCvc, 2 %}       | `boolean` | To use this feature it has to be enabled on the contract with Swedbank Pay. The CVC field is not required in the UI, but you can set it to `false` if you want to show it. Otherwise it will be set to `true`.                                                                                                                                                                                                                                                                                                                                                                               |

{% endunless %}

When a known payer returns, you can display their details by initiating the
transaction with the parameter `paymentToken` and its associated value. Please
note that the value in `payerReference` needs to be identical to the value given
when the token was generated. We highly recommend that you use a value that
represents the customer in your system, so it's easier to keep track. An example
could be an alpha-numerical value like "ABC123".

For card payments, using `payerReference` and `generatePaymentToken: true` will
display all (max 3) cards connected to the payerReference. If you wish to
display one specific card only, you can remove `generatePaymentToken` and add
the field `paymentToken` in it's place. This must be the paymentToken generated
in the initial purchase.

{% if documentation_section contains "payment-instruments" %}

You can add the field `noCvc` set to `true` in the `creditcard` object,
containing card specific feature fields. This disables the CVC field.

## One-Click Request Displaying A Specific Card

{% capture request_header %}POST {{ purchase_url }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "payment": {
        "operation": "Purchase",
        "intent": "Authorization",
        "paymentToken": "{{ page.payment_token }}"
    },
    "payer": {
        "payerReference": "AB1234",
    },
    "creditCard": {
        "noCvc": true
    }
}{% endcapture %}

{% include code-example.html
    title='One-Click Request Displaying A Specific Card'
    header=request_header
    json= request_content
    %}

{% else %}

## One-Click Request Displaying All Cards

{% capture request_header %}POST {{ purchase_url }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "Purchase",
        "generatepaymentToken": "true"
    },
    "payer": {
        "payerReference": "AB1234",
    }
}{% endcapture %}

{% include code-example.html
    title='One-Click Request Displaying All Cards'
    header=request_header
    json= request_content
    %}

## One-Click Request Displaying A Specific Card

{% capture request_header %}POST {{ purchase_url }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
    "paymentorder": {
        "operation": "Purchase",
        "paymentToken": "{{ page.payment_token }}"
    },
    "payer": {
        "payerReference": "AB1234",
    }
}{% endcapture %}

{% include code-example.html
    title='One-Click Request Displaying A Specific Card'
    header=request_header
    json= request_content
    %}

{% endif %}

{% if documentation_section contains "payment-instruments" %}

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                  | Type      | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :--------------: | ---------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f payment, 0 %}   | `object`  | The `payment` object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | {% f operation %}    | `string`  | {% include fields/operation.md resource="payment" %} |
| {% icon check %} | {% f intent %}       | `string`  | {% include fields/intent.md %}                    |
| {% icon check %} | {% f paymentToken %} | `string`  | The `paymentToken` value received in `GET` response towards the Payment Resource is the same `paymentToken` generated in the initial purchase request. The token allow you to use already stored card data to initiate one-click payments.                                                                                                                                                                                                                                                                                                                                                |
|                  | {% f generatePaymentToken %}     | `bool`       | Determines if a payment token should be generated. Default value is `false`.                                               |
|                  | {% f payer %}                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                |
|                  | {% f payerReference, 2 %}                     | `string`     | A reference used in the Enterprise and Payments Only implementations to recognize the payer when no SSN is stored.                                                                                                                                                                                                            |
|                  | {% f creditCard %}   | `object`  | An object that holds different scenarios for card payments.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|                  | {% f noCvc, 2 %}       | `boolean` | `true` if the CVC field should be disabled for this payment in the case a stored card is used; otherwise `false` per default. To use this feature it has to be enabled on the contract with Swedbank Pay.                                                                                                                                                                                                                                                                                                                                                                                 |
{% endcapture %}
{% include accordion-table.html content=table %}

{% else %}

{:.table .table-striped}
|     Required     | Field                  | Type      | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :--------------: | ---------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f paymentOrder, 0 %}              | `object`  | The `paymentorder` object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {% icon check %} | {% f operation %}    | `string`  | {% include fields/operation.md %} |
| {% icon check %} | {% f paymentToken %} | `string`  | The `paymentToken` value received in `GET` response towards the Payment Resource is the same `paymentToken` generated in the initial purchase request. The token allow you to use already stored card data to initiate one-click payments.                                                                                                                                                                                                                                                                                                                                                |
|                  | {% f generatePaymentToken %}     | `bool`       | Determines if a payment token should be generated. Default value is `false`.                                               |
|                  | {% f payer %}                    | `object`     | The `payer` object containing information about the payer relevant for the payment order.                                                                                                                                                                                                                |
|                  | {% f payerReference %}                     | `string`     | A reference used in the Enterprise and Payments Only implementations to recognize the payer when no SSN is stored.                                                                                                                                                                                                            |

{% endif %}

{% if documentation_section contains "checkout-v3" %}

## Disable Store Details and Toggle Consent Checkbox

This is a feature intended for instrument mode and or custom menus.

If you have built your own interface to display previously stored details and
generate transactions using them ("One-Click Request Displaying A Specific
Card"), you will also  have the need to include an option for them to store new
details. This can be performed using either a `Purchase` or `Verify` operation.

For `Purchase` operations aiming to store new details simultaneously, you will
need to utilize the `disableStoredPaymentDetails` parameter. This is because the
payer has already made the decision not to use any stored details in your
interface. By including this parameter, you effectively eliminate the need for
confirmation in our UI, due to how the combination of `generatePaymentToken` and
`payerReference` works in our API.

By employing this parameter, you as the Merchant will assume the responsibility
of colllecting the payer's consent for purpose of storing their details. If you
do not want this responsibility and would like for us to help you out, you can
combine `disableStoredPaymentDetails` along with
`enablePaymentDetailsConsentCheckbox` and flag them both as `true`. That will
enable our handler for collecting consent from the payer for you inside our
Swedbank Pay UI. When the choice has been made and transaction is completed, we
will relay that information to you. We will do this by setting the flag
`paymentTokenGenerated` in the subsequent `GET` call towards the `PaymentOrder`
to either `true` or `false`.

`Verify` operations do not require the use of these additional parameters, as
they do not display any previously stored details based on your supplied
reference, thereby avoiding redundancy. Including them in a `Verify` will result
in a validation error.

{% capture request_content %}{
 "paymentorder": {
    "enablePaymentDetailsConsentCheckbox": true,
    "disableStoredPaymentDetails": true,
  }
}{% endcapture %}

{% include code-example.html
    title='generatePaymentToken field'
    header=request_header
    json= request_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
|     Required     | Field                              | Type         | Description                                                                                                                                                                                                                                                                                              |
| :--------------: | :--------------------------------- | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| {% icon check %} | {% f paymentOrder, 0 %}                     | `object`     | The payment order object.                                                                                                                                                                                                                                                                                |
|  | {% f EnablePaymentDetailsConsentCheckbox %}                     | `bool`     | Set to `true` or `false`. Used to determine if the checkbox used to save payment details is shown or not. Will only work if the parameter `disableStoredPaymentDetails` is set to `true`.                                                                                                                                                                                                                                                                                 |
|  | {% f disableStoredPaymentDetails %}                     | `bool`     | Set to `true` or `false`. Must be set to `true` for `enablePaymentDetailsConsentCheckbox` to work.                                                                                                                                                                                                                                           |

{% endcapture %}
{% include accordion-table.html content=table %}

{% endif %}

## Delete Payment Token

If you need to delete a `paymentToken`, you have two options. The first is by
`payerReference`, which deletes all payment, recurrence and/or unscheduled
tokens associated with the payer. The second is by `paymentToken`, which only
deletes a specific token.

{% include alert.html type="warning"
                      icon="warning"
                      body="Please note that this call does not erase the card
  number stored at Swedbank Pay.
  A card number is automatically deleted six months after a successful
  `Delete payment token` request.
  If you want card information removed at an earlier date, you need to contact
  [ehandelsetup@swedbankpay.dk](mailto:ehandelsetup@swedbankpay.dk),
  [verkkokauppa.setup@swedbankpay.fi](mailto:verkkokauppa.setup@swedbankpay.fi),
  [ehandelsetup@swedbankpay.no](mailto:ehandelsetup@swedbankpay.no) or
  [ehandelsetup@swedbankpay.se](mailto:ehandelsetup@swedbankpay.se);
  and supply them with the relevant transaction reference or payment token." %}

If you want to delete tokens by `payerReference`, the request and response
should look like the below. You should retrieve the tokens by performing a `GET`
towards the payerReference below before doing the `PATCH`, to make sure you have
the correct token input.

## Delete Payment Token Request

{% capture request_header %}PATCH /psp/paymentorders/payerownedtokens/<payerReference> HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0      // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
  "state": "Deleted",
  "comment": "Comment stating why this is being deleted"
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% comment %}
TODO: Remove pipes from the above code example and add a field table
      explaining each field here.
{% endcomment %}

## Delete Payment Token Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "payerOwnedTokens": {
        "id": "/psp/paymentorders/payerownedtokens/123456",
        "payerReference": "123456",
        "tokens": [
            {
                "tokenType": "Payment",
                "token": "7fc5e705-d2c4-4c8b-8ff7-d40c355d6916",
                "instrument": "CreditCard",
                "instrumentDisplayName": "522661******3406",
                "instrumentParameters": {
                    "expiryDate": "12/2033",
                    "cardBrand": "MasterCard"
                }
            },
            {
                "tokenType": "Payment",
                "token": "ddd3ddf7-58ab-43f2-8d72-3a1899f33252",
                "instrument": "CreditCard",
                "instrumentDisplayName": "476173******0416",
                "instrumentParameters": {
                    "expiryDate": "12/2033",
                    "cardBrand": "Visa"
                }
            }
        ]
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

## Deleting Single Tokens

{% if documentation_section contains "checkout" %}

For single token deletions, the request and response should look like this. In
this example, the token is connected to a card. For Trustly transactions, it
will be a masked account number.

## Delete Single Token Request For Checkout Integrations

{% capture request_header %}PATCH /psp/paymentorders/paymenttokens/{{ page.payment_token }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0 // Version optional for 3.0 and 2.0{% endcapture %}

{% capture request_content %}{
  "state": "Deleted",
  "comment": "Comment stating why this is being deleted"
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

## Delete Single Token Response For Checkout Integrations

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.1
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
  "paymentToken": "{{paymentToken}}",
    "instrument": "CreditCard",
    "instrumentDisplayName": "492500******0004",
    "correlationId": "e2f06785-805d-4605-bf40-426a725d313d",
    "instrumentParameters": {
        "expiryDate": "12/2022",
        "cardBrand": "Visa"
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% else %}

For single token deletions, the request and response should look like this. In
this example, the token is a payment token and is connected to a card.

## Delete Single Token Request

{% capture request_header %}PATCH /psp/creditcard/payments/instrumentData/{{ page.payment_token }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
  "state": "Deleted",
  "comment": "Comment on why the deletion is happening",
  "tokenType" : "PaymentToken"
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

## Delete Single Token Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
  "instrumentData": {
    "id": "/psp/creditcard/payments/instrumentdata/12345678-1234-1234-1234-123456789000",
    "paymentToken": "12345678-1234-1234-1234-123456789000",
    "payeeId": "61c65499-de5c-454e-bf4c-043f22538d49",
    "isDeleted": true,
    "isPayeeToken": false,
    "cardBrand": "Visa",
    "maskedPan": "123456xxxxxx1111",
    "expiryDate": "MM/YYYY",
    "tokenType" : "PaymentToken"
  }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% endif %}

<!--lint disable final-definition -->

[card]: /old-implementations/payment-instruments-v1/card
[one-click-image]: /assets/img/checkout/new-one-click.png
[create-card-payment]: /old-implementations/payment-instruments-v1/card/features/technical-reference/create-payment
[paid-resource]: /checkout-v3/technical-reference/status-models#paid
[verify]: /checkout-v3/features/optional/verify
