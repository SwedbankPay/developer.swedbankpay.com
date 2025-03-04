---
title: Request Customer Confirmation
permalink: /:path/requestcustomerconfirmation/
description: |
    Use this method to ask the customer a yes/no question.
---
### Method Signatures

*   void  RequestCustomerConfirmation(string message)

*   Task\<CustomerConfirmationResult\> RequestCustomerConfirmationAsync(string message)

### Description

Call RequestCustomerConfirmation / RequestCustomerConfirmationAsync to ask customer a yes/no question. The message will be shown on the terminal's display together with a green and read button for yes and no. The method may only be called before or after a PaymentRequest has been sent to the terminal, which means it may be sent after a GetPaymentInstrument, but not during the actual payment which in general starts when the amount is known.

### Returns

A **CustomerConfirmationResult**

```c#
public class CustomerConfirmationResult : NexoRequestResult
    {
        public bool Confirmation { get; set; }
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

[Example when used][handle-loyalty-ask-for-membership]

[handle-loyalty-ask-for-membership]: /pax-terminal/NET/CodeExamples/#handle-loyalty---ask-for-membership
