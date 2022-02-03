{% capture documentation_section %}{%- include documentation-section.md -%}{% endcapture %}

## Enterprise PayerReference

If a merchant wants to use the **Enterprise** or **Payments Only**
implementation, but does not have the payer's SSN or a secure login, they can
add a `payerReference` in the `payer` field of the payment request.

{% if documentation_section contains "checkout-v3/enterprise" %}

If the `payerReference` is present along with `email` and `msisdn`, the merchant
does not need to add a `nationalIdentifier`. Other than that, it is the same as
a regular [Redirect][enterprise-redirect] or [Seamless
View][enterprise-seamless-view] request using the **Enterprise** implementation.

{% else %}

If the `payerReference` is present along with `email` and `msisdn`, the merchant
does not need to add a `nationalIdentifier`. Other than that, it is the same as
a regular [Redirect][payments-only-redirect] or [Seamless
View][payments-only-seamless-view] request using the Payments Only
implementation.

{% endif %}

If no existing consumer profile exists on the `payerReference` or `email` and
`msisdn`, the payer will be asked to enter their social security number as shown
below. This information is needed in order to store payment information. The
payer will be given the option to continue as a guest. When doing so, no payment
information will be stored.

{:.text-center}
![Payer is presented with SSN input or continue as guest][enterprise-enter-ssn]

[3d-secure-2]: /checkout-v3/mac/features/core/3d-secure-2
[enterprise-enter-ssn]: /assets/img/checkout/enterprice-enter-ssn.png
[enterprise-redirect]: /checkout-v3/enterprise/redirect#step-1-create-payment-order
[enterprise-seamless-view]: /checkout-v3/enterprise/seamless-view#step-1-create-payment-order
[payments-only-redirect]: /checkout-v3/payments-only/redirect#step-1-create-payment-order
[payments-only-seamless-view]: /checkout-v3/payments-only/seamless-view#step-1-create-payment-order
