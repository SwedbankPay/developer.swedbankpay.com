---
title: Terminology
permalink: /:path/terminology/
menu_order: 12
---

{:.table .table-striped}
| **0-9** |
|  | **3-D Secure 2.0 (3DS2)** | The new authentication protocol for online card payments. The protocol is XML-based and designed to be an additional security layer for online credit and debit card transactions. |
|  | **3.x**       | The umbrella term for all Online Payments versions 3.0 and newer. If (v)3.x is used instead of a specific version (like v3.1), the feature, section or code example is applicable for all versions. |
|  **A**  |
|  | **Access Token**                | The OAauth 2 Access token needed to access Swedbank Pay e-commerce API. Tokens are generated in the Merchant Portal. Learn how to get started in the Merchant Portal Manual. Note that it must follow the regex pattern `[\w-]*`. |
|  | **Account Receivable Consumer** | The [`AccountReceivableConsumer`][invoice-url] API is the fundament for Swedbank Pay [Invoice Payments][invoice-url] service. It is a service where Swedbank Pay helps produce and distribute invoices to payers. |
|  | **Authorization**               | The first part of a [two-phase][fundamentals] transaction where a certain amount is blocked on the payer's account. The authorized amount is unavailable for the payer, ensuring that the merchant receives the money during the subsequent capture phase. |
|  **C**  |
|  | **Callback**                    | If `callbackURL` is set, a [Callback][callback-url] is triggered when a change or update from the back-end system is made on a payment or transaction. Swedbank Pay performs an async callback to inform the payee/merchant about this kind of update. |
|  | **Cancellation**                | Used to [cancel][cancel-url] authorized and not yet captured transactions. If a cancellation is performed after doing a part-capture, it will only affect the not yet captured authorization amount. |
|  | **Capture**                     | The second part of a [two-phase][fundamentals] transaction where the authorized amount is sent from the payer to the payee. It is possible to do a part-capture on a subset of the authorized amount. Several captures on the same payment are possible, up to the total authorization amount. |
|  | **Checkin**                     | Checkin is the first part of the Swedbank Pay [Checkout v2][checkout-url] flow (prior to displaying the Payment Menu), where the payer is identified by email and mobile phone number.  |
|  | **Consumer**                    | The person doing the purchase, equivalent to Payer.  |
|  | **Consumers**                   | The Consumers resource stores information about the consumer of the sold services or goods. It is the fundament of Checkin in Swedbank Pay [Checkout v2][checkout-url].  |
|  **F**  |
|  | **Financing Consumer**          | The `FinancingConsumer` Invoice API is the fundament for Swedbank Pay [Invoice Payments][invoice-url] service. It is a service where Swedbank Pay helps improve cashflow by purchasing merchant invoices. |
|  **H**  |
|  | **Header**                      | An `HTTP` header used to carry information when doing an API Request. All API requests share some [common headers][common-headers]. |
|  **I**  |
|  | **Intent**                      | An `intent` is a payment parameter that determines the possible activity states available for a payment option (e.g. Purchase). Intents differ depening on the payment method used. Creating a payment within a [one-phase][fundamentals] payment flow (Swish, Direct debit) must have the intent to create a [Sale][fundamentals]. This is in contrast to a [two-phase][fundamentals] payment flow that have the intent to create an [Authorization][fundamentals]. |
|  **M**  |
|  | **Merchant Portal**          | The Merchant Portal interface where you perform day to day operations on payments processed by Swedbank Pay. The Merchant Portal manual consists of two parts, [Getting Started and Interface and Search. |
|  **O**  |
|  | **One-phase payment flow**      | A [one-phase][fundamentals] payment is a payment done in one step. The amount is settled in one transactional step. |
|  | **Operation**                   | A  payment operation determines what kind of payment that should be implemented. Available payment operations vary, depending on payment method. The most common operation all payment methods share is the Purchase operation. Card Payments have several others, such as [Verify][verify-url] and [Recur][recur]. |
|  | **Operations**                  | Operations consist of an array of contextual links / actions that direct the payment flow in a given state of the payment resource (i.e. creating a capture transaction, creating a reversal transaction, returning a redirect URL, etc). Operations are [HATEOAS][hateoas]{:target="_blank"} driven and managed through API calls. |
|  **P**  |
|  | **Payee**                       | The company that receive funds for the payment. |
|  | **Payee ID**                    | The ID of the company that receive funds for the payment. Also referred to as Merchant ID.  |
|  | **Payer**                       | The person doing the purchase, equivalent to Consumer. |
|  | **Payment**                     | A payment is the main resource in all of Swedbank Pay [RESTful APIs][restful-api], and a fundamental building block for each payment method during the payment process. The payment resource of each payment method is architectually similar, although it is tailor-made to manage the specifics of each one. It can be in different states and contain several different types of transactions. The state of the payment decides the operations that are available. |
|  | **Payment Menu**                | A menu containing all the payment methods you as a merchant can and want to offer to the payer. Shown on a redirect page or embedded on the merchant's page (Seamless View). |
|  | **Payment Orders**              | The Payment Orders resource is used when initiating a payment process using the Payment Menu v2 and Swedbank Pay Checkout. What payment method the payment order will make use of is up to the payer. The payment order is a container for the payment method object selected, acessed through the sub-resources payments and currentPayment. |
|  | **Payment token**               | A payment token is generated through a card purchase or card verification. It contains all necessary payment details to enable subsequent server-to-server payments. Used in One-click payments and recurring payment scenarios (Card, Invoice and Swedbank Pay Checkout). |
|  | **PSD2**                        | PSD2 is the second Payment Services Directive, being the requirement for strong customer authentication. It is performed with multi-factor authentication, on the majority of electronic payments. |
|  | **Purchase**                    | The payment operation that initiates a purchase payment process. |
|  **R**  |
|  | **Recur**                       | The payment operation that initiates a recurring payment process. It is a payment that references a `recurrenceToken` created through a previous payment in order to charge the same card.  |
|  | **Reversal**                    | Used to reverse a payment. It is only possible to reverse a payment that has been captured and not yet reversed. |
|  **S**  |
|  | **Sale**                        | A [one-phase][fundamentals] transaction where the amount is settled when the transaction has succeeded. Payment methods using sales transactions are Swish and Direct Bank Debit. |
|  | **SCA**                         | Strong Customer Authentication, which is a requirement from EU Revised Directive on Payment Services (PSD2). This implements the multi-factor authentication, for stronger security of electronic payments. |
|  | **Swedbank Pay Direct API**     | A payment flow where the implementer (Swedbank Pay customer) handles all user intreraction and make direct API calls to Swedbank Pay (server-to-server). |
|  | **Swedbank Pay Seamless View**  | A payment flow were the payer interacts with pages developed by Swedbank Pay directly through an iframe, directly embedded in the webshop/merchant site. |
|  | **Swedbank Pay Payment Pages**  | A payment flow where the payer is redirected to a payment page developed and hosted by Swedbank Pay.  |
|  **T**  |
|  | **Two-phase payment flow**      | A payment done in [two steps] [fundamentals]. Authorization and capture. The most common payment method using two-phase payments is card payments. |
|  **U**  |
|  | **Unscheduled Purchase**                       | An unscheduled purchase, also called a Merchant Initiated Transaction (MIT), is a payment which uses an `unscheduledToken` generated through a previous payment in order to charge the same card at a later time. They are done by the merchant without the cardholder being present. |
|  **V**  |
|  | **Verify**                      | The payment operation that initiates a [verification][verify-url] payment process. It is a payment that lets you post verifications to confirm the validity of card information, without reserving or charging any amount. This option is used to generate a payment- or recurrence token, that can be used in a recurring payments scenarios or for one-clickpayments, without charging the card in the process. |

[callback-url]:/checkout-v3/features/payment-operations/callback/
[cancel-url]: /checkout-v3/get-started/post-purchase/#cancel-v31
[checkout-url]: /old-implementations/checkout-v2/
[common-headers]: /checkout-v3/get-started/fundamental-principles#headers
[fundamentals]: /old-implementations/payment-instruments-v1/#the-fundamentals
[hateoas]: https://en.wikipedia.org/wiki/HATEOAS
[invoice-url]: /old-implementations/payment-instruments-v1/invoice/
[recur]: /checkout-v3/features/optional/recur/
[restful-api]: /checkout-v3/get-started/fundamental-principles#connection-and-protocol
[verify-url]: /checkout-v3/features/optional/verify/
