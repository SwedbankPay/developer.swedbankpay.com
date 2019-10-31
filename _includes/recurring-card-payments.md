## Recurring payments

{% include jumbotron.html body="A recurring payment enables you to charge a
credit card without any consumer interaction. When an initial payment token is
generated subsequent payments is made through server-to-server requests. " %}

### Prerequisites

Prior to making any server-to-server requests, you need to supply the payment instrument details and a payment token to PayEx by initial purchase or [card verification][payment-verify].

There are two ways to initiate recurring payments procedures, depending on if you want to make an initial charge or not:

* Initiate a recurring payment flow and **charge the credit card**. This is done by creating a "Purchase Payment" and generating a recurrence token.

* Initiate a recurring payment flow **without charging the credit card**. This is done by creating  a "Verify Payment" and generating a recurrence token.

#### Generate RecurrenceToken

* When posting a `Purchase` payment, you need to make sure that the attribute `generateRecurrenceToken` is set to `true`

{:.code-header}
**Attribute**

```JS
"generateRecurrenceToken": "true"
```

* When posting a `Verify` payment, a payment token will be generated automatically.

#### Creating a Payment

* You need to `POST` a [Purchase payment][card-payment-purchase] / and generate a recurrence token (safekeep for later recurring use).

* You need to `POST` a [Verify payment][payment-verify], that will automatically generate a recurrence token (for later recurring use).

#### Retreive Recurrence Token

The recurrence token can then be retrieved by doing a `GET` request against the `paymen`. You need to store this `recurrenceToken` in your system and keep track of the corresponding consumer-ID.

#### Delete Recurrence Token

You can delete a created recurrence token with a `PATCH`-request. Please see technical reference for details [here][card-payments-remove-payment-token].

### Recurring purchases

When you have a Recurrence token stored away. You can use the same token in a subsequent [`recurring payment`][card-payment-recur] `POST`. This will be a server-to-server affair, as we have both payment instrument details and recurrence token from the initial payment. Please note that this `POST`request is made directly on the payment level, and will not create a payment order.

#### Options after a payment

You have the following options after a server-to-server Recur payment `POST`.

##### Autorization (intent)

* **Authorization (two-phase):** If you want the credit card to reserve the amount, you will have to specify that the intent of the purchase is Authorization. The amount will be reserved but not charged. You will later (i.e. when you are ready to ship the purchased products) have to make a [Capture][card-payment-capture] or [Cancel][card-payment-cancel] request.

##### Capture (intent)

* **AutoCapture (one-phase)**: If you want the credit card to be charged right away, you will have to specify that the intent of the purchase is AutoCapture. The credit card will be charged and you don't need to do any more financial operations to this purchase.​​​​​

##### General 

* **Defining CallbackURL**: When implementing a scenario, it is optional to set a [`CallbackURL`][technical-reference-callbackurl]  in the `POST` request. If callbackURL is set PayEx will send a postback request to this URL when the consumer has fulfilled the payment. [See the Callback API description here][technical-reference-callback].

[payment-verify]: #
[card-payment-purchase]: #
[card-payment-verify]: #
[card-payment-recur]: #
[card-payment-capture]: #
[card-payment-cancel]: #
[card-payments-remove-payment-token]: #
[technical-reference-callbackurl]: #
[technical-reference-callback]: #