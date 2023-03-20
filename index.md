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
          title='Get Startet'
          no_icon=true
          button_content="Let's get started"
          text="Every business has its own unique needs. That's why we made it possible to fit a variety of needs with just one integration. Ready to learn more? Here's what you need to know!"
          button_type='primary'
          button_alignment='align-self-end'
          to='/paymentmenuv3/'

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
  <a href="/resources/release-notes">See full release notes</a>
{% endcontentfor %}

{% contentfor extras %}
  <h2 id="front-page-extra-resources" class="heading-line">Extra resources</h2>
  <div class="row mt-4">
      <div class="{{ card_col_class }}">
          {% include card.html title='OS development guidelines'
              text='This is how we create an inclusive environment'
              icon_content='account_circle'
              icon_outlined=true
              to='/resources/development-guidelines'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Test data'
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
          {% include card.html title='See all resources (7)'
              text='Data protection, public migration key etc'
              no_icon=true
              to='/resources/'
          %}
      </div>
  </div>
{% endcontentfor %}
