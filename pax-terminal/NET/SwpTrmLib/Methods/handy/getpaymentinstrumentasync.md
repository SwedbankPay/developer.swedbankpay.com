---
title: Get Payment Instrument
permalink: /:path/getpaymentinstrumentasync/
description: |
    Use this to read a card before the amount is known. This way it is easy to make a loyalty solution and to deduct the amount in case of a loyalty member. It may also speed ut the process in case contactless is used and PIN not required.
menu_order: 40
---
### Method Signatures

Synchronous

*   void GetPaymentInstrument(Nexo.PaymentTypes type= Nexo.PaymentTypes.Normal)
*   void GetPaymentInstrument(`TransactionSetup` setup)

Asynchronous

*   async Task\<GetPaymentInstrumentResult\> GetPaymentInstrumentAsync(Nexo.PaymentTypes type= Nexo.PaymentTypes.Normal)
*   async Task\<GetPaymentInstrumentResult\> GetPaymentInstrumentAsync(`TransactionSetup` setup)

### Description

Use GetPaymentInstrumentAsync to read a card before the amount is known. The call starts a payment transaction, and the card read will be held by the terminal until PaymentAsync or RefundAsync is called. When you have the response, a new card may be read. The last payment card read is the one that gets charged.

### Parameters

*   **type** - `Nexo.PaymentTypes.Normal` or `Nexo.PaymentTypes.Refund`

or

*   **setup** - [`TransactionSetup`][transactionsetup]. Use this to set a transacion id to track the transaction.

### Returns

```c#
public class GetPaymentInstrumentResult
    {
        public NexoResponseResult Result { get; set; }
        public string ErrorCondition { get; set; }
        public string Text { get; set; }
        public CardTypes Type { get; set; }
        public string Brand { get; set; }
        public string PAN { get; set; }
        public string CNA { get; set; }
    }

```

[Example of usage][getpaymentinstrument-sample-code]

### CardTypes

```c#
public enum CardTypes { Payment=1, Combined=2,Loyalty=3,Unspecified=4 };
```

### Example nexo response

The actual nexo message response looks as follows.

```xml
<SaleToPOIResponse>
    <MessageHeader MessageClass="Service" MessageCategory="CardAcquisition" MessageType="Response" ServiceID="2010" SaleID="2" POIID="A-TEST-POIID"/>
    <CardAcquisitionResponse>
        <Response Result="Success"/>
        <SaleData>
            <SaleTransactionID TransactionID="28151231" TimeStamp="2023-03-20T09:01:56+01:00"/>
        </SaleData>
        <POIData>
            <POITransactionID TransactionID="024195" TimeStamp="2023-03-20T08:01:56.357Z"/>
        </POIData>
        <PaymentInstrumentData PaymentInstrumentType="Card">
            <CardData PaymentBrand="01,Visa" MaskedPAN="453903******8373" EntryMode="Contactless">
                <AllowedProduct ProductCode="1">
                    <ProductLabel>card:cashback</ProductLabel>
                    <AdditionalProductInfo>maxAmount:100000</AdditionalProductInfo>
                </AllowedProduct>
                <PaymentToken TokenRequestedType="Customer" TokenValue="E2648A1822580C93B79BDE7B22A134E85415F94DD6AF2325E1735E0722FDCB3BF8EA20"/>
            </CardData>
        </PaymentInstrumentData>
    </CardAcquisitionResponse>
</SaleToPOIResponse>
```

[transactionsetup]: /pax-terminal/NET/includes/transactionsetup
[getpaymentinstrument-sample-code]: /pax-terminal/NET/CodeExamples/#get-cna-for-customer
