---
title: Google Pay&trade;
permalink: /:path/google-pay-presentation/
hide_from_sidebar: true
description: |
  What is Google Pay&trade;, and what has to be done before you can offer it as
  a payment method?
menu_order: 500
---

{% include alert.html type="informative" icon="info" header="Google Pay&trade;
in apps" body="We do not currently support launching Google Pay&trade; within an
in-app solution. If you want to implement Google Pay&trade; in your web-view
application, you will need to open it in a browser and open the Checkout from
there." %}

<section class="panel panel-brand">
 <header>
 <h3 class="panel-title">Pay Smarter with Google Pay&trade;!</h3>
 <p class="panel-sub-title"></p>
 </header>
 <div class="panel-body">
<div>
 Simplify your checkout experience with Google Pay&trade; — the fast, secure, and
 hassle-free way to pay online, in-store and in apps.
 </div>
 <br/>
 <ul>
 <li>Fast Transactions: Tap, click, or swipe—pay in seconds.</li>
 <li>Secure Payments: Advanced encryption keeps your card details safe.</li>
 <li>Seamless Convenience: Save cards, loyalty programs and tickets all in one place.</li>
 <li>Widely Accepted: Use it anywhere Google Pay is supported..</li>
 </ul>
 </div>
</section>

### Merchant ID

You need to sign up for a **Google Developer Account** and
[create a **business profile** and **payment profile**][google-pay-profile]{:target="_blank"}.

After creating the business profile, you will be able to see your Merchant ID on
the top right corner of the page. We need that ID in order to activate Google
Pay for you.

However, be sure to register your domain/package and submit screenshots of your
integration for approval. Login to
[Google Pay&trade; & Wallet Console][google-pay-profile]{:target="_blank"}, go
to the **Google Pay&trade; API tab** and upload the screenshots and submit your
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
[Google Pay Android Developer Documentation][android-googlepay-devdoc]{:target="_blank"},
[Google Pay Android Integration Checklist][android-googlepay-checklist]{:target="_blank"}
and the
[Google Pay Android Brand Guidelines][android-googlepay-brand-guidelines].

**Which Google Pay&trade; documentation and guidelines should you use if you**
**are a web merchant?**
[Google Pay Web Developer Documentation][web-googlepay-devdoc]{:target="_blank"},
[Google Pay Web Integration Checklist][web-googlepay-checklist]{:target="_blank"}
and the
[Google Pay Web Brand Guidelines][web-googlepay-brand-guidelines].{:target="_blank"}

**Do you as a merchant need to take additional steps with regards to the**
**Google Pay&trade; payment button or other hosted components to your website?**

No additional steps are required. Contact Customer Operations after signing up
with Google with your **Merchant ID** to setup your contract. Once set up, the
option to pay with Google Pay&trade; should appear in your implementation, as
long as your payer's device supports Google Pay&trade;.

Please remember that you do must adhere to Google Pay&trade; API's
[Acceptable Use Policy][acceptable-use-policy]{:target="_blank"} and accept the
terms defined in the Google Pay&trade; API's
[Terms of Service][google-pay-tos]{:target="_blank"}.

**If our SDK generates an [IsReadyToPayRequest][irtp-request] or a**
**[PaymentDataRequest][pd-request] on behalf of you as a merchant, do you need**
**to take additional steps before the Google Pay&trade; functionality is**
**available?**

No additional steps are required. Contact Customer Operations after signing up
with Google with your **Merchant ID** to setup your contract. Once set up, the
option to pay with Google Pay&trade; should appear in your implementation, as
long as your payer's device supports Google Pay&trade;.

Please remember that you do must adhere to Google Pay&trade; API's
[Acceptable Use Policy][acceptable-use-policy]{:target="_blank"} and accept the
terms defined in the Google Pay&trade; API's
[Terms of Service][google-pay-tos]{:target="_blank"}.

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
                         prev_title="Back to Introduction" %}

[acceptable-use-policy]: https://payments.developers.google.com/terms/aup
[android-googlepay-brand-guidelines]: https://developers.google.com/pay/api/android/guides/brand-guidelines
[android-googlepay-checklist]: https://developers.google.com/pay/api/android/guides/test-and-deploy/integration-checklist
[android-googlepay-devdoc]: https://developers.google.com/pay/api/android/
[google-pay-profile]: https://pay.google.com/business/console/
[google-pay-tos]: https://payments.developers.google.com/terms/sellertos
[irtp-request]: https://developers.google.com/pay/api/web/reference/request-objects#IsReadyToPayRequest
[pd-request]: https://developers.google.com/pay/api/web/reference/request-objects#PaymentDataRequest
[web-googlepay-brand-guidelines]: https://developers.google.com/pay/api/web/guides/brand-guidelines
[web-googlepay-checklist]: https://developers.google.com/pay/api/web/guides/test-and-deploy/integration-checklist
[web-googlepay-devdoc]: https://developers.google.com/pay/api/web/
[req-con-address]: /checkout-v3/features/optional/request-delivery-info
