{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{% assign operation_title = include.operation_title %}
{% assign checkout = include.checkout %}

## Split Settlement

The split settlement feature is an easy way of doing settlements for companies
with multiple sub-merchants. With only a few steps, the settlement process
becomes more efficient with regards to invoicing, payouts and setup for both
your sub-merchants and yourself.

In short, it is a settlement feature where a company with a website or an app
can attach specific subsite numbers to sub-merchants selling their goods or
services through the company. The subsite number is used to match the
transactions with the correct sub-merchant, so the settlement is automatically
split between them. If you run a site selling tickets to concerts, theaters,
sporting events etc., each venue gets its own subsite number. If you run a
funeral home, the sub-merchants can be everything from flower shops to
charities.

## What We Need From You As A Company

*   Submit a KYC (Know Your Customer) form for each sub-merchant you want to
    include. We will also do a KYC check on your sub-merchants, providing extra
    security for both of us.
*   Give every sub-merchant who sells goods/services through your website or in
    your app a unique subsite number. It must be in the format of `A-Za-z0-9`.
    This must be included in the KYC form. We recommend using the same customer
    number they have in your system.
*   Attach the subsite number to all the goods/services the sub-merchant
    sells through your website or app, so the goods/services can be matched
    to the correct merchant in our back office system.
*   A partner agreement is needed for automatic deduction of revenue cuts
    and fees.

## How It Works

1.  We set up the sub-merchant subsite number in our system.
2.  You add the number in the request's subsite field when you create the
    payment for the goods or service.
3.  The customer selects a payment method and completes the payment.
4.  The payment goes into a client funds account.
5.  Swedbank Pay matches the transaction with the sub-merchant using the subsite
    number.
6.  The settlement is split and connected to the correct sub-merchant.
7.  Revenue cuts for the super merchant and fees from Swedbank Pay are deducted
    automatically.
8.  Payout to the sub-merchant is done.

## Create Request with Subsite

The `subsite` field will is added in the `payeeInfo` node. If you offer Amex
as a card payment option, a `siteId` is added if you need to specify to Amex
which sub-merchant the payment is intended for.

{% capture request_header %}POST /psp/paymentorders HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=<PaymentOrderVersion>{% endcapture %}

{% capture request_content %}{
    "payeeInfo": {
            "subsite": "MySubsite",
            "siteId": "MySiteId",
            "payeeId": "{{ page.merchant_id }}",
            "payeeReference": "AB832",
            "payeeName": "Merchant1",
            "orderReference": "or-123456"
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- subsite (required, level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f subsite, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string(40)</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">{% include fields/subsite.md %}</div></div>
  </details>

  <!-- siteId (required, level 0) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f siteId, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string(15)</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">{% include fields/site-id.md %}</div></div>
  </details>
</div>

## The Upsides Of Split Settlement

Connecting sub-merchants to Swedbank Pay through the super merchant instead of
having separate setups has a lot of pros:

*   You only need one agreement for each payment method (credit card, Vipps,
    Swish, MobilePay Online, invoice) and payment gateway.
*   You only need one acquiring agreement.
*   You only need one Vipps or Swish certificate.
*   You can add more payment methods easily, as it only has to be done once.
*   New sub-merchants can be set up quickly, as the only thing needed is a KYC
    form and a subsite number. This shortens the setup time to a matter of hours
    for both you and us.
*   The automatic settlement split and deduction of fees and revenue cuts
    minimizes the work for your accounting department, as you won't have to
    invoice your sub-merchants.
*   The subsite split is available for all payment methods we offer on
    our e-commerce platform.

## Split Settlement Admin Functions

With regards to admin functions, we offer a full integration towards our
Merchant Portal system. This way, you do not have to log in to the Merchant
Portal to perform these operations.

## Capture And Cancel

Captures and cancels are done by the super merchant the same way as all other
flows.

## Reversal

In cases where you need to do reversals, this will be performed by the super
merchant. The reversal amount will be charged from the sub-merchants subsite
number. If the sub-merchants balance is 0 (zero), the super merchant will be
invoiced. The super merchant will in turn have to invoice this amount to the sub
merchant.
