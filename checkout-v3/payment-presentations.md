---
section: Checkout v3
title: Payment Instrument Presentations
description: |
  **An overview of all the payment instruments Checkout v3 has to offer.**
menu_order: 400
---

## Apple Pay

Apple Pay provides an easy and secure way to make payments. By using Face ID,
Touch ID, or double-clicking their Apple Watch, payers can quickly and securely
check out. Payers love the simplicity, and you’ll love the increased conversion
rates and new user adoption that comes with it.

### Domain Verification

**Redirect** integrations does not require a domain verification, as it will
be hosted on Swedbank Pay's domain.

For **Seamless View** integrations, Apple needs to verify also your domain as a
part of Swedbank Pay's set up process. To do this, you need to host a
verification file on the following web path:

`https://example.com/.well-known/apple-developer-merchantid-domain-association`

To make sure your file looks correct, you can copy
[our domain file][payex-domain-file] which is already present on our server.

The verification file consists of a hex string which contains a JSON. Opening it
is OK, but make sure that you **upload it exactly as it is**. We recommend
opening it as a text file or something similar, and **not** e.g. in Word or an
editor, as it could result in unwanted formatting changes if you save it. The
file does not, and should not, have a file extension.

To help you validate that your file looks correct, you can
[compare it to this][payex-domain-file], which is already present on our server.

**If you are using our iOS SDK**, you need to ensure that the **WebViewBaseURL**
is set to the exact same domain as where you host the file. Otherwise, it will
not validate.

This file must be in place before we can activate Apple Pay for you.

### Accepting Donations

Apple Pay provides nonprofit organizations a simple and secure way to accept
donations. To register your nonprofit organization for Apple Pay, please visit
[Benevity][benevity-donation-setup].

You’ll be asked to provide basic information about your organization. Note that
the **Apple Developer Team ID** is an **optional** field, so this is not needed.

When you get your approval from Benevity, you need to share it with Swedbank Pay
before we can activate Apple Pay for you. You can e-mail it to
**agreement@swedbankpay.com** together with **Name**, **Organizational** and
**Customer number**.

### Apple Pay Terms And Conditions

Apple requires Swedbank Pay to identify whether and when you have accessed the
Apple Pay Platform Web Merchant Terms and Conditions, and to record whether you
have accepted and agreed to them.

We also need to require you to periodically incorporate updates or amendments to
the terms of the Apple Pay Web Terms and Conditions, Apple Pay Web Guidelines,
Apple Pay HI Guidelines, Apple Pay Best Practices Guide, or Apple Marketing
Guidelines.

Unless you have already accepted as part of signing your agreement with
Swedbank Pay, we can provide the following links for digital signature in
[Sweden][apple-pay-tc-sign-sweden] and [Norway][apple-pay-tc-sign-norway].

If you are unable to sign the Apple Pay Web Terms and Conditions in Swedish or
Norwegian digitally, please use the
[**supplementary agreement template**][apple-pay-sup-agreement] (click to
download) in English, and e-mail it to **agreement@swedbankpay.com** together
with **Name**, **Organizational** and **Customer number**. Your acceptance is
needed before we can activate Apple Pay for you.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started" %}

## Click to Pay

Click to Pay makes it easy for payers to check out, no matter what online
payment channel they choose. All cards are stored in a portable profile they can
be used securely whenever the Click to Pay icon is present. Built on EMV
standards, Click to Pay is a password-free checkout option that delivers
security, convenience and control to the payers.

Unless you have requested Click to Pay as part of signing your agreement with
Swedbank Pay, you can e-mail a request to **agreement@swedbankpay.com** together
with **Name**, **Organizational** and **Customer number**.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started" %}

## Google Pay&trade;

Google Pay&trade; enables quicker, safer checkout in apps and websites, and
makes it easy for customers to pay with their phones. With a simple integration,
you can access hundreds of millions of cards saved to Google Accounts and open
up your business for more business.

With a click, the payers can choose any payment method saved in their Google
Account and check out almost instantly across apps and sites.

### Merchant ID

You need to sign up for a **Google Developer Account** and
[create a **business profile** and **payment profile**][google-pay-profile].

After creating the business profile, you will be able to see your Merchant ID on
the top right corner of the page. We need that ID in order to activate Google
Pay for you.

However, be sure to register your domain/package and submit screenshots of your
integration for approval. Login to
[Google Pay&trade; & Wallet Console][google-pay-profile], go to the
**Google Pay&trade; API tab** and upload the screenshots and submit your
integration for approval. The screenshots should be of the entire buyflow
process (ex: add to cart, checkout, payment, confirmation - if available). Your
**Merchant ID** will only work in production environment once Google complete
their review and approve your submitted integration.

Unless you have provided us with your **Merchant ID** as part of signing your
agreement with Swedbank Pay, you can e-mail us it at
**agreement@swedbankpay.com** together with **Name**, **Organizational** and
**Customer number**.

### Implementation Paths

**Which Google Pay&trade; documentation and guidelines should you use if you**
**are an android merchant?**
[Google Pay Android Developer Documentation][android-googlepay-devdoc],
[Google Pay Android Integration Checklist][android-googlepay-checklist] and the
[Google Pay Android Brand Guidelines][android-googlepay-brand-guidelines].

**Which Google Pay&trade; documentation and guidelines should you use if you**
**are a web merchant?**
[Google Pay Web Developer Documentation][web-googlepay-devdoc],
[Google Pay Web Integration Checklist][web-googlepay-checklist] and the
[Google Pay Web Brand Guidelines][web-googlepay-brand-guidelines].

**Do you as a merchant need to take additional steps with regards to the**
**Google Pay&trade; payment button or other hosted components to your website?**

No additional steps are required. Contact Customer Operations after signing up
with Google with your **Merchant ID** to setup your contract. Once set up, the
option to pay with Google Pay&trade; should appear in your implementation, as
long as your payer's device supports Google Pay&trade;.

Please remember that you do must adhere to Google Pay&trade; API's
[Acceptable Use Policy][acceptable-use-policy] and accept the terms defined in
the Google Pay&trade; API's [Terms of Service][google-pay-tos].

**If our SDK generates an [IsReadyToPayRequest][irtp-request] or a**
**[PaymentDataRequest][pd-request] on behalf of you as a merchant, do you need**
**to take additional steps before the Google Pay&trade; functionality is**
**available?**

No additional steps are required. Contact Customer Operations after signing up
with Google with your **Merchant ID** to setup your contract. Once set up, the
option to pay with Google Pay&trade; should appear in your implementation, as
long as your payer's device supports Google Pay&trade;.

Please remember that you do must adhere to Google Pay&trade; API's
[Acceptable Use Policy][acceptable-use-policy] and accept the terms defined in
the Google Pay&trade; API's [Terms of Service][google-pay-tos].

### Implementation Details

**Do Swedbank Pay support 3-D Secure, and will merchants have to enable it for**
**`PAN_ONLY` credentials themselves?**

3DS is enabled by default. Merchants will not handle any payment details or
sensitive data at all during the purchase process. The data is encrypted and
sent to our PCI zone, where we decrypt and handle processing of the cards.
Merchants cannot selectively enable/disable what types of authorization methods
they receive. We handle all kinds on our end.

**How do merchants set the gateway and gatewayMerchantID values?**

Swedbank Pay will handle both **gateway** and **gatewayMerchantID** internally
during merchant onboarding, and is not an issue you need to address. Please note
that **Merchant ID** and **gatewayMerchantID** is not the same. The
**Merchant ID** is given to you in the Google Console. The **gatewayMerchantID**
is the ID given to a merchant from the gateway.

**Which authorization methods do Swedbank Pay accept?**

We accept both `PAN_ONLY` and `CRYPTOGRAM_3DS` cards in all countries
where Google Pay is supported.

**Which card networks methods do Swedbank Pay accept?**

We support Visa, Mastercard and Amex in all countries where Google Pay&trade; is
supported.

**Are there any requirements regarding the billing address to be submitted by**
**the developer for address verification?**

Any merchant onboarded with Swedbank Pay who's been given access to
Google Pay&trade;, can
[request the payer to provide billing address][req-con-address] in relation
to shipping them physical goods. These are encrypted and can only be accessed by
the merchant that requested the billing details and is deleted after 30 days.

**How do merchants send Google encrypted payment data and transaction data to**
**Swedbank Pay?**

Merchants will not handle any of the customers payment details. The encrypted
details are passed on to our backend systems, where we pass them to our internal
PCI environment for processing. Within the PCI environment, a tokenized
representation of the card is created, which is then used outside of the PCI
environment to ensure the customers details are kept safe.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started" %}

[acceptable-use-policy]: https://payments.developers.google.com/terms/aup
[android-googlepay-brand-guidelines]: https://developers.google.com/pay/api/android/guides/brand-guidelines
[android-googlepay-checklist]: https://developers.google.com/pay/api/android/guides/test-and-deploy/integration-checklist
[android-googlepay-devdoc]: https://developers.google.com/pay/api/android/
[apple-pay-sup-agreement]: /assets/documents/supplementary-agreement-ecommerce.docx
[apple-pay-tc-sign-sweden]: https://signup.swedbankpay.com/se/applepay
[apple-pay-tc-sign-norway]: https://signup.swedbankpay.com/no/applepay
[apple-pay-verification-file]: /assets/documents/apple-ecom
[benevity-donation-setup]: https://www.benevity.org
[google-pay-profile]: https://pay.google.com/business/console/
[google-pay-tos]: https://payments.developers.google.com/terms/sellertos
[irtp-request]: https://developers.google.com/pay/api/web/reference/request-objects#IsReadyToPayRequest
[payex-domain-file]: https://ecom.payex.com/.well-known/apple-developer-merchantid-domain-association
[pd-request]: https://developers.google.com/pay/api/web/reference/request-objects#PaymentDataRequest
[req-con-address]: /checkout-v3/payments-only/features/optional/request-delivery-info
[web-googlepay-brand-guidelines]: https://developers.google.com/pay/api/web/guides/brand-guidelines
[web-googlepay-checklist]: https://developers.google.com/pay/api/web/guides/test-and-deploy/integration-checklist
[web-googlepay-devdoc]: https://developers.google.com/pay/api/web/
