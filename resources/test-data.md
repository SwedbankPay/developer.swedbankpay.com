---
title: Test Data
sidebar:
  navigation:
  - title: Resources
    items:
    - url: /resources/
      title: Introduction
    - url: /resources/test-data
      title: Test Data
    - url: /resources/demoshop
      title: Demoshop
    - url: /resources/development-guidelines
      title: Open Source Development Guidelines
    - url: /resources/release-notes
      title: Release Notes
    - url: /resources/terminology
      title: Terminology
    - url: /resources/data-protection
      title: Data Protection
---

{% include alert-review-section.md %}

{% include jumbotron.html body="Testing, are we? Good! Here's some data you can
   use to test and verify your integration!" %}

## Swedbank Pay Checkout Test Data

During a Swedbank Pay Checkout implementation you can use the test data related
to the different payment instruments listed below. To see Swedbank Pay Checkout in
action, please visit our
[demoshop]({{ page.frontEndUrl }}/pspdemoshop)

To test a logged in user in the Demo Shop, please use the following test data:

### Norway

{:.table .table-striped}
| Type            | Data                      | Description                                                         |
| :-------------- | :------------------------ | :------------------------------------------------------------------ |
| `Email`         | `olivia.nyhuus@payex.com` | The e-mail address of the payer.                                    |
| `Mobile number` | `+47 98765432`            | The mobile phone number of the payer. Format Norway: +4799999999.   |
| `SSN`           | `26026708248`             | The social security number of the payer. Format: Norway DDMMYYXXXXX |
| `ZipCode`       | `1642`                    | The city zip code. Format: Norway XXXX                              |

### Sweden

{:.table .table-striped}
| Type            | Data                      | Description                                                        |
| :-------------- | :------------------------ | :----------------------------------------------------------------- |
| `Email`         | `leia.ahlstrom@payex.com` | The e-mail address of the payer.                                   |
| `Mobile number` | `+46 739000001`           | The mobile phone number of the payer. Format Sweden: +46707777777. |
| `SSN`           | `971020-2392`             | The social security number of the payer. Sweden: YYYYMMDDXXXX.     |
| `ZipCode`       | `17674`                   | The city zip code. Format: Sweden XXXXX                            |

### Denmark

{:.table .table-striped}
| Type            | Data          | Description                                                          |
| :-------------- | :------------ | :------------------------------------------------------------------- |
| `Mobile number` | `+4522222222` | The mobile phone number of the payer. Format Denmark: `+45 22222222` |

## Credit Card Test Data

### Visa

{:.table .table-striped}
| Card number        | Expiry                  | CVC  | Type of test data |
| :----------------- | :---------------------- | :--- | :---------------- |
| `4925000000000004` | After the current month | Any  | Loopback only     |
| `4581097032723517` | After the current month | Any  | Loopback only     |
| `4581099940323133` | After the current month | Any  | Loopback only     |
| `5226600159865967` | After the current month | Any  | Loopback only     |
| `5226603115488031` | After the current month | Any  | Loopback only     |
| `5226604266737382` | After the current month | Any  | Loopback only     |
| `5226600156995650` | After the current month | Any  | Loopback only     |

### American Express

{:.table .table-striped}
| Card number       | Expiry                  | CVC   | Type of test data |
| :---------------- | :---------------------- | :---- | :---------------- |
| `377601000000000` | After the current month | `525` | Amex & loopback   |

### JCB

{:.table .table-striped}
| Card number        | Expiry                  | CVC   |
| :----------------- | :---------------------- | :---- |
| `3569990010082211` | After the current month | `123` |

### Diners

{:.table .table-striped}
| Card number     | Expiry                  | CVC   |
| :-------------- | :---------------------- | :---- |
| `6148201829798` | After the current month | `832` |

### Maestro

{:.table .table-striped}
| Card number        | Expiry | CVC   | Type of test data |
| :----------------- | :----- | :---- | :---------------- |
| `6764429999947470` | 03/17  | `066` | Evry & loopback   |

### Dankort

{:.table .table-striped}
| Card number        | Expiry | CVC   | Type of test data |
| :----------------- | :----- | :---- | :---------------- |
| `5019994016316467` | 10/23  | `375` | NETS & loopback   |
| `5019994001307083` | 05/21  | `615` | NETS & loopback   |

### Visa/DanKort

{:.table .table-striped}
| Card number        | Expiry | CVC   | Type of test data |
| :----------------- | :----- | :---- | :---------------- |
| `4571994016401817` | 10/17  | `212` | NETS & loopback   |
| `4571994016471869` | 01/19  | `829` | NETS & loopback   |

## Failure Testing

For testing errors in transactions there are two different methods. The first
method is performed through 3-D Secure, and the second method is for testing
errors thorugh spesific amounts.

### 3-D Secure Method

First, POST a Payment (operation purchase) and enter the link to the payment
page. Example URL: -
<{{ page.frontEndUrl }}/creditcardv2/payments/authorize/{{ page.paymentToken }}> .
Fill the data for either the Visa or MasterCard as shown below.

{:.table .table-striped}
| Card type  | Card number        | Expiry | CVC   | Type of test data                           |
| :--------- | :----------------- | :----- | :---- | :------------------------------------------ |
| Visa       | `4761739001010416` | 12/22  | `268` | 3-D Secure enrolled, ECI 5, Evry & loopback |
| MasterCard | `5226612199533406` | 09/28  | `602` | 3-D Secure enrolled, ECI 6, Evry & loopback |

After pressing the purchase button you will then be taken to a menu where you
can select Authentication status, menu is displayed in the picture under:

<!--- TODO: REMEMBER TO ADD PICTURE HERE -->

In this menu there is a few different options to choose from, choose the status
you want to test. When selected, simply press the Continue button and the
status you selected will be sent with the payment.

### Amount Error Testing Method

We have some preset amounts that can be used to produce error codes. When
making a payment (operation purchase) enter one of these numbers from the list
below, in the prices object ("amount": <    number>,) before submitting a
transaction. Then the error message displayed behind the numbers will be sent
with your payment in the test environment.

The amounts that can be used and produce error codes
(transactionThirdPartyError):

{:.table .table-striped}
| Number                                         | Error message                           |
| :--------------------------------------------- | :-------------------------------------- |
| 900313                                         | REJECTED_BY_ACQUIRER_INVALID_AMOUNT     |
| 900330                                         | REJECTED_BY_ACQUIRER_FORMAT_ERROR       |
| 900334                                         | REJECTED_BY_ACQUIRER_POSSIBLE_FRAUD     |
| 900343                                         | REJECTED_BY_ACQUIRER_CARD_STOLEN        |
| 900354                                         | REJECTED_BY_ACQUIRER_CARD_EXPIRED       |
| 900351                                         | REJECTED_BY_ACQUIRER_INSUFFICIENT_FUNDS |
| 900359                                         | CARD_DECLINED                           |
| 900362                                         | REJECTED_BY_PAYEX_CARD_BLACKLISTED      |
| 900391                                         | ACQUIRER_HOST_OFFLINE                   |

## Invoice Test Data

### Norway

{:.table .table-striped}
| Type   | Data             |
| :----- | :--------------- |
| SSN    | 26026708248      |
| Name   | Olivia Nyhuus    |
| Adress | SaltnesToppen 43 |
| City   | 1642 Saltnes     |

### Sweden

{:.table .table-striped}
| Type   | Data            | Alternative data        |
| :----- | :-------------- | :---------------------- |
| SSN    | 600307-1161     | 971020-2392             |
| Name   | Azra Oliveira   | Leia Ahlstrom           |
| Adress | Helgestavägen 9 | Helgestavägen 9         |
| City   | 19792 Bro       | 19792 Bro               |
| msisdn |                 | +46739000001            |
| email  |                 | leia.ahlstrom@payex.com |

### Finland

{:.table .table-striped}
| Type   | Data             |
| :----- | :--------------- |
| SSN    | 100584-451P      |
| Name   | Järvilehto Kimmo |
| Adress | Kiannonkatu 88   |
| City   | 90500 Oulu       |

## Invoice Service Test Data

Use any name, adress etc.

## Vipps Test Data

For testing a positive purchase (in our external integration test environment),
please use any mobile number, except within the range: 99999991-99999999, as
these will trigger error messages. The error messages are documented in the
table below. There will be no user dialog at the mobile phone when testing
Vipps.

{:.table .table-striped}
| Mobile number | Error message                                                   |
| :------------ | :-------------------------------------------------------------- |
| 99999991      | Vipps internal error                                            |
| 99999992      | Request Validation error message on paticular request parameter |
| 99999993      | Transaction Id already exists in vipps                          |
| 99999994      | PSPID not enrolled in vipps                                     |
| 99999995      | Invalid payment model type                                      |
| 99999996      | User Vipps App version not supported                            |
| 99999997      | User not Registered with Vipps                                  |
| 99999998      | Merchant not available or active                                |

Since there is no user dialog when testing Vipps in external integration, the
following mobile numbers can be used to simulate consumer action/behaviour in
Vipps application.

{:.table .table-striped}
| Mobile number | Simulation                                                                        |
| :------------ | :-------------------------------------------------------------------------------- |
| 99999990      | Timeout, i.e. the consumer does not confirm the payment in the Vipps app in time. |
| 99999989      | Cancellation by consumer in app.                                                  |

## Swish Test Data

For testing a positive purchase (in our external integration test environment),
please use any mobile number. E.g: +46 739000001

To simulate an error message, set description in `POST` Create Payment or
`Create` Payment Order to one of the following values:

{:.table .table-striped}
| Description | Simulates                                      |
| :---------- | :--------------------------------------------- |
| RF07        | Transaction declined                           |
| TM01        | Swish timed out before the payment was started |
| BANKIDCL    | Payer cancelled BankId signing                 |

## Callback Test Data

{:.table .table-striped}
| URL                                                              | Response                                             |
| :--------------------------------------------------------------- | :--------------------------------------------------- |
| <https://api.internaltest.payex.com/psp/fakecallback>            | `200 OK`                                             |
| <https://api.internaltest.payex.com/psp/fakecallback/notfound>   | `404 Not Found`                                      |
| <https://api.internaltest.payex.com/psp/fakecallback/badrequest> | `400 Bad Request`                                    |
| <https://api.internaltest.payex.com/psp/fakecallback/random>     | `200 OK, 404 Not Found or 400 Bad Request at random` |
