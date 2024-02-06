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
          text='Experience our brand new accessibility compliant payment UI in the Swedbank Pay Playground'
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
          {% include card.html title='Contact Us'
              text='Get in touch with our sales department to make sure that your needs are covered'
              to="mailto:sales.swedbankpay@swedbank.se"
          %}
      </div>
            <div class="{{ card_col_class }}">
          {% include card.html title='Denmark'
              text='Get to know the Danish partners who help us deliver the best payment experience'
              to='https://www.swedbankpay.dk/partners'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Norway'
              text='Get to know the Norwegian partners who help us deliver the best payment experience'
              to='https://www.swedbankpay.no/partners'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Sweden'
              text='Get to know the Swedish partners who help us deliver the best payment experience'
              to='https://www.swedbankpay.se/partners'
          %}
      </div>
  </div>
{% endcontentfor %}
