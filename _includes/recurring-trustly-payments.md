## Trustly Recurring

{% include jumbotron.html body="A service where payer interaction is not possible, where the payment is pulled from the payer's bank account by sending a request to Trustly. " %}

{% include alert.html type="warning" icon="warning" body="Please note that this feature is only available through Payment Order, and the service is asynchronous which will require a compatible implementation. Using a similar implementation to Credit Card Recur will therefore not work." %}

## Prerequisites

Prior to making any server-to-server requests, you need to make sure the
`directDebitEnabled` setting in your Trustly contract is set to `true`. Then you
need to supply the payment instrument details and a payment token to Swedbank
Pay by initial purchase or select account verification. Note that the `email`
field must be set, as this is a required parameter. If the `email` is missing,
Trustly will not be available for selection from the payments menu.

If you enable `callbackEnabled` and send a `callbackUrl`, you can expect to get
a callback when the payment is finised. The alternative is setting up polling to
poll for a state.

There are two ways to initiate recurring payments procedures, depending on if
you want to make an initial charge or not:

*   Initiate a recurring payment flow and **charge the bank account**. This is
    done by creating a "Purchase Payment" and generating a recurrence token.

*   Initiate a recurring payment flow **without charging the bank account**.
    This is done by creating a "Verify Payment" and generating a recurrence
    token.

## Generate Recurrence Token

*   When posting a `Purchase` payment, you need to make sure that the field
    `generateRecurrenceToken` is set to `true`.

{:.code-view-header}
**Field**

```json
"generateRecurrenceToken": true
```

*   When posting a `Verify` payment, you need to make sure that the the field
    `generateRecurrenceToken` is set to `true`.

{:.code-view-header}
**Field**

```json
"generateRecurrenceToken": true
```

## Creating The Payment

*   You need to `POST` a [Purchase payment][trustly-paymentorder-create] / and
    generate a recurrence token (for later recurring use). As mentioned, the
    `email` parameter MUST be set for trustly to appear as an available option.

*   You need to `POST` a [Verify payment][trustly-paymentorder-create] / and
    generate a recurrence token (for later recurring use). As mentioned, the
    `email` parameter MUST be set for trustly to appear as an available option.

## Delete Recurrence Token

You can delete a created recurrence token. Please see technical reference for
details [here][trustly-remove-payment-token].

## Recurring Purchases

When you have a Recurrence token, you can use the same token in a subsequent
`recurring payment` `POST`. This will be a server-to-server affair, as we have
both payment instrument details and recurrence token from the initial payment.

## Verify

A `Verify` payment lets you post verifications to confirm the validity of one of
your bank accounts, without reserving or charging any amount. This option is
often used to initiate a recurring payment flow where you do not want to charge
the payer right away.

<!--lint disable final-definition -->

[trustly-remove-payment-token]: /old-implementations/payment-menu-v2/features/optional/delete-token
[trustly-paymentorder-create]: /old-implementations/payment-menu-v2/payment-order
