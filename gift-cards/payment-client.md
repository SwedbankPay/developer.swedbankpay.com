---
title: Test Client
sidebar:
  navigation:
  - title: Gift Cards
    items:
    - url: /gift-cards/
      title: Introduction
    - url: /gift-cards/operations
      title: Operations
    - url: /gift-cards/security
      title: Security
    - url: /gift-cards/payment-client
      title: Test Client
    - url: /gift-cards/other-features
      title: Other Features
---

----

## Prerequisites

*   Java 11
*   VueJS
*   Maven
*   Postgres

## Project setup

```text
vas-payment-api-client
├─┬ backend     → backend module with Spring Boot code
│ ├── src
│ └── pom.xml
├─┬ frontend    → frontend module with Vue.js code
│ ├── src
│ └── pom.xml
└── pom.xml     → Maven parent pom managing both modules
```

## First App run

{% include alert.html type="informative" icon="informative" header="PostgreSQL"
body="The application expects a PostgreSQL server to be running on localhost
with a username `test` and password `test` to exist." %}

The username and password for PostgreSQL can automatically be configured if
PostgreSQL server is started in Docker with environment variables
`POSTGRES_USER=test` and `POSTGRES_PASSWORD=test` are set (See
[docker-compose.yml][docker-compose]).

Clone the [Payment Client repository][payment-client] from Github.

Inside the root directory, do a:

```bash
mvn clean install
```

Run the Spring Boot App:

```bash
mvn --projects backend spring-boot:run
```

Now go to `http://localhost:8080/` and have a look at your new client.

## Testing application

1.  Add a new Merchant with the details provided by Swedbank Pay.
2.  Click on Gift Cards and add a new Gift card.

## Build docker image

```bash
mvn --projects backend clean compile jib:dockerBuild
```

## Deploy to local docker

```bash
docker-compose up -d
```

[docker-compose]: https://github.com/SwedbankPay/vas-payment-api-client/blob/master/docker-compose.yml
[payment-client]: https://github.com/SwedbankPay/vas-payment-api-client
