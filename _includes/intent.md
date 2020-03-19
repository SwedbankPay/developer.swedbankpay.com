{% assign autocapture = include.autocapture | default: false %}
{% assign show_authorization = include.show_authorization | default: true %}
{% assign sale = include.sale | default: false %}

### Intent

The intent of the payment identifies how and when the charge will be
effectuated. This determines the type of transaction used during the payment
process.

{% if show_authorization %}

* **`Authorization` (two-phase)**: If you want the credit card to reserve the
  amount, you will have to specify that the intent of the purchase is
  Authorization. The amount will be reserved but not charged. You will (i.e.
  when you are ready to ship the purchased products) have to make a
  [capture][capture] or [cancel][cancel] request later on to fulfill the
  transaction.
{% endif %}
{% if autocapture %}
* **`AutoCapture` (one-phase)**:  If you want the credit card to be charged
  right away, you will have to specify that the intent of the purchase is
  `AutoCapture`. This is only allowed if the consumer purchases digital
  products. The credit card will be charged automatically after authorization
  and you don't need to do any more financial operations to fulfill the
  transaction.
{% endif %}
{% if sale %}
* **`Sale` (one-phase)**: The `sale` intent is used by the payment instruments
  like Swish, where the funds are reserved and drawn from the payer's account
  immediately. This means you don't need to do any more financial operations to
  fulfill the transaction. The only available after payment operation is
  `reversal`.
{% endif %}

[capture]: ./after-payment#capture
[cancel]: ./after-payment#cancellations
