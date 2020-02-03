---
title: Public migration key
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
    - url: /resources/public-migration-key
      title: Public migration key
---


## Swedbank Pay Public key for card data migration

Key type: RSA
Key size: 4096 bits
RealName: SwedbankPayProd

In order to send sensitive credit card data to Swedbank Pay, you need to use this public pgp key in order to 

You can encrypt files with this command-line:
Import public key
gpg2 --import SwedbankPayProd.key

Encrypt file
gpg2 --armor --encrypt -r SwedbankPayProd CARDDATA.csv.asc


The gpg tool will then create a file named CARDDATA.csv.asc, which contains the encrypted data.

```
-----BEGIN PGP PUBLIC KEY BLOCK-----

mQINBF4z9A4BEAC/vaD46H+zlurFsukuT/V8JEhoOWDXngOKa9cjosFCp3t2QXJL
RSgpaL927ZKT1xVcp2qos31HI4WcrX47o0N+VtBvRQlWReaVzwBEzz6Oy25GpkaQ
QCasU+3NYzYy4fkZgegVb1QWCHbTN1LNzW3jUUMoS5M93lEAmNT+LoqA42KbRxuk
L4TNqahJhOgasP1UxMqOFM/uN895Y8/FaY5unLwnMjIasDUrnqsfEnrir22zcwiB
oikr9ZvqbdaoQeVwvAfzW5TGSfTCaF8jR4ekmKWJt7sl8RHJfVNzOOJIu+twWX7t
XPO3l57FXpARIy5d7qZrsHfAf1EhuIz2uLCI5WyiGCpLTna6IyJ8koRpbOUtwdHW
v5ZGj26Y+Yz0qWYv8Y6roelI+RWmAnT/36AQ6jOfaVQjNQ8mVIGbijtucoMg/VmN
ClFv8fhUwJ+YwQz76ZvHx8PZNBDACwRXEt/Qceue5oRmMS+cMS08tqacJO76mgHG
iMzb8frdL6z9M+7H+XLtF9i4CbB3DRZTXa1DUE1k0TlEib1gdekONLOoCPTVmOsr
Q0SM7MGgNdu2YiuiG7Nt1L4dTKniCNCOZhCHsyzNwg5ZnodzcJlkgrTcKu9b3aC7
P0zYcOmdgorlJ8jsbErogKMqgftI6qJUgGEYxDT45KfXgPGLfGxJIEPIYwARAQAB
tFxTd2VkYmFua1BheVB1YktleVByb2QgKFB1YmxpYyBrZXkgZm9yIGNhcmQgbWln
cmF0aW9uIGluIHByb2R1Y3Rpb24pIDxzdXBwb3J0LmVjb21AcGF5ZXguY29tPokC
TgQTAQgAOBYhBF5WOEElHQeb55m/2HKuiuDPLBkbBQJeM/QOAhsDBQsJCAcCBhUK
CQgLAgQWAgMBAh4BAheAAAoJEHKuiuDPLBkbwKcP/37JJMarT2UmOLchZ97Buj27
iXVC2sdflsFDRJ4HjyCA3veRbl204OSc0h9kIxTIeJaTjvBQwutTyaSjGfWHN/FC
/8548zvno3E7Kk8/fQXl6+JBGrDGuSsXlAxamHZ2D9QEn29KZNhxTCGuFZdKJnan
EB+U9wCPhR0xTWkjaQ6BSQNhJpdmQJqbKOGhCYbkc/aepnZ0yamjkAcWZddm1/68
A+Ws0IxgmeGbBAWD4QlhnW3+cgnZQGtA8aeYiejBHsIJVj/GrH69llJ5dfxjlqQM
UE8NNcU2cqHmuguLwyefP+O6FXkMFW4rPrZ0CthfOUQmF1gK9VAErl8VmK7fe1RW
Bj+c0yeeFcfwfmA5LI0KiwAWJAsDECapcKHD8p9kInUu0rGUA59paAf1pXTvhD5x
FTv8NxB99FmMQi6cQ2sMwY4jvcXOjmnQzVQEY8oewHhZKgJQ1gOfVkpF1wkKU4VX
6m39JHWO2/Yae+bSRaW4/wm4dE/M0OZfBgBjCyEN+S9mItirTfgzNJevdzPCN2cy
Sqtz1rDMg0Oma6yFbyTOSQu3FCHrXsn9fockLqmCtTAiySJ5GWCTXOcCCR5t2lUL
oUzVNp5jgmPJmH+Ph8ou1Pl6qNIqetmhmi0Snw9EjZA26IxS7jGoZlW4wgtZOApc
MhuBMIsLJ6QT3XaZMn4CuQINBF4z9A4BEAC8NnwmpJvqGFzD4fQWAXOBW1ICDEcm
oHRiXdTSx02ywHyAF7wEg2beT+Ke4xojR7q2nbJSD8gZYEQT8qNV/VJax/xlMjHQ
9psCgRJDRDXYprTStwkCK/eHtC1zwhHDir7acyWAc6bGoEw4qx5jQeImRaxAPOP+
55Zy3aWWI8J+nAVkkmjJWqTjHl/4FYyrHsnkTOxmsRWG6DxaEQ+me3ZRIgiRpQBC
WC3pLnjrtyqpBW8Y/lMBMkBcWJOISB1FXKYjxA1Fj3VtkZRPZ98lGT+Af6Pe0v1P
S77OB769J8Fp62iUexE7hrGrnS5nE+M9/gYG50+qIc2Ro7rPKJZ73sFglS8DZ2N0
O671hJSQ6KEw0yLhofoswGR64Oq40ld7b8eAeZaQc7nny6KwJBJ6zhst7LfCdk/P
FwE83249/Sj+1QPpADx2CQpK1hyzIPnHvyttq6m4K2LGj+jBSpC1SL4lzMVzVx3f
PzL5ZA6gKkx7mMLRipjilBLhej0GEFBh5UnWndEmQFZSORxQduUnLgr+yTe8Yc7V
z0MCO5M2YgU4lAnbjxOLqz7FoY2NKOrsx1BdPt3ctp7WSSJ7zODcI62J2PB4gmFi
sqkGwSjkVGSVhPyqjrC5UDFnjTqYmyRhC4rQrupOQ+2doPSH77YGiMO0FDKL7awN
rZoj1fcFa1ffEwARAQABiQI2BBgBCAAgFiEEXlY4QSUdB5vnmb/Ycq6K4M8sGRsF
Al4z9A4CGwwACgkQcq6K4M8sGRs7sQ//WX7FnX7GZUmQR7VDAtOjdzHxLL56weSY
6WqrLbMAgNiz0MUlAvBlF82A61wEyW4zu2f6SFMlXlq7hSahVH9/jg+GuRfKxy6w
OI77JHkRUYLi+gswxKsvYFfMGWI3oZZUIgNMG9I2fwbQTag94zVQHFkLCXG1Ivdk
LHpldUt7fPTf3TcKO5vfAr7Dv/MsYqZr7kPlMtqU+pgBcRnUi1sw0OS5A0f42U4F
mcChRoAs1Z1vdTS8ybspSbo/3BNuF+/FLQAqyAHY1NybSERdOYTVBKMqBlA5UCNd
GGR+Kvr0Xl6Kf1+7e4DJl4P/1/bDDQk/ld7QNF4dBu4WWM0xj2IcUexBehdO7+Bo
T6KkxgUddZRknlkLus7unxBTIloGAbUO+ZIuEegL2wtWb1GfDEadfHhOpVLv8ZCD
J7DnpJlV8dyxhso7swzSeCnXldlQsztBGe8zSzTMT/AdOm2CNNasLIuLYgf3LSwt
sKPUaorh+QZ6zp78rCYAz7b4ILqLj0YeDdJXaA7uoUnSUmxSfuDv5ErDwcFmFe/o
CnN8h1Z6kVNMcfMxFnyTF3N7Quiwq5B68xnhphppXd4oWnwNsQucw9RQ1pmJrr32
cUpPPy+TutcdIbt1jN8TbCE47NNu/rVJd02cYa2HTaQ1lUP3FYNaBl59LUBrwjqm
qEsRRfu0umo=
=IoLx
-----END PGP PUBLIC KEY BLOCK-----
```
