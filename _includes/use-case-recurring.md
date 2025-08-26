
## Supported Payment Methods

Looking to get started with recurring services? They are currently supported
using card payments.

## Step 1: Create a Payment Order

To initiate recurring services, create a payment order with Swedbank Pay.
This can be done by making an initial purchase, storing user details along with
the transaction, or performing a `Verify` operation for account verification.
`Verify` is a zero-sum operation used solely for registering details for future
use.

You can read more about the basic implementation of a payment order in our
[Get Started][get-started] section. The API calls needed for this use case are
available and ready to use in our [collection of Online Payment APIs][testsuite].
You can use the collection with your own test account or with the generic test
merchant.

## Step 2: Choose Recurring Model and Token

Identify the recurring model and token type based on your needs. We support both
dynamic and static prices and intervals. Use the `RecurrenceToken` flow for
recurring payments with a constant price and interval, and the
`UnscheduledToken` flow for variable services or goods. We **highly** recommend
using the `Unscheduled` option, as it gives you flexibility regarding changes
in amount and interval.

From a technical standpoint, both flows work identically, with the differences
lying in usage areas and limitations set for merchants and expectations from
payers.

## Purchase Example

Start with the [basic payment order request][basic-request] and modify it by
including the parameter `generateUnscheduledToken` or `generateRecurrenceToken`:
`true` | `false`. Include only the token(s) you intend to use.

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% capture request_content %}{
"paymentorder": {
"operation": "Purchase",
"currency": "SEK",
"amount": 1500,
"vatAmount": 375,
"description": "Test Purchase",
"userAgent": "Mozilla/5.0...",
"language": "sv-SE",
"productName": "Checkout3",
"generateUnscheduledToken": "true | false",
"generateRecurrenceToken": "true | false"
    }
}{% endcapture %}

{% include code-example.html
    title='Payment Request'
    header=request_header
    json= request_content
    %}

## Verify

The `Verify` request is identical to the `Purchase` request, with the only tweak
being the value of the `operation` parameter (should be `Verify`). Exclude
`amount`, `vatAmount`, and the `orderItems` object since no monetary value is
associated with this action.

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.x/2.0{% endcapture %}

{% capture request_content %}{
"paymentorder": {
"operation": "Verify",
"currency": "SEK",
"description": "Test Purchase",
"userAgent": "Mozilla/5.0...",
"language": "sv-SE",
"productName": "Checkout3",
"generateUnscheduledToken": "true | false",
"generateRecurrenceToken": "true | false"
    }
}{% endcapture %}

{% include code-example.html
    title='Verify Request'
    header=request_header
    json= request_content
    %}

## Post-Purchase / Post-Verify

After the payer completes their interaction, retrieve the token in the `Paid`
node by performing a `GET` call towards the [`Paid` URL][paid].

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
    "paid": {
    "id": "/psp/paymentorders/08349122-aa53-40e8-dd36-08dbbb319d19/paid",
    "instrument": "CreditCard", // Instrument used
    "number": 40126707630, // Transaction number associated with the action
    "tokens":[
        {
          "type": "unscheduled",
          "token": "e9e61882-7655-4023-adb1-a46b52e786b4",
          "name": "522661******3406",
          "expiryDate": "12/2033"
        },
        {
          "type": "recurrence",
          "token": "812db58a-a10e-4a96-80f2-8247ce2bc8d9",
          "name": "522661******3406",
          "expiryDate": "12/2033"
        }
       // ... other details
    ]
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

## Charging Your Customer

Now that your customer has stored their details and you've retrieved their
token, you are ready to start charging based on the agreed-upon details (price &
interval). Modify the parameters in the `Purchase`/`Verify` request as follows:

*   Operation: Use either `UnscheduledPurchase` or `Recur` based on the stored
    token. Modify the parameter `generateUnscheduledToken` or
    `generateRecurrenceToken` into `unscheduledToken` or `recurrenceToken`:
    "{{ insert-token-here }}".

*   URL: `CallbackUrl` is mandatory and will send you an asynchronous `POST` to
    make sure the information is received. Information regarding the results
    will also be displayed in the direct response to your request.

*   The `payerReference` in the `Payer` node needs to be consistent with the one
    used to create the token details in `Purchase`/`Verify`.

## Removal of Payment Method Details

 When conditions like error codes or payer requests to remove details are met,
 you'll need to delete associated tokens. Here are two methods:

*   Deletion of all tokens:

 Send a `PATCH` call to the base URL with the endpoint
 `/psp/paymentorders/payerOwnedTokens/<payerReference>`.

*   Deletion of a singular token:

Use the URL `/psp/paymentorders/unscheduledTokens/<TokenValue>`.

*   Both scenarios generate the same response.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.x/2.0
api-supported-versions: 3.x/2.0{% endcapture %}

{% capture response_content %}{
"state": "Deleted",
"comment": "Comment on why the deletion is happening"
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

### Common causes that triggers the need for deletion

*   Your customer requests their information to be removed.

*   The agreement with your customer has been terminated or expired.

*   Error codes pertaining to permanent causes, for example `Card expired (54)`
    or `Card stolen (43)`.

## Sources

If you would like to read more in depth about each specific instance, we have
compiled relevant documentation below.

*   Generation of tokens (with value): [Unscheduled][unscheduled],
    [Recur][recur]

*   [Verify][verify] (operation to store details with no sum).

*   [Deletion of tokens][delete-token].

*   [Callback][callback] (asynchronous update).

*   Post-purchase: [Capture][capture], [Cancel][cancel], [Reversal][reversal].

[basic-request]: /checkout-v3/get-started/payment-request/#create-payment-order-v31
[callback]: /checkout-v3/features/payment-operations/callback
[cancel]: /checkout-v3/features/payment-operations/cancel
[capture]: /checkout-v3/features/payment-operations/payment-order-capture
[delete-token]: /checkout-v3/features/optional/delete-token
[get-started]: /checkout-v3/get-started/#the-basic-implementation
[paid]: https://api.externalintegration.payex.com/psp/paymentorders/<PaymentOrderIdHere>/paid
[recur]: /checkout-v3/features/optional/recur
[reversal]: /checkout-v3/features/payment-operations/reversal
[unscheduled]: /checkout-v3/features/optional/unscheduled
[verify]: /checkout-v3/features/optional/verify
[testsuite]: https://www.postman.com/swedbankpay
