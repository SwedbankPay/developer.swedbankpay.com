{% capture documentation_section %}{%- include documentation-section.md -%}{% endcapture %}

## Enterprise PayerReference

If a merchant wants to use the **Enterprise** implementation and has a secure
login, but doesn't store the payer's SSN, they can add a `payerReference` in the
`payer` field of the payment request.

If the `payerReference` is present along with `email` and `msisdn`, the merchant
doesn't need to add a `nationalIdentifier`. Other than that, it is the same as
a regular [Redirect][enterprise-redirect] or [Seamless
View][enterprise-seamless-view] request using the **Enterprise** implementation.

If no existing consumer profile exists on the `payerReference` or `email` and
`msisdn`, the payer will be asked to enter their social security number as shown
below. This information is needed in order to store payment information. The
payer will be given the option to continue as a guest. When doing so, no payment
information will be stored.

## How It Looks

{:.text-center}
![Payer is presented with SSN input or continue as guest][enterprise-enter-ssn]

[enterprise-enter-ssn]: /assets/img/checkout/enterprise-enter-ssn.png
[enterprise-redirect]: /checkout-v3/enterprise/redirect#step-1-create-payment-order
[enterprise-seamless-view]: /checkout-v3/enterprise/seamless-view#step-1-create-payment-order
[payments-only-redirect]: /checkout-v3/payments-only/redirect#step-1-create-payment-order
[payments-only-seamless-view]: /checkout-v3/payments-only/seamless-view#step-1-create-payment-order
