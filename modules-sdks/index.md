---
section: Modules & SDKs
title: Introduction
redirect_from: /resources/sdk-modules
estimated_read: 4
description: |
  We have multiple Open Source-based SDKs and Modules to use with
  Swedbank Pay APIs.
permalink: /:path/
menu_order: 600
---

Swedbank Pay offers APIs, SDKs, libraries, modules, extensions and plugins as
different ways to integrate and use our products and services. It might not
be obvious to everyone what these are, so to describe them we use the analogy
of **baking a cake**.

### APIs

APIs (Application Programming Interface) are the lowest level building block of
our offering and can be compared to **raw ingredients**. They give you a whole
lot of flexibility, but also requires you to have more knowledge in how to use
them correctly and you need to know which recipe to cook in order to get a
workable cake out in the other end. To efficiently use an API, you need to be
a trained baker.

### SDKs

SDKs (Software Development Kit), also known as libraries, can be compared to
a **cake mix**. It requires less knowledge of the ingredients and how to use
them and a recipe is provided for you. Because of this, you also have less
flexibility because you can't bake any cake, you can only bake the one the mix
is for. You still have to mix everything together, so you need some experience
in the kitchen is required, but less than using the "raw" API.

### Modules

Modules, also known as extensions or plugins, can be compared to a **readily
baked cake** purchased at a bakery. You don't need any baking skills to have
one, but you also have very little flexibility in what goes into the cake or
how it tastes.

## Official Modules

**Modules, extensions and plugins** are typically used as a way to extend
webshop platforms such as [WooCommerce][woocommerce] and [Magento][magento] with
functionality that isn't provided in the core platform. Such functionality may
be to allow visitors of your website to pay with a payment provider such as
Swedbank Pay.

{% include alert-unsupported.md type='modules' %}

{:.table .table-striped}
|            Platform          | Module                                                           | Repository                                    |
| :--------------------------: | :--------------------------------------------------------------- | :-------------------------------------------- |
| ![Episerver][episerver-icon] | [Swedbank Pay **Checkout** for Episerver][episerver-link]        | [`…episerver-checkout`][episerver-repo]       |
|   ![Magento][magento-icon]   | [Swedbank Pay **Checkout** for Magento 2][magento-checkout-link] | [`…magento2-checkout`][magento-checkout-repo] |
|   ![Magento][magento-icon]   | [Swedbank Pay **Payments** for Magento 2][magento-payments-link] | [`…magento2-payments`][magento-payments-repo] |
|   ![WooCommerce][woo-icon]   | [Swedbank Pay **Checkout** for WooCommerce][woo-checkout-link]   | [`…woocommerce-checkout`][woo-checkout-repo]  |
|   ![WooCommerce][woo-icon]   | [Swedbank Pay **Payments** for WooCommerce][woo-payments-link]   | [`…woocommerce-payments`][woo-payments-repo]  |

## Official SDKs

**Software Development Kits** allow developers to integrate with Swedbank Pay's
APIs without having to write a lot of low-level code dealing with HTTP, status
codes, problem messages, parsing, serializaiton, etc. Developers can use their
language of choice and write against a set of typed objects native to their
programming language and environment.

SDKs are often used as a building block to construct a *Module*.

{% include alert-unsupported.md type='SDKs' %}

{:.table .table-striped}
|            Platform      | SDK                                          | Repository                     |
| :----------------------: | :------------------------------------------- | :----------------------------- |
| ![Android][android-icon] | [Swedbank Pay SDK for Android][android-link] | [`…sdk-android`][android-repo] |
|     ![iOS][ios-icon]     | [Swedbank Pay SDK for iOS][ios-link]         | [`…sdk-ios`][ios-repo]         |
|   ![.NET][dotnet-icon]   | [Swedbank Pay SDK for .NET][dotnet-link]     | [`…sdk-dotnet`][dotnet-repo]   |
|     ![PHP][php-icon]     | [Swedbank Pay SDK for PHP][php-link]         | [`…sdk-php`][php-repo]         |
|      ![JS][js-icon]      | [Swedban k Pay SDK for JavaScript][js-link]  | [`…sdk-js`][js-repo]           |

## Official Libraries

**Software libraries** are bundles of code often used by an *SDK* or in a
*Module* to solve one or a set of specific problems.

{% include alert-unsupported.md type='libraries' %}

{:.table .table-striped}
|            Platform      | Library                                                     | Repository                            |
| :----------------------: | :---------------------------------------------------------- | :------------------------------------ |
| ![Magento][magento-icon] | [Swedbank Pay Core plugin for Magento 2][magento-core-link] | [`…magento2-core`][magento-core-repo] |
| ![WooCommerce][woo-icon] | [Swedbank Pay Core plugin for WooCommerce][woo-core-link]   | [`…woocommerce-core`][woo-core-repo]  |
|   ![.NET][dotnet-icon]   | [Swedbank Pay SDK Extensions for .NET][dotnet-link]         | [`…sdk-dotnet`][dotnet-repo]          |

[android-icon]: /assets/img/logos/android.svg
[android-link]: https://search.maven.org/artifact/com.swedbankpay.mobilesdk/mobilesdk
[android-repo]: https://github.com/SwedbankPay/swedbank-pay-sdk-android
[dotnet-icon]: /assets/img/logos/dotnet.svg
[dotnet-link]: https://www.nuget.org/packages/SwedbankPay.Sdk
[dotnet-repo]: https://github.com/SwedbankPay/swedbank-pay-sdk-dotnet
[episerver-icon]: /assets/img/logos/episerver.svg
[episerver-link]: https://marketplace.episerver.com/apps/swedbank/swedbankpay/
[episerver-repo]: https://github.com/SwedbankPay/swedbank-pay-episerver-checkout
[ios-icon]: /assets/img/logos/swift.svg
[ios-link]: https://cocoapods.org/pods/SwedbankPaySDK
[ios-repo]: https://github.com/SwedbankPay/swedbank-pay-sdk-ios
[js-icon]: /assets/img/logos/js.svg
[js-link]: https://www.npmjs.com/package/@swedbank-pay/sdk
[js-repo]: https://github.com/SwedbankPay/swedbank-pay-sdk-js
[magento-checkout-link]: https://marketplace.magento.com/swedbank-pay-magento2-checkout.html
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
[woo-checkout-link]: https://wordpress.org/plugins/swedbank-pay-checkout/
[woo-checkout-repo]: https://github.com/SwedbankPay/swedbank-pay-woocommerce-checkout
[woo-core-link]: https://packagist.org/packages/swedbank-pay/swedbank-pay-woocommerce-core
[woo-core-repo]: https://github.com/SwedbankPay/swedbank-pay-woocommerce-core
[woo-icon]: /assets/img/logos/woocommerce.svg
[woo-payments-link]: https://wordpress.org/plugins/swedbank-pay-payments/
[woo-payments-repo]: https://github.com/SwedbankPay/swedbank-pay-woocommerce-payments
[woocommerce]: https://woocommerce.com/
