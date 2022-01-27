---
title: Sequence Diagrams
hide_from_sidebar: false
description: |
    The sequence diagrams for Checkout v3 integrations
menu_order: 600
---

## Authenticated Redirect

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, Payer refers to the merchant front-end
(website) while Merchant refers to the merchant back-end." %}

```plantuml
{% include diagrams/checkout-v3-business-redirect.puml %}
```

*   ① Read more about [callback][callback] handling in the technical reference.

{% include iterator.html prev_href="/checkout-v3/authenticated/redirect"
                         prev_title="Back to Authenticated Redirect" %}<br/>

## Authenticated Seamless View

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, the Payer refers to the merchant front-end
(website) while Merchant refers to the merchant back-end." %}

```plantuml
{% include diagrams/checkout-v3-business-seamless-view.puml %}
```

*   ① See [seamless view events][seamless-view-events] for further information.
*   ② Read more about [callback][callback] handling in the technical reference.

{% include iterator.html prev_href="/checkout-v3/authenticated/seamless-view"
                         prev_title="Back to Authenticated Seamless View" %}<br/>

## Merchant Authenticated Consumer Redirect

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, the Payer refers to the merchant front-end
(website) while Merchant refers to the merchant back-end." %}

```plantuml
{% include diagrams/checkout-v3-enterprise-redirect.puml %}
```

*   ① Read more about [callback][mac-callback] handling in the technical reference.

{% include iterator.html prev_href="/checkout-v3/mac/redirect"
                         prev_title="Back to MAC Redirect" %}<br/>

## Merchant Authenticated Consumer Seamless View

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, the Payer refers to the merchant front-end
(website) while Merchant refers to the merchant back-end." %}

```plantuml
{% include diagrams/checkout-v3-enterprise-seamless-view.puml %}
```

*   ① See [seamless view events][mac-seamless-view-events] for further information.
*   ② Read more about [callback][mac-callback] handling in the technical reference.

{% include iterator.html prev_href="/checkout-v3/mac/seamless-view"
                         prev_title="Back to MAC Seamless View" %}

## Payments Only Redirect

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, the Payer refers to the merchant front-end
(website) while Merchant refers to the merchant back-end." %}

```plantuml
{% include diagrams/checkout-v3-payments-only-redirect.puml %}
```

*   ① Read more about [callback][payments-callback] handling in the technical reference.

{% include iterator.html prev_href="/checkout-v3/payments-only/redirect"
                         prev_title="Back to Payments Only Redirect" %}<br/>

## Payments Only Seamless View

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, the Payer refers to the merchant front-end
(website) while Merchant refers to the merchant back-end." %}

```plantuml
{% include diagrams/checkout-v3-payments-only-seamless-view.puml %}
```

*   ① See [seamless view events][payments-seamless-view-events] for further information.
*   ② Read more about [callback][payments-callback] handling in the technical reference.

{% include iterator.html prev_href="/checkout-v3/payments-only/seamless-view"
                         prev_title="Back to Payments Only Seamless View" %}

## Starter Seamless View

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, the Payer refers to the merchant front-end
(website) while Merchant refers to the merchant back-end." %}

```plantuml
{% include diagrams/checkout-v3-starter-seamless-view.puml %}
```

*   ① See [seamless view events][standard-seamless-view-events] for further information.
*   ② Read more about [callback][standard-callback] handling in the technical reference.

{% include iterator.html prev_href="/checkout-v3/standard/seamless-view"
                         prev_title="Back to Standard Seamless View" %}

[callback]: /checkout-v3/authenticated/features/technical-reference/callback
[mac-callback]: /checkout-v3/mac/features/technical-reference/callback
[payments-callback]: /checkout-v3/payments-only/features/technical-reference/callback
[standard-callback]: /checkout-v3/standard/features/technical-reference/callback
[seamless-view-events]: /checkout-v3/authenticated/features/technical-reference/seamless-view-events
[mac-seamless-view-events]: /checkout-v3/mac/features/technical-reference/seamless-view-events
[payments-seamless-view-events]: /checkout-v3/payments-only/features/technical-reference/seamless-view-events
[standard-seamless-view-events]: /checkout-v3/standard/features/technical-reference/seamless-view-events
