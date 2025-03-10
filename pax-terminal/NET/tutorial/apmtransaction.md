---
title: APM transaction
description: |
    APM - Alternative Payment Method. Let the customer choose a different payment method than card but keep the same flow towards the sale system as for a card payment.
permalink: /:path/apmtransaction/
menu_order: 70
---
### Alternative Payment Methods

An APM transaction is started just like a card payment. The only thing that differs from a card payment is the content of the [`PaymentRequestResult`][paymentrequestresult].

{:.code-view-header}
Payment started as a regular payment for 10 in currency of decided culture

```c#
  var result = await pax.PaymentAsync(10);
  if (result.ResponseResult == NexoResponseResult.Success) 
  {
    if (!String.IsNullOrEmpty(result.APMReference)) 
    {
      // this is an APM transaction
      string type = result.APMType;
    }
  }
 ```

The important thing from the result is the `APMReference` which needs to be on the receipt since it is used when making a refund. The type of APM that was used is retrieved from `APMType`.

{:.code-view-header}
ReceiptBlob with APMReference as Ref.nr and APMType is Swish.

```text
Swedbank Pay Charity    
Kungsgatan 36           
11135 Stockholm         
Org nr: 5567355671      
Phone no.:              
                        
Swedbank                
Butiksnr:       20001601
2024-01-18         11:40
Kvittonr.:        020424
                        
                        
          KÖP           
                        
SEK                 1,00
Totalt:             1,00
                        
SWISH                   
                        
                        
  BETALNING GENOMFÖRD   
                        
Ref.nr: 3558174609679520
                        
     SPARA KVITTOT      
      KUNDENS EX.
```

The `APMReference` would be nice to have like a barcode, but the minimum is just print the ReceiptBlob as is.
The PaymentRequestsResult contins more information but things will change in a near future so don't do extensive coding on that information for a APM transaction without contacting SwedbankPay.

[paymentrequestresult]: /pax-terminal/NET/includes/paymentrequestresult
