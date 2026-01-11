---
title: Icons
permalink: /:path/icons/
description: |
 Icons
menu_order: 1300
---

# Icons

Icons support recognition and comprehension. They are used sparingly and never
as the sole carrier of information.

---

## Icon style

- Flat icons
- No shadows or decorative effects
- Clear, recognizable shapes

---

## Sizes

{:.table .table-plain}

|        | Payment Method | Region                                    |
| :--------------------------: | :--------------: | :---------------------------------------- |
| ![Apple Pay][apple-pay-logo]     | [Apple Pay][apple-pay]           |  ![EarthIcon][earth-icon]    |
| ![Card][card-icon]               | [Card][card]                     |  ![EarthIcon][earth-icon]    |
| ![Click to Pay][c2p-logo]        | [Click to Pay][click-to-pay]     |  ![EarthIcon][earth-icon]    |
| ![Google Pay][google-pay-logo]   | [Google Pay][google-pay]&trade;  |  ![EarthIcon][earth-icon]    |
| ![MobilePay][mobilepay-logo]     | [MobilePay][mobilepay]           | {% flag dk %} {% flag fi %}  |
| ![Swedbank Pay][swp-logo]        | Swedbank Pay Installment Account | {% flag se %} {% flag no %}  |
| ![Swedbank Pay][swp-logo]        | Swedbank Pay Invoice             | {% flag no %} {% flag se %}  |
| ![Swedbank Pay][swp-logo]        | Swedbank Pay Monthly Payments    | {% flag se %}                |
| ![Swish][swish-logo]             | [Swish][swish]                   | {% flag se %}                |
| ![Trustly][trustly-logo]         | [Trustly][trustly]               | {% flag se %} {% flag fi %}  |
| ![Vipps][vipps-logo]             | [Vipps][vipps]                   | {% flag no %}                |

{:.table .table-plain}

| Context | Size |
| :-----: | :--- |
| Payment method icon     |40px height    |
| Inline / action icon    | 24×24px |

Icons must not be arbitrarily scaled.

---

## Color usage

Icons use functional color tokens:
- Default: text color
- Muted: muted text color
- Interactive: primary color

Icons must meet non-text contrast requirements (3:1).

---

### Accessibility

Icons are designed to support comprehension and must not replace text.

- Interactive icons are operable using a keyboard.
- Interactive icons have visible focus indicators.
- Decorative icons are hidden from assistive technology.

For general accessibility requirements, see [Accessibility](../accessibility)