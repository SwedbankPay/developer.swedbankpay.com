---
title: Make a Payment
description: |
 Once there is a Login Session it is possible to make a Payment transaction. The PaymentRequest is used for purchase as well as refund.
menu_order: 40
---
## PaymentRequest

Send a PaymentRequest to make a payment or refund when there is a `LoginSession`.
Make sure to save the `MessageHeader` since that is needed if abort is needed.

```xml
<SaleToPOIRequest>
    <MessageHeader MessageCategory="Payment" MessageClass="Service" MessageType="Request" POIID="A-POIID" ProtocolVersion="3.1" SaleID="ECR1" ServiceID="1524253497"/>
    <PaymentRequest>
        <SaleData TokenRequestedType="Customer">
            <SaleTransactionID TimeStamp="2023-09-08T16:17:32.9834651+02:00" TransactionID="1524253496"/>
        </SaleData>
        <PaymentTransaction>
            <AmountsReq CashBackAmount="0" Currency="SEK" RequestedAmount="38"/>
        </PaymentTransaction>
        <PaymentData PaymentType="Normal"/>
    </PaymentRequest>
</SaleToPOIRequest>
```

{:.table .table-striped}
| Name | Lev | Attributes | Description |
| :------------- | :--: | :-------------- |:--------------- |
| PaymentRequest | 1 | | |
| SaleData | 2 | TokenRequestedType | This will give a token for the card used. Only value available is `Customer` which gives a Card Number Alias which is a one way hash computed locally in the terminal. The CNA is the same for a specific card in all SwedbankPay terminals. |
| SaleTransactionID | 3 | TimeStamp| Request timestamp local time with offset from GMT |
|   | | TransactionID | ID of the transaction set by the POS. This value is sent to the PosPay server, but is unfortunately not forwarded to clearing.|
| PaymentTransaction | 2 | | |
| AmountsReq | | RequestedAmount | The total amount of transaction as a decimal value. Use a **'.'** for decimal point if needed |
|   | | Currency | As a 3 letter abbrivation - ISO-4217. Available are `SEK`, `NOK`, `DKK`, `EUR`.|
|  | | CashBackAmount | As `whereof`value. Is included in `RequestedAmount` |
| PaymentData | 2 | PaymentType | Type of transaction that is requested. Availabel values are `Normal`, which is a payment and `Refund` |

## Following a PaymentRequest

{% include iterator.html next_href="payment-response" next_title="Payment response is received" %}
{% include iterator.html next_href="abortpayment" next_title="Abort payment with an AbortRequest" %}
{% include iterator.html next_href="transactionstatus" next_title="Transaction status is asked for" %}
{% include iterator.html next_href="first-message" next_title="LoginRequest if all else fail" %}
