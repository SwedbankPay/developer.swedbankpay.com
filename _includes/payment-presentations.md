---
section: Checkout v3
title:
description: |
  **An overview of all the payment instruments Checkout v3 has to offer.**
checkout_v3: true
menu_order: 400
---

## Apple Pay

Apple Pay provides an easy and secure way to make payments. By using Face ID,
Touch ID, or double-clicking their Apple Watch, payers can quickly and securely
check out. Payers love the simplicity, and you’ll love the increased conversion
rates and new user adoption that comes with it. There are some additional steps
steps which must be completed befire we can activate Apple Pay for you.

### Domain Verification

**Redirect** integrations does not require a domain verification, as it will
be hosted on Swedbank Pay's domain.

For **Seamless View** integrations, Apple needs to verify your domain as a
part of Swedbank Pay's set up process. To do this, you need to host a
verification file on the following web path:

https://[DOMAIN_NAME]/.well-known/apple-developer-merchantid-domain-association

THE FILE IN WHATEVER FORMAT WE CHOOSE TO PRESENT IT!!! **(Not a Word file)**

The verification file consists of a hex string which contains a JSON. Do not
be alarmed if you read the hex data and find this. It is by design.

Opening it is OK, but make sure that you **upload it exactly as it is**. We
recommend opening it as a text file or something similar, and **not** e.g. in
Word, as it could result in unwanted formatting changes if you save it. The file
does not, and should not, have a file extension.

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
Norwegian digitally, please use the **supplementary agreement template** (link)
in English, and e-mail it to **agreement@swedbankpay.com** together with
**Name**, **Organizational** and **Customer number**. Your acceptance is needed
before we can activate Apple Pay for you.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started" %}

## Card

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

## Credit Account

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started" %}

## Google Pay

Google Pay enables quicker, safer checkout in apps and websites and makes it
easy for customers to pay with their phones. With a simple integration, you can
access hundreds of millions of cards saved to Google Accounts and open up your
business for more business. With a click, the payers can choose any payment
method saved in their Google Account and check out almost instantly across apps
and sites.

### Merchant ID

You need to sign up for a **Google Developer Account** and
[create a **business profile** and **payment profile**][google-pay-profile].

After creating the business profile, you will be able to see your Merchant ID on
the top right corner of the page. We need that ID in order to activate Google
Pay for you.

Unless you have provided us with your **Merchant ID** as part of signing your
agreement with Swedbank Pay, you can e-mail us it at
**agreement@swedbankpay.com** together with **Name**, **Organizational** and
**Customer number**.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started" %}

## Invoice

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started" %}

## MobilePay

MobilePay is the main payment app in Denmark and one of the leading apps in
Finland, making it essential for merchants operating in these Nordic countries.
More than 4.4 million Danes and 2 million Finns use the app. 140,000 stores are
accepting payments.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started" %}

## Monthly Payments

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started" %}

## Swish

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started" %}

## Trustly

Trustly is the simplest way to provide **Direct Bank** payments on your website,
allowing your payers to shop and pay from their online bank account, without the
use of cards or apps. 11 Swedish and 10 Finnish banks are supported (among 6,300
worldwide).

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started" %}

## Vipps

Vipps is the main Norwegian payment app for mobile phones supported by the major
Norwegian banks, making it essential for merchants operating in Norway. Approx.
4.2 million Norwegians use Vipps.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started" %}

[benevity-donation-setup]: https://www.benevity.org
[apple-pay-tc-sign-sweden]: https://signup.swedbankpay.com/se/applepay
[apple-pay-tc-sign-norway]: https://signup.swedbankpay.com/no/applepay
[google-pay-profile]: https://pay.google.com/business/console/
[payex-domain-file]: https://ecom.payex.com/.well-known/apple-developer-merchantid-domain-association
