---
section: Checkout v3
title: Payment Instrument Presentations
description: |
  **An overview of all the payment instruments Checkout v3 has to offer.**
checkout_v3: true
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
part of Swedbank Pay's set up process. To do this, you need to host this
[verification file][apple-pay-verification-file] (click to download) on the
following web path:

`https://example.com/.well-known/apple-developer-merchantid-domain-association`

The verification file consists of a hex string which contains a JSON. Do not be
alarmed if you read the hex data and find this. It is by design.

Opening it is OK, but make sure that you **upload it exactly as it is**. We
recommend opening it as a text file or something similar, and **not** e.g. in
Word or an editor, as it could result in unwanted formatting changes if you save
it. The file does not, and should not, have a file extension.

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

## Google Pay

Google Pay enables quicker, safer checkout in apps and websites, and makes it
easy for customers to pay with their phones. With a simple integration, you can
access hundreds of millions of cards saved to Google Accounts and open up your
business for more business.

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
[Google Pay & Wallet Console][google-pay-profile], go to the
**Google Pay API tab** and upload the screenshots and submit your integration
for approval. The screenshots should be of the entire buyflow process (ex: add
to cart, checkout, payment, confirmation - if available). Your **Merchant ID**
will only work in production environment once Google complete their review and
approve your submitted integration.

Unless you have provided us with your **Merchant ID** as part of signing your
agreement with Swedbank Pay, you can e-mail us it at
**agreement@swedbankpay.com** together with **Name**, **Organizational** and
**Customer number**.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started" %}

[apple-pay-sup-agreement]: /assets/documents/supplementary-agreement-ecommerce.docx
[apple-pay-tc-sign-sweden]: https://signup.swedbankpay.com/se/applepay
[apple-pay-tc-sign-norway]: https://signup.swedbankpay.com/no/applepay
[apple-pay-verification-file]: /assets/documents/apple-developer-merchantid-domain-association
[benevity-donation-setup]: https://www.benevity.org
[google-pay-profile]: https://pay.google.com/business/console/
[payex-domain-file]: https://ecom.payex.com/.well-known/apple-developer-merchantid-domain-association
