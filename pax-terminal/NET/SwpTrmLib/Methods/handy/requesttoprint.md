---
title: Request To Print
permalink: /:path/requesttoprint/
description: |
    Call this method to use the A920pro printer for printing.
icon:
    content: print
    outlined: true
---
### Method Signatures

*   void RequestToPrint(List<`OutputText`> outputTexts)
*   Task<`NexoRequestResult`> RequestToPrintAsync(List<`OutputText`> outputTexts)

### Description

This method is typically used for printing the sale receipt for an integrated A920pro terminal.
The method may only be called before or after a PaymentRequest has been sent to the terminal, which means it may be sent after a GetPaymentInstrument, but not during the actual payment which in general starts when the amount is known.

Some formatting is possible regarding font size and alignment. An OutputText generates a line break. It is however possible to have one OutputText spanning several lines by using a 0x0A for line break in the Content member.

## OutputText Class

{% include pax-outputtext.md %}

## Printing on A920Pro

{:.code-view-header}
Example using RequestToPrint

```c#
// Prerequisites: PAX is an instace of ISwpTrmImp_1 using an A920pro.
// Login has been made.
using SwpTrmLib.Nexo;
void MyTestOfA920proPrinter()
{
    List<OutputText> textToPrint = new List<OutputText>();

    textToPrint.Add(new OutputText() {
        Content = "Text using default style"
    });
    textToPrint.Add(new OutputText() {
        Content = "Larger text",
        Height = CharacterHeights.DoubleHeight,
        Width = CharacterWidth.DoubleWidht,
        Alignment = Alignments.Centred
    });
    // StartRow is paper feed in pixels
    textToPrint.Add(new OutputText() {
        StartRow = 200,
        Content = "Space before this text",
        Alignment = Alignments.Right
    });
    // Text divided left and right using tab and alignment
    textToPrint.Add(new OutputText() {
        Content = "Left\tRight",
        Alignment = Alignments.Justified
    });
   
    textToPrint.Add(new OutputText() {
        Content = "This text is\x0a divided on several\x0a lines with the\x0a same formatting",
        Alignment = Alignments.Justified
    });
    
    PAX.RequestToPrint(textToPrint);
}
```

## Printing Payment Result

{:.code-view-header}
**Example printing sale receipt on A920Pro**

```c#
{
    NexoPaymentResult r = await PAX.Payment(amount);

    if (string(IsNullOrEmpty(r.ReceiptBlobNoHeader)) {
        // Create list for recipt print on A920Pro
        List<OutputText> items = new List<OutputText>();

        // Add normal sale receipt
        AddSaleReceiptHeaderAndItems(items);

        // Add terminal receipt
        items.Add(new OutputText() {
            Content = "Card payment:"
        });
        items.Add(new OutputText()
        {
            Content = r.ReceiptBlobNoHeader,
            StartRow = 40,
        });

        AddFooter(items);

    _ = await PAX.RequestToPrint(items);
    }
}
```
