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
| UnitsOfMeasure | UnitOfMeasures |Litre or Kilogram | Mandatory |
| Decimal | Quantity | | Mandatory |
| string |ProductLabel |Name of product | Optional |
| string |AdditionalProductInfo | | Optional |
| int | ItemID | 0-n | Mandatory |
| string | ProductCode | Digits | Mandatory |
| Decimal | ItemAmount | Total product price | Mandatory |
| **Functions** | | | |
| XElement | XML | Returns the nexo SaleItem element | used internally |
