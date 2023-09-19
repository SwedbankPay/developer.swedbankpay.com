---
title: Developer Portal
layout: front-page
front_page:
  show_merchants_bar: false
  start_heading: The complete toolbox for integrating our easy and safe omni-channel payment solutions.
hide_from_sidebar: true
---

{% assign card_col_class="col-xxl-3 col-xl-6 col-lg-6" %}

{% contentfor intro_cards %}
  <h2 id="front-page-contact-partners" class="heading-line">Products</h2>
  <div class="row mt-4">
      <div class="{{ card_col_class }}">
          {% include card.html title='Digital Payments'
              text='A guide through our digital payments'
              icon_content='shopping_cart'
              icon_outlined=true
              to="/checkout-v3/"
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Payment Terminals'
              text='A guide through our payment terminals'
              icon_content='point_of_sale'
              to='/pax-terminal/'
          %}
      </div>
  </div>
{% endcontentfor %}

{% contentfor intro_cards %}

      {% include card-extended.html
          title='Want to give Digital Payments a try?'
          no_icon=true
          button_content='Head to the playground'
          text='Experience our brand new WCAG compliant payment UI in the Swedbank Pay Playground'
          button_type='secondary'
          button_alignment='align-self-start'
          card_container=true
          container_content='![demoshop](/assets/img/demoshop-image.svg)'
          to='https://playground.dev.swedbankpay.com'
          %}
{% endcontentfor %}

{% assign card_col_class="col-xxl-3 col-xl-6 col-lg-6" %}

{% contentfor extras %}
  <h2 id="front-page-contact-partners" class="heading-line">Contact & Partners</h2>
  <div class="row mt-4">
      <div class="{{ card_col_class }}">
          {% include card.html title='Contact Us'
              text='Before you start, you can get in touch with our Sales department to find the perfect solution for your needs'
              icon_content='email'
              icon_outlined=true
              to="mailto:sales.swedbankpay@swedbank.se"
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Partners'
              text='A lot of partners help us deliver the best payment experience. Get to know them all here'
              icon_content='handshake'
              to='/checkout-v3/resources/partners'
          %}
      </div>
  </div>
{% endcontentfor %}
