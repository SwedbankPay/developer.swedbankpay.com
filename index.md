---
title: Developer Portal
layout: front-page
front_page:
  ingress: |
    Our developer portal is a full tool box for getting started with easy,
    flexible and safe payments on your e-commerce website. Read the
    <a href="/introduction">introduction</a> or make your selection below.
  show_merchants_bar: false
  start_heading: Let's get you started with easy, flexible and safe payments on your e-commerce website!
hide_from_sidebar: true
---

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
              to='/resources'
          %}
      </div>
  </div>
{% endcontentfor %}
