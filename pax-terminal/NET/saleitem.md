---
permalink: /:path/saleitem/
description: |
    SaleItem is used for fuel transactions. A list of sale items is included i TransactionSetup when calling Payment.
---

```c#
namespace SwpTrmLib.Nexo 
{
    public class SaleItem
    {
        public enum UnitsOfMeasure { None, Litre, Centilitre, Kilometre, Kilogram, Gram, Metre, Centimetre, Other};

        public UnitsOfMeasure UnitOfMeasure { get; set; } = UnitsOfMeasure.None;
        public string Quantity { get; set; } = string.Empty;
        public Decimal UnitPrice { get; set; } = Decimal.Zero;
        public string ProductLabel { get; set; } = string.Empty;
        public string AdditionalProductInfo { get; set; } = string.Empty;

        //Attributes
        public int ItemID { get; set; } = int.MinValue ;
        //digit strings
        public string ProductCode { get; set; } = string.Empty;
        public Decimal ItemAmount { get; set; } = Decimal.Zero;

        public SaleItem();
        public XElement XML();
        public override string ToString();
    }
}
```

{:.table .table-striped}
| :------------- | :-------------- |:--------------- |:---|
| **Type** | **Name** | **Description** | |
| UnitOfMeasure | Enumeration UnitOfMeasures |Litre or Kilogram | Mandatory |
| Decimal | Quantity | | Mandatory |
| string |ProductLabel |Name of product | Optional |
| string |AdditionalProductInfo | | Optional |
| int | ItemID | 0-n | Mandatory |
| string | ProductCode | Digits | Mandatory |
| Decimal | ItemAmount | Total product price | Mandatory |
| **Functions** | | | |
| XElement | XML | Returns the nexo SaleItem element | used internally |

{:.code-view-header}
**Example creating a list of sale items for a purchase**

```c#
    ISwpTrmIf_1 PAX;
    .
    .
    .
    List<SaleItem> saleItems = new List<SaleItem>();
    saleItems.Add(new SaleItem()
    {
        ItemID = 0,
        ItemAmount = (decimal)25.5,
        ProductCode = "24601",
        UnitOfMeasure = SaleItem.UnitsOfMeasure.Litre,
        Quantity = "10",
        UnitPrice = (decimal)2.55,
        ProductLabel = "Stellar",
        AdditionalProductInfo = "The best there is"
    });
    saleItems.Add(new SaleItem()
    {
        ItemID = 1,
        ItemAmount = (decimal)29.5,
        ProductCode = "2564",
        Quantity = "1",
        UnitPrice = (decimal)29.5
    });

    NexoPayementResult r = await PAX.Payment(new TransactionSetup(){
        Amount = 70,
        SaleItems = saleItems
    });
```
