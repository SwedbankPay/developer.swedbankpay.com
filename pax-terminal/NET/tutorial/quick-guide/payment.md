---
title: Payment
description: |
 Once there is a login session it is possible to make payment or refund.
permalink: /:path/payment/
hide_from_sidebar: true
menu_order: 30
---

### Payment

During a login session you may make several payments. There are synchronous and asynchronous versions for starting a [payment][payment] but there are two function signatures for both versions. A normal payment may be started just supplying one parameter, amount. To that call it is actually three parameters, amount, cashback and currency, but they are default. The cashback is included in the amount and is zero if not. The default currency is the currency of the culture provided in the call to the [`Create`][create] method.

It is also possible to start a payment supplying a [`TransactionSetup`][transactionsetup] object which opens up for other variants, such as fuel, refund of APM transaction, or just supplying a transaction id the may be tracked in reports.

Regardless how the payment is done the result is always deliverd as a [`PaymentRequestResult`][paymentrequestresult].

{%include alert.html type="warning" icon="warning" header="Heads up!"
body="Make sure to always print the terminal receipt when it is included in the result."%}

{:.code-view-header}
**Using PaymentAsync and just the amount.**

```c#
    class PaxImplementation : ISwpTrmCallbackInterface
    {
        public ISwpTrmIf_1 PAX = {get; internal set; } = null;
        .
        .
        .
        // PAX is an instance of PAXTrmImp_1
        private async Task SomewhereInYourCode(decimal total)
        {
            PaymentRequestResult result = await PAX.PaymentAsync(total);

            if (result.ResponseResult == NexoRequestResult.Success) 
            {
                // Payment was successful 
            }
            else 
            {
                switch ((ErrorConditionEnumeration)Enum.Parse(typeof(ErrorConditionEnumeration), result.ErrorCondition)) 
                {
                    case ErrorConditionEnumeration.Refusal:
                        // Transaction was refused.
                        break;
                    case ErrorConditionEnumeration.NotAllowed:
                        // Login is required. Call open.
                        break;
                    case ErrorCondition.Busy:
                        // A new payment was made too tight with a previous. Wait awhile 
                        // and try again. Reapeatedly up to totally three seconds.
                        break;
                }
            }
            if (result.ReceiptBlob != string.NullOrEmpty) {
                SaveAndPrintCardReceipt(reslut.ReceiptBlob);
            }
        }
```

{%include alert.html type="warning" icon="warning" header="Heads up!" body="Make sure to check ErrorCondition if `NexoRequestResult.Failure`.
NotAllowed means most likely that a login is required and Busy that you need to retry. After a payment response the terminal is busy for approximately three seconds."%}

### Synchronous version of Payment

When using the synchronous the result is received in the callback `SyncRequestResult`. Since all synchronous calls returns the result in the same callback, the type of result has to be decided by checking the object type name.

{:.code-view-header}
**Using synchronous Payment and just the amount.**

```c#
    class PaxImplementation : ISwpTrmCallbackInterface
    {
        public ISwpTrmIf_1 PAX = {get; internal set; } = null;
        .
        .
        .
        private void SomewhereInYourCode(decimal total)
        {
            PAX.Payment(total); // result arrives in SyncRequestResult callback
        }
        .
        .
        .
        public void SyncRequestResult(object result)
        {
            switch (Enum.Parse(typeof(RequestResultTypes), result.GetType().Name))
            {
                case RequestResultTypes.PaymentRequestResult: 
                    PaymentRequestResult pr = result as PaymentRequestResult; 
                    if (pr.ResponseResult == NexoRequestResult.Success) 
                    {
                        // Payment was successful 
                    }
                    else 
                    {
                        switch ((ErrorConditionEnumeration)Enum.Parse(typeof(ErrorConditionEnumeration), pr.ErrorCondition)) 
                        {
                            case ErrorConditionEnumeration.Refusal:
                                // Transaction was refused.
                                break;
                            case ErrorConditionEnumeration.NotAllowed:
                                // Login is required. Call open.
                                break;
                            case ErrorCondition.Busy:
                                // A new payment was made too tight with a previous. Wait awhile 
                                // and try again. Reapeatedly up to totally three seconds.
                                break;
                        }
                    }
                    if (pr.ReceiptBlob != string.NullOrEmpty) 
                    {
                        SaveAndPrintCardReceipt(pr.ReceiptBlob);
                    }
                break;
            }
        }
```

{% include iterator.html prev_href="/pax-terminal/NET/tutorial/quick-guide/" prev_title="Back" %}

[payment]: /pax-terminal/NET/SwpTrmLib/Methods/essential/paymentasync
[transactionsetup]: /pax-terminal/NET/includes/transactionsetup
[paymentrequestresult]: /pax-terminal/NET/includes/paymentrequestresult
[create]: /pax-terminal/NET/SwpTrmLib/Methods/essential/create
