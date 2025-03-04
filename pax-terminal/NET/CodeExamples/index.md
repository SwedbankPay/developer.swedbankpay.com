---
title: C# Code Examples
description: |
    Simple code examples without the aim of being state of the art. The code works, so feel free to copy and test.
permalink: /:path/
menu_order: 90
---

## As Client Only

The following is an example of the simplest form of making a program that actually makes a payment. It is a windows form with one button making a payment for 10 SEK and printing the receipt to a TextBox.
The only methods used are [Create][create-method], [Start][start-method], [OpenAsync][openasync] and [PaymentAsync][paymentasync].

{% include alert.html type="warning" icon="warning" header="Warning"
body= "The IP address to terminal needs to be changed"
%}
{% include alert.html type="informative" icon="info" header="Heads up"
body= "The first attempt will fail, since OpenAsync is successful but the terminal starts communicating with its host. Click the button again to start the payment."
%}

{:.code-view-header}
Simplest form of implementation, Client Only - Happy Flow

```c#
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using SwpTrmLib;
using SwpTrmLib.NexoTypes;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form, ISwpTrmCallbackInterface
    {
        ISwPTrmIf_1 PAX;

        public Form1()
        {
            InitializeComponent();

        }
        private async void button1_Click(object sender, EventArgs e)
        {
            if (PAX == null)
            {
                LoginToTerminal();
            }
            var result = await PAX.PaymentAsync(10);
            if (result.ResponseResult == NexoResponseResult.Success)
            {
                textBox1.AppendText("APPROVED TRANSACTION" + Environment.NewLine);
            }
            else
            {
                textBox1.AppendText("REJECTED TRANSACTION" + Environment.NewLine);
                textBox1.AppendText(result.ResponseText + Environment.NewLine);
            }
            // The result contains the receipt information
            textBox1.AppendText(result.ReceiptBlob + Environment.NewLine);
        }

        private void CreatePAXInstance()
        {
            PAX = PAXTrmImp_1.Create(new SwpIfConfig(), this);

            PAX.Start(new SaleApplInfo()
            {
                ApplicationName = "Quick Demo-Client Only",
                ProviderIdentification = "SwP",
                SoftwareVersion = "0.1",
                POIID = "A-TEST-POIID",
                SaleCapabilities = SaleCapabilitiesEnum.PrinterReceipt.ToString() // Client only mode!
            });
        }
        private async void LoginToTerminal()
        {
            if (PAX == null)
            {
                CreatePAXInstance();
            }

            PAX.TerminalAddress = "192.168.1.34:11000";

            var res = await PAX.OpenAsync();
            if (res.Result == ResponseResult.Success)
            {
                textBox1.AppendText("Terminal connected " + Environment.NewLine);
                textBox1.AppendText("Terminal: " + res.SerialNumber + Environment.NewLine);
                textBox1.AppendText("Terminal version: " + res.SoftwareVersion + Environment.NewLine);
            }
            else
            {
                textBox1.AppendText("Failed to connect terminal " + Environment.NewLine);
                textBox1.AppendText(res.Text + Environment.NewLine);
            }
        }
        // Occurs when customer need to sign the receipt
        public void ConfirmationHandler(string text, IConfirmationResult callback)
        {
            // Cashier needs to confirm the acceptance of signature and ID
            DialogResult result = MessageBox.Show(text, "", MessageBoxButtons.YesNo, MessageBoxIcon.Question);

            if (result == DialogResult.Yes) 
                callback.Confirmation(true); 
            else callback.Confirmation(false);
        }
        public void EventCallback(EventCallbackObject eventObject)
        {
            switch (eventObject.type)
            {
                case EventCallbackTypes.PrintRequestEventCallback:
                    PrintRequestEventCallback po = (eventObject as PrintRequestEventCallback);
                    { /*
                    Code for printing the Cashier Receipt that needs to be signed
                    by the card holder
                    */}
                    break;
            }
        }
        public void EventNotificationHandler(EventToNotifyEnumeration type, string text)
        {
            /* Won't happen in Client Only mode */
            throw new NotImplementedException();
        }
        public void SyncRequestResult(object result)
        {
            /* Won't if using the awaitable functions */
            throw new NotImplementedException();
        }


        private async void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            await PAX.CloseAsync();
            PAX.Stop();
        }
    }
}
```

## As Client and Server

Based on [*Simplest Client only*][simplest-client] the following runs as a server too. The difference is:

*   Removed SalesCapabilites in call to Start
*   Subscribed to the `OnTerminalDisplay` event
*   Added code to the callback `EventNotificationHandler`

{% include pax-netshaddurlacl.md %}

{:.code-view-header}
Simplest Client And Server form of implementation - Happy Flow

```c#
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using SwpTrmLib;
using SwpTrmLib.NexoTypes;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form, ISwpTrmCallbackInterface
    {
        ISwPTrmIf_1 PAX;

        public Form1()
        {
            InitializeComponent();

        }
        private async void button1_Click(object sender, EventArgs e)
        {
            if (PAX == null)
            {
                LoginToTerminal();
            }
            var res = await PAX.PaymentAsync(10);
            if (res.ResponseResult == NexoResponseResult.Success)
            {
                textBox1.AppendText("APPROVED TRANSACTION" + Environment.NewLine);
            }
            else
            {
                textBox1.AppendText("REJECTED TRANSACTION" + Environment.NewLine);
                textBox1.AppendText(res.ResponseText + Environment.NewLine);
            }
            // The result contains the receipt information
            textBox1.AppendText(res.ReceiptBlob + Environment.NewLine);
        }

        private void CreatePAXInstance()
        {
            PAX = PAXTrmImp_1.Create(new SwpIfConfig(), this);

            PAX.Start(new SaleApplInfo()
            {
                ApplicationName = "Quick Demo",
                ProviderIdentification = "SwP",
                SoftwareVersion = "0.1",
                POIID = "A-TEST-POIID",
                //SaleCapabilities = SaleCapabilitiesEnum.PrinterReceipt.ToString()
            });
        }
        // A DisplayRequest from the terminal
        private void PAX_OnTerminalDisplay(string message)
        {
            textBox1.AppendText(message + Environment.NewLine);
        }

        private async void LoginToTerminal()
        {
            if (PAX == null)
            {
                CreatePAXInstance();
            }

            PAX.TerminalAddress = "192.168.1.34:11000";

            var res = await PAX.OpenAsync();
            if (res.Result == ResponseResult.Success)
            {
                textBox1.AppendText("Terminal connected " + Environment.NewLine);
                textBox1.AppendText("Terminal: " + res.SerialNumber + Environment.NewLine);
                textBox1.AppendText("Terminal version: " + res.SoftwareVersion + Environment.NewLine);
            }
            else
            {
                textBox1.AppendText("Failed to connect terminal " + Environment.NewLine);
                textBox1.AppendText(res.Text + Environment.NewLine);
            }
        }
        public void ConfirmationHandler(string text, IConfirmationResult callback)
        {
            DialogResult result = MessageBox.Show(text, "", MessageBoxButtons.YesNo, MessageBoxIcon.Question);

            if (result == DialogResult.Yes)
                callback.Confirmation(true);
            else callback.Confirmation(false);
        }
        public void EventCallback(EventCallbackObject eventObject)
        {
            switch (eventObject.type)
            {
                case EventCallbackTypes.PrintRequestEventCallback:
                    PrintRequestEventCallback po = (eventObject as PrintRequestEventCallback);
                    { /*
                    Code for printing the Cashier Receipt that needs to be signed
                    by the card holder
                    */}
                    break;
                case EventCallbackTypes.DisplayEventCallback:
                    textBox1.AppendText((eventObject as DisplayEventCallback).Text + Environment.NewLine);
                    break;

            }
        }
        public void EventNotificationHandler(EventToNotifyEnumeration type, string text)
        {
            textBox1.AppendText($"Event: {type} - {text}" + Environment.NewLine);
        }
        public void SyncRequestResult(object result)
        {
            /* won't happen when using the awaiatable functions */
            throw new NotImplementedException();
        }
        private async void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (PAX != null)
            {
                PAX.Stop();
                await PAX.CloseAsync();
            }
        }
    }
}
```

### Changes From Client Only

{:.code-view-header}
**Use default values in SaleCapabilities**

```c#
    PAX.Start(new SaleApplInfo()
    {
        ApplicationName = "Quick Demo",
        ProviderIdentification = "SwP",
        SoftwareVersion = "0.1",
        POIID = "A-POIID",
        //SaleCapabilities = SaleCapabilitiesEnum.PrinterReceipt.ToString()
    });
```

{:.code-view-header}
**Show the display messages from the terminal (optional)**

```c#
            case EventCallbackTypes.DisplayEventCallback:
                textBox1.AppendText((eventObject as DisplayEventCallback).Text + Environment.NewLine);
                break;
```

{:.code-view-header}
**Implement some code for Event messages from the terminal (optional)**

```c#
public void EventNotificationHandler(EventToNotifyEnumeration type, string text)
{
    textBox1.AppendText($"Event: {type} - {text}" + Environment.NewLine);
}
```

## Using Synchronous Calls

When using the synchronous calls the code is pretty much the same except that the results are receivied in the `SyncRequestResult` callback instead.

{:.code-view-header}
**Code when using asynchronous calls**

```c#
    private async Task LoginToTerminal()
    {
        var res = await PAX.OpenAsync();
        if (res.Result == ResponseResult.Success)
            { /* Ready to use */}
        else { /* unable to login to terminal */}
    }
    private async Task MakePayment()
    {
        var res = await PAX.PaymentAsync(amount);
        if (res.ResponseResult == NexoResponseResult.Success)
            {  /* Handle successful payment */ }
        else { /* Handle refused payment */ }
    }

```

{:.code-view-header}
**Same result but using synchronous calls**

```c#
    private void LoginToTerminal()
    {
        PAX.Open();
    }
    private void MakePayment()
    {
        PAX.Payment(amount);
    }
    public void SyncRequestResult(object result)
    {
        switch (Enum.Parse(typeof(RequestResultTypes), result.GetType().Name))
        {
            case RequestResultTypes.OpenResult: 
                OpenResult or = result as OpenResult;
                if (or.Result == ResponseResult.Success)
                    {/* Ready to use*/ }
                else { /* unable to login to terminal */}
            break;
            case RequestResultTypes.PaymentRequestResult: 
                PaymentRequestResult pr = result as PaymentRequestResult;
                if (pr.ResponseResult == NexpResponseResult.Success)
                    {  /* Handle successful payment */ }
                else { /* Handle refused payment */ }
                break;
        }
    }

```

## Get CNA For Customer

Based on either [Client Only][simplest-client] or [Client And Server][clientnserver], let's take it a bit further and find out who the customer is before starting the actual purchase transaction. The only change is in the button1_click where `GetPaymentInstrumentAsync` is called. The result contains among others `masked PAN` and `CNA - CardNumberAlias`.

This is a very simple way to handle members. The CNA will be the same in all our PAX terminals.

{:.code-view-header}
Get to know the customer before deciding amount - Happy Flow

```c#
    private async void button1_Click(object sender, EventArgs e)
    {
        if (PAX == null)
        {
            LoginToTerminal();
        }
        var cardres = await PAX.GetPaymentInstrumentAsync();
        if (cardres.Result == NexoResponseResult.Success)
        {
            textBox1.AppendText($"CNA: {cardres.CNA}" + Environment.NewLine);
            textBox1.AppendText($"for card: {cardres.PAN}" + Environment.NewLine);

            var res = await PAX.PaymentAsync(10);
            if (res.ResponseResult == NexoResponseResult.Success)
            {
                textBox1.AppendText("APPROVED TRANSACTION" + Environment.NewLine);
            }
            else
            {
                textBox1.AppendText("REJECTED TRANSACTION" + Environment.NewLine);
                textBox1.AppendText(res.ResponseText + Environment.NewLine);
            }
            // The result contains the receipt information
            textBox1.AppendText(res.ReceiptBlob + Environment.NewLine);
        }
    }
```

## Handle Loyalty - Ask For Membership

Based on the version [Get CNA For Customer][getcna], let's see if CNA exists in the database and if so, give the customer a better price. If the costumer is not a member, ask them to join so they can get a better price next time.

The only change is to create a list of members and add CNA to that list if the customer wants to join.
Other that creating the *Members* which is a list of strings, there are only changes in the button1_click.
The important addition is the call to `RequestCustomerConfirmationAsync`. It requests the terminal to show a message and asks for a yes/no response. The member `CustomerConfirmation` of the result is true or false.

{% include alert.html type="warning" icon="warning" header="Note!"
body= "The delay before a new request after a finished transaction is needed. If the delay is not added, the request will get a failure due to terminal being busy"
%}
{% include alert.html type="informative" icon="info" header="Remember"
body= "to add List<*string*> Member; "
%}

```c#
private async void button1_Click(object sender, EventArgs e)
{
    decimal priceofproduct = 10;
    bool asktojoin = false;

    if (PAX == null)
    {
        LoginToTerminal();
        if (Members == null) {
            Members = new List<string>();
        }
    }
    var cardres = await PAX.GetPaymentInstrumentAsync();
    if (cardres.Result == NexoResponseResult.Success)
    {
        textBox1.AppendText($"CNA: {cardres.CNA}" + Environment.NewLine);
        textBox1.AppendText($"for card: {cardres.PAN}" + Environment.NewLine);

        if (Members.Contains(cardres.CNA))
        {
            priceofproduct = 8;
        }
        else
        {
            asktojoin = true;
        }

        var res = await PAX.PaymentAsync(priceofproduct);
        if (res.ResponseResult == NexoResponseResult.Success)
        {
            textBox1.AppendText("APPROVED TRANSACTION" + Environment.NewLine);
        }
        else
        {
            textBox1.AppendText("REJECTED TRANSACTION" + Environment.NewLine);
            textBox1.AppendText(res.ResponseText + Environment.NewLine);
        }
        // The result contains the receipt information
        textBox1.AppendText(res.ReceiptBlob + Environment.NewLine);

        if (asktojoin)
        {
            await Task.Delay(3000);
            var confirmres = await PAX.RequestCustomerConfirmationAsync("Would you like to join?");
            if (confirmres.ResponseResult == NexoResponseResult.Success && confirmres.Confirmation == true)
            {
                Members.Add(cardres.CNA);
            }
        }
    }
}
```

[simplest-client]: #as-client-only
[clientnserver]: #as-client-and-server
[getcna]: #get-cna-for-customer
[create-method]: /pax-terminal/NET/SwpTrmLib/Methods/essential/create
[start-method]: /pax-terminal/NET/SwpTrmLib/Methods/essential/start
[openasync]: /pax-terminal/NET/SwpTrmLib/Methods/essential/openasync
[paymentasync]: /pax-terminal/NET/SwpTrmLib/Methods/essential/paymentasync
