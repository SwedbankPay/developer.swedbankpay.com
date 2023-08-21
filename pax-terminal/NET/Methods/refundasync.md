---
title: Refund
description: |
    The Refund / RefundAsync should be called when the amount is known.
---
### Method Signatures

*   void Refund(decimal amount,string apmreference="", string currency="SEK")
*   async Task\<PaymentRequestResult\> RefundAsync(decimal amount,string apmreference="", string currency="SEK")

### Description

The Refund / RefundAsync should be called when the amount is known. It opens all available readers and waits for a payment instrument. If Alternative Payment Methods are activated it will open for that too.

{% include alert.html type="warning" icon="warning" header="Heads up"
body="After RefundAsync returns there has to be a delay before next request can be made. If there is no delay the next request will fail, indicating that the terminal is busy and retries have to be made."
%}

### Parameters

*amount - amount to for refund
*apmreference - A reference if the transaction was made using APM. When this reference is not null, APM is assumed.
*currency - currency code as a string representing ISO-4217 3 letter code. Has to be available in the terminal setup. The default is "SEK".

### Returns

A **PaymentRequestResult** - [Detailed description][paymentrequestresult]

A `PayementRequestResult.ResponseResult` of value `Success` means transaction approved.
If `ResponseResult` is `Failure` there is an `ErrorCondition`. If `ErrorCondition` is `Busy` wait awhile and try again.

[paymentrequestresult]: ./paymentasync
