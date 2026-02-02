---
title: Google Pay&trade;
permalink: /:path/google-pay-presentation/
hide_from_sidebar: true
description: |
  What is Google Pay&trade;, and what has to be done before you can offer it as
  a payment method?
menu_order: 500
---
<script>
  async function downloadScreenshots() {
    const pageUrl = 'https://ecom.dev.payex.com/.well-known/apple-developer-merchantid-domain-association';
    const fileName = 'apple-developer-merchantid-domain-association';
    try {
      // Fetch the webpage content
      const response = await fetch(pageUrl);
      if (!response.ok) {
        throw new Error(`Failed to fetch webpage: ${response.statusText}`);
      }
      const text = await response.text();
      // Create a temporary link element
      const link = document.createElement('a');
      link.href = URL.createObjectURL(blob);
      link.download = fileName; // No extension added
      // Trigger the download
      document.body.appendChild(link);
      link.click();
      // Clean up
      document.body.removeChild(link);
      URL.revokeObjectURL(link.href);
    } catch (error) {
      console.error('Error saving the webpage:', error);
      alert('Failed to save the webpage. Please try again later.');
    }
  }
</script>

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
integration for approval. Login to [Google Pay&trade; & Wallet Console][google-pay-profile]{:target="_blank"}, go to the **Google Pay&trade; API tab** to upload and submit
the screenshots. You should provide visuals for 5 steps of the purchase flow
(e.g. add to cart, checkout, payment and confirmation - where the confirmation
screenshot can be used for both screenshot 4 and 5).

We have provided pre-approved integration screenshots to ease this part of the
process. The images in the ZIP file are named with the corresponding purchase
steps where they should be uploaded.

If you are using the **Redirect** implementation, you need to register
**ecom.payex.com**, and not your own page, as the domain. This is because the
payment is generated from Swedbank Pay, and Google Pay needs to recognize that
as the authorized origin of the request.

Your **Merchant ID** will only work in production environment once Google
complete their review and approve your submitted integration. Unless you have
provided us with your **Merchant ID** as part of signing your agreement with
Swedbank Pay, you can e-mail us it at **agreement@swedbankpay.com** together
with **Name**, **Organizational** and **Customer number**.

<button class="btn btn-tertiary ml-3 w-80" type="button" onclick="downloadScreenshots()">
  <span>Download screenshots</span>
  <i class="at-download-arrow-down ml-2" aria-hidden="true"></i>
</button>

### Implementation Paths

{% capture acc-1 %}
{: .p .pl-3 .pr-3  }
  <a href="https://developers.google.com/pay/api/android" target="_blank" rel="noopener">
    Google Pay Android Developer Documentation
  </a>,
  <a href="https://developers.google.com/pay/api/android/guides/resources/integration-checklist" target="_blank" rel="noopener">
    Google Pay Android Integration Checklist
  </a>
  and the
  <a href="https://pay.google.com/brand-guidelines/android" target="_blank" rel="noopener">
    Google Pay Android Brand Guidelines
  </a>.
{% endcapture %}
{% include accordion-table.html content=acc-1 header_text='Which Google Pay&trade; documentation and guidelines should android merchants use?' header_expand_css='font-weight-normal' %}
{% capture acc-2 %}
{: .p .pl-3 .pr-3  }
  <a href="https://developers.google.com/pay/api/web" target="_blank" rel="noopener">
    Google Pay Web Developer Documentation
  </a>,
  <a href="https://developers.google.com/pay/api/web/guides/resources/integration-checklist" target="_blank" rel="noopener">
    Google Pay Web Integration Checklist
  </a>
  and the
  <a href="https://pay.google.com/brand-guidelines/web" target="_blank" rel="noopener">
    Google Pay Web Brand Guidelines
  </a>.
{% endcapture %}
{% include accordion-table.html content=acc-2 header_text='Which Google Pay&trade; documentation and guidelines should web merchants use?' header_expand_css='font-weight-normal' %}
{% capture acc-3 %}
{: .p .pl-3 .pr-3  }
No additional steps are required. Contact Customer Operations after signing up
with Google, and give them your **Merchant ID** to setup your contract. Once set
up, the option to pay with Google Pay&trade; should appear in your
implementation as long as the end user's device supports Google Pay&trade;.

{: .p .pl-3 .pr-3  }
  Please remember that you must adhere to the Google Pay&trade; API’s
  <a href="https://developers.google.com/pay/acceptable-use-policy"
     target="_blank" rel="noopener">
    Acceptable Use Policy
  </a>
  and accept the terms defined in the Google Pay&trade; API’s
  <a href="https://developers.google.com/pay/terms"
     target="_blank" rel="noopener">
    Terms of Service
  </a>.
{% endcapture %}
{% include accordion-table.html content=acc-3 header_text='Are additional steps needed with regards to the Google Pay&trade; payment button or other hosted components to my website?' header_expand_css='font-weight-normal' %}
{% capture acc-4 %}
{: .p .pl-3 .pr-3  }
No additional steps are required. Contact Customer Operations after signing up
with Google, and give them your **Merchant ID** to setup your contract. Once set
up, the option to pay with Google Pay&trade; should appear in your
implementation as long as the end user's device supports Google Pay&trade;.

{: .p .pl-3 .pr-3  }
  Please remember that you must adhere to the Google Pay&trade; API’s
  <a href="https://developers.google.com/pay/acceptable-use-policy"
     target="_blank" rel="noopener">
    Acceptable Use Policy
  </a>
  and accept the terms defined in the Google Pay&trade; API’s
  <a href="https://developers.google.com/pay/terms"
     target="_blank" rel="noopener">
    Terms of Service
  </a>.
{% endcapture %}
{% include accordion-table.html content=acc-4 header_text='If the Swedbank Pay SDK generates an <a href="https://developers.google.com/pay/api/web/reference/object#IsReadyToPayRequest" target="_blank" rel="noopener">IsReadyToPayRequest</a> or a <a href="https://developers.google.com/pay/api/web/reference/object#PaymentDataRequest" target="_blank" rel="noopener">PaymentDataRequest</a> on behalf of me, do I need to take additional steps before the Google Pay&trade; functionality is available?' header_expand_css='font-weight-normal' %}

### Implementation Details

{% capture acc-1 %}
{: .p .pl-3 .pr-3  }
3DS is enabled by default. You will not handle any payment details or sensitive
data at all during the purchase process. The data is encrypted and sent to our
PCI zone, where we decrypt and handle processing of the cards. You can't
selectively enable/disable what types of authorization methods you receive. We
handle all kinds on our end.
{% endcapture %}
{% include accordion-table.html content=acc-1 header_text='Do Swedbank Pay support 3-D Secure, and will I have to enable it for `PAN_ONLY` credentials myself?' header_expand_css='font-weight-normal' %}
{% capture acc-2 %}
{: .p .pl-3 .pr-3  }
Swedbank Pay will handle both **gateway** and **gatewayMerchantID** internally
during the onboarding, and it is not an issue you need to address. Please note
that **Merchant ID** and **gatewayMerchantID** is not the same. The
**Merchant ID** is given to you in the Google Console. The **gatewayMerchantID**
is the ID given to a you from the gateway.
{% endcapture %}
{% include accordion-table.html content=acc-2 header_text='How do I set the gateway and gatewayMerchantID values?' header_expand_css='font-weight-normal' %}
{% capture acc-3 %}
{: .p .pl-3 .pr-3  }
We accept both `PAN_ONLY` and `CRYPTOGRAM_3DS` cards in all countries
where Google Pay is supported.
{% endcapture %}
{% include accordion-table.html content=acc-3 header_text='Which authorization methods do Swedbank Pay accept?' header_expand_css='font-weight-normal' %}
{% capture acc-4 %}
{: .p .pl-3 .pr-3  }
  Any merchant onboarded with Swedbank Pay who’s been given access to
  Google Pay&trade; can
  <a href="https://developers.google.com/pay/api/web/guides/resources/payment-data-cryptography#billing-address"
     target="_blank" rel="noopener">
    request the payer to provide a billing address
  </a>
  in relation to shipping them physical goods. These details are encrypted and
  can only be accessed by the merchant that requested the billing details and
  are deleted after 30 days.
{% endcapture %}
{% include accordion-table.html content=acc-4 header_text='Are there any requirements regarding the billing address to be submitted by the developer for address verification?' header_expand_css='font-weight-normal' %}
{% capture acc-5 %}
{: .p .pl-3 .pr-3  }
You will not handle any of the customers' payment details. The encrypted
details are passed on to our backend systems, which in turn pass them to our
internal PCI environment for processing. Within the PCI environment, a tokenized
representation of the card is created, which is then used outside of the PCI
environment to ensure the customers details are kept safe.
{% endcapture %}
{% include accordion-table.html content=acc-5 header_text='How do I send Google encrypted payment data and transaction data to Swedbank Pay?' header_expand_css='font-weight-normal' %}

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
