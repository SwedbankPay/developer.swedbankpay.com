---
title: Developer Portal
layout: front-page
front_page:
  ingress: The complete toolbox for integrating our easy and safe omnichannel payment solutions.
  show_merchants_bar: false
hide_from_sidebar: true
---

{% assign card_col_class="col-xl-6 col-lg-6" %}

{% contentfor intro_cards %}
  <h2 id="front-page-contact-partners" class="heading-line">Products</h2>
  <div class="row mt-4">
      <div class="{{ card_col_class }}">
          {% include card.html title='Digital Payments'
              text='A guide through our Digital Payments'
              icon_content='shopping_cart'
              icon_outlined=true
              to="/checkout-v3/"
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Payment Terminals'
              text='A guide through our Payment Terminals'
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
          text='Experience our accessibility compliant payment UI in the Swedbank Pay Playground'
          button_type='secondary'
          button_alignment='align-self-start'
          card_container=true
          container_content='![demoshop](/assets/img/demoshop-image.svg)'
          to='https://playground.swedbankpay.com'
          %}
{% endcontentfor %}

{% assign card_col_class="col-xl-6 col-lg-6" %}

{% contentfor extras %}
  <h2 id="front-page-contact-partners" class="heading-line">Contact & Partners</h2>
  <div class="row mt-4">
      <div class="{{ card_col_class }}">
          {% include card.html title='Talk To Us'
              text='Improve your payment solutions. Connect with our sales team to see all that we can offer. Contact us.'
              to="mailto:sales.swedbankpay@swedbank.se"
          %}
      </div>
            <div class="{{ card_col_class }}">
          {% include card.html title='Denmark'
              text='Discover our Danish payment solutions and partners. Dive in.'
              to='https://www.swedbankpay.dk/partners'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Norway'
              text='Power up your payments through our Norwegian partnerships. Get started.'
              to='https://www.swedbankpay.no/partners'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Sweden'
              text='Explore partnerships in Sweden for better payment experiences. Learn more.'
              to='https://www.swedbankpay.se/partners'
          %}
      </div>
  </div>
{% endcontentfor %}
