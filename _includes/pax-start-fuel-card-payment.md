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

    PaymentRequestResult r = await PAX.Payment(new TransactionSetup(){
        Amount = (decimal)55,
        SaleItems = saleItems
    });
```
