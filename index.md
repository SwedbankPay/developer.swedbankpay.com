---
title: Developer Portal
layout: front-page
front_page:
  ingress: |
    Here you'll find the full toolbox for how to integrate our payment solutions, acquaint yourself with their different features and functionalities, and learn how to integrate them.
  show_merchants_bar: false
  start_heading: Let's get you started with easy, flexible and safe payments on your e-commerce website!
hide_from_sidebar: true
---

{% contentfor intro_cards %}
  {% include card-extended.html
          title='Get to know Checkout v3'
          no_icon=true
          button_content='Get started'
          text='All businesses have their own unique needs. Which is why we have made it possible for you to adapt to a variety of those needs, using only one integration. To help you get started we have made five implementation options to choose among. In that way you can utilize your checkin in just a few configurations, or switch into any other of our stand alone payment methods - if that suits you better. Intrigued yet? Let’s find out more!'
          button_type='primary'
          button_alignment='align-self-end'
          to='/checkout-v3/'

          %}

      {% include card-extended.html
          title='Want to try it yourself?'
          no_icon=true
          button_content='Visit our Demoshop'
          text='Experience what it would be like to pay as a costumer of yours in our demoshop.'
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
