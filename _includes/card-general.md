{% include alert.html type="neutral" icon="info" body="**No 3-D Secure and card
acceptance**: There are optional parameters that can be used in relation to 3-D
Secure and card acceptance. By default, most credit card agreements with an
acquirer will require that you use 3-D Secure for card holder authentication.
However, if your agreement allows you to make a card payment without this
authentication, or that specific cards can be declined, you may adjust these
optional parameters when posting in the payment. This is specified in the
technical reference section for creating credit card payments – you will find
the link in the sequence diagram below." %}

{% include alert.html type="success" icon="link" body="**Defining
`callbackUrl`**: When implementing a scenario, it is optional to set a
`callbackUrl` in the `POST` request. If `callbackUrl` is set Swedbank Pay will
send a `POST` request to this URL when the consumer has fulfilled the payment.
[See the Callback API description for more
information](/payments/card/other-features#callback)." %}
