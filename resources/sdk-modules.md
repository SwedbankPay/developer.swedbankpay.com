---
title: SDKs and Modules
sidebar:
  navigation:
  - title: Resources
    items:
    - url: /resources/
      title: Introduction
    - url: /resources/sdk-modules
      title: SDKs and Modules
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
    - url: /resources/public-migration-key
      title: Public Migration Key
---

{% assign active_repositories = site.github.public_repositories | where: 'archived', false %}

{% include jumbotron.html body="We have multiple Open Source-based SDKs and
Modules to use with Swedbank Pay APIs." %}

## Introduction

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
be to allow consumers of your website to pay with a payment provider such as
Swedbank Pay.

{% include repository-table.md type='Module' %}

## Official SDKs

**Software Development Kits** allow developers to integrate with Swedbank Pay's
APIs without having to write a lot of low-level code dealing with HTTP, status
codes, problem messages, parsing, serializaiton, etc. Developers can use their
language of choice and write against a set of typed objects native to their
programming language and environment.

SDKs are often used as a building block to construct a Module.

{% include repository-table.md type='SDK' use_language=true %}

## Unofficial SDKs

{% include alert.html type="warning" icon="warning" header="Unsupported"
body="Unofficial SDKs are offered as a convenience to speed up your development,
but are not supported in any way by Swedbank Pay – not now, nor in the future."
%}

{:.table .table-striped}
|              Platform               | Repository                                           | Status                                                                                             |
| :---------------------------------: | :--------------------------------------------------- | :------------------------------------------------------------------------------------------------- |
| {% include logo.md platform="js" %} | [`bjerkio/swedbank-pay-js`][bjerkio-swedbank-pay-js] | [![npm version](https://badge.fury.io/js/swedbank-pay.svg)](https://badge.fury.io/js/swedbank-pay) |

## Official Libraries

**Software libraries** are bundles of code often used by an SDK or in a Module
to solve one or a set of specific problems.

{% include repository-table.md type='Library' use_language=true %}

[woocommerce]: https://woocommerce.com/
[magento]: https://magento.com/
[bjerkio-swedbank-pay-js]: https://github.com/bjerkio/swedbank-pay-js
