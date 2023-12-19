---
title: Java
permalink: /:path/java/
description: |
    Use the Java SDK to quickly and easy integrate with the terminal from your ECR.
menu_order: 1000
---

## Installation

The SDK jar file is hosted on maven central. Look up the latest version.

Add the following dependency to you application:

```xml
<dependency>
    <groupId>com.swedbankpay.pax</groupId>
    <artifactId>swedbankpay-pax-sdk</artifactId>
    <version>1.2.38</version>
</dependency>
```

## How to use

You need to implement the callback interface `SwpTrmCallbackInterface` to receive
asynchronous callbacks from the terminal. This class then need to be provided
when creating an instance of `SwpTrmInterface`.

Once an instance is created call *start*. Supplied `SaleApplInfo` when calling
Start method decides whether to implement a server or just run as a client.

```java
public class PaxController implements SwpTrmCallbackInterface  {

  private SwpTrmInterface paxTerminal;

  public void initialize() {
    int port = 11000;
    SwpTrmCallbackInterface callbackInterface = this;
    Config config = new Config.ConfigBuilder("http://" + ipTextField.getText(), port).build();
    List<SaleCapabilitiesEnumeration> saleCapabilities = Arrays.asList(SaleCapabilitiesEnumeration.PRINTER_RECEIPT, ...);

    SwpTrmInterface paxTerminal = paxTerminal = PAXTrmImpl.create(config, callbackInterface);
    paxTerminal = paxTerminal.start(new SaleApplInfo("Demo", "Test SwpIf", "1.0", "poi-id", saleCapabilities, TerminalEnvironmentEnumeration.ATTENDED));
  }

  @Override
  void terminalDisplayEvent(int txtId, String text) {}

  @Override
  void terminalNotificationEvent(EventToNotifyEnumeration type, String eventDetails) {}

  @Override
  void terminalAddressObtainedEvent(String ipv4, int port) {}

  @Override
  boolean onPrintRequest(boolean transactionEnded, Receipt receipt) {}

  @Override
  void requestForConfirmationEvent(String message, ConfirmationResult cashierConfirmation) {}
}
```

There are two ways to call each method, *synchronous* and *asynchronous*. In the
synchronous method call the program stops and waits until the response arrives.
In the asynchronous method call the program continues to perform other tasks and
when the response arrives the program handles it. The asynchronous call is
especially useful for the PaymentRequest where the response arrives after the
payment process is done.

### Open

Call *openAsync* to send a login and wait for answer.

```java
public void onOpenButtonClick() {
  //Asynchronous example
  CompletableFuture<OpenResult> openResult=paxTerminal.openAsync();
  //Register method to call when the response arrives
  openResult.thenAccept(this::onOpenResult);
}

//When the response arrives display it
private void onOpenResult(OpenResult result) {
  if (result.isSuccess()) {
    logOutput(String.format("Login successful. (Software version: %s, Environment: %s, Serial number: %s)",
    result.getSoftwareVersion(), result.getEnvironment(), result.getSerialNumber()));
  } else {
    logOutput(String.format("Login failed with error: %s. (%s)", result.getErrorCondition(), result.getResponseText()));
  }
}
```

### Payment & refund

Call *paymentAsync* or *refundAsync* to start a transaction and wait for response.

```java
public void onPayButtonClick() {
  try {
    CompletableFuture<PaymentRequestResult> payment =
    paxTerminal.paymentAsync(new BigDecimal(amountTextField.getText()), BigDecimal.ZERO, "SEK");
    payment.thenAccept(this::showPaymentResultMessage);
  } catch (NumberFormatException e) {
    logOutput("Invalid amount!");
  }
}

private void showPaymentResultMessage(PaymentRequestResult paymentResult) {
  if (paymentResult.isSuccess()) {
    logOutput("Payment ok.");
    printReceipt(paymentResult.getReceipt());
  } else {
    logOutput("Payment failed: " + paymentResult.getErrorCondition() + ", (" + paymentResult.getResponseText() + ")");
  }
}

public void onRefundButtonClick() {
  logOutput("Starting refund...");

  try {
    CompletableFuture<PaymentRequestResult> payment =
    paxTerminal.refundAsync(new BigDecimal(amountTextField.getText()), "SEK", referenceTextField.getText());
    payment.thenAccept(this::showRefundResultMessage);
  } catch (NumberFormatException e) {
    logOutput("Invalid amount!");
  }
}

private void showRefundResultMessage(PaymentRequestResult refundResult) {
  if (refundResult.isSuccess()) {
    logOutput("Refund ok");
    printReceipt(refundResult.getReceipt());
  } else {
    logOutput("Refund failed: " + refundResult.getErrorCondition() + ", (" + refundResult.getResponseText() + ")");
  }
}
```

### Get payment instrument

Call *getPaymentInstrumentAsync* to start a transaction when a card needs to be
read before amount is known. Call either *paymentAsync* or *refundAsync* to
proceed the actual payment.

```java
protected void onPaymentInstrumentButtonClick() {
  CompletableFuture<PaymentInstrumentResult> result = paxTerminal.getPaymentInstrumentAsync();
  result.thenAccept(this::showPaymentInstrumentResultMessage);
}

private void showPaymentInstrumentResultMessage(PaymentInstrumentResult result) {
  if (result.isSuccess()) {
    logOutput(String.format("Payment instrument response successful: Type=%s, Brand=%s, CNA=%s, PAN=%s"
    ,result.getCardType(), result.getBrand(), result.getCNA(), result.getPAN()));
  } else {
    logOutput("Payment instrument did not succeed: " + result.getErrorCondition() +
    ". (" + result.getResponseText() + ")");
  }
}
```

### Close

Call *close* to send logout.

```java
protected void onCloseButtonClick() {
  logOutput("Closing terminal...");
  CompletableFuture<NexoRequestResult> result = paxTerminal.closeAsync();
  result.thenAccept(r -> {
    if (r.isSuccess()) {
      logOutput("Logout successful");
    } else {
      logOutput("Logout failed with the following error: " + r.getErrorCondition());
    }
  });
}
```

### Abort

Call *abort* to abort a payment transaction.

```java
public void onAbortButtonClick() {
  logOutput("Aborting payment...");

  CompletableFuture<AbortRequestResult> payment = paxTerminal.abortAsync();
  payment.thenAccept(this::showAbortResultMessage);
}

private void showAbortResultMessage(AbortRequestResult result) {
  if (result.isSuccess()) {
    logOutput("Abort ok");
  } else {
    logOutput("Abort was not ok. Try to reverse payment.");
  }
}
```

## Callbacks

To receive event callbacks from the terminal the following methods need to be implemented
in the interface `SwpTrmCallbackInterface`.

### Terminal Display Event

Get status information and displays from the terminal.

```java
@Override
public void terminalDisplayEvent(int txtId, String text) {
  LOG.info("Terminal event: id {}, text: {}", txtId, text);
}
```

### Terminal Notification Event

The event function is used by Swedbank Pay Payment Application to communicate
an ‘out of sequence’ event - the beginning of maintenance for example.

```java
@Override
public void terminalNotificationEvent(EventToNotifyEnumeration type, String eventDetails) {
    LOG.info("Terminal notification event: type {}, event details {}", type, eventDetails);
}
```

### Terminal Address Obtained Event

Called when a new terminal is installed.

```java
@Override
public void terminalAddressObtainedEvent(String ipv4, int port) {
  LOG.info("Terminal address obtained event: ipv4 {}, port {}", ipv4, port);
}
```

### Print Request

Called when a receipt is to be printed. The print result needs to be confirmed
from the ECR.

```java
@Override
public boolean onPrintRequest(boolean transactionEnded, Receipt receipt) {
    LOG.info("Print receipt: " + receipt.getCustomerFormattedReceipt());

    if (transactionEnded) {
      logOutput("Transaction ended");
    }
    return true;
}
```

### Request For Confirmation Event

Called when there is a confirmation needed by the cashier, i.e when a signature
purchase needs to be confirmed. Will soon be deprecated when signature purchase
is removed.

```java
@Override
public void requestForConfirmationEvent(String message, ConfirmationResult cashierConfirmation) {
    LOG.info("Message: " + message)
    //Confirm with true if the signature matches
    cashierConfirmation.confirm(true);
}
```

## Logging

Logging is done through Slf4j. To see what is going on set DEBUG level for the
following package `com.swedbankpay`.

When running the application standalone it can be handy to see the communication
between the ECR and the terminal. To log communication between the ECR and
terminal to some text window in the application the following can be used. This
can be enabled or disabled runtime. It is disabled by default.

```java
paxTerminal.addLoggAppender(this::appender);
paxTerminal.enableTraceLog(true);
    ...
private void appender(String text) {
  Platform.runLater(() -> outputTextArea.appendText(text));
}
```

## Error handling

When an error occurs either in the terminal or within this codebase, the
framework will handle it and always return a result object with the following
three fields populated:

```text
result = FAILURE
statusCode = 500
errorCondition = "The nature of the error"
```

There are five cases where the error can occur:

- `Communication error with the terminal` Ex connection timeout
- `Terminal error response` There was an error in the terminal resulting in a failure response.
- `Parsing terminal response` There was an error when parsing the response from the terminal.
- `Creating result object` There was an error when creating the result object.
- `User error` The user has provided faulty input.

## Receipts

Receipts are created when a payment or reversal has been completed or on the
request from the terminal. The receipt contains both the raw customer and/or
merchant data in json format. It also contains a preformatted printable string
for each of the two. The preformatted receipts are localized using the locale
provided in the terminal config. In the future hopefully we can
take the locale from the payment response if the customer chooses a different
language during the payment process.

There is also the possibility to create your own formatter by extending the class
`AbstractReceiptFormatter` and then use the `format(...)` method on the `Receipt`
object from the payment.

```java
PaymentRequestResult payment = paxTerminal.paymentAsync(...).join();
Receipt receipt = payment.getReceipt().format(new MyCustomReceiptFormatter());
String customerReceipt = receipt.getCustomerFormattedReceipt();
```

You also have access to the receipt data object to extract the information you need.

```java
JSONObject json = receitp.getCustomerReceiptData();
```
