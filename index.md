---
title: Developer Portal
layout: front-page
hide_from_sidebar: true
---

{% assign card_col_class="col-xxl-3 col-xl-6 col-lg-6" %}

{% contentfor start %}
  <div class="row mt-4">
      <div class="{{ card_col_class }}">
        {% include card.html
            title='Checkout'
            title_type="h2"
            text='With our Checkout you get the pre-built all-in-one payment solution,
                  complete with a checkin interface and payment menu.'
            icon_content='shopping_cart'
            icon_outlined=true
            to='/checkout'
        %}
      </div>
      <div class="{{ card_col_class }}">
        {% include card.html
            title='Payment Instruments'
            title_type="h2"
            text='Payment Instruments gives you a one-by-one integration with more
            customization for each payment method to build your own
            payment menu.'
            icon_content='credit_card'
            to='/payments'
        %}
      </div>
      <div class="{{ card_col_class }}">
        {% include card.html
            title='Gift Cards'
            title_type="h2"
            text='Our Gift Cards API allows your customers to pay with prepaid gift cards issued by Swedbank Pay in your Checkout.'
            icon_content='card_giftcard'
            to='/gift-cards'
        %}
      </div>
  </div>
{% endcontentfor %}

{% contentfor sdks %}
  <h2 id="front-page-sdk" class="heading-line heading-line-sdk">Looking for SDKs?</h2>
  <div class="row mt-4">
    <div class="{{ card_col_class }}">
      {% include card.html
          title='Android SDK'
          text='Learn more about how to integrate our Android SDK'
          icon_content='img/sdks/logo-android.svg'
          icon_svg=true
          type='sdk'
          to='/modules-sdks/mobile-sdk/android'
      %}
    </div>
    <div class="{{ card_col_class }}">
      {% include card.html
          title='iOS SDK'
          text='Learn more about how to integrate our iOS SDK'
          icon_content='img/sdks/logo-swift.svg'
          icon_svg=true
          type='sdk'
          to='/modules-sdks/mobile-sdk/ios'
      %}
    </div>
    <div class="{{ card_col_class }}">
      {% include card.html
          title='.NET SDK'
          text='Learn more about how to integrate our .NET SDK'
          icon_content='img/sdks/logo-net.svg'
          icon_svg=true
          type='sdk'
          to='/modules-sdks/#official-sdks'
      %}
    </div>
    <div class="{{ card_col_class }}">
      {% include card.html
          title='PHP SDK'
          text='Learn more about how to integrate our PHP SDK'
          icon_content='img/sdks/logo-php.svg'
          icon_svg=true
          type='sdk'
          to='/modules-sdks/#official-sdks'
      %}
    </div>
  </div>
{% endcontentfor %}

{% contentfor modules %}
  <h2 id="front-page-module" class="heading-line heading-line-module">Or perhaps modules?</h2>
  <div class="row mt-4">
    <div class="{{ card_col_class }}">
      {% include card.html
          title='Episerver'
          text='See how you can integrate the Episerver module'
          icon_content='img/modules/logo-episerver.svg'
          icon_svg=true
          type='module'
          to='/modules-sdks/#official-modules'
      %}
    </div>
    <div class="{{ card_col_class }}">
      {% include card.html
          title='Magento 2'
          text='See how you can integrate the Magento 2 module'
          icon_content='img/modules/logo-magento2.svg'
          icon_svg=true
          type='module'
          to='/modules-sdks/#official-modules'
      %}
    </div>
    <div class="{{ card_col_class }}">
      {% include card.html
          title='WooCommerce'
          text='See how you can integrate the WooCommerce module'
          icon_content='img/modules/logo-woocommerce.svg'
          icon_svg=true
          type='module'
          to='/modules-sdks/#official-modules'
      %}
    </div>
  </div>
{% endcontentfor %}

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
