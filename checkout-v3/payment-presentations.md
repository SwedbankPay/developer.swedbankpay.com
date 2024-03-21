---
title: Payment Presentations
permalink: /:path/payment-presentations/
hide_from_sidebar: true
description: |
  **An overview of what the payment menu has to offer, and additional steps
  you may have to complete to activate them.**
menu_order: 400
---

## Apple Pay

Apple Pay provides an easy and secure way to make payments. By using Face ID,
Touch ID, or double-clicking their Apple Watch, payers can quickly and securely
check out. Payers love the simplicity, and you’ll love the increased conversion
rates and new user adoption that comes with it.

### Domain Verification

To ensure that we can enable Apple Pay for you, there are a few steps you need
to take. If you're using a Redirect integration, you are all set and can skip
this step. If you're using a Seamless View integration, you need to do the
following:

1.  Download the [domain file][payex-domain-file] (right click and "Save as").
    -   Make sure you do not change, edit or manipulate the file in any way,
    shape or form.
    -   The file should have **NO EXTENSION**, meaning there should not be any
    ".txt", ".doc", ".mp4" or any other extension to the file.

2.  Upload the file to the following web path:
    `https://[DOMAIN-NAME]/.well-known/apple-developer-merchantid-domain-association`
    -   Replace `[DOMAIN-NAME]` with your own domain.
    -   If your website is https://example.com, then the site would be
    `https://example.com/.well-known/apple-developer-merchantid-domain-association`
    -   If you want to activate Apple Pay on multiple domains, for example
    `https://ecom.payex.com` and `https://developer.swedbankpay.com`, you need
    to upload the file to all of the unique domains.

3.  Verify that the file has been uploaded correctly by opening the site. You
    should see a series of letters and numbers.
    -   You can compare it to our own verification file, found on
    [this site][swp-file-site].
    -   If done correctly, they should look identical.

If you're using our **iOS SDK**, make sure that the `webViewBaseURL` is set to
the same domain as where you host the file. If you're presenting Seamless View
payments in a custom **plain web view** implementation in your iOS application,
you need to make sure that the provided `baseURL` in the call to
`loadHTMLString(_:baseURL:)` is set to the same domain as where you host the
file. If not, it may fail to validate, making it so payments with Apple Pay
may not function. You also need to make sure that Apple Pay scripts are allowed
to be loaded and executed in the web view (relevant if you're implementing
`WKNavigationDelegate` and your own
`webView(_:decidePolicyFor:decisionHandler:)` implementation).

Once the previous steps have been completed, get in touch with us to activate
Apple Pay. The verification file is a hex string that contains a **JSON**. If
the file is modified or the file is saved in a different format, this may cause
the validation to fail. If you have further questions about how to upload the
file and make it available, contact your domain administrator or provider for
further instructions and assistance.

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

{% include alert.html type="informative" icon="info" header="Google Pay&trade;
in apps" body="We do not currently support launching Google Pay&trade; within an
in-app solution. If you want to implement Google Pay&trade; in your web-view
application, you will need to open it in a browser and open the Checkout from
there." %}

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

## Trustly

Useful information regarding Trustly in our payment menu.

### Overlay

When using a payment menu integration (including Instrument Mode), Trustly will
now be opened in a modal. (This is unlike the Trustly instrument implementation
where it opens inside the same frame). The modal will close once the interaction
at Trustly is finished.

### Trustly Express

As a part of our Trustly offering, Trustly Express provides an even swifter
payment process.

Trustly Express is supported by a range of European banks, and the following
in Sweden and Finland.

**Sweden**: Danske Bank, Handelsbanken, Länsförsäkringar and Nordea.

**Finland**: Danske Bank, Handelsbanken, Nordea, OmaSP, OP, POP Pankki,
S-Pankki, Säästöpankki and Ålandsbanken.

While it works mostly the same way as the [payer aware payment menu][papm], we
have two recommendations to make the experience as smooth as possible.

-   Include the first and last name of the payer in the `payer`
  object.

-   Add the payer's SSN. If you provide it in the `payerReference` field, the
  SSN has to be hashed.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Introduction" %}

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
[papm]: /checkout-v3/features/optional/payer-aware-payment-menu
[restrict]: /checkout-v3/features/optional/payer-restrictions
[req-con-address]: /checkout-v3/features/optional/request-delivery-info
[swp-file-site]: https://ecom.payex.com/.well-known/apple-developer-merchantid-domain-association
[web-googlepay-brand-guidelines]: https://developers.google.com/pay/api/web/guides/brand-guidelines
[web-googlepay-checklist]: https://developers.google.com/pay/api/web/guides/test-and-deploy/integration-checklist
[web-googlepay-devdoc]: https://developers.google.com/pay/api/web/
