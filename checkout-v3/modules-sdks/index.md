---
section: Modules & SDKs
sidebar_icon: extension
title: Introduction
redirect_from: /checkout-v3/resources/sdk-modules
description: |
  We have multiple Open Source-based SDKs and Modules to use with
  Swedbank Pay APIs.
permalink: /:path/
menu_order: 4
---

Swedbank Pay offers SDKs, libraries, modules, extensions and plugins as
different ways to integrate and use our products and services. Platform specific
packaging that handles a lot of the logic towards our REST API, so you don't
have to.

## Official Modules

**Modules, extensions and plugins** are typically used as a way to extend
webshop platforms such as [WooCommerce][woocommerce]{:target="_blank"} with
functionality that isn't provided in the core platform. Such functionality may
be to allow visitors of your website to pay with a payment provider such as
Swedbank Pay.

{:.table .table-striped}
|            Platform          | Module                                                           | Repository                                    |
| :--------------------------: | :--------------------------------------------------------------- | :-------------------------------------------- |
|   ![WooCommerce][woo-icon]   | [Swedbank Pay Payment Menu for WooCommerce][woo-checkout-link]{:target="_blank"}   | [`…woocommerce-checkout`][woo-checkout-repo]{:target="_blank"}  |

## Official SDKs

**Software Development Kits** allow developers to integrate with Swedbank Pay's
APIs without having to write a lot of low-level code dealing with HTTP, status
codes, problem messages, parsing, serializaiton, etc. Developers can use their
language of choice and write against a set of typed objects native to their
programming language and environment.

SDKs are often used as a building block to construct a *Module*.

The Android and iOS SDKs are our currently supported SDKs. They both run using
our session API, and enable merchants to integrate their own design or UI into
our SDK payments.

{:.table .table-striped}
|            Platform      | SDK                                          | Repository                     |
| :----------------------: | :------------------------------------------- | :----------------------------- |
| ![Android][android-icon] | [Swedbank Pay SDK for Android][android-link]{:target="_blank"} | [`…sdk-android`][android-repo]{:target="_blank"} |
|     ![iOS][ios-icon]     | [Swedbank Pay SDK for iOS][ios-link]{:target="_blank"}         | [`…sdk-ios`][ios-repo]{:target="_blank"}         |

### Unsupported SDKs

{% include alert-unsupported.md type='SDKs' %}

{:.table .table-striped}
|            Platform      | SDK                                          | Repository                     |
| :----------------------: | :------------------------------------------- | :----------------------------- |
|   ![.NET][dotnet-icon]   | [Swedbank Pay SDK for .NET][dotnet-link]{:target="_blank"}     | [`…sdk-dotnet`][dotnet-repo]{:target="_blank"}   |
|     ![PHP][php-icon]     | [Swedbank Pay SDK for PHP][php-link]{:target="_blank"}         | [`…sdk-php`][php-repo]{:target="_blank"}         |

## Official Libraries

**Software libraries** are bundles of code often used by an *SDK* or in a
*Module* to solve one or a set of specific problems.

{:.table .table-striped}
|            Platform      | Library                                                     | Repository                            |
| :----------------------: | :---------------------------------------------------------- | :------------------------------------ |
| ![WooCommerce][woo-icon] | [Swedbank Pay Core plugin for WooCommerce][woo-core-link]{:target="_blank"}   | [`…woocommerce-core`][woo-core-repo]{:target="_blank"}  |

### Unsupported Libraries

{% include alert-unsupported.md type='libraries' %}

{:.table .table-striped}
|            Platform      | Library                                                     | Repository                            |
| :----------------------: | :---------------------------------------------------------- | :------------------------------------ |
|   ![.NET][dotnet-icon]   | [Swedbank Pay SDK Extensions for .NET][dotnet-link]{:target="_blank"}         | [`…sdk-dotnet`][dotnet-repo]{:target="_blank"}          |

[android-icon]: /assets/img/logos/android.svg
[android-link]: https://search.maven.org/artifact/com.swedbankpay.mobilesdk/mobilesdk
[android-repo]: https://github.com/SwedbankPay/swedbank-pay-sdk-android
[dotnet-icon]: /assets/img/logos/dotnet.svg
[dotnet-link]: https://www.nuget.org/packages/SwedbankPay.Sdk
[dotnet-repo]: https://github.com/SwedbankPay/swedbank-pay-sdk-dotnet
[episerver-icon]: /assets/img/logos/episerver.svg
[episerver-link]: https://www.optimizely.com/apps/swedbank-pay-checkout/
[episerver-repo]: https://github.com/SwedbankPay/swedbank-pay-episerver-checkout
[ios-icon]: /assets/img/logos/swift.svg
[ios-link]: https://cocoapods.org/pods/SwedbankPaySDK
[ios-repo]: https://github.com/SwedbankPay/swedbank-pay-sdk-ios
[js-icon]: /assets/img/logos/js.svg
[js-link]: https://www.npmjs.com/package/@swedbank-pay/sdk
[js-repo]: https://github.com/SwedbankPay/swedbank-pay-sdk-js
[magento-checkout-repo]: https://github.com/SwedbankPay/swedbank-pay-magento2-checkout
[magento-core-link]: https://packagist.org/packages/swedbank-pay/magento2-core
[magento-core-repo]: https://github.com/SwedbankPay/swedbank-pay-magento2-core
[magento-icon]: /assets/img/logos/magento.svg
[magento-payments-link]: https://packagist.org/packages/swedbank-pay/magento2-payments
[magento-payments-repo]: https://github.com/SwedbankPay/swedbank-pay-magento2-payments
[magento]: https://magento.com/
[php-icon]: /assets/img/logos/php.svg
[php-link]: https://packagist.org/packages/swedbank-pay/swedbank-pay-sdk-php
[php-repo]: https://github.com/SwedbankPay/swedbank-pay-sdk-php
[woo-checkout-link]: https://wordpress.org/plugins/swedbank-pay-payment-menu/
[woo-checkout-repo]: https://github.com/SwedbankPay/swedbank-pay-woocommerce-paymentmenu
[woo-core-link]: https://packagist.org/packages/swedbank-pay/swedbank-pay-woocommerce-core
[woo-core-repo]: https://github.com/SwedbankPay/swedbank-pay-woocommerce-core
[woo-icon]: /assets/img/logos/woocommerce.svg
[woocommerce]: https://woocommerce.com/
