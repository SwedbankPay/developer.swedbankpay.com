## Styling

>You can customize the visual look by inserting style attributes in the JavaScript function call, inside the `<script>` element.

{:.code-header}
**JavaScript function call**

```JS
{
    payex.hostedView.paymentMenu({
        container: 'checkout',
        culture: 'nb-NO',
        onPaymentCompleted: function(paymentCompletedEvent) {
            console.log(paymentCompletedEvent);
        },
        onPaymentFailed: function(paymentFailedEvent) {
            console.log(paymentFailedEvent);
        },
        onPaymentCreated: function(paymentCreatedEvent) {
            console.log(paymentCreatedEvent);
        },
        onPaymentToS: function(paymentToSEvent) {
            console.log(paymentToSEvent);
        },
        onPaymentMenuInstrumentSelected: function(paymentMenuInstrumentSelectedEvent) {
            console.log(paymentMenuInstrumentSelectedEvent);
        },
        onError: function(error) {
            console.error(error);
        },
        style: {   
            body: {
                backgroundColor: "somecolor|#rrggbb",
                border: "1px solid black",
                borderRadius: "5px",
                boxShadow: "10px 5px 5px red;",
                font: "italic small-caps bold normal 14px/1.5em Verdana, Arial, Helvetica, sans-serif",
                color: "hotpink",
                margin: "2px 3px 2px 3px",
                padding: "3px 2px 3px 2px"
            }
        }     
    }).open();
}        
```
