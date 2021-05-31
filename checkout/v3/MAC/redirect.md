---
title: Redirect
estimated_read: 10
description: |
  Redirect is the simplest integration that lets Swedbank Pay handle the
  payments, while you handle your core activities.
  When ready to pay, the payer will be redirected to a secure Swedbank Pay
  hosted site, authenticate the Checkout profile and select preferred payment instrument.
  Finally, the payer will be redirected back to your website after the
  payment process.
menu_order: 200
---

Below, you will see a sequence diagram showing the sequence of a Swedbank Pay
checkout integration using the Redirect solution.

{% include alert.html type="informative" icon="info" body="
Note that in this diagram, the Payer refers to the merchant front-end
(website) while Merchant refers to the merchant back-end." %}

```mermaid
sequenceDiagram
    participant Consumer
    participant Merchant
    participant SwedbankPay as Swedbank Pay
    participant 3rdParty

        rect rgba(238, 112, 35, 0.05)
            note left of Consumer: Checkout Authenticate Redirect
            activate Consumer
            Consumer ->>+ Merchant: Initiate Purchase
            deactivate Consumer
            Merchant ->>+ SwedbankPay: POST /psp/paymentorders (completeUrl, payer information)
            deactivate Merchant
            SwedbankPay -->>+ Merchant: rel:redirect-paymentmenu
            deactivate SwedbankPay
            Merchant -->>- Consumer: Redirect consumer to SwedbankPay payment page.
            activate Consumer
    Consumer ->> Consumer: Initiate Payment step
            deactivate Consumer
            SwedbankPay ->>+ Consumer: Do payment logic
            deactivate SwedbankPay
            Consumer ->> SwedbankPay: Do payment logic
            deactivate Consumer

                opt Consumer perform payment out of iFrame
                    activate Consumer
                    Consumer ->> Consumer: Redirect to 3rd party
                    Consumer ->>+ 3rdParty: Redirect to 3rdPartyUrl URL
                    deactivate Consumer
                    3rdParty -->>+ Consumer: Redirect back to SwedbankPay 
                    deactivate 3rdParty
                    Consumer ->> Consumer: Initiate Payment Menu
                    Consumer ->>+ SwedbankPay: Show Payment UI page in iframe
                    deactivate Consumer
                end

        SwedbankPay -->> Payer: Payment status

            alt If payment is completed
            activate Consumer
            Consumer ->> Consumer: Redirect back to CompleteUrl
            Consumer ->>+ Merchant: Check payment status
            deactivate Consumer
            Merchant ->>+ SwedbankPay: GET <paymentorder.id>
            deactivate Merchant
            SwedbankPay ->>+ Merchant: rel: paid-paymentorder
            deactivate SwedbankPay
            opt Get PaymentOrder Details (if paid-paymentorder operation exist)
            activate Consumer
            deactivate Consumer
            Merchant ->>+ SwedbankPay: GET rel: paid-paymentorder
            deactivate Merchant
            SwedbankPay -->> Merchant: Payment Details
            deactivate SwedbankPay
            end
            end
 
        activate Merchant
        Merchant -->>- Consumer: Show Purchase complete
            opt PaymentOrder Callback (if callbackUrls is set)
            activate Consumer
            deactivate Consumer
                SwedbankPay ->> Merchant: POST Payment Callback
            end
            end

    rect rgba(81,43,43,0.1)
        activate Merchant
        note left of Consumer: Capture
        Merchant ->>+ SwedbankPay: rel:create-paymentorder-capture
        deactivate Merchant
        SwedbankPay -->>- Merchant: Capture status
        note right of Merchant: Capture here only if the purchased<br/>goods don't require shipping.<br/>If shipping is required, perform capture<br/>after the goods have shipped.<br>Should only be used for <br>PaymentInstruments that support <br>Authorizations.
        end
```


{% include payment-order-checkout-mac.md %}
