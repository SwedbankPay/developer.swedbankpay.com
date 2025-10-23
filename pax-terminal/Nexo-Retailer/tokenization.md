---
title: Available Tokenization
permalink: /:path/tokenization/
description: |
    There are three types of tokenization of customer available for the POS
menu_order: 13
---
There are three different types of tokens of customer data available when using PAX terminals from Swedbank Pay. The will explain in brief the differences and their recommended use.

*   **CNA** - Cardnumber Alias, is a token that is generated in the terminals for a specific card number. There will be different CNAs for physical, mobile and cards in wearables even though they point at the same account. The benefit is that you may request this before the transaction takes place so that it is possible change amount depending on membership. [See more...][loyalty_adv]{:target="_blank"}
*   **PAR** - Payment Account Reference, is supplied in the response from the card issuer. It May not be awailable for all card brands, but is for Visa, MasterCard and Amex. As of now it is not possible to get PAR before the transaction takes place. The benefit is that PAR is the same for a physical card added to a wallet or a wearable. [See more...][paymentresponse]{:target="_blank"}
*   **NonPaymentToken** - A Swedbank Pay generated token, which needs to be activated on a merchant level in our host and is the same for a payment instrument from a Swedbank Pay PAX terminal as well as for a web shop using Swedbank Pay. This token works for all cards as well as mobile wallets and wearables. [See more...][paymentresponse]{:target="_blank"}

[loyalty_adv]: /pax-terminal/Nexo-Retailer/get-card-ahead
[paymentresponse]: /pax-terminal/Nexo-Retailer/Quick-guide/payment-response
