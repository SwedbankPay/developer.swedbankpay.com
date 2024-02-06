---
title: Fuel Functionality
permalink: /:path/fuelfunctionality/
description: |
    A matter of adding SaleItem elements to the PaymentTransaction element in a PaymentRequest.
    
icon:
  content: local_gas_station
  outlined: true
menu_order: 60
---
### What is Fuel Funtionality

Fuel functionality in our PAX terminals is just a matter of supplying `SaleItems` in a payment request. If any of the `SaleItems` is not valid for the card used, the payment will fail and the response will contain product codes that are valid for the card.

### PaymentRequest for fuel

{:.table .table-striped}
| Name | Lev | Attributes | Description |
| :------------- | :--: | :-------------- |:--------------- |
| PaymentRequest | 1 | | |
| SaleData | 2 | TokenRequestedType | This will give a token for the card used. Only value available is `Customer` which gives a Card Number Alias which is a one way hash computed locally in the terminal. The CNA is the same for a specific card in all SwedbankPay terminals. |
| SaleTransactionID | 3 | TimeStamp| Request timestamp local time with offset from GMT. |
|   | | TransactionID | ID of the transaction set by the POS. This value is sent to the PosPay server, but is unfortunately not forwarded to clearing.|
| PaymentTransaction | 2 | | |
| AmountsReq | 3 | RequestedAmount | The total amount of transaction as a decimal value. Use a **'.'** for decimal point if needed. |
|   | | Currency | As a 3 letter abbrivation - ISO-4217. Available are `SEK`, `NOK`, `DKK`, `EUR`.|
|  | | CashBackAmount | As `whereof`value. Is included in `RequestedAmount`. |
| SaleItem | 3 | ItemId | 0-n Required. |
|  | | ProductCode | DigitString 1-12 bytes. Required. |
|  | | ItemAmount | Decimal: Total amount of the SaleItem. Use a **'.'** for decimal point. Required.|
| UnitOfMeasure|4| |Only present together with Quantity. Enumeration: Litre or Kilogram. |
| Quantity |4| | Decimal: Product quantity. Use a **'.'** for decimal point. |
| UnitPrice |4| | Decimal: price per unit. Use a **'.'** for decimal point. Only if Quantity is present. |
| ProductLabel |4||Name of product purchased. |
| AdditionalProductInfo|4| |Additional information about the product.|
| PaymentData | 2 | PaymentType | Type of transaction that is requested. Availabel values are `Normal`, which is a payment and `Refund`. |

{:.code-view-header}
**Example of purchase request for two products**

```xml
 <SaleToPOIRequest>
    <MessageHeader MessageCategory="Payment" MessageClass="Service" MessageType="Request" POIID="A-POIID" ProtocolVersion="3.1" SaleID="1" ServiceID="1524253497"/>
    <PaymentRequest>
        <SaleData TokenRequestedType="Customer">
            <SaleTransactionID TimeStamp="2023-09-08T16:17:32.9834651+02:00" TransactionID="1524253496"/>
        </SaleData>
        <PaymentTransaction>
            <AmountsReq CashBackAmount="0" Currency="SEK" RequestedAmount="514.90"/>
            <SaleItem ItemID="0" ItemAmount="446.90" ProductCode="24601">
                <UnitOfMeasure>LITRE</UnitOfMeasure>
                <Quantity>20.5</Quantity>
                <UnitPrice>21.8</UnitPrice>
                <ProductLabel>Diesel</ProductLabel>
                <AdditionalProductInfo>1541257424284</AdditionalProductInfo>
            </SaleItem>
            <SaleItem ItemId="1" ItemAmount="68.0" ProductCode="1645">
                <Quantity>1</Quantity>
                <UnitPrice>68.0</UnitPrice>
            </SaleItem>
        </PaymentTransaction>
        <PaymentData PaymentType="Normal"/>
    </PaymentRequest>
</SaleToPOIRequest>
```

### Payment Restrictions

In case the card used for the purchase has restrictions and any product is not payable with the card, the payment will fail and the response will contain the product codes for those producs that are allowed to pay for. In such case the `Result` is `Failure` and `ErrorCondition` is `PaymentRestriction`.

The difference from a [normal purchase response][normalpurchaseresponse] is in the element `CardData` within the `PaymentResult` element. The following example shows the PaymentResult element if the above PaymentRequest failed due to payment restriction on the card for which only product code **24601** is allowed.

{:.code-view-header}
**Example of PaymentResult element if above payment failed with PaymentRestriction**

```xml
    <PaymentResult PaymentType="Normal">
        <PaymentInstrumentData PaymentIntrumentType="Card">
            <CardData EntryMode="ICC" PaymentBrand="02,TheBestFuelCard" MaskedPAN="12345*******2020" />
                <PaymentToken TokenRequested="Customer" TokenValue="6FD955C23A48A041D881003CDBF836DC59F89CE0ECA8288129696CDF9BB8B8DD67F233" />
                <AllowedProductCode>24601</AllowedProductCode>
            </CardData>
        </PaymentIntrumentData>
    </PaymentResult>
                    
```

The response may contain several `AllowedProductCode` elements. One for each allowed product of those included in the payment request.

{:.code-view-header}
**Example of the complete payment response**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SaleToPOIResponse>
 <MessageHeader MessageClass="Service" MessageCategory="Payment" MessageType="Response" ServiceID="1524253497" SaleID="1" POIID="A-POIID"/>
 <PaymentResponse>
  <Response ErrorCondition="PaymentRestriction" Result="Failure">
    <AdditionalResponse>Some Products not Payable by the TheBestFuelCard</AdditionalResponse>
  </Response>
  <SaleData>
   <SaleTransactionID TimeStamp="2023-09-08T16:17:32.9834651+02:00" TransactionID="1524253496"/>
  </SaleData>
  <POIData>
   <POITransactionID TransactionID="8778880185" TimeStamp="2023-09-08T14:17:32.999Z"/>
  </POIData>
  <PaymentResult PaymentType="Normal">
        <PaymentInstrumentData PaymentIntrumentType="Card">
            <CardData EntryMode="ICC" PaymentBrand="02,TheBestFuelCard" MaskedPAN="12345*******2020" />
                <PaymentToken TokenRequested="Customer" TokenValue="6FD955C23A48A041D881003CDBF836DC59F89CE0ECA8288129696CDF9BB8B8DD67F233" />
                <AllowedProductCode>24601</AllowedProductCode>
            </CardData>
        </PaymentIntrumentData>
   <AmountsResp Currency="SEK" AuthorizedAmount="56" CashBackAmount="0.00"/>
   <PaymentAcquirerData MerchantID="10020001" AcquirerPOIID="877888">
    <ApprovalCode>611506</ApprovalCode>
   </PaymentAcquirerData>
  </PaymentResult>
  <PaymentReceipt DocumentQualifier="CashierReceipt">
   <OutputContent OutputFormat="Text">
    <OutputText>eyJNZXJjaGFudCI6e...Mocked-up-data</OutputText>
   </OutputContent>
  </PaymentReceipt>
  <PaymentReceipt DocumentQualifier="CustomerReceipt">
   <OutputContent OutputFormat="Text">
    <OutputText>eyJDYXJkaG9sZGVy...Mocked-up-data</OutputText>
   </OutputContent>
  </PaymentReceipt>
 </PaymentResponse>
</SaleToPOIResponse>
```

[normalpurchaseresponse]: /pax-terminal/resources/normal-purchase-response
