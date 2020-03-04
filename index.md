---
title: Swedbank Pay Developer Portal
sidebar:
  navigation:
  - title: Home
    items:
    - url: /home/technical-information
      title: Technical Information
---

{% assign design_guide_base_url = design_guide_version_url | default: 'https://design.swedbankpay.com' %}
{% assign design_guide_version = site.design_guide.version | default: '4.1.0' %}
{% assign design_guide_version_url = design_guide_base_url | append: '/v/' | append: design_guide_version %}

Welcome to the **Swedbank Pay Developer Portal**. Please make your choice of
product to integrate below or read on for more general information about
Swedbank Pay's API platform. If you are new to Swedbank Pay's API Platform,
you are strongly advised to read through our section with fundamental
[technical information][technical-information].

<div class="row">
  <div class="col-12 col-md-6 pt-3 pt-md-0 d-flex">
    <div class="doc-card card card-plain">
      <div class="card-body text-center d-flex flex-column">
        <img src="{{ design_guide_version_url }}/img/swedbankpay-logo.svg" alt="Swedbank Pay" height="120">
        <h3>Checkout</h3>
        <p>Speed up checkout by allowing your customers to check-in with Swedbank Pay, and pay with their favorite payment instruments through our payment menu.</p>
        <a class="btn btn-guiding btn-outline btn-block mt-auto" href="/checkout/">Checkout Documentation</a>
      </div>
    </div>
  </div>
  <div class="col-12 col-md-6 pt-3 pt-md-0 d-flex">
    <div class="doc-card card card-plain">
      <div class="card-body text-center d-flex flex-column">
        <img src="{{ design_guide_version_url }}/img/swedbankpay-logo.svg" alt="Swedbank Pay" height="120">
        <h3>Payments</h3>
        <p>Identify your customer, while we take care of the payment. Choose from our uniform and wide selection of payment instruments.</p>
        <a class="btn btn-guiding btn-outline btn-block mt-auto" href="/payments/">Payments Documentation</a>
      </div>
    </div>
  </div>
</div>

{% include jumbotron.html body="**Swedbank Pay's API Platform** is built using the [REST architectural style](https://en.wikipedia.org/wiki/Representational_state_transfer) and the request and responses come in the [JSON](http://json.org/) format. The API has predictable, resource-oriented URIs and use default HTTP features, like HTTP authentication (using OAuth 2), HTTP methods and headers. These techniques are widely used and understood by most HTTP client libraries." %}

[technical-information]: /home/technical-information
