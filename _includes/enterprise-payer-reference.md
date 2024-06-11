{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}

## Enterprise PayerReference

If a merchant wants to use the **Enterprise** implementation and has a secure
login, but doesn't store the payer's SSN, they can add a `payerReference` in the
`payer` field of the payment request.

If the `payerReference` is present along with `email` and `msisdn`, the merchant
won't need to add a `nationalIdentifier`. Other than that, it is the same as
a regular [Redirect][enterprise-redirect] or
[Seamless View][enterprise-seamless-view] request using the **Enterprise**
implementation.

If no consumer profile exists on the `payerReference` or `email` and `msisdn`,
the payer will be asked to enter their social security number as shown below.
This information is needed in order to store payment information. The payer will
get the option to continue as a guest. When doing so, no payment information
will be stored.

{:.text-center}
![Payer is presented with SSN input or continue as guest][enterprise-enter-ssn]

[enterprise-enter-ssn]: /assets/img/checkout/enterprise-enter-ssn.png
[enterprise-redirect]: /old-implementations/enterprise/redirect#step-1-create-payment-order
[enterprise-seamless-view]: /old-implementations/enterprise/seamless-view#step-1-create-payment-order
