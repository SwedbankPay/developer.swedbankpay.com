---
title: Request Customer DigitString
permalink: /:path/requestcustomerdigitstring/
description: |
    Use this method to ask the customer to enter a string of digits
icon:
    content: support_agent
    outlined: true
---
### Method Signatures

*   void RequestCustomerDigitString(string message)

*   Task\<CustomerDigitStringResult\> RequestCustomerDigitString(string message)

### Description

RequestCustomerDigitString / RequestCustomerDigitStringAsync may be used to ask customer to enter any digit string. Typically this may be used to start onboarding a customer to a loyalty program.
The message will be shown on the terminal's display together with an input area where the entered digits are displayed. The method may only be called before or after a PaymentRequest has been sent to the terminal, which means it may be sent after a GetPaymentInstrument, but not during the actual payment which in general starts when the amount is known.

#### Returns

A **CustomerDigitStringResult**

```c#
 public class CustomerDigitStringResult : NexoRequestResult
    {
        public string DigitString { get; set; }
        public override string ResponseContent { get; set; }
    }
```

```c#
public class NexoRequestResult
    {
        public string ResponseContent
        public NexoResponseResult ResponseResult { get; set; }
        public string ErrorCondition { get; set; }
        public string ResponseText { get; set; }
    };
```
