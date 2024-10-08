---
title: Test Data
permalink: /:path/test-data/
redirect_from: /checkout-v3/resources/test-data/
description: |
  Testing, are we? Good! Here's some data you can
  use to test and verify your integration!
menu_order: 6
---

## Swedbank Pay Checkout Test Data

When implementing Digital Payments, you can use the test data related to the
different payment methods listed below. To see Digital Payments in live action,
please visit the [Playground][playground]{:target="_blank"}.

To test a checked-in user in the Playground, please use the following test data:

### Checkout test data for Norway

{:.table .table-striped}
| Type            | Data                         | Description                                                           |
| :-------------- | :--------------------------- | :-------------------------------------------------------------------- |
| `Email`         | `olivia.nyhuus@payex.com`    | The e-mail address of the payer.                                      |
| `Mobile number` | `+47 98765432`               | The mobile phone number of the payer. Format Norway: `+47 99999999`.  |
| `SSN`           | `{{ page.consumer_ssn_no }}` | The social security number of the payer. Format Norway: `DDMMYYXXXXX` |
| `ZipCode`       | `1642`                       | The city zip code. Format Norway: `XXXX`                              |

### Checkout test data for Sweden

{:.table .table-striped}
| Type            | Data                         | Description                                                             |
| :-------------- | :--------------------------- | :---------------------------------------------------------------------- |
| `Email`         | `leia.ahlstrom@payex.com`    | The e-mail address of the payer.                                        |
| `Mobile number` | `+46 739000001`              | The mobile phone number of the payer. Format Sweden: `+46 707777777`.   |
| `SSN`           | `{{ page.consumer_ssn_se }}` | The social security number of the payer. Format Sweden: `YYYYMMDDXXXX`. |
| `ZipCode`       | `17674`                      | The city zip code. Format Sweden: `XXXXX`                               |

### Checkout test data for Denmark

{:.table .table-striped}
| Type            | Data          | Description                                                          |
| :-------------- | :------------ | :------------------------------------------------------------------- |
| `Mobile number` | `+4522222222` | The mobile phone number of the payer. Format Denmark: `+45 22222222` |

## Credit Card Test Data

With regards to card payments, our external integration test environment is
connected to our POS system instead of a fake service. It is set up with an
internal acquirer. This gives us a production-like test environment, while also
giving us sandbox testing opportunities, such as 3-D Secure card enrollment and
error scenarios. No payment information will be sent to other acquiring
institutions.

### 3-D Secure Cards

{:.table .table-striped}
| Card type  | Card number        | Expiry                   | CVC   | Type of test data   |
| :--------- | :----------------- | :----------------------- | :-----| :------------------ |
| Visa       | `4761739001010416` | After the current month  | Any   | 3-D Secure enrolled |
| MasterCard | `5226612199533406` | After the current month  | Any   | 3-D Secure enrolled |

### 3-D Secure 2

For merchants using 3DS2, OTP (One-Time Password) is the ACS (Access Control
Server) you will encounter. Use the Visa or MasterCard listed under 3-D Secure
Cards above when doing a card payment. Click approved or cancel to select
authentication status.

![otp-challenge-form][otp-challenge-form]

### Network Tokenization

When testing Network Tokenization you can use one of the cards listed below,
depending on if you want to use MasterCard or Visa, and if you want a
frictionless flow or a challenge flow. These cards are test `FPAN`s (Funding
PAN, an actual card number). Make sure that your merchant contract is configured
towards our internal acquirer (loopback), since they won't work as intended if
you are configured towards other acquirers.

Each `FPAN` is connected to a `DPAN` (Network Token). The `DPAN` will **not**
appear in the initial transaction response. It will only be displayed when you
run the next transaction with the stored token.

Once your card has been enrolled, you will enter into a rotation where the
`DPAN` is updated with a new `FPAN` every 24h. This way you can notice the
changes easily. The rotation consists of 10 cards and will run indefinitely, but
the initial `FPAN` won't appear again, as it is not a part of the `DPAN`s set of
cards. The four `FPAN`s can be used again every day to store a card and initiate
a fresh rotation.

Note that in the response, the 6 first digits of the `PAN` will be shown in the
`BIN` field. The `maskedPan` will only contain the last 4 digits.

Error testing can be performed using the four bottom cards. They will all be
rejected during tokenization.

If you want to test Network Tokenization without card updates, simply use one of
our other MasterCard or Visa test cards. You still need to be configured against
our internal acquirer (loopback).

{:.table .table-striped}
| Card type  | Card number        | Expiry | CVC   | Type of test data   |
| :--------- | :----------------- | :----  | :---- | :------------------ |
| MasterCard | `5510000000001232` | 04/35  | Any   | Frictionless        |
| MasterCard | `5510000000002347` | 06/35  | Any   | Challenge           |
| Visa       | `4111112000003211` | 09/35  | Any   | Frictionless        |
| Visa       | `4111112000006545` | 11/35  | Any   | Challenge           |

{:.table .table-striped}
| Card type  | Card number        | Expiry | CVC   | Type of test data   |
| :--------- | :----------------- | :----  | :---- | :------------------ |
| MasterCard | `5510000000009631` | 08/35  | Any   | Rejected during tokenization |
| MasterCard | `5510000000005431` | 02/35  | Any   | Rejected during tokenization |
| Visa       | `4111112000004565` | 07/35  | Any   | Rejected during tokenization |
| Visa       | `4111112000007899` | 12/35  | Any   | Rejected during tokenization |

### Misc Cards

A selection of cards not connected to Network Tokenization or 3D-Secure.

### Visa

{:.table .table-striped}
| Card number        | Expiry                  | CVC  |
| :----------------- | :---------------------- | :--- |
| `4925000000000004` | After the current month | Any  |
| `4581097032723517` | After the current month | Any  |
| `4581099940323133` | After the current month | Any  |

### MasterCard

{:.table .table-striped}
| Card number        | Expiry                  | CVC  |
| :----------------- | :---------------------- | :--- |
| `5226600159865967` | After the current month | Any  |
| `5226603115488031` | After the current month | Any  |
| `5226604266737382` | After the current month | Any  |
| `5226600156995650` | After the current month | Any  |

### American Express

{:.table .table-striped}
| Card number       | Expiry                  | CVC            | Type of test data |
| :---------------- | :---------------------- | :------------  | :---------------- |
| `377601000000000` | After the current month | Any (4 digits) | Amex & loopback   |

### Maestro

{:.table .table-striped}
| Card number        | Expiry                   | CVC   |
| :----------------- | :----------------------- | :---- |
| `6764429999947470` | After the current month  | Any   |

### Dankort

{:.table .table-striped}
| Card number        | Expiry                   | CVC   |
| :----------------- | :----------------------- | :---- |
| `5019994016316467` | After the current month  | Any   |
| `5019994001307083` | After the current month  | Any   |

### Visa/DanKort

{:.table .table-striped}
| Card number        | Expiry                   | CVC   |
| :----------------- | :----------------------- | :---- |
| `4571994016401817` | After the current month  | Any   |
| `4571994016471869` | After the current month  | Any   |

### Forbrugsforeningen

{:.table .table-striped}
| Card number        | Expiry                   | CVC   |
| :----------------- | :----------------------- | :---- |
| `6007220000000004` | After the current month  | Any   |

## Failure Testing Cards

There are two different ways of testing Card Payments error scenarios. You can
test 3-D Secure errors using our 3-D Secure emulator, or you can use specific
amounts set to trigger errors in our test environment.

### Magic Amounts (Error Testing Using Amounts)

We have some preset amounts that will trigger error codes. While creating a
payment (operation `purchase`), enter one of the amounts from the list below in
the prices object (`"amount": <number>`) before submitting a payment. The error
message displayed behind the amounts will be sent with your payment in the test
environment.

The amounts that can be used to trigger error codes
(`transactionThirdPartyError`):

{:.table .table-striped}
| Amount   | Error Code                                | Description                                     |
| :------- | :---------------------------------------- | :---------------------------------------------- |
| `900313` | `REJECTED_BY_ACQUIRER_INVALID_AMOUNT`     | Invalid amount, response-code: 13               |
| `900330` | `REJECTED_BY_ACQUIRER_FORMAT_ERROR`       | Format error, response-code: 30                 |
| `900334` | `REJECTED_BY_ACQUIRER_POSSIBLE_FRAUD`     | Possible fraud, response-code: 34               |
| `900343` | `REJECTED_BY_ACQUIRER_CARD_STOLEN`        | Card stolen, response-code: 43                  |
| `900354` | `REJECTED_BY_ACQUIRER_CARD_EXPIRED`       | Card expired, response-code: 54                 |
| `900351` | `REJECTED_BY_ACQUIRER`                    | Unknown error, response-code: 51                |
| `900359` | `REJECTED_BY_ACQUIRER_POSSIBLE_FRAUD`     | Possible fraud, response-code: 59               |
| `900361` | `REJECTED_BY_ACQUIRER_INSUFFICIENT_FUNDS` | Insufficient funds, response-code: 61           |
| `900362` | `REJECTED_BY_ACQUIRER`                    | Unknown error, response-code: 62                |
| `900391` | `ACQUIRER_HOST_OFFLINE`                   | Acquirer host offline, response-code: 91        |
| `952400` | `DONOTRETRY`                              | Transaction declined, do not retry              |
| `952507` | `MODIFICATIONSREQUIRED`                   | Transaction is declined and needs modifications |
| `952100` | `DAILYLIMITEXCEEDED`                      | The daily attempt limit has been exceeded       |
| `952100` | `MONTHLYLIMITEXCEEDED`                    | The monthly attempt limit has been exceeded     |

The `DAILYLIMITEXCEEDED` must be performed 10 times to be triggered, and the
`MONTHLYLIMITEXCEEDED` has to be performed 15 times to be triggered. The
`SuspensionWarning` response message appears when the two limit exceeds have
5 attempts left (i.e. after 5 daily or 10 monthly attempts).

## Invoice Test Data

### Invoice test data for Norway

{:.table .table-striped}
| Type    | Data             |
| :------ | :--------------- |
| SSN     | 26026708248      |
| Name    | Olivia Nyhuus    |
| Address | Saltnestoppen 43 |
| City    | 1642 Saltnes     |

### Invoice test data for Sweden

{:.table .table-striped}
| Type    | Data            | Alternative data        |
| :------ | :-------------- | :---------------------- |
| SSN     | 600307-1161     | 971020-2392             |
| Name    | Azra Oliveira   | Leia Ahlström           |
| Address | Helgestavägen 9 | Hökvägen 5              |
| City    | 19792 Bro       | 17674 Järfälla          |
| MSISDN  |                 | +46739000001            |
| email   |                 | leia.ahlstrom@payex.com |

## Invoice Service Test Data

Use any name, address etc.

## Swish Test Data

Testing a successful Swish purchase (in our external integration test
environment) can be done by using any valid Swedish mobile number. E.g:
`+46 739000001`. As with Vipps, the external integration test environment uses a
fake service with no app involved. To trigger an error message, set the
`description` value in `POST` Create Payment or `Create` Payment Order to one of
the following values:

{:.table .table-striped}
| Description | Simulates                                      |
| :---------- | :--------------------------------------------- |
| RF07        | Transaction declined                           |
| TM01        | Swish timed out before the payment was started |
| BANKIDCL    | Payer cancelled BankId signing                 |

[otp-challenge-form]: /assets/img/new-otp-challenge-form.png
[playground]: https://playground.swedbankpay.com
