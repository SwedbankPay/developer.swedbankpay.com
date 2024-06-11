---
title: Trustly
permalink: /:path/trustly-presentation/
hide_from_sidebar: true
description: |
  A quick introduction to Trustly, and useful tips for an optimal user
  experience.
menu_order: 400
---

<section class="panel panel-brand">
 <header>
 <h3 class="panel-title">Pay Smarter with Trustly!</h3>
 <p class="panel-sub-title"></p>
 </header>
 <div class="panel-body">
<div>
 Experience seamless online payments with Trustly — the fast, secure, and direct way to pay from your bank account without cards or apps.
 </div>
 <br/>
 <ul>
 <li>Fast & Easy: Complete transactions in seconds.</li>
 <li>Secure & Reliable: Bank-level encryption protects your data.</li>
 <li>No Cards Needed: Pay directly from your bank account.</li>
 <li>Widely Accepted: Trusted by thousands of merchants worldwide.</li>
 </ul>
 </div>
</section>

### Overlay

When using a payment menu integration (including Instrument Mode), Trustly will
now be opened in a modal. (This is unlike the Trustly payment method
implementation where it opens inside the same frame). The modal will close once
the interaction at Trustly is finished.

### Trustly Express

As a part of our Trustly offering, Trustly Express provides an even swifter
payment process.

Trustly Express is supported by a range of European banks, and the following
in Sweden and Finland.

**Sweden**: Handelsbanken, Länsförsäkringar and Nordea.

**Finland**: Handelsbanken, Nordea, OmaSP, OP, POP Pankki,
S-Pankki, Säästöpankki and Ålandsbanken.

While it works mostly the same way as the [payer aware payment menu][papm], we
have two recommendations to make the experience as smooth as possible.

-   Include the first and last name of the payer in the `payer`
  object.

-   Add the payer's SSN. If you provide it in the `payerReference` field, the
  SSN has to be hashed.

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Introduction" %}

[papm]: /checkout-v3/features/optional/payer-aware-payment-menu
