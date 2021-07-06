---
title: Seamless View
redirect_from: /payments/card/seamless-view
estimated_read: 10
description: |
  The Seamless View purchase scenario
  represents the opportunity to implement card payments
  directly in your webshop.
menu_order: 300
---

Below, you will see a sequence diagram showing the sequence of a Swedbank Pay
checkout integration using the Seamless view solution.

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
            note left of Consumer: Checkout Authenticate seamless view
            activate Consumer
            Consumer ->>+ Merchant: Initiate Purchase
            deactivate Consumer
            Merchant ->>+ SwedbankPay: POST /psp/paymentorders (hostUrls, paymentUrl, payer information)
            deactivate Merchant
            SwedbankPay -->>+ Merchant: rel:view-paymentmenu
            deactivate SwedbankPay
            Merchant -->>- Consumer: Display SwedbankPay Payment Menu on Merchant Page
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
                    3rdParty -->>+ Consumer: Redirect back to paymentUrl (merchant)
                    deactivate 3rdParty
                    Consumer ->> Consumer: Initiate Payment Menu Seamless View (open iframe)
                    Consumer ->>+ SwedbankPay: Show Payment UI page in iframe
                    deactivate Consumer
                end

        SwedbankPay -->> Payer: Payment status

            alt If payment is completed
            activate Consumer
            Consumer ->> Consumer: Event: onPaymentCompleted
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

                opt If payment is failed
                activate Consumer
                Consumer ->> Consumer: Event: OnPaymentFailed
                Consumer ->>+ Merchant: Check payment status
                deactivate Consumer
                Merchant ->>+ SwedbankPay: GET {paymentorder.id}
                deactivate Merchant
                SwedbankPay -->>+ Merchant: rel: failed-paymentorder
                deactivate SwedbankPay
                opt Get PaymentOrder Details (if failed-paymentorder operation exist)
                activate Consumer
                deactivate Consumer
                Merchant ->>+ SwedbankPay: GET rel: failed-paymentorder
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

### Explanations

Under, you see a list of notes that explains some of the sequences in the
diagram.

#### Checkin

*   ① `rel: view-consumer-identification` is a value in one of the operations,
    sent as a response from Swedbank Pay to the Merchant.
*   ② `Initiate Consumer Seamless View (open iframe)` creates the iframe.
*   ③ `Show Consumer UI page in iframe` displays the checkin form as content inside
    of the iframe.
*   ④ `onConsumerIdentified (consumerProfileRef)` is an event that triggers when
    the consumer has been identified

#### Payment Menu

*   ⑤ `Authorize Payment` is when the payer has accepted the payment.

{% include payment-order-checkout-mac.md %}

{% include view-payment-order-checkout.md %}
