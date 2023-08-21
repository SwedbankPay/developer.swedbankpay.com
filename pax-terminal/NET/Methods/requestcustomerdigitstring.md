---
title: RequestCustomerDigitString
description: |
RequestCustomerDigitString / RequestCustomerDigitStringAsync
---
### Method Signatures

*   void RequestCustomerDigitString(string message)
*   Task\<CustomerDigitStringResult\> RequestCustomerDigitString(string message)

### Description

RequestCustomerDigitString / RequestCustomerDigitStringAsync may be used to ask customer to enter any digit string. Typically this may be used to start onboarding a customer to a loyalty program. 
The method may not be used during a Payment/Refund e.g. 
The message will be shown on the terminal's display together with an input area where the entered digits are displayed. The method may only be called before or after a PaymentRequest has been sent to the terminal, which means it may be sent after a GetPaymentInstrument, but not during the actual payment which in general starts when the amount is known.

#### Returns

A **CustomerDigitStringResult**

*   `NexoResponseResult` - **ResponseResult**. `Success` or `Failure`
*   `string` **ResponseContent** - Complete response message from terminal.
*   `string` **ErrorCondition** - Valid if ResponseResult is failure
*   `string` **ResponseText** - Valid if ResponseResult is failure.
*   `string` **DigitString** - Entered string of digits.
