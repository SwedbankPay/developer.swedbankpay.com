---
title: Apple Pay
permalink: /:path/apple-pay-presentation/
hide_from_sidebar: true
description: |
  What is Apple Pay, and what has to be done before you can offer it as a
  payment method?
menu_order: 700
---

<section class="panel panel-brand">
 <header>
 <h3 class="panel-title">Looking to streamline payments for your customers?</h3>
 <p class="panel-sub-title"></p>
 </header>
 <div class="panel-body">

 With Apple Pay, you can offer a fast, secure, and seamless checkout experience that customers love.
 <br>

 <ul>
 <li>Speed: Transactions are completed with a single touch.</li>
 <li>Security: Built-in encryption and biometric authentication (Face ID or Touch ID) ensure every payment is safe. Your customer’s card details are never shared.</li>
 <li>Wide Reach: Apple Pay works online, in apps, and in stores, making it easier for customers to pay wherever they are.</li>
 <li>Higher Conversions: Customers are more likely to complete purchases with quick, frictionless checkouts.</li>
 <li>Active Users: 500 million active users worldwide.</li>
 </ul>
 </div>
</section>

## Domain Verification

To ensure that we can enable Apple Pay for you, there are a few steps you may
need to complete.

If you’re using a Redirect integration, you are all set - no further action is
needed.

If you’re using a Seamless View integration, you need to complete the
steps below to get started.

1.  Download the [domain file][payex-domain-file]{:target="_blank"}
   (right click and "Save as").
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
    [this site][swp-file-site]{:target="_blank"}.
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

## Apple Pay Terms And Conditions

Apple requires Swedbank Pay to identify whether and when you have accessed the
Apple Pay Platform Web Merchant Terms and Conditions, and to record whether you
have accepted and agreed to them.

We also need to require you to periodically incorporate updates or amendments to
the terms of the Apple Pay Web Terms and Conditions, Apple Pay Web Guidelines,
Apple Pay HI Guidelines, Apple Pay Best Practices Guide, or Apple Marketing
Guidelines.

Unless you have already accepted as part of signing your agreement with
Swedbank Pay, we can provide the following links for digital signature in
[Sweden][apple-pay-tc-sign-sweden]{:target="_blank"} and
[Norway][apple-pay-tc-sign-norway]{:target="_blank"}.

If you are unable to sign the Apple Pay Web Terms and Conditions in Swedish or
Norwegian digitally, please use the
[**supplementary agreement template**][apple-pay-sup-agreement] (click to
download) in English, and e-mail it to **agreement@swedbankpay.com** together
with **Name**, **Organizational** and **Customer number**. Your acceptance is
needed before we can activate Apple Pay for you.

## Accepting Donations

Apple Pay provides nonprofit organizations a simple and secure way to accept
donations. To register your nonprofit organization for Apple Pay, please visit
[Benevity][benevity-donation-setup]{:target="_blank"}.

You’ll be asked to provide basic information about your organization. Note that
the **Apple Developer Team ID** is an **optional** field, so this is not needed.

When you get your approval from Benevity, you need to share it with Swedbank Pay
before we can activate Apple Pay for you. You can e-mail it to
**agreement@swedbankpay.com** together with **Name**, **Organizational** and
**Customer number**.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Introduction" %}

[apple-pay-sup-agreement]: /assets/documents/supplementary-agreement-ecommerce.docx
[apple-pay-tc-sign-sweden]: https://signup.swedbankpay.com/se/applepay
[apple-pay-tc-sign-norway]: https://signup.swedbankpay.com/no/applepay
[apple-pay-verification-file]: /assets/documents/apple-ecom
[benevity-donation-setup]: https://www.benevity.com
[payex-domain-file]: https://ecom.payex.com/.well-known/apple-developer-merchantid-domain-association
[swp-file-site]: https://ecom.payex.com/.well-known/apple-developer-merchantid-domain-association
