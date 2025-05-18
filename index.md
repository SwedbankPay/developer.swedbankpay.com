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
  <div class="row">
    <div class="{{ card_col_class }}">
        {% include card.html title='Online Payments'
        image_alt_text="The image shows a woman seated in comfortable surroundings in her home using a computer to make an online payment."
        image_src="/assets/img/betala-online.jpg"
        cta_text='Read more'
        description='Learn about our Online Payments and how to integrate them.'
        url="/checkout-v3/"
        %}
    </div>
    <div class="{{ card_col_class }}">
        {% include card.html title='In-Store Payments'
        image_alt_text="The image shows someone seated in a cafe with a glass of juice, a cup of coffee and a cake on the table in front of them, using a card terminal to pay."
        image_src="/assets/img/betala-med-pax-a920pro.jpg"
        cta_text='Read more'
        description='Discover our In-Store Payments and their technical specifications.'
        url='/pax-terminal/'
        %}
    </div>
  </div>
{% endcontentfor %}

{% contentfor playground %}
  <div class="row slab mt-5 ml-0 mr-0">
    <div class="col-lg-7 pl-2 mb-2">
      <h2>Want to try Online Payments live?</h2>
      <p>Use the Playground to test our payment methods. Customize your solution from scratch or start with one of our ready-made examples.</p>
      <p>See the menu clothed in your colors and with your logo.</p>
      <p>The goal is to give you an introduction to how you can setup the solution and how your customers will experience it.</p>
      <div class="mt-5">
        <a class="btn btn-primary playground-cta" target="_blank" href="https://playground.swedbankpay.com" type="button">Head to our Playground <i class="at-arrow-right ml-2" aria-hidden="true"></i></a>
      </div>
    </div>
    <div class="col-lg-5 pr-0 d-flex justify-content-end">
      <div class="video-container">
        <video loop autoplay muted><source src="/assets/mp4/Playground_2_Logo_Tall.mp4" type="video/mp4"></video>
      </div>
    </div>
  </div>
{% endcontentfor %}

{% assign card_col_class="col-xl-4 col-lg-4" %}

{% contentfor extras %}
  <h2 id="front-page-contact-partners" class="heading-line">Partners</h2>
  <div class="row mt-4">
    <div class="{{ card_col_class }}">
      {% include card.html
          title='Danish partners'
          open_in_new_tab=true
          icon_content='flag-icon flag-icon-dk'
          cta_text='Learn more'
          description='Discover our Danish payment solutions and partners.'
          url='https://www.swedbankpay.dk/partners'
      %}
    </div>
    <div class="{{ card_col_class }}">
      {% include card.html
          title='Norwegian partners'
          open_in_new_tab=true
          icon_content='flag-icon flag-icon-no'
          cta_text='Learn more'
          description='Power up your payments through our Norwegian partnerships.'
          url='https://www.swedbankpay.no/partners'
      %}
    </div>
    <div class="{{ card_col_class }}">
      {% include card.html
          title='Swedish partners'
          open_in_new_tab=true
          icon_content='flag-icon flag-icon-se'
          cta_text='Learn more'
          description='Explore partnerships in Sweden for better payment experiences.'
          url='https://www.swedbankpay.se/partners'
      %}
    </div>
  </div>
{% endcontentfor %}

{% assign card_col_class="col-xl-4 col-lg-4" %}

{% contentfor extras %}
  <h2 id="front-page-contact-partners" class="heading-line">Contact</h2>
  <div class="row mt-4">
    <div class="{{ card_col_class }}">
      {% include card.html
          title='Denmark'
          open_in_new_tab=true
          icon_content='flag-icon flag-icon-dk'
          cta_text='Contact us'
          description='Enhance your payment solutions. Reach out to our Danish sales team to explore our offerings.'
          url='https://www.swedbankpay.dk/kontakt-os'
      %}
    </div>
    <div class="{{ card_col_class }}">
      {% include card.html
          title='Norway'
          open_in_new_tab=true
          icon_content='flag-icon flag-icon-no'
          cta_text='Contact us'
          description='Optimize your payment solutions. Get in touch with our Norwegian sales team to discover our services.'
          url='https://www.swedbankpay.no/kontakt-oss'
      %}
    </div>
    <div class="{{ card_col_class }}">
      {% include card.html
          title='Sweden'
          open_in_new_tab=true
          icon_content='flag-icon flag-icon-se'
          cta_text='Contact us'
          description='Upgrade your payment solutions. Connect with our Swedish sales team to learn about our offerings.'
          url='https://www.swedbankpay.se/kontakta-oss'
      %}
    </div>
  </div>
{% endcontentfor %}
