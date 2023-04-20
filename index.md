---
title: Developer Portal
layout: front-page
front_page:
  ingress: |
    We've compiled a complete toolbox for integrating our online payment solutions, so you can familiarize yourself with their various features and functionalities.
  show_merchants_bar: false
  start_heading: Let's get your e-commerce website up and running with easy, flexible, and safe payments!
hide_from_sidebar: true
---

{% contentfor intro_cards %}
  {% include card-extended.html
          title='Getting to know our products'
          no_icon=true
          button_content="Let's get started"
          text="Discover our versatile ecommerce solutions designed to streamline online transactions. Explore our secure payment gateway, including cross channel payments, subscription payments, and more. Dive into the documentation to learn about each product's features and how they can enhance your business operations."
          button_type='primary'
          button_alignment='align-self-end'
          to='products/'

          %}
  {% include card-extended.html
          title='Get startet with development'
          no_icon=true
          button_content="Make your first payment"
          text="Jumpstart your integration with our developer-friendly resources, including comprehensive API documentation and SDKs. Follow our step-by-step guides to seamlessly incorporate our PSP solutions into your e-commerce platform. Empower your business with secure and efficient payment processing by starting your development journey today"
          button_type='primary'
          button_alignment='align-self-end'
          to='developers/'

          %}

      {% include card-extended.html
          title='Want to try it yourself?'
          no_icon=true
          button_content='Visit our Demoshop'
          text='Experience what it would be like to pay as a customer of yours in our demoshop.'
          button_type='secondary'
          button_alignment='align-self-start'
          card_container=true
          container_content='![demoshop](/assets/img/demoshop-image.svg)'
          to='https://ecom.externalintegration.payex.com/pspdemoshop'
          %}
{% endcontentfor %}

{% assign card_col_class="col-xxl-3 col-xl-6 col-lg-6" %}

{% contentfor release_notes %}
  <h2 id="front-page-release-notes" class="heading-line heading-line-green">What's new in the documentation</h2>
  {% include release_notes.html num_dates=3 %}
  <a href="resources/release-notes">See full release notes</a>
{% endcontentfor %}

{% contentfor extras %}
  <h2 id="front-page-extra-resources" class="heading-line">Extra resources</h2>
  <div class="row mt-4">
      <div class="{{ card_col_class }}">
          {% include card.html title='Test data'
              text='Get the required data for testing in our interfaces'
              icon_content='content_paste'
              to='resources/test-data'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Terminology'
              text='Get a better understanding of the terms we use'
              icon_content='menu_book'
              to='resources/terminology'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Data Protection'
              text='Data Protection rules to follow'
              icon_content='account_circle'
              icon_outlined=true
              to='resources/data-protection'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='See all resources (6)'
              text='Data protection, public migration key etc'
              no_icon=true
              to='resources/'
          %}
      </div>
  </div>
{% endcontentfor %}
