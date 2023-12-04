---
title: Partners
permalink: /:path/partners/
menu_order: 1000
sidebar_icon: handshake
description: |
    We have a lot of partners who help us create the best payment experience.
    Select a country to see who we are collaborating with in your market(s).
---

{% assign card_col_class="col-xxl-3 col-xl-6 col-lg-6" %}

  <h2 id="partners" class="heading-line">Partners</h2>
  <div class="row mt-4">
      <div class="{{ card_col_class }}">
          {% include card.html title='Denmark'
              text='Our Danish partners'
              icon_content='email'
              icon_outlined=true
              to='https://www.swedbankpay.dk/partners'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Norway'
              text='Our Norwegian partners'
              icon_content='email'
              icon_outlined=true
              to='https://www.swedbankpay.no/partners'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Sweden'
              text='Our Swedish partners'
              icon_content='email'
              icon_outlined=true
              to='https://www.swedbankpay.se/partners'
          %}
      </div>
  </div>
