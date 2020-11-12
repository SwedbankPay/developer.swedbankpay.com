## Payment And Transaction States

Both payments and transactions can be in several different states during
the course of a purchase. You can find a short description of each state below.

### Payment States

*   `ready` means that the payment has been created successfully, and is now
    ready for further transaction operations, like `authorization`, `sale` or
    `abort`.

*   `failed` means that something went wrong during the payment process, and no
    further transactions can be created if the payment is in this state.
    Examples of possible failures are triggering of anti-fraud protection or if
    the payer reaches the maximum number of attempts for a given payment.

*   `aborted` means that the merchant has aborted the payment before the
    payer has fulfilled the payment process. Aborting a payment is done by
    performing the `update-payment-abort` operation.

*   `pending` is the state of a payment when a transaction is in an
    `initialized` state. See more below. As long as a payment is `pending`, no
    further transactions can be done.

{% capture alert %}
If you want to inspect the transactional status of a payment, read about the
[`paid-payment`](#operation-paid-payment),
[`failed-payment`](#operation-failed-payment) and
[`aborted-payment`](#operation-aborted-payment) operations.
{% endcapture %}

{% include alert.html type="informative" icon="info" body=alert %}

### Transaction States

*   `ìntialized` is the transaction state when something unexpected occured, and
   it is impossible to determine the exact status of the transaction.
   An example of this can be a network failure.
   No further actions can be done on a payment with a transaction in this state.

*   `completed` means that the transaction has reached its intended purpose. An
    `authorization` will be `completed` when the funds have been authorized, a
    `capture` will be `completed` when the funds have been captured and a
    `reversal` will be `completed` when the payer has been refunded.

*   `failed` means that the transaction has `failed`. The state is final for
    that specific transaction, but given that the payment is operational, it is
    possible to perform more transactions on the same payment, i.e. retry the
    authorization with another card.
    If the payer reaches the maximum amount of retries, the payment itself will
    be set to `failed`.

*   `awaitingActivity` is in use for a selection of payment instruments. A
    transaction reaches this state when a payer is sent away from Swedbank Pay
    to do a confirmation or verification. Examples of this can be payment apps
    like Swish, Vipps or MobilePay, or 3-D Secure verifications for card
    payments.
