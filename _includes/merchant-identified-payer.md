## Merchant Identified Payer

Merchant Identified Payer should be used if you want to use Swedbank Pay's 
Payment Menu in one or more channels. If you want to use the Payment Menu in 
all channels, you only need to implement the use of the parameter
`payerReference`. That should identify the payer in your system. 
Swedbank Pay will then ask the payer if they want to store their payment 
information for later use and then store this information linked to the 
`payerReference` transmitted with the `Purchase` request.

If you want to use Swedbank Pay Payment Menu in some channels like web and
build your own in other channels like in-app you should also use this 
functionality. But when making your own menu you will need to look up the 
different payment tokens (`paymentToken` or `recurrenceToken`) linked to the 
specific `payerReference`. You should always look up this information for 
each payment as the payer can have added new payment information through the a 
web interface since the last time the app was used.
