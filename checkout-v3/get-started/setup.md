---
sidebar_icon: payments
title: Test Account Setup
permalink: /:path/setup/
description: |
  **In this section we are going to guide you through setting up your test account
  and how to make an API request for your first test payment. After these steps,
  you're ready to build your integration!**
menu_order: 3
---

{% include alert.html type="informative" icon="info" body="
By creating a test account, you will not by default have a commercial
relationship with Swedbank Pay, it is solely a test account for you to use and
test towards our solution. To enjoy integration support, a commercial agreement
with Swedbank Pay is required. Please contact Swedbank Pay Sales at
sales@swedbankpay.se (Sweden), salg@swedbankpay.no (Norway) or
salg@swedbankpay.dk (Denmark)." %}

<section class="panel panel-brand">
 <header>
 <h3 class="panel-title">Why have your own test account?</h3>
 <p class="panel-sub-title"></p>
 </header>
 <div class="panel-body pb-0">
 <ul>
 <li>Access to the merchant portal in our test environment</li>
 <li>Manage your account across different platforms</li>
 <li>Use the credentials in our API collection</li>
 <li>Follow your test payments from creation to settlement</li>
 </ul>
 </div>
</section>

[API collection](testsuite){:target="_blank"}

## Step 1: Sign Up For A Test Account

Your test account request should be sent to:
[testaccount@swedbankpay.com](mailto:testaccount@swedbankpay.com) in order to
create an account for you, we need some specific information from your side:

*   **Company name:** Your company name.

*   **Organization number**: Your organization number.

*   **Technical contact**: Email and phone number.

*   **Commercial contact**: Email and phone number.

## Step 2: Wait For Response

Within 8 working hours we will have created your account and sent you an email
containing the following information:

**Merchant name:** This represents your core business entity with us.

**Payee ID:** This is how we identify you.

**Services:** The payment options which are activated and ready for testing.

**Login credentials:** You will receive a temporary password in a separate
email.

{% include alert.html type="informative" icon="info" body="Please
check your spam folder if you haven't received this email. " %}

## Step 3: Get Your Access Tokens

To submit payments to us, you will be making API requests that are authenticated
with an access token.

How to generate your access token:

**Log in to:** [The External Integration Merchant Portal](https://merchantportal.externalintegration.swedbankpay.com){:target="_blank"} - For
testing environment.

**Merchant details:** Here you will find information about your
account.

An access token is necessary since it will be used together with Payee ID to
validate transactions. The Payee ID will serve as the door and, your token is
the key.

*   Navigate to “Access Tokens” at the top of the page.

*   Choose "Add" and name the token. We suggest you name it according to what
    environment it is created in.

*   Your token will **only** be fully visible upon creation. For security
    purposes, we will mask it like this: `12a3**********bc4de56f` when it is
    displayed later. If you need to keep track of it, please copy and save it
    externally in a safe place. The token will not be visible unmasked in any of
    our systems, so a lost token must be replaced by a new one.

{% include alert.html type="informative" icon="info" body="Please note that the
production and staging environment need separate tokens. " %}

{% include iterator.html prev_href="/checkout-v3/get-started"
                         prev_title="Back to Get Started"
                         next_href="/checkout-v3/get-started/payment-request"
                         next_title="Start Integrating" %}

[testsuite]: https://www.postman.com/swedbankpay/swedbank-pay-online/collection/000bv9t/testsuite
