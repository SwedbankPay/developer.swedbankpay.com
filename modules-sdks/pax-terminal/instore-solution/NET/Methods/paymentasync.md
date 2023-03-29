---
title: PaymentAsync
description: async Task\<PaymentRequestResult\> PaymentAsync(decimal totalamount,[decimal cashback=0], [string currency="SEK"])
---

The PaymentAsync should be called when the amount is known. It opens all available readers and waits for a payment instrument. If Alternative Payment Methods are activated it will open for that too.

{% include alert.html type="warning" icon="warning" header="Heads up"
body="After PaymentAsync returns there has to be a delay before next request can be made. If no delay the next request will fail, indicating busy and retries have to be made."
%}

### Parameters

* **totalamount** - includes possible cashback amount
* **cashback** - part of total amount that will be handed to customer
* **currency** - currency code as a string representing ISO-4217 3 letter code. Has to be available in the terminal setup. Default "SEK".

### Returns

A **PaymentRequestResult**

A `PayementRequestResult.ResponseResult` of value `Success` means transaction approved.
If `ResponseResult` is `Failure` there is an `ErrorCondition`. If `ErrorCondition` is `Busy` wait awhile and try again.

Make sure to always print the customer receipt when available. For an aborted PaymentAsync there might not be one available.

```c#
public class NexoRequestResult
{
  public virtual string ResponseContent { get; set; }
  public NexoResponseResult ResponseResult { get; set; }
  public string ErrorCondition { get; set; }
  public string ResponseText { get; set; }
}

public class PaymentRequestResult : NexoRequestResult
{
  public JObject CustomerReceiptData { get; set; }
  public JObject MerchantReceiptData { get; set; }
  public string FormattedReceipt { get; set; }
  public string ReceiptBlob { get; set; }
  public JObject SettlementData { get; set; }
  public XElement OriginalTransaction { get; set; }
  public string UICulture { get; set; }
  public override string ResponseContent { get; set; }
}


```

### CustomerReceiptData - Json object

```json
{
 "Cardholder": {
  "Mandatory": {
   "Acquirer": {
    "CardAcceptorNumber": "10020001",
    "TerminalID": "877888"
   },
   "CardAcceptor": {
    "Address1": "Kungsgatan 36",
    "BankAgentName": "banky-bank",
    "Name": "Demo shop",
    "OrganisationNumber": "5565671-6165",
    "PostZipCode": "5050",
    "TownCity": "merchant-Base24-City"
   },
   "CardDetails": {
    "ApplicationIdentifier": "A0000000031010",
    "CardSchemeName": {
     "ApplicationLabel": "Visa Debit"
    },
    "PrimaryAccountNumber": "************4565",
    "TerminalVerificationResult": "0080008000",
    "TransactionStatusInformation": "E800"
   },
   "Outcome": {
    "ApprovalCode": "942932",
    "AuthorisationResponder": "9",
    "AuthorisationResponseCode": "00",
    "DebitStatus": "00"
   },
   "Payment": {
    "AuthorisationChannel": "1",
    "CardholderVerificationMethod": "a",
    "Currency": "SEK",
    "FinancialInstitution": "SWE",
    "PaymentAmount": "41,00",
    "ReceiptNumber": "8778880241",
    "SignatureBlock": false,
    "TotalAmount": "41,00",
    "TransactionSource": "C",
    "TransactionType": "00"
   },
   "TimeStamp": {
    "DateOfPayment": "2023-03-16",
    "TimeOfPayment": "18:01"
   }
  },
  "Optional": {
   "CardAcceptor": {
    "CountryName": "752",
    "PhoneNumber": "+4684051000"
   },
   "CardDetails": {
    "CardSchemeName": {
     "ApplicationLabel": "Visa Debit"
    }
   },
   "Payment": {
    "Reference": "1801042"
   }
  }
 }
}
```

### FromattedRececipt - array of lines

```text
[{"Text":"Demo shop              "},{"Text":"Kungsgatan 36           "},{"Text":"5050 merchant-Base24-City"},{"Text":"Org nr: 5565671-6165    "},{"Text":"                        "},{"Text":"Butiksnr.:      10020001"},{"Text":"Termid:           877888"},{"Text":"2023-03-16         18:01"},{"Text":"                        "},{"Text":"          KÖP           "},{"Text":"                        "},{"Text":"SEK                41,00"},{"Text":"Total:             41,00"},{"Text":"                        "},{"Text":"Personlig kod           "},{"Text":"************4565        "},{"Text":"Visa Debit              "},{"Text":"                        "},{"Text":"                        "},{"Text":"Ca1 9 00 942932         "},{"Text":"                        "},{"Text":"Ref.nr:       8778880241"},{"Text":"AID:      A0000000031010"},{"Text":"TVR:          0080008000"},{"Text":"TSI:                E800"},{"Text":"                        "},{"Text":"     SPARA KVITTOT      "},{"Text":"      KUNDENS EX.       "}]
```

### ResponseContent - The Complete Nexo Response Message

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SaleToPOIResponse>
  <MessageHeader POIID="AJACQH28" SaleID="1" ServiceID="12" MessageType="Response" MessageCategory="Payment" MessageClass="Service"/>
  <PaymentResponse>
    <Response Result="Success"/>
    <SaleData>
      <SaleTransactionID TimeStamp="2023-03-16T18:01:04+01:00" TransactionID="1801042"/>
    </SaleData>
    <POIData>
      <POITransactionID TimeStamp="2023-03-16T17:00:56.684Z" TransactionID="8778880241"/>
    </POIData>
    <PaymentResult PaymentType="Normal">
      <PaymentInstrumentData PaymentInstrumentType="Card">
        <CardData EntryMode="ICC" MaskedPAN="458109******4565" PaymentBrand="01,Visa Debit">
          <PaymentToken TokenValue="6FD955BEFC750A42A6AFC46E7679ACE20E89FD18E740D3F32F97D5F2D29BA2100A8898" TokenRequestedType="Customer"/>
        </CardData>
      </PaymentInstrumentData>
      <AmountsResp CashBackAmount="0.00" AuthorizedAmount="41.00" Currency="SEK"/>
      <PaymentAcquirerData AcquirerPOIID="877888" MerchantID="10020001">
        <ApprovalCode>942932</ApprovalCode>
      </PaymentAcquirerData>
    </PaymentResult>
    <PaymentReceipt DocumentQualifier="CashierReceipt">
      <OutputContent OutputFormat="Text">
        <OutputText>eyJNZXJjaGFudCI6eyJNYW5kYXRvcnkiOnsiQWNxdWlyZXIiOnsiQ2FyZEFjY2VwdG9yTnVtYmVyIjoiMTAwMjAwMDEiLCJUZXJtaW5hbElEIjoiODc3ODg4In0sIkNhcmRBY2NlcHRvciI6eyJBZGRyZXNzMSI6IkjDpGxsZXNrw6VyYW4gMjgiLCJCYW5rQWdlbnROYW1lIjoiYmFua3ktYmFuayIsIk5hbWUiOiJKw6Ryb2xkcyBHb29kaWVzIiwiT3JnYW5pc2F0aW9uTnVtYmVyIjoiNTU2NTY3MS02MTY1IiwiUG9zdFppcENvZGUiOiI1MDUwIiwiVG93bkNpdHkiOiJtZXJjaGFudC1CYXNlMjQtQ2l0eSJ9LCJDYXJkRGV0YWlscyI6eyJBcHBsaWNhdGlvbklkZW50aWZpZXIiOiJBMDAwMDAwMDAzMTAxMCIsIkNhcmRTY2hlbWVOYW1lIjp7IkFwcGxpY2F0aW9uTGFiZWwiOiJWaXNhIERlYml0In0sIlByaW1hcnlBY2NvdW50TnVtYmVyIjoiNDU4MTA5KioqKioqNDU2NSIsIlRlcm1pbmFsVmVyaWZpY2F0aW9uUmVzdWx0IjoiMDA4MDAwODAwMCIsIlRyYW5zYWN0aW9uU3RhdHVzSW5mb3JtYXRpb24iOiJFODAwIn0sIk91dGNvbWUiOnsiQXBwcm92YWxDb2RlIjoiOTQyOTMyIiwiQXV0aG9yaXNhdGlvblJlc3BvbmRlciI6IjkiLCJBdXRob3Jpc2F0aW9uUmVzcG9uc2VDb2RlIjoiMDAiLCJEZWJpdFN0YXR1cyI6IjAwIn0sIlBheW1lbnQiOnsiQXV0aG9yaXNhdGlvbkNoYW5uZWwiOiIxIiwiQ2FyZGhvbGRlclZlcmlmaWNhdGlvbk1ldGhvZCI6ImEiLCJDdXJyZW5jeSI6IlNFSyIsIkZpbmFuY2lhbEluc3RpdHV0aW9uIjoiU1dFIiwiUGF5bWVudEFtb3VudCI6IjQxLDAwIiwiUmVjZWlwdE51bWJlciI6Ijg3Nzg4ODAyNDEiLCJTaWduYXR1cmVCbG9jayI6ZmFsc2UsIlRvdGFsQW1vdW50IjoiNDEsMDAiLCJUcmFuc2FjdGlvblNvdXJjZSI6IkMiLCJUcmFuc2FjdGlvblR5cGUiOiIwMCJ9LCJUaW1lU3RhbXAiOnsiRGF0ZU9mUGF5bWVudCI6IjIwMjMtMDMtMTYiLCJUaW1lT2ZQYXltZW50IjoiMTg6MDEifX0sIk9wdGlvbmFsIjp7IkNhcmRBY2NlcHRvciI6eyJDb3VudHJ5TmFtZSI6Ijc1MiIsIlBob25lTnVtYmVyIjoiKzQ2ODQwNTEwMDAifSwiQ2FyZERldGFpbHMiOnsiQ2FyZFNjaGVtZU5hbWUiOnsiQXBwbGljYXRpb25MYWJlbCI6IlZpc2EgRGViaXQifX0sIlBheW1lbnQiOnsiUmVmZXJlbmNlIjoiMTgwMTA0MiJ9fX19</OutputText>
      </OutputContent>
    </PaymentReceipt>
    <PaymentReceipt DocumentQualifier="CustomerReceipt">
      <OutputContent OutputFormat="Text">
        <OutputText>eyJDYXJkaG9sZGVyIjp7Ik1hbmRhdG9yeSI6eyJBY3F1aXJlciI6eyJDYXJkQWNjZXB0b3JOdW1iZXIiOiIxMDAyMDAwMSIsIlRlcm1pbmFsSUQiOiI4Nzc4ODgifSwiQ2FyZEFjY2VwdG9yIjp7IkFkZHJlc3MxIjoiSMOkbGxlc2vDpXJhbiAyOCIsIkJhbmtBZ2VudE5hbWUiOiJiYW5reS1iYW5rIiwiTmFtZSI6IkrDpHJvbGRzIEdvb2RpZXMiLCJPcmdhbmlzYXRpb25OdW1iZXIiOiI1NTY1NjcxLTYxNjUiLCJQb3N0WmlwQ29kZSI6IjUwNTAiLCJUb3duQ2l0eSI6Im1lcmNoYW50LUJhc2UyNC1DaXR5In0sIkNhcmREZXRhaWxzIjp7IkFwcGxpY2F0aW9uSWRlbnRpZmllciI6IkEwMDAwMDAwMDMxMDEwIiwiQ2FyZFNjaGVtZU5hbWUiOnsiQXBwbGljYXRpb25MYWJlbCI6IlZpc2EgRGViaXQifSwiUHJpbWFyeUFjY291bnROdW1iZXIiOiIqKioqKioqKioqKio0NTY1IiwiVGVybWluYWxWZXJpZmljYXRpb25SZXN1bHQiOiIwMDgwMDA4MDAwIiwiVHJhbnNhY3Rpb25TdGF0dXNJbmZvcm1hdGlvbiI6IkU4MDAifSwiT3V0Y29tZSI6eyJBcHByb3ZhbENvZGUiOiI5NDI5MzIiLCJBdXRob3Jpc2F0aW9uUmVzcG9uZGVyIjoiOSIsIkF1dGhvcmlzYXRpb25SZXNwb25zZUNvZGUiOiIwMCIsIkRlYml0U3RhdHVzIjoiMDAifSwiUGF5bWVudCI6eyJBdXRob3Jpc2F0aW9uQ2hhbm5lbCI6IjEiLCJDYXJkaG9sZGVyVmVyaWZpY2F0aW9uTWV0aG9kIjoiYSIsIkN1cnJlbmN5IjoiU0VLIiwiRmluYW5jaWFsSW5zdGl0dXRpb24iOiJTV0UiLCJQYXltZW50QW1vdW50IjoiNDEsMDAiLCJSZWNlaXB0TnVtYmVyIjoiODc3ODg4MDI0MSIsIlNpZ25hdHVyZUJsb2NrIjpmYWxzZSwiVG90YWxBbW91bnQiOiI0MSwwMCIsIlRyYW5zYWN0aW9uU291cmNlIjoiQyIsIlRyYW5zYWN0aW9uVHlwZSI6IjAwIn0sIlRpbWVTdGFtcCI6eyJEYXRlT2ZQYXltZW50IjoiMjAyMy0wMy0xNiIsIlRpbWVPZlBheW1lbnQiOiIxODowMSJ9fSwiT3B0aW9uYWwiOnsiQ2FyZEFjY2VwdG9yIjp7IkNvdW50cnlOYW1lIjoiNzUyIiwiUGhvbmVOdW1iZXIiOiIrNDY4NDA1MTAwMCJ9LCJDYXJkRGV0YWlscyI6eyJDYXJkU2NoZW1lTmFtZSI6eyJBcHBsaWNhdGlvbkxhYmVsIjoiVmlzYSBEZWJpdCJ9fSwiUGF5bWVudCI6eyJSZWZlcmVuY2UiOiIxODAxMDQyIn19fX0=</OutputText>
      </OutputContent>
    </PaymentReceipt>
  </PaymentResponse> 
</SaleToPOIResponse>
```

### ReceiptBlob - Fast Forward To Well Formatted Receipt Information

```text
Demo shop               
Kungsgatan 36           
5050
 merchant-Base24-City
Org nr: 5565671-6165    
                        
Butiksnr.:      10020001
Termid:           877888
2023-03-16         18:01
                        
          KÖP           
                        
SEK                41,00
Total:             41,00
                        
Personlig kod           
************4565        
Visa Debit              
                        
                        
Ca1 9 00 942932         
                        
Ref.nr:       8778880241
AID:      A0000000031010
TVR:          0080008000
TSI:                E800
                        
     SPARA KVITTOT      
      KUNDENS EX. 
```
