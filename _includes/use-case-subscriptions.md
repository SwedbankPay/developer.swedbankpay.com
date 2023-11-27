
## Supported Payment Instruments

Looking to get started with subscription services? They are currently supported
in Digital Payments using these instruments:

*   Card payments
*   Trustly payments

## Step 1: Create a Payment Order

To initiate subscription services, create a payment order with Swedbank Pay.
This can be done by making an initial purchase, storing user details along with
the transaction, or performing a `Verify` operation for account verification.
`Verify` is a zero-sum operation used solely for registering details for future
use.

## Step 2: Choose Subscription Model and Token

Identify the subscription model and token type based on your needs. We support
both dynamic and static prices and intervals. Use the `RecurrenceToken` flow for
constant price and interval subscriptions, and the `UnscheduledToken` flow for
variable services or goods.

From a technical standpoint, both flows work identically, with the differences
lying in usage areas and limitations set for merchants and expectations from
payers.

## Purchase Example

Start with the [basic payment order request][basic-request] and modify it by
including the parameter `generateUnscheduledToken` or `generateRecurrenceToken`:
`true` | `false`. Include only the token(s) you intend to use.

{:.code-view-header}
**Payment Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.1/3.0/2.0

{
"paymentorder": {
"operation": "Purchase",
"currency": "SEK",
"amount": 1500,
"vatAmount": 375,
"description": "Test Purchase",
"userAgent": "Mozilla/5.0...",
"language": "sv-SE",
"productName": "Checkout3",
"generateRecurrenceToken": "true | false",
"generateUnscheduledToken": "true | false"
    }
}
```

## Verify

The `Verify` request is identical to the `Purchase` request, with the only tweak
being the value of the `operation` parameter (should be `Verify`). Exclude
`amount`, `vatAmount`, and the `orderItems` object since no monetary value is
associated with this action.

{:.code-view-header}
**Verify Request**

```http
POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.1/3.0/2.0

{
"paymentorder": {
"operation": "Verify",
"currency": "SEK",
"description": "Test Purchase",
"userAgent": "Mozilla/5.0...",
"language": "sv-SE",
"productName": "Checkout3",
"generateRecurrenceToken": "true | false",
"generateUnscheduledToken": "true | false"
    }
}
```

## Post-Purchase / Post-Verify

After the payer completes their interaction, retrieve the token in the `Paid`
node by performing a `GET` call towards the [`Paid` URL][paid].

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.1/3.0/2.0
api-supported-versions: 3.1/3.0/2.0

{
    "paid": {
    "id": "/psp/paymentorders/08349122-aa53-40e8-dd36-08dbbb319d19/paid",
    "instrument": "CreditCard", // Instrument used
    "number": 40126707630, // Transaction number associated with the action
    "tokens":[
        {
          "type": "recurrence",
          "token": "e9e61882-7655-4023-adb1-a46b52e786b4",
          "name": "522661******3406",
          "expiryDate": "12/2033"
        },
        {
          "type": "unscheduled",
          "token": "812db58a-a10e-4a96-80f2-8247ce2bc8d9",
          "name": "522661******3406",
          "expiryDate": "12/2033"
        }
       // ... other details
    }
}
```

## Charging Your Customer

Now that your customer has stored their details and you've retrieved their
token, you are ready to start charging based on the agreed-upon details (price &
interval). Modify the parameters in the `Purchase`/`Verify` request as follows:

*   Operation: Use either `Recur` or `UnscheduledPurchase` based on the stored
    token. Modify the parameter `generateRecurrenceToken` or
    `generateUnscheduledToken` into `recurrenceToken` or `unscheduledToken`:
    "{{ insert-token-here }}".

*   URL: `CallbackUrl` is mandatory and will send you an asynchronous `POST` to
    make sure the information is received. Information regarding the results
    will also be displayed in the direct response to your request.

*   The `payerReference` in the `Payer` node needs to be consistent with the one
    used to create the token details in `Purchase`/`Verify`.

## Removal of Instrument Details

 When conditions like error codes or payer requests to remove details are met,
 you'll need to delete associated tokens. Here are two methods:

*   Deletion of all tokens:

 Send a `PATCH` call to the base URL with the endpoint
 `/psp/paymentorders/payerOwnedTokens/<payerReference>`.

*   Deletion of a singular token:

Use the URL `/psp/paymentorders/recurrenceTokens/<TokenValue>`.

*   Both scenarios generate the same response.

{:.code-view-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.1/3.0/2.0
api-supported-versions: 3.1/3.0/2.0

{
"state": "Deleted",
"comment": "Comment on why the deletion is happening"
}
```

### Common causes that triggers the need for deletion

*   Your customer requests their information to be removed.

*   The agreement with your customer has been terminated or expired.

*   Error codes pertaining to permanent causes, for example `Card expired (54)`
    or `Card stolen (43)`.

## Sources

If you would like to read more in depth about each specific instance, we have
compiled relevant documentation below.

*   Generation of tokens (with value): [Recur][recur],
    [Unscheduled][unscheduled]

*   [Verify][verify] (operation to store details with no sum).

*   [Deletion of tokens][delete-token].

*   [Callback][callback] (asynchronous update).

*   Post-purchase: [Capture][capture], [Cancel][cancel], [Reversal][reversal].

[basic-request]: /checkout-v3/payment-request#payment-order-request
[callback]: /checkout-v3/features/core/callback
[cancel]: /checkout-v3/features/core/cancel
[capture]: /checkout-v3/features/core/payment-order-capture
[delete-token]: /checkout-v3/features/optional/delete-token
[paid]: https://api.externalintegration.payex.com/psp/paymentorders/<PaymentOrderIdHere>/paid
[recur]: /checkout-v3/features/optional/recur
[reversal]: /checkout-v3/features/core/reversal
[unscheduled]: /checkout-v3/features/optional/unscheduled
[verify]: /checkout-v3/features/optional/verify
