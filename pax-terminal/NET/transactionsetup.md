---
permalink: /:path/transactionsetup/
description: TransactionSetup may be used as a parameter when starting a transaction.
---
TransactionSetup holds properties for a transaction and may be passed as an input parameter to functions that start a transaction sequence. All properties are not relevant depending on which function that is called.

```c#
    public class TransactionSetup
    {
        public Nexo.PaymentTypes type { get; set; } =  Nexo.PaymentTypes.Normal;
        public decimal Amount { get; set; } = 0;
        public decimal CashBack { get; set; } = 0;
        public string Currency { get; set; } = "SEK";
        public string TransactionID { get; set; } = String.Empty;
        public string APMReference { get; set; } = String.Empty;
        public string PaymentInstrument { get; set; } = String.Empty;
        public List<SaleItem> SaleItems {get; set;} = List<SaleItem>();
        public override string ToString() 
        {
            return $"{type}, {Amount}, {CashBack}, {Currency}, {TransactionID}, {APMReference}, {PaymentInstrument}";
        }
    }
```

{:.table .table-striped}
| :------------- | :-------------- |:--------------- |:---|
| Nexo.PaymentTypes |type |Normal or Refund | Mandatory |
| decimal |Amount |Total amount | Mandatory |
| decimal |CashBack |included in Amount | Optional |
| string |Currency |As a 3 letter abbrivation - ISO-4217. Available are `SEK`, `NOK`, `DKK`, `EUR`. Needs to be configured in terminal. | Optional Default SEK. |
| string |TransactionID |A transaction id that may be set by sale system for tracking. If a transaction is started by calling `GetPayementInstrument`, the transaction id must be set in that call and cannot be changed when later calling `Payment` or `Refund` | Optional |
| string |APMReference |Used only if refund of a transaction made using alternative payment method. The reference originates from the response of the APM transaction | Only for Refund of APM transaction |
| string |PaymentInstrument |A non PCI regulated payment instrument. Prefix and supplied PAN must be registred in the terminal setup. The normal usage is for giftcards or card numbers that are created on site such as financing.| Optional |
| List\<[SaleItem][saleitem]\> | SaleItems | Product details for fuel functionality | Optional |

{:.code-view-header}
**Example creating a list of sale items**

```c#
    
    NexoPayementResult r = await PAX.Payment(new TransactionSetup(){
        Amount = 70,
        SaleItems = saleItems
    });

```

[saleitem]: /pax-terminal/NET/saleitem
