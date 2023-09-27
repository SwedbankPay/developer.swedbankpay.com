---
title: Developer Portal
layout: front-page
front_page:
  ingress: The complete toolbox for integrating our easy and safe omnichannel payment solutions.
  show_merchants_bar: false
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
          title='Want to give Digital Payments a go?'
          no_icon=true
          button_content='Head to the playground'
          text='Experience our brand new accessability compliant payment UI in the Swedbank Pay Playground'
          button_type='secondary'
          button_alignment='align-self-start'
          card_container=true
          container_content='![demoshop](/assets/img/demoshop-image.svg)'
          to='https://playground.externalintegration.swedbankpay.com'
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

{% assign card_col_class="col-xxl-3 col-xl-6 col-lg-6" %}

{% contentfor extras %}
<h2 id="front-page-extra-resources" class="heading-line">Digital Payments Resources</h2>
<div class="row mt-4">
      <div class="{{ card_col_class }}">
          {% include card.html title='OS Development Guidelines'
              text='This is how we create an inclusive environment'
              icon_content='account_circle'
              icon_outlined=true
              to='/resources/development-guidelines'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Test Data'
              text='Get the required data for testing in our interfaces'
              icon_content='content_paste'
              to='/resources/test-data'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Terminology'
              text='Get a better understanding of the terms we use'
              icon_content='menu_book'
              to='/resources/terminology'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='See All Resources (7)'
              text='Data protection, public migration key etc'
              no_icon=true
              to='/resources/'
          %}
      </div>
  </div>
{% endcontentfor %}
