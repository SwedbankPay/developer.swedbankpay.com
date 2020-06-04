---
title: Swedbank Pay Developer Portal
sidebar:
  navigation:
  - title: Home
    items:
    - url: /home/technical-information
      title: Technical Information
---

Hi! Welcome to the **Swedbank Pay Developer Portal**.

### New to our API Platform?

Are you new to Swedbank Pay's API Platform? That's okay, go ahead and look at
the fundamental [technical information][technical-information]. It will help you
further on.

### Know what product to integrate?

Nice, let's dive in. Click on the product below to get started.

<div class="row">
  <div class="col-12 col-md-4 pt-3 pt-md-0 d-flex">
    <div class="doc-card card card-plain">
      <div class="card-body text-center d-flex flex-column">
        {% icon shopping_cart %}
        <h3>Checkout</h3>
        <p>Speed up checkout by allowing your customers to check-in with Swedbank Pay, and pay with their favorite payment instruments through our payment menu.</p>
        <a class="btn btn-guiding btn-outline btn-block mt-auto" href="/checkout/">{% icon shopping_cart %}&nbsp; Checkout</a>
      </div>
    </div>
  </div>
  {% comment %}
  <div class="row">
  <div class="col-12 col-md-4 pt-3 pt-md-0 d-flex">
    <div class="doc-card card card-plain">
      <div class="card-body text-center d-flex flex-column">
        {% icon featured_play_list %}
        <h3>Payment Menu</h3>
        <p>Allow your customers to pay with their favorite payment instruments through our Swedbank Pay Payment Menu.</p>
        <a class="btn btn-guiding btn-outline btn-block mt-auto" href="/checkout/">{% icon shopping_cart %}&nbsp; Checkout</a>
      </div>
    </div>
  </div>
  {% endcomment %}
  <div class="col-12 col-md-4 pt-3 pt-md-0 d-flex">
    <div class="doc-card card card-plain">
      <div class="card-body text-center d-flex flex-column">
        {% icon credit_card %}
        <h3>Payments</h3>
        <p>Identify your customer, while we take care of the payment. Choose from our uniform and wide selection of payment instruments.</p>
        <a class="btn btn-guiding btn-outline btn-block mt-auto" href="/payments/">{% icon credit_card %}&nbsp; Payments</a>
      </div>
    </div>
  </div>
  <div class="col-12 col-md-4 pt-3 pt-md-0 d-flex">
    <div class="doc-card card card-plain">
      <div class="card-body text-center d-flex flex-column">
        {% icon card_giftcard %}
        <h3>Gift Cards</h3>
        <p>Our Gift Cards API allows you to perform payments with Swedbank Pay issued gift cards.</p>
        <a class="btn btn-guiding btn-outline btn-block mt-auto" href="/gift-cards/">{% icon card_giftcard %}&nbsp; Gift Cards</a>
      </div>
    </div>
  </div>
</div>

{% include jumbotron.html body="**Swedbank Pay's API Platform** is built using the [REST architectural style](https://en.wikipedia.org/wiki/Representational_state_transfer) and the request and responses come in the [JSON](https://www.json.org/) format. The API has predictable, resource-oriented URIs and use default HTTP features, like HTTP authentication (using OAuth 2), HTTP methods and headers. These techniques are widely used and understood by most HTTP client libraries." %}

[technical-information]: /home/technical-information
