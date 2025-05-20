---
title: Apple Pay
permalink: /:path/apple-pay-presentation/
hide_from_sidebar: true
description: |
  What is Apple Pay, and what has to be done before you can offer it as a
  payment method?
menu_order: 700
---
<script>
  async function downloadDomainFile() {
    const pageUrl = 'https://ecom.dev.payex.com/.well-known/apple-developer-merchantid-domain-association';
    const fileName = 'apple-developer-merchantid-domain-association';

    try {
      // Fetch the webpage content
      const response = await fetch(pageUrl);
      if (!response.ok) {
        throw new Error(`Failed to fetch webpage: ${response.statusText}`);
      }
      const text = await response.text();

      // Create a blob with the webpage content
      const blob = new Blob([text], { type: 'text/plain' }); // Set type to 'text/plain' to avoid extensions

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

<section class="panel panel-brand">
 <header>
 <h3 class="panel-title">Looking to streamline payments for your customers?</h3>
 <p class="panel-sub-title"></p>
 </header>
 <div class="panel-body">
<div>
 With Apple Pay, you can offer a fast, secure, and seamless checkout experience that customers love.
 </div>
 <br/>
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
<div class="alert alert-informative">
    <i class="swepay-icon-info-circle-filled" aria-hidden="true"></i>
    <p>Seamless View integration only</p>
</div>

To ensure that we can enable Apple Pay for you when using a Seamless View integration, there are a few steps you may
need to complete.

{% capture downloadDomainFile %}
{: .p .pl-3 .pr-3  }
You need a copy of our domain file.

*   Make sure you do not change, edit or manipulate the file in any way, shape or form.
*   The file should have **NO EXTENSION**, meaning there should not be any ".txt", ".doc", ".mp4" or any other extension to the file.

<button class="btn btn-tertiary ml-3 w-100" type="button" onclick="downloadDomainFile()">
  <span>Download our domain file</span>
  <i class="at-download-arrow-down ml-2" aria-hidden="true"></i>
</button>
{% endcapture %}
{% include accordion-table.html content=downloadDomainFile header_text='1. Download our domain file' header_expand_css='font-weight-normal' %}
   
{% capture uploadDomainFile %}
{: .p .pl-3 .pr-3  }
Upload the file to the following web path: `https://[DOMAIN-NAME]/.well-known/apple-developer-merchantid-domain-association`

*   Replace `[DOMAIN-NAME]` with your own domain.
*   If your website is https://example.com, then the site would be `https://example.com/.well-known/apple-developer-merchantid-domain-association`
*   If you want to activate Apple Pay on multiple domains, for example `https://ecom.payex.com` and `https://developer.swedbankpay.com`, you need to upload the file to all of the unique domains.

{: .p .pl-3 .pr-3  }
If you have any questions about how to upload the file to your domain and make it available, contact your domain administrator or provider for further instructions and assistance.
{% endcapture %}
{% include accordion-table.html content=uploadDomainFile header_text='2. Upload the file to your domain' header_expand_css='font-weight-normal' %}
   
{% capture verifyDomainFile %}
{: .p .pl-3 .pr-3  }
Verify that the file has been uploaded correctly by opening the site. You should see a series of letters and numbers.

*   You can compare it to our own verification file, found on <a target="_blank" href="https://ecom.payex.com/.well-known/apple-developer-merchantid-domain-association">this site</a>.  
*   If done correctly, they should look identical.
*   The verification file is a hex string that contains a **JSON**. If the file is modified or the file is saved in a different format, this may cause the validation to fail.
{% endcapture %}
{% include accordion-table.html content=verifyDomainFile header_text='3. Verify the upload' header_expand_css='font-weight-normal' %}
   
{% capture contactUs %}
{: .p .pl-3 .pr-3  }
Once the previous steps have been completed you have to notify us that everything is ready and you are good to go. The easiest way? Simply reply to the email you received from us regarding domain verification! But you can of course also reach out to your technical contact.
{% endcapture %}
{% include accordion-table.html content=contactUs header_text='4. Contact us for activation' header_expand_css='font-weight-normal' %}
  
{% capture iosSdk %}
{: .p .pl-3 .pr-3  }
If you're using our **iOS SDK**, make sure that the `webViewBaseURL` is set to the same domain as where you host the file. 

{: .p .pl-3 .pr-3  }
If you're presenting Seamless View payments in a custom **plain web view** implementation in your iOS application, you need to make sure that the provided `baseURL` in the call to `loadHTMLString(_:baseURL:)` is set to the same domain as where you host the file. If not, it may fail to validate, making it so payments with Apple Pay may not function.

{: .p .pl-3 .pr-3  }
You also need to make sure that Apple Pay scripts are allowed to be loaded and executed in the web view (relevant if you're implementing `WKNavigationDelegate` and your own `webView(_:decidePolicyFor:decisionHandler:)` implementation).
{% endcapture %}
{% include accordion-table.html content=iosSdk header_text='Note: iOS SDK' header_expand_css='font-weight-normal' %}

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
